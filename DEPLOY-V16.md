# mindRID V16 — Landing Visual Update

## Included
- Supplied bird artwork added as `assets/landing-bird.gif` with transparent background and subtle motion.
- `assets/landing-bird.png` included as a static source/fallback asset.
- Three curved flight trails integrated behind the bird.
- Bird color grading tuned toward mindRID’s sky/lavender/plum palette.
- Landing message left border removed.
- `100% AI-assisted platform` moved below the “A quiet place…” line.
- Landing background rebalanced for blue → lavender atmosphere with a restrained warm glow.
- `app.js` cache-busted to `?v=20261004-02`.

## Deployment
1. Upload the entire package contents to the existing mindrid.com static site.
2. Keep the `assets/` directory and both bird files.
3. Hard refresh / clear the old cached `app.js` if the old landing illustration appears.
4. Verify the landing page on iPhone width and desktop width.

No database or Supabase schema changes are required for this visual update.
