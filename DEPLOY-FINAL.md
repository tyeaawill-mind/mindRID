mindRID — reliable recovery deployment
This package is the recovery baseline. Do not combine it with files from older mindRID packages.
1. Website
Upload all files in this folder to the root of the GitHub Pages/site repository, replacing the old files.
Important: `app.js` is deliberately loaded with a version query (`?v=20260919-01`) so an older cached JavaScript file is less likely to be reused.
2. One-time browser cleanup
If the old site previously showed `Can't find variable: shell`, an older Service Worker may still be controlling the site.
Before testing this build, use a private/incognito window first. If the new build works there, clear the normal mindRID site data/cache and reload it.
In Chrome: address-bar lock/site controls → Site settings → Delete data, then reopen mindrid.com.
3. Supabase
Run the included `schema.sql` in the Supabase SQL Editor.
The schema explicitly permits unauthenticated visitors to read public Whispers. Private and selected Whispers remain protected.
Do not put a Supabase secret/service-role key into the website.
4. First test — do only these
Open mindrid.com in an incognito/private window.
Home loads.
Explore loads.
Sign in / Create account opens.
Create an account.
Sign in.
Post one simple text Whisper.
Open that Whisper.
Add one reply.
Do not test media, selected visibility, editing, saving, etc. until these nine steps work.
5. No welcome email
There is no welcome-email Edge Function, Gmail integration, or email-sending code in this package.

Included in this version
Fix for `Could not find the table 'public.saves' in the schema cache`: `schema.sql` creates `public.saves`, recreates its RLS policies safely, and ends with `NOTIFY pgrst, 'reload schema'`.
Private one-to-one messaging: `#messages`, conversation creation by username, protected conversation membership, and protected message rows.
Media expansion: click/press Expand on attached images/video (and Open for audio) to view the media in a larger modal.
Deployment order
Replace the website files with the contents of this ZIP.
In Supabase SQL Editor, run the entire `schema.sql` from this ZIP.
Wait briefly for the schema cache to reload.
Open the site in a private/incognito window for the first test.
Test: sign in → Whisper → open Whisper → reply → Save → Messages → send a private message → expand attached media.
No welcome email or Gmail/Edge Function is included.
