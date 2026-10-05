# Deploy mindRID V16.5

1. Replace the deployed V16.3 files with the complete contents of this package.
2. Keep `assets/` beside `index.html`.
3. Ensure `assets/landing-bird.webp` and `assets/landing-bird.gif` are both uploaded.
4. Supabase password recovery configuration from V16.3 remains required:
   - Site URL: `https://mindrid.com`
   - Additional Redirect URL: `https://mindrid.com/?recovery=1`
5. After deployment, hard refresh or use a private window once so the V16.5 cache-busted assets load.
6. Test both desktop and iPhone-width views.
7. Test a new password-reset email after deployment.

No database migration is introduced by V16.5.
