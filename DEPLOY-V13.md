mindRID V13 — Finished Web Deployment
Release
V13 is the final finishing pass built directly from the uploaded V12 package. It covers reliability, security, performance, responsive UX, iPhone/PWA presentation, navigation, personalization and profile customization.
Major corrections
Added the approved For You feed and Home feed tabs: For You / Following / Latest.
Added Following / Followers, with database-backed one-way follow relationships and follow notifications.
Added Timeline, Spaces, Community, History, Whisper Memory and Help & Support.
Added a genuinely scrollable desktop left navigation rail.
Guest Home remains separate from the authenticated feed.
Restored the approved six-line guest message:
When something weighs upon the mind,
And there is no one safe to tell,
There ought to be a quiet place
Where part of what we carry
May be laid down,
And left behind.
Reworked Get rid with calligraphic typography, an original small flying-bird silhouette, a soft sky/cloud background and three curved flight lines.
Added profile background photo, profile photo, and selectable/automatic visual themes.
Auto theme can follow a derived vibe from the latest Whisper without storing the full Whisper body in the profile.
Added iPhone/PWA metadata and an Apple touch icon.
Hardened search sanitization.
Fixed auth-state duplicate profile work.
Fixed route-refresh inconsistencies after connection actions.
Fixed Whisper edit rollback so a failed edit restores the previous text/identity/visibility/recipients.
Media uploads now run concurrently with progress feedback, while text remains required for a thought-first Whisper/reply.
Reduced initial media cost with lazy media hydration and a short-lived public-feed cache.
Storage policy now supports profile background photos while retaining private media controls.
Deployment
Replace the existing website files with the contents of this package.
In Supabase SQL Editor, run the complete `schema.sql` from this package from top to bottom.
Wait for the SQL editor to finish without errors.
Open mindRID in an Incognito/Private window for the first verification.
Minimum acceptance test
Guest
Home is a dedicated guest experience.
No authenticated feed is visible.
“Get rid” has the sky/bird/triple-line treatment.
The six-line approved message is visible.
Sign in / Create account work.
Authenticated
Home → For You / Following / Latest.
For You returns a personalized public-thought stream.
Following shows followed people and their public Whispers.
Followers / Following lists update after follow/unfollow.
Person profile has Wall, follow counts, follow/unfollow, Connect and Message.
Profile photo and background photo upload/replacement/removal work.
Profile theme selection works; Auto follows the derived latest-Whisper vibe.
Whisper Memory save/remove state is visible.
History records opened Whispers.
Spaces, Community and Help & Support open correctly.
Desktop left navigation scrolls when the menu exceeds viewport height.
Mobile/iPhone bottom navigation remains compact and touch-friendly.
Mobile Whisper composer has a large writing area.
Edit Whisper shows existing media and permits deletion.
Search covers People, Circles, Whispers and context tags.
Circle join, member wall, messaging and Live entry points work.
Notifications, private messages, 2FA, account deactivation/deletion and Live continue to work.
Cache
V13 uses a new `app.js` cache-busting version. If an older interface still appears, test once in a private/incognito window or clear the site's stored data.
Important
The schema is rerunnable: policy changes use `drop policy if exists` followed by `create policy`. Always use the complete schema file rather than copying only selected additions.
Product boundary
Spaces is currently a discovery/navigation surface. It does not pretend to be a separate large-room live system. The existing Live implementation remains the current live architecture; true multiparty Spaces would require a dedicated realtime/SFU architecture.
