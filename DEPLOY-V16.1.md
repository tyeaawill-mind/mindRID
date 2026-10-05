# mindRID V16.1 — Reliability Patch

## Fixes
1. Mobile bottom navigation keeps **Messages** visible for signed-in users.
2. Logging out always returns to the public landing page (`#home`) instead of leaving the last authenticated Whisper route open.
3. Removed the invalid `profiles.last_whisper_body` dependency. The deployed schema contains `last_whisper_vibe`, not `last_whisper_body`; profile loading and saving no longer query or write the missing column.
4. Password recovery now relies on Supabase Auth's standard production Site URL instead of constructing a runtime redirect URL. This removes a common redirect-allowlist mismatch point.
5. Legacy `?recovery=1` links remain recognized, while the normal Supabase `PASSWORD_RECOVERY` event opens the reset-password form automatically.

## Supabase setup — important
In **Supabase → Authentication → URL Configuration**:

- **Site URL:** `https://mindrid.com`
- Keep `https://mindrid.com/?recovery=1` in Additional Redirect URLs if it is already present, because older reset emails may still use that URL.

After deploying V16.1, request a **new** password-reset email. Do not reuse an old reset email.

Supabase's password reset flow sends the email and redirects the user back to the configured application URL; the application then handles the `PASSWORD_RECOVERY` event and calls `updateUser({ password })`.

## Validation
- `node --check app.js` passed.
- The package should be deployed as a whole; keep `assets/` unchanged.
