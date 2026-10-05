# mindRID V16.3 Deployment

1. Replace the deployed V16.2 files with the complete contents of this package.
2. Keep `assets/landing-bird.gif` and `assets/landing-bird.png` in the `assets/` folder beside `index.html`.
3. In Supabase Authentication → URL Configuration, keep:
   - Site URL: `https://mindrid.com`
   - Additional Redirect URL: `https://mindrid.com/?recovery=1`
4. Request a NEW password-reset email after deployment. Existing reset emails can contain an older redirect.
5. If GitHub Pages is used, replace the repository contents rather than uploading only individual CSS/JS files.
6. After deployment, hard-refresh once on desktop and clear the site cache on mobile if the previous bird size persists.
