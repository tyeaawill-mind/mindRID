# mindRID V17 deployment

1. Replace the current site files with the contents of this package.
2. Keep `assets/` beside `index.html`.
3. In Supabase SQL Editor, run `MIGRATION-V17.sql` once on the existing project.
4. Wait for the SQL to complete without errors.
5. Hard refresh / clear the old site cache if necessary.
6. Test: open a public reflection → Related reflections; Develop this thought; Has your thinking changed; People → thought matching; For You → Why this?; Surprise my mind.

No existing tables are modified by the migration. It adds only `whisper_links` and its policies/indexes.
