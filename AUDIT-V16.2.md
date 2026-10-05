# mindRID V16.2 — Landing Bird + Reliability Audit

## Scope
V16.2 is a focused reliability and landing-page polish release built on V16.1.

## Fixed
- Mobile bottom navigation explicitly includes **Messages**.
- Sign-out now clears the active Whisper/session navigation state and returns to the clean landing page.
- The application no longer depends on the nonexistent `profiles.last_whisper_body` column.
- Password recovery now requests a Supabase reset link with an explicit redirect to `https://mindrid.com/?recovery=1` (derived from the live site origin), and the app opens the **Choose a new password** modal when the recovery session is returned.
- Recovery URL is cleaned after a successful password update.
- `app.js` cache version advanced to `20261005-02`.

## Landing visual
- Supplied bird artwork retained and colour-balanced toward the mindRID lavender/blue palette.
- Black-background GIF replaced with a transparent animated GIF.
- Bird reduced to approximately two-thirds of the previous V16 display size.
- Bird animation combines wing-flap frames with a gentle flight motion.
- Three flight trails are deliberately non-parallel, curved, dashed and subtly animated.
- Desktop landing composition widened and vertically balanced.
- Mobile bird remains compact and responsive.
- Poem panel remains borderless on the left side.
- AI tagline remains below the quiet-place trust line.

## Validation
- JavaScript syntax check: passed.
- GIF transparency check: passed; corner pixels are transparent.
- Animated GIF frame count: 10.
- ZIP/package integrity: to be checked at final packaging.

## Deployment requirement
In Supabase Authentication → URL Configuration:
- Site URL: `https://mindrid.com`
- Additional Redirect URL: `https://mindrid.com/?recovery=1`

After deployment, request a **new** password-reset email. Previously issued emails may still contain the previous redirect target.
