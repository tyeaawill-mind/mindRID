mindRID V10 — Responsive UX deployment
What changed
Mobile Whisper composer is now a full-height focused writing surface with a large text area, compact header, and bottom publish action.
Signed-in and logged-out Home experiences are separated. Guests see a landing message, public thought discovery, and sign-in/create-account actions; signed-in users see their social feed and authenticated navigation.
Home hero wording is Get rid. with a small inline bird-in-blue-sky sketch.
Desktop and mobile navigation now follow familiar large-social-network interaction conventions: persistent primary navigation on desktop, compact bottom navigation on mobile, focused creation flow, and clear feed hierarchy.
Existing mindRID thought-first features remain unchanged.
Deployment
Replace the current website files with the contents of this ZIP.
No database/schema change is required for V10.
Test in a private/incognito window after deployment.
Test both states: logged out and logged in.
On a phone, tap the + button or the What’s on your mind? composer strip and verify that the writing area occupies most of the screen.
Important
The implementation follows Facebook-like interaction conventions and responsive hierarchy, but does not copy Facebook branding, proprietary assets, or source code.
