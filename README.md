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
V15 additions
Account recovery: Forgot password → secure Supabase reset email → new password form.
Mobile navigation now exposes Messages directly; Network remains available from the wider navigation/profile areas.
Guest landing page includes the requested visible “100% AI-assisted platform” tagline.
Password recovery deployment requirement
In Supabase Auth URL Configuration, allow the production redirect URL:
`https://mindrid.com/?recovery=1`
For a staging/custom domain, add its equivalent recovery URL as an allowed redirect URL. The password reset flow itself uses Supabase Auth; no custom email service is added.
