# mindRID V14 — FINAL UX/PERFORMANCE PASS

V14 is built directly on V13 and contains the requested final UI and responsiveness corrections. It is a frontend-only pass; **schema.sql is unchanged from V13** and does not need to be rerun unless the deployment process requires it.

## Changes

- Removed the opening quotation-mark glyph from the guest Home.
- Removed the Home subtitle: “A thought-first feed shaped around you”.
- Removed the Following subtitle: “Thoughts from people you choose to follow”.
- Changed the composer prompt to **“What’s going through your mind?”**.
- Doubled the writing surface: desktop composer textarea is approximately 148px minimum; iPhone modal writing area is approximately 76dvh.
- After publishing a Whisper, the composer modal closes and navigation goes directly to that Whisper's page.
- Replaced initial-letter avatars with either the available profile image or a neutral contact/person icon.
- Changed appropriate user-facing “thought” wording to **reflection/reflections** while retaining “Whisper” as the product action/content type.
- Reworked the landing bird into a slim, swift-inspired flying-bird silhouette with swept wings and forked tail, while retaining the three curved flight lines and sky aesthetic.
- Improved perceived sign-in speed: authenticated Home now renders immediately while profile hydration runs in the background; the profile is refreshed only after hydration completes and only if the user remains on the same route.
- Reduced initial profile query payload by selecting required profile columns rather than `select('*')`.
- Updated cache-busting app.js version.

## Deployment

1. Replace the current website files with the contents of this package.
2. No SQL migration is required for V14.
3. Test first in an iPhone browser/private tab.
4. Test sign-in and confirm Home appears immediately while the profile finishes hydrating.
5. Test opening the mobile Whisper composer.
6. Confirm the writing area is substantially larger.
7. Publish a Whisper and confirm the app immediately opens that Whisper page.
8. Confirm avatar circles show the profile photo when available, otherwise the contact icon.

## Cache

The app.js query string has been bumped. If an old UI remains visible, perform one hard refresh or clear the site's cached files once.
