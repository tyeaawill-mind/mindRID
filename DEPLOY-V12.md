# mindRID V12 — Finished Web Deployment

## What changed

V12 is a finishing and reliability pass over the V11 product.

### Critical fixes
- Mobile Whisper composer now scopes all fields to the active composer. The previous hidden desktop composer could compete with the mobile modal because of duplicate element IDs.
- Search is inclusive across People, Circles, public Whispers and Whisper context tags.
- Search terms are sanitized before being placed into PostgREST filters.
- Search results for People open a public profile surface instead of sending the user to the generic People page.
- Search has a real form/submit interaction for mobile keyboards.
- Modal dialogs can be dismissed with Escape or by tapping the modal backdrop.
- Signup rejects usernames that become too short after normalization.
- Profile-photo replacement removes the previous stored photo after a successful update and cleans up a newly uploaded photo if the profile update fails.
- Context-tag failure no longer makes an already-created Whisper appear to have failed.

### Security / data lifecycle
- Public/selected Whisper visibility continues to be enforced by RLS.
- Deactivated profiles no longer expose their public Whispers through the visibility helper.
- Private-message conversation creation rejects blocked pairs.
- Connection creation rejects blocked pairs.
- Account deletion now attempts to remove the user's mindRID media-storage objects before deleting the auth account.
- Search performance indexes use `pg_trgm` for the main partial-match fields.

### UX / accessibility
- Larger touch targets and clearer focus states.
- Mobile modal and composer respect the safe-area inset.
- Rich informational pages retain the mindRID typemark and consistent visual hierarchy.
- Guest Home remains intentionally separate from the authenticated social feed.

## Deployment

1. Replace the existing website files with the contents of this package.
2. In Supabase SQL Editor, run the **complete `schema.sql` in this package** from top to bottom.
3. Wait for the SQL editor to finish without errors.
4. Test in a private/incognito browser window.
5. Test at minimum:
   - logged-out Home
   - sign in / sign up
   - mobile Whisper creation
   - media add/remove before posting
   - Whisper edit + existing media deletion
   - global Search: People / Circles / Whispers
   - Circle join / member list / Add members
   - Circle messaging
   - notifications
   - private messages
   - account deactivation / reactivation
   - account deletion
   - 2FA
   - Live

## Cache

V12 uses a new app.js query version. If an old interface still appears, use a private/incognito window or clear the site's stored data once.

## Important

The schema contains both existing product structures and V12 hardening changes. Do not run only the newly added lines; use the complete schema file.
