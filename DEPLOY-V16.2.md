# mindRID V16.2 — Deployment

1. Replace the current V16.1 site files with the contents of this package.
2. Keep the `assets/` folder in the same directory as `index.html`.
3. Do not rename or move `assets/landing-bird.gif`.
4. In Supabase → Authentication → URL Configuration, confirm:
   - Site URL: `https://mindrid.com`
   - Additional Redirect URL: `https://mindrid.com/?recovery=1`
5. Deploy the files.
6. Open `https://mindrid.com/` in a private/incognito window for the first verification.
7. Test in this order:
   - Landing page: no black rectangle around bird.
   - Bird: smaller, transparent, visibly flapping and moving along three curved trails.
   - Mobile: bottom navigation includes **Messages**.
   - Sign in → open a Whisper → sign out → landing page appears.
   - Forgot password → request a **new** email → click reset link → mindRID **Choose a new password** modal appears.
   - Set a new password → success confirmation → clean mindRID home.

## No database migration
V16.2 does not require a database schema migration for these fixes.
