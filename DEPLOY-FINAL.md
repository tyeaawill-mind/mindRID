mindRID V6 — deployment and verification
1. Website
Replace the website files on the hosting service with all files in this package.
The application version is `20260919-03`.
2. Supabase
Open Supabase → SQL Editor and run the entire `schema.sql` from this package.
Do not run only selected sections. The schema is designed to be rerunnable: existing policies are dropped before recreation, `public.saves` is created if absent, private messaging is included, comment reactions are included, and the script reloads the PostgREST schema cache at the end.
3. First browser test
Use a private/incognito window for the first test. If an old deployment still appears, clear the site's stored data/cache once.
4. Core verification order
Sign in.
Create a Whisper with text only.
Create a Whisper with image/video/audio media.
Open the Whisper and expand its media.
Edit the Whisper with an attached existing media item and save.
Like/save the Whisper.
Open the Whisper and reply.
Like and dislike a reply; switch between them.
Share the Whisper from the feed and detail page.
Share a reply and open the resulting link.
Open Report and verify the explanation/reason choices.
Open Messages, start a private conversation, and send a message.
Check Saved.
5. Expected media fix
The previous error:
`Could not find the 'owner_id' column of 'whisper_media' in the schema cache`
was caused by the application sending `owner_id` while the database table uses `author_id`.
V6 sends `author_id`.
6. Interaction/performance changes
Actions acknowledge immediately with progress text/toast.
Different actions no longer block one another globally.
Feed text/cards render before media URLs finish loading.
Public feed initial batch is 30 items rather than 80.
Reply media and reaction data load in parallel.
Whisper detail renders its structure before media/replies finish loading.
7. Report meaning
Report is a moderation mechanism for possible rule violations such as harassment, threats, abusive/hateful content, spam/scams, privacy exposure, sexual/exploitative content, or illegal/dangerous content. It is not a dislike button and should not be used merely because someone disagrees with a thought.
8. Not included
No welcome email, Gmail integration, or Edge Function is included.
