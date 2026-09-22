mindRID V8 — Reliability, Security & Social UX
Deploy
Replace the website files with the files in this package.
Run the complete `schema.sql` in Supabase SQL Editor.
Wait for the SQL to finish completely.
Open the site in a private/incognito window for the first test.
V8 changes
Smartphone-first responsive navigation and layout adjustments.
Back button on every non-home page.
40-minute inactivity logout.
Supabase TOTP 2FA enrollment, verification and sign-in challenge.
MFA challenge before sensitive account deactivation/deletion when MFA is enabled.
Realtime notification delivery for connection requests and other notifications.
My Network page with incoming requests, Accept and Decline.
Clear connection state: Connect, Pending, Accept, Disconnect.
Whispers around My network.
Popular Whispers.
Home shortcuts for My Network, Whispers around My network, Popular Whispers and People.
More responsive “What people are thinking” area.
Live, People, Groups and Network remain separate surfaces while sharing common navigation and feedback behavior.
Supabase note
The schema includes a safe check for adding `public.notifications` to `supabase_realtime` when that publication is available. If the project does not expose that publication, the rest of the schema continues normally.
2FA note
Supabase currently supports TOTP and phone MFA. This V8 implementation uses TOTP because it does not require an external SMS/WhatsApp provider. Supabase does not provide recovery codes; users should keep a backup authenticator factor.
