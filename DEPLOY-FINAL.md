# mindRID final deployment guide

## What goes where

### Website hosting
Upload these root files to the static host for `mindrid.com`:
- `index.html`
- `app.js`
- `styles.css`
- `icon.svg`
- `manifest.webmanifest`
- `robots.txt`
- `sitemap.xml`
- `sw.js`
- `CNAME` (when using a CNAME-based static host such as GitHub Pages)

Do **not** upload a `supabase` folder. This build has no Edge Function.

### Supabase
Use the Supabase project already referenced by `app.js`.

1. Open the project's SQL Editor.
2. Run the complete `schema.sql` once.
3. In Authentication, make the email/password provider available.
4. For the intended immediate account-creation flow, disable email confirmation.
5. In Storage, verify the private `mindrid-media` bucket exists after the SQL script runs.

The browser uses only the Supabase publishable key. Never put a service-role/secret key into `app.js`.

## Replacement rule

Replace the existing website files with the files from this package. Do not mix the old welcome-email files or an older `app.js` with this build.

## Important product behavior

- A user must sign in/create an account to publish a Whisper or attach media.
- Media uploads occur when the user submits, not when a file is merely selected. This prevents duplicate uploads.
- A selected Whisper requires at least one valid recipient.
- Editing a selected Whisper preserves its existing recipients in the editor and allows them to be replaced.
- Failed media/database operations attempt cleanup so incomplete posts do not remain silently.
- Own Whisper/reply actions are protected by database ownership policies; frontend controls are not the security boundary.

## First launch test

After deployment, test in this order:

1. Create account.
2. Sign out.
3. Sign in.
4. Publish a public text Whisper.
5. Publish a Whisper with an image.
6. Open the direct Whisper link.
7. Like and unlike it from another account.
8. Save and remove it from Saved.
9. Reply, then edit and delete the reply.
10. Edit the Whisper.
11. Create a selected Whisper and verify only the selected recipient can view/reply.
12. Report another user's Whisper.
13. Verify a private Whisper is not visible to another account.

If any test fails, stop before public launch and inspect the failing layer rather than adding a frontend workaround.
