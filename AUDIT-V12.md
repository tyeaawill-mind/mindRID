# mindRID V12 Deep Audit / QA Record

## Scope

Reviewed the V11 web package and the V0.1 iOS project at source level, including JavaScript syntax, HTML structure, CSS responsive rules, database/RLS design, storage lifecycle, authentication flows, media flows, search, Circles, notifications, messaging and the iOS project configuration.

## Findings corrected

### P0 / critical interaction
1. **Mobile composer field collision** — V11 rendered a hidden desktop composer and a mobile modal composer with the same IDs. DOM lookup could therefore target the hidden composer. V12 scopes composer controls to the active composer root.

### P1 / reliability and security
2. **Search filter robustness** — V11 inserted user search text directly into PostgREST `.or(...)` expressions. V12 sanitizes search terms and uses separate profile queries where practical.
3. **Deactivated content visibility** — public Whisper visibility now checks that the author's profile is active.
4. **Blocked conversation/connection paths** — new conversations and connection requests reject blocked pairs at the database function level.
5. **Account deletion media lifecycle** — V12 attempts to remove the user's private media-storage objects before deleting the auth account.
6. **Profile photo lifecycle** — failed profile updates clean up the newly uploaded photo; successful replacement removes the old photo.
7. **Partial tag-save failure** — a tag problem no longer makes a successfully created Whisper look like a failed post.
8. **Username normalization** — signup now prevents unusably short usernames after normalization.

### P2 / UX
9. Search results now have a dedicated public-person profile surface.
10. Search has keyboard-friendly form submission.
11. Modal Escape/backdrop dismissal was added.
12. Touch target and focus-state rules were strengthened.
13. Mobile modal safe-area handling was strengthened.

## Static verification completed

- `node --check app.js` — passed.
- HTML parsed with BeautifulSoup — passed; no duplicate IDs in the static index.
- `Info.plist` — `plutil -lint` passed.
- iOS Swift source — `swiftc -parse` passed in the available Linux Swift parser.
- Xcode project was inspected for target configuration and resource membership.
- AppIcon and launch assets are now included in the Xcode resource phase.

## iOS corrections

The previous iOS package had two important architectural issues:

- The native tab bar could coexist with mindRID's own mobile bottom navigation, producing competing navigation surfaces.
- The Xcode project contained an asset catalog but did not include it in the resources build phase.

V0.2 corrects both and adds:

- route synchronization between web and native navigation
- native bottom navigation without the duplicate web mobile bar
- offline monitoring with `NWPathMonitor`
- external-link handling
- `target="_blank"` handling
- mail/tel handoff to iOS
- accessibility labels and selected-state semantics
- AppIcon resource inclusion
- safe-area content spacing

## Not possible in this environment

A real App Store/iPhone build cannot be executed here because Xcode/iOS SDK and Apple signing are macOS-only. The iOS package therefore has source-level Swift parsing and project/resource validation, but final device compilation/signing must be performed on macOS with Xcode.

## Design basis

The finishing pass follows current Apple Human Interface Guidance for adaptive layout, progressive disclosure, familiar navigation, adequate touch targets, clear press states and accessibility. Apple currently recommends at least a 44×44 pt hit region for buttons and emphasizes layouts that adapt across display sizes. See the Apple HIG references in the delivery response.
