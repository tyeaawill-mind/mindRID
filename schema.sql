-- mindRID V0.2 FINAL Supabase schema
-- Purpose: public social Whispers with private identity verification.
-- Run this in Supabase SQL Editor.
-- This script is designed to be safe to re-run.
--
-- IMPORTANT:
-- 1) The browser app must use only the Supabase publishable key.
-- 2) Never expose a Supabase secret/service-role key.
-- 3) Private identification is intentionally kept in a separate table.
-- 4) New app code should NOT put private identification in auth metadata.

create extension if not exists pgcrypto;

-- ============================================================
-- TABLES
-- ============================================================

create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  username text unique,
  display_name text,
  avatar_url text,
  created_at timestamptz not null default now()
);

create table if not exists public.private_identity (
  user_id uuid primary key references auth.users(id) on delete cascade,
  identification text not null check (char_length(identification) between 1 and 2000),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.whispers (
  id uuid primary key default gen_random_uuid(),
  author_id uuid not null references auth.users(id) on delete cascade,
  body text not null check (char_length(body) between 1 and 10000),
  identity_mode text not null default 'anonymous'
    check (identity_mode in ('real','anonymous')),
  visibility text not null default 'private'
    check (visibility in ('private','selected','public')),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.whisper_recipients (
  whisper_id uuid not null references public.whispers(id) on delete cascade,
  recipient_id uuid not null references auth.users(id) on delete cascade,
  primary key (whisper_id, recipient_id)
);

create table if not exists public.comments (
  id uuid primary key default gen_random_uuid(),
  whisper_id uuid not null references public.whispers(id) on delete cascade,
  author_id uuid not null references auth.users(id) on delete cascade,
  body text not null check (char_length(body) between 1 and 3000),
  parent_comment_id uuid references public.comments(id) on delete cascade,
  created_at timestamptz not null default now()
);

create table if not exists public.reports (
  id uuid primary key default gen_random_uuid(),
  reporter_id uuid not null references auth.users(id) on delete cascade,
  whisper_id uuid references public.whispers(id) on delete cascade,
  comment_id uuid references public.comments(id) on delete cascade,
  reason text not null check (char_length(reason) between 1 and 1000),
  created_at timestamptz not null default now(),
  check (
    (whisper_id is not null and comment_id is null)
    or
    (whisper_id is null and comment_id is not null)
  )
);

create table if not exists public.blocks (
  blocker_id uuid not null references auth.users(id) on delete cascade,
  blocked_id uuid not null references auth.users(id) on delete cascade,
  created_at timestamptz not null default now(),
  primary key (blocker_id, blocked_id),
  check (blocker_id <> blocked_id)
);

-- ============================================================
-- HELPER FUNCTIONS
-- SECURITY DEFINER functions are used to avoid circular RLS
-- evaluation between whispers and whisper_recipients.
-- ============================================================

create or replace function public.mindrid_is_blocked(
  viewer uuid,
  owner uuid
) returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select exists (
    select 1
    from public.blocks b
    where
      (b.blocker_id = viewer and b.blocked_id = owner)
      or
      (b.blocker_id = owner and b.blocked_id = viewer)
  );
$$;

create or replace function public.mindrid_can_view_whisper(
  whisper_author uuid,
  whisper_visibility text,
  whisper_id uuid,
  viewer uuid
) returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select
    viewer is not null
    and (
      whisper_author = viewer
      or (
        not public.mindrid_is_blocked(viewer, whisper_author)
        and (
          whisper_visibility = 'public'
          or (
            whisper_visibility = 'selected'
            and exists (
              select 1
              from public.whisper_recipients r
              where r.whisper_id = mindrid_can_view_whisper.whisper_id
                and r.recipient_id = viewer
            )
          )
        )
      )
    );
$$;

create or replace function public.mindrid_can_comment(
  target_whisper uuid,
  viewer uuid
) returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select exists (
    select 1
    from public.whispers w
    where w.id = target_whisper
      and public.mindrid_can_view_whisper(w.author_id, w.visibility, w.id, viewer)
      and w.visibility in ('public','selected')
  );
$$;

create or replace function public.mindrid_can_report_whisper(
  target_whisper uuid,
  reporter uuid
) returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select exists (
    select 1
    from public.whispers w
    where w.id = target_whisper
      and w.author_id <> reporter
      and public.mindrid_can_view_whisper(w.author_id, w.visibility, w.id, reporter)
  );
$$;

create or replace function public.mindrid_can_report_comment(
  target_comment uuid,
  reporter uuid
) returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select exists (
    select 1
    from public.comments c
    where c.id = target_comment
      and c.author_id <> reporter
      and public.mindrid_can_comment(c.whisper_id, reporter)
  );
$$;

revoke all on function public.mindrid_is_blocked(uuid, uuid) from public;
revoke all on function public.mindrid_can_view_whisper(uuid, text, uuid, uuid) from public;
revoke all on function public.mindrid_can_comment(uuid, uuid) from public;
revoke all on function public.mindrid_can_report_whisper(uuid, uuid) from public;
revoke all on function public.mindrid_can_report_comment(uuid, uuid) from public;

grant execute on function public.mindrid_is_blocked(uuid, uuid) to authenticated;
grant execute on function public.mindrid_can_view_whisper(uuid, text, uuid, uuid) to authenticated;
grant execute on function public.mindrid_can_comment(uuid, uuid) to authenticated;
grant execute on function public.mindrid_can_report_whisper(uuid, uuid) to authenticated;
grant execute on function public.mindrid_can_report_comment(uuid, uuid) to authenticated;

-- ============================================================
-- RLS
-- ============================================================

alter table public.profiles enable row level security;
alter table public.private_identity enable row level security;
alter table public.whispers enable row level security;
alter table public.whisper_recipients enable row level security;
alter table public.comments enable row level security;
alter table public.reports enable row level security;
alter table public.blocks enable row level security;

-- Profiles
drop policy if exists profiles_select_public on public.profiles;
drop policy if exists profiles_insert_own on public.profiles;
drop policy if exists profiles_update_own on public.profiles;
create policy profiles_select_public
  on public.profiles for select
  using (true);
create policy profiles_insert_own
  on public.profiles for insert
  with check (id = auth.uid());
create policy profiles_update_own
  on public.profiles for update
  using (id = auth.uid())
  with check (id = auth.uid());

-- Private identity: owner only.
drop policy if exists private_identity_select_own on public.private_identity;
drop policy if exists private_identity_insert_own on public.private_identity;
drop policy if exists private_identity_update_own on public.private_identity;
drop policy if exists private_identity_delete_own on public.private_identity;
create policy private_identity_select_own
  on public.private_identity for select
  using (user_id = auth.uid());
create policy private_identity_insert_own
  on public.private_identity for insert
  with check (user_id = auth.uid());
create policy private_identity_update_own
  on public.private_identity for update
  using (user_id = auth.uid())
  with check (user_id = auth.uid());
create policy private_identity_delete_own
  on public.private_identity for delete
  using (user_id = auth.uid());

-- Whispers
drop policy if exists whispers_select_own_or_public on public.whispers;
drop policy if exists whispers_insert_own on public.whispers;
drop policy if exists whispers_update_own on public.whispers;
drop policy if exists whispers_delete_own on public.whispers;

create policy whispers_select_visible
  on public.whispers for select
  using (
    public.mindrid_can_view_whisper(author_id, visibility, id, auth.uid())
  );

create policy whispers_insert_own
  on public.whispers for insert
  with check (author_id = auth.uid());

create policy whispers_update_own
  on public.whispers for update
  using (author_id = auth.uid())
  with check (author_id = auth.uid());

create policy whispers_delete_own
  on public.whispers for delete
  using (author_id = auth.uid());

-- Selected recipients
drop policy if exists whisper_recipients_select_related on public.whisper_recipients;
drop policy if exists whisper_recipients_insert_owner on public.whisper_recipients;
drop policy if exists whisper_recipients_delete_owner on public.whisper_recipients;

create policy whisper_recipients_select_related
  on public.whisper_recipients for select
  using (
    recipient_id = auth.uid()
    or exists (
      select 1
      from public.whispers w
      where w.id = whisper_id
        and w.author_id = auth.uid()
    )
  );

create policy whisper_recipients_insert_owner
  on public.whisper_recipients for insert
  with check (
    exists (
      select 1
      from public.whispers w
      where w.id = whisper_id
        and w.author_id = auth.uid()
    )
  );

create policy whisper_recipients_delete_owner
  on public.whisper_recipients for delete
  using (
    exists (
      select 1
      from public.whispers w
      where w.id = whisper_id
        and w.author_id = auth.uid()
    )
  );

-- Comments/replies
drop policy if exists comments_select_visible on public.comments;
drop policy if exists comments_insert_signed_in_visible on public.comments;
drop policy if exists comments_update_own on public.comments;
drop policy if exists comments_delete_own on public.comments;

create policy comments_select_visible
  on public.comments for select
  using (
    public.mindrid_can_comment(whisper_id, auth.uid())
  );

create policy comments_insert_signed_in_visible
  on public.comments for insert
  with check (
    author_id = auth.uid()
    and public.mindrid_can_comment(whisper_id, auth.uid())
  );

create policy comments_update_own
  on public.comments for update
  using (author_id = auth.uid())
  with check (author_id = auth.uid());

create policy comments_delete_own
  on public.comments for delete
  using (author_id = auth.uid());

-- Reports: reporters can create reports; they cannot read the report queue.
drop policy if exists reports_insert_own_visible_target on public.reports;
drop policy if exists reports_select_own on public.reports;
drop policy if exists reports_delete_own on public.reports;

create policy reports_insert_own_visible_target
  on public.reports for insert
  with check (
    reporter_id = auth.uid()
    and (
      (whisper_id is not null and public.mindrid_can_report_whisper(whisper_id, auth.uid()))
      or
      (comment_id is not null and public.mindrid_can_report_comment(comment_id, auth.uid()))
    )
  );

create policy reports_select_own
  on public.reports for select
  using (reporter_id = auth.uid());

create policy reports_delete_own
  on public.reports for delete
  using (reporter_id = auth.uid());

-- Blocks
drop policy if exists blocks_select_own on public.blocks;
drop policy if exists blocks_insert_own on public.blocks;
drop policy if exists blocks_delete_own on public.blocks;

create policy blocks_select_own
  on public.blocks for select
  using (blocker_id = auth.uid());

create policy blocks_insert_own
  on public.blocks for insert
  with check (blocker_id = auth.uid());

create policy blocks_delete_own
  on public.blocks for delete
  using (blocker_id = auth.uid());

-- ============================================================
-- PROFILE CREATION
-- This trigger creates only the public profile.
-- It intentionally does NOT read private identification.
-- ============================================================

create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.profiles (id, username, display_name)
  values (
    new.id,
    nullif(new.raw_user_meta_data->>'username',''),
    nullif(new.raw_user_meta_data->>'display_name','')
  )
  on conflict (id) do nothing;

  return new;
end;
$$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
after insert on auth.users
for each row
execute procedure public.handle_new_user();

-- ============================================================
-- INDEXES
-- ============================================================

create index if not exists whispers_public_created_idx
  on public.whispers (visibility, created_at desc);

create index if not exists whispers_author_created_idx
  on public.whispers (author_id, created_at desc);

create index if not exists whisper_recipients_recipient_idx
  on public.whisper_recipients (recipient_id, whisper_id);

create index if not exists comments_whisper_created_idx
  on public.comments (whisper_id, created_at asc);

create index if not exists comments_author_idx
  on public.comments (author_id, created_at desc);

create index if not exists reports_whisper_idx
  on public.reports (whisper_id)
  where whisper_id is not null;

create index if not exists reports_comment_idx
  on public.reports (comment_id)
  where comment_id is not null;

create index if not exists blocks_blocked_idx
  on public.blocks (blocked_id, blocker_id);

-- ============================================================
-- NOTE ABOUT EXISTING AUTH METADATA
-- ============================================================
-- This final schema deliberately does NOT copy or delete
-- private_identification from auth.users metadata.
--
-- If the earlier prototype stored private_identification in
-- auth metadata for test accounts, do NOT try to migrate it
-- automatically with this schema. We will handle any existing
-- test-account migration explicitly, after inspecting what is
-- actually present.

-- ============================================================
-- RELIABILITY EXTENSION: reactions, saves and media
-- ============================================================

alter table public.whispers drop constraint if exists whispers_body_check;
alter table public.whispers add constraint whispers_body_check check (char_length(body) between 0 and 10000);
alter table public.comments drop constraint if exists comments_body_check;
alter table public.comments add constraint comments_body_check check (char_length(body) between 0 and 3000);
alter table public.whispers alter column body set default '';
alter table public.comments alter column body set default '';

alter table public.whispers add column if not exists updated_at timestamptz not null default now();
alter table public.comments add column if not exists updated_at timestamptz not null default now();

create table if not exists public.likes (
  whisper_id uuid not null references public.whispers(id) on delete cascade,
  user_id uuid not null references auth.users(id) on delete cascade,
  created_at timestamptz not null default now(),
  primary key (whisper_id, user_id)
);

create table if not exists public.saves (
  whisper_id uuid not null references public.whispers(id) on delete cascade,
  user_id uuid not null references auth.users(id) on delete cascade,
  created_at timestamptz not null default now(),
  primary key (whisper_id, user_id)
);

create table if not exists public.whisper_media (
  id uuid primary key default gen_random_uuid(),
  whisper_id uuid not null references public.whispers(id) on delete cascade,
  author_id uuid not null references auth.users(id) on delete cascade,
  storage_path text not null unique,
  public_url text,
  mime_type text not null,
  file_name text not null,
  file_size bigint not null check (file_size > 0 and file_size <= 52428800),
  created_at timestamptz not null default now()
);

create table if not exists public.comment_media (
  id uuid primary key default gen_random_uuid(),
  comment_id uuid not null references public.comments(id) on delete cascade,
  author_id uuid not null references auth.users(id) on delete cascade,
  storage_path text not null unique,
  public_url text,
  mime_type text not null,
  file_name text not null,
  file_size bigint not null check (file_size > 0 and file_size <= 52428800),
  created_at timestamptz not null default now()
);

alter table public.likes enable row level security;
alter table public.saves enable row level security;
alter table public.whisper_media enable row level security;
alter table public.comment_media enable row level security;

drop policy if exists likes_select_visible on public.likes;
drop policy if exists likes_insert_own on public.likes;
drop policy if exists likes_delete_own on public.likes;
create policy likes_select_visible on public.likes for select using (
  exists (select 1 from public.whispers w where w.id=whisper_id and public.mindrid_can_view_whisper(w.author_id,w.visibility,w.id,auth.uid()))
);
create policy likes_insert_own on public.likes for insert with check (
  user_id=auth.uid() and exists (select 1 from public.whispers w where w.id=whisper_id and public.mindrid_can_view_whisper(w.author_id,w.visibility,w.id,auth.uid()))
);
create policy likes_delete_own on public.likes for delete using (user_id=auth.uid());

drop policy if exists saves_select_own on public.saves;
drop policy if exists saves_insert_own on public.saves;
drop policy if exists saves_delete_own on public.saves;
create policy saves_select_own on public.saves for select using (user_id=auth.uid());
create policy saves_insert_own on public.saves for insert with check (user_id=auth.uid());
create policy saves_delete_own on public.saves for delete using (user_id=auth.uid());

drop policy if exists whisper_media_select_visible on public.whisper_media;
drop policy if exists whisper_media_insert_own on public.whisper_media;
drop policy if exists whisper_media_delete_own on public.whisper_media;
create policy whisper_media_select_visible on public.whisper_media for select using (
  exists (select 1 from public.whispers w where w.id=whisper_id and public.mindrid_can_view_whisper(w.author_id,w.visibility,w.id,auth.uid()))
);
create policy whisper_media_insert_own on public.whisper_media for insert with check (
  author_id=auth.uid() and exists (select 1 from public.whispers w where w.id=whisper_id and w.author_id=auth.uid())
);
create policy whisper_media_delete_own on public.whisper_media for delete using (author_id=auth.uid());

drop policy if exists comment_media_select_visible on public.comment_media;
drop policy if exists comment_media_insert_own on public.comment_media;
drop policy if exists comment_media_delete_own on public.comment_media;
create policy comment_media_select_visible on public.comment_media for select using (
  exists (select 1 from public.comments c where c.id=comment_id and public.mindrid_can_comment(c.whisper_id,auth.uid()))
);
create policy comment_media_insert_own on public.comment_media for insert with check (
  author_id=auth.uid() and exists (select 1 from public.comments c where c.id=comment_id and c.author_id=auth.uid())
);
create policy comment_media_delete_own on public.comment_media for delete using (author_id=auth.uid());

-- Private media bucket. The application generates access URLs only after
-- the database visibility rules permit the media row to be read.
insert into storage.buckets (id,name,public)
values ('mindrid-media','mindrid-media',false)
on conflict (id) do update set public=false;

drop policy if exists mindrid_media_storage_select on storage.objects;
drop policy if exists mindrid_media_storage_insert on storage.objects;
drop policy if exists mindrid_media_storage_update on storage.objects;
drop policy if exists mindrid_media_storage_delete on storage.objects;

create policy mindrid_media_storage_select on storage.objects for select using (
  bucket_id='mindrid-media' and (
    (storage.foldername(name))[1]=auth.uid()::text
    or exists (
      select 1 from public.whisper_media wm
      join public.whispers w on w.id=wm.whisper_id
      where wm.storage_path=name and public.mindrid_can_view_whisper(w.author_id,w.visibility,w.id,auth.uid())
    )
    or exists (
      select 1 from public.comment_media cm
      join public.comments c on c.id=cm.comment_id
      where cm.storage_path=name and public.mindrid_can_comment(c.whisper_id,auth.uid())
    )
  )
);
create policy mindrid_media_storage_insert on storage.objects for insert with check (
  bucket_id='mindrid-media' and (storage.foldername(name))[1]=auth.uid()::text
);
create policy mindrid_media_storage_update on storage.objects for update using (
  bucket_id='mindrid-media' and (storage.foldername(name))[1]=auth.uid()::text
) with check (
  bucket_id='mindrid-media' and (storage.foldername(name))[1]=auth.uid()::text
);
create policy mindrid_media_storage_delete on storage.objects for delete using (
  bucket_id='mindrid-media' and (storage.foldername(name))[1]=auth.uid()::text
);

create index if not exists likes_whisper_idx on public.likes (whisper_id, created_at desc);
create index if not exists saves_user_idx on public.saves (user_id, created_at desc);
create index if not exists whisper_media_whisper_idx on public.whisper_media (whisper_id, created_at asc);
create index if not exists comment_media_comment_idx on public.comment_media (comment_id, created_at asc);

-- Automatic updated_at maintenance.
create or replace function public.mindrid_touch_updated_at()
returns trigger language plpgsql as $$
begin new.updated_at=now(); return new; end;
$$;
drop trigger if exists whispers_touch_updated_at on public.whispers;
create trigger whispers_touch_updated_at before update on public.whispers for each row execute procedure public.mindrid_touch_updated_at();
drop trigger if exists comments_touch_updated_at on public.comments;
create trigger comments_touch_updated_at before update on public.comments for each row execute procedure public.mindrid_touch_updated_at();
