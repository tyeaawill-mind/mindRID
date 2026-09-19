mindRID final deployment guide
What goes where
Website hosting
Upload these root files to the static host for `mindrid.com`:
`index.html`
`app.js`
`styles.css`
`icon.svg`
`manifest.webmanifest`
`robots.txt`
`sitemap.xml`
`sw.js`
`CNAME` (when using a CNAME-based static host such as GitHub Pages)
Do not upload a `supabase` folder. This build has no Edge Function.
Supabase
Use the Supabase project already referenced by `app.js`.
Open the project's SQL Editor.
Run the complete `schema.sql`. It is written to be safely re-runnable.
In Authentication, make the email/password provider available.
For the intended immediate account-creation flow, disable email confirmation.
In Storage, verify the private `mindrid-media` bucket exists after the SQL script runs.
The browser uses only the Supabase publishable key. Never put a service-role/secret key into `app.js`.
Replacement rule
Replace the existing website files with the files from this package. Do not mix files from the previous build with this package. In particular, do not restore any old `app.js` or Edge Function files.
Important product behavior
A user must sign in/create an account to publish a Whisper or attach media.
Media uploads occur when the user submits, not when a file is merely selected. This prevents duplicate uploads.
A selected Whisper requires at least one valid recipient.
Editing a selected Whisper preserves its existing recipients in the editor and allows them to be replaced.
Failed media/database operations attempt cleanup so incomplete posts do not remain silently.
Own Whisper/reply actions are protected by database ownership policies; frontend controls are not the security boundary.
Reliability check performed before packaging
JavaScript syntax check passed with Node.
The previously missing `shell()` renderer was restored; this was the direct cause of the “Can’t find variable: shell” failure.
Reply/profile loading was changed to fetch comments and profiles separately because the database schema does not define a direct `comments → profiles` foreign-key relationship.
App table references were checked against `schema.sql`.
Welcome-email/Gmail integration is absent from the package.
ZIP integrity was checked after packaging.
First launch test
After deployment, test in this order:
Create account.
Sign out.
Sign in.
Publish a public text Whisper.
Publish a Whisper with an image.
Open the direct Whisper link.
Like and unlike it from another account.
Save and remove it from Saved.
Reply, then edit and delete the reply.
Edit the Whisper.
Create a selected Whisper and verify only the selected recipient can view/reply.
Report another user's Whisper.
Verify a private Whisper is not visible to another account.
If any test fails, stop before public launch and inspect the failing layer rather than adding a frontend workaround.
