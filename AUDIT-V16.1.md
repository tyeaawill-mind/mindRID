# mindRID V16.1 Audit

- JavaScript syntax: PASS (`node --check app.js`).
- Removed database dependency on `profiles.last_whisper_body`, which is absent from the deployed schema.
- Profile update no longer writes the missing column.
- Mobile Messages item is visible in the signed-in bottom navigation.
- Logout explicitly returns to `#home`, and session-loss handling also returns to `#home`.
- Password reset now calls Supabase `resetPasswordForEmail(email)` without a runtime redirect override, relying on the configured production Site URL.
- Existing `PASSWORD_RECOVERY` handler remains in place and opens the reset form.
- Legacy `?recovery=1` route remains supported.
- Package integrity: PASS.

## Deployment dependency
Set Supabase Authentication → URL Configuration → Site URL to `https://mindrid.com`. Keep the legacy `https://mindrid.com/?recovery=1` redirect URL if already configured so previously issued emails can still resolve. Request a fresh reset email after deployment.
