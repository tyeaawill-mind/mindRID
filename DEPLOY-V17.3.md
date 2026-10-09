# mindRID V17.3 — Portal refinement

## Scope
- Landing-page design and copy are preserved from V17.1. `styles.css`, landing assets, and the guest-home markup are unchanged.
- Fixed the sign-out and password-recovery navigation calls to use `window.history.replaceState`. The route handler named `history()` shadowed the browser global when code used bare `history.replaceState`.
- Removed the duplicate quick-link strip from the authenticated Home feed. The same destinations remain available through the app navigation; feed tabs and the composer remain.
- Updated the `app.js` query version to bypass stale browser caches.

## Deploy
1. Back up the current hosted files.
2. Upload all files from this package, preserving the `assets/` folder.
3. In a private browser tab, test sign-in, sign-out, password recovery, Home, For You, Explore, Network, Messages, Profile, and mobile navigation.
4. Confirm the guest landing page visually matches the previous version.

## Verification limits
Static JavaScript syntax and archive integrity were checked. A live Supabase/browser test was not performed; verify the production workflows after deployment.
