# mindRID V10.1 — Guest Home & Auth-State UX

## Changes
- Guest Home no longer exposes the public Whisper feed.
- Guest navigation is separated from the signed-in social interface.
- Guest landing headline is **Get rid** with no full stop.
- Added a custom small flying-bird sketch beside the headline.
- Added the explanatory Mind message in a focused, editorial-style panel.
- Sign in / Create account remain the primary guest actions.
- Added a cache-busting app.js version.
- Signed-in Home and existing V9 functionality remain unchanged.

## Deployment
1. Replace the current website files with all files in this ZIP.
2. Do **not** run schema.sql for this UI-only change.
3. Test in an Incognito/Private window first.
4. Confirm the logged-out Home shows only the guest landing experience.
5. Sign in and confirm the normal Home feed/composer/navigation returns.
6. Test both desktop and mobile widths.

## Important
If an older interface remains visible after deployment, clear the site's cached files/site data or test in an Incognito/Private window. The app.js query string was also incremented for cache busting.
