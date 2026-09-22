# mindRID V9 — Edit Media, Thought Signals & Circles

## Deploy
1. Replace the website files with the contents of this package.
2. In Supabase SQL Editor, run the complete `schema.sql`.
3. Let the SQL finish completely before opening the site.
4. Test in a private/incognito window first.

## V9 changes
- Edit Whisper now lists existing media with individual Delete media controls.
- What people are thinking topics no longer display `#`; topic clicks search public Whispers by body and matching tag values.
- Mentions in the Whisper composer suggest people from the user's accepted network while typing `@...`.
- Groups are presented as Circles in the user interface.
- Circle menu includes Popular Circles.
- Joined Circle confirmation says: "You are a member now."
- Circle detail shows members and a public Whisper wall from Circle members.
- Circle adda includes member-only Circle messaging and a Live adda entry point.
- Circle messages use a dedicated `circle_messages` table with RLS.
- About copy updated to the approved mindRID wording.

`groups` remains the internal database table name for compatibility; the user-facing product term is Circle.
