mindRID V13 — Finished Product Pass
A deployable web release built from the V12 package and subjected to a source-level reliability, security, performance and UX review.
Included
Thought-first Home with For You / Following / Timeline feed choices.
Following / Followers system.
Timeline, Spaces, Community, History and Whisper Memory.
Scrollable desktop navigation and iPhone-aware mobile/PWA shell.
Profile photo + background photo + selectable/automatic theme.
Approved guest “Get rid” hero wording and flying-bird/triple-flight-line treatment.
Search hardening, route refresh corrections and feed/media performance improvements.
Read `DEPLOY-V13.md` before deployment and the updated audit record for the QA scope.
V14 final pass
Faster perceived sign-in through immediate authenticated rendering and background profile hydration.
Larger writing surface on desktop and iPhone.
“What’s going through your mind?” composer language.
Direct navigation to the newly published Whisper.
Contact-icon avatar fallback instead of initials.
Reflection-oriented descriptive language.
Swift-inspired landing bird with triple flight lines.
V16 landing visual update
Replaced the previous landing-page bird illustration with the supplied bird artwork, packaged as a lightweight animated GIF with transparent background.
Added three soft, curved flight trails matched to the new bird.
Refined the bird palette with restrained saturation/contrast so the lavender/plum body harmonizes with mindRID's sky/lavender portal palette while retaining the warm beak accent.
Moved the 100% AI-assisted platform tagline below the “A quiet place…” trust line.
Removed the left-side border from the landing-page message block.
Rebalanced the landing-page sky/lavender/warm-light color dynamics for a calmer, more cohesive appearance.
V15 additions
Account recovery: Forgot password → secure Supabase reset email → new password form.
Mobile navigation now exposes Messages directly; Network remains available from the wider navigation/profile areas.
Guest landing page includes the requested visible “100% AI-assisted platform” tagline.
Password recovery deployment requirement
In Supabase Auth URL Configuration, allow the production redirect URL:
`https://mindrid.com/?recovery=1`
For a staging/custom domain, add its equivalent recovery URL as an allowed redirect URL. The password reset flow itself uses Supabase Auth; no custom email service is added.
V16.1 reliability patch
Mobile Messages visibility reinforced.
Logout returns to landing page.
Removed invalid profiles.last_whisper_body dependency.
Password recovery uses Supabase production Site URL by default.
