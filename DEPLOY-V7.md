mindRID V7 — Social & Discovery Deployment
Deploy
Replace the website files with all files in this package.
In Supabase SQL Editor, run the entire `schema.sql` from this package.
Wait for the query to finish completely.
Open mindRID in a private/incognito window for the first test.
Test: sign up → location → profile picture → Whisper + tags → reply reactions → notifications → messaging search → connection → group → account controls → live room.
V7 additions
Working notification table and notification triggers.
Messaging search with name/username typeahead suggestions.
Profile picture storage and display.
Profile bio, location, background and interests.
People/network discovery with connection request, accept and disconnect.
Groups with create/join/leave foundation.
Structured Whisper tags: location, feeling, idea, vibe.
Explore filters: Read, Listen, See, Common.
Common-ground discovery using shared location/interests.
Account deactivation/reactivation.
Permanent account deletion workflow.
Live one-to-one audio/video using browser WebRTC + Supabase Realtime signaling.
Removed generic “member” identity wording from visible content; identified users show their display name, anonymous Whispers show Anonymous.
Important
Live audio/video requires browser microphone/camera permission and a secure HTTPS origin. Users should only share live-room links with people they intend to invite.
No welcome email, Gmail integration, or Edge Function is included.
