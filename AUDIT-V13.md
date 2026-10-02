# mindRID V13 Deep Audit / QA Record

## Scope

Source-level review of the V12 package and a finishing pass over navigation, guest/auth state, mobile/iPhone UX, search, profile customization, follows, history, feed performance, storage lifecycle, RLS and route interactions.

## Material findings corrected

### P0 — product correctness
1. **For You was missing from the V12 navigation despite being approved.** Added as a real feed route and as a Home feed tab.
2. **V12 guest copy had reverted to the earlier prose.** Restored the approved six-line “When something weighs upon the mind…” wording.
3. **V12 bird treatment did not match the approved direction.** Reworked it to a small original flying-bird silhouette with three curved flight lines and a sky/cloud treatment.

### P1 — reliability/security
4. **Search wildcard handling was incomplete.** `searchWhispers()` now uses the same sanitized search term path as global search.
5. **Auth-state handling could repeat profile setup and renders.** Added same-user session suppression.
6. **Connection actions could refresh the wrong page.** Refresh now respects the current route.
7. **Profile background-photo support was absent.** Added dedicated background storage path, storage policy support, replacement cleanup and profile rendering.
8. **Following/Followers were previously represented only by Connections.** Added a separate follows model with RLS and follow notification trigger.
9. **History was absent.** Added per-user Whisper viewing history with owner-only RLS.
10. **Auto profile theme previously had no durable vibe signal.** The profile stores only a derived `last_whisper_vibe`, not the full Whisper body.

### P2 — performance / UX
11. Added a short-lived public-feed cache to reduce repeated navigation queries.
12. Reduced initial media work by separating feed data from media hydration and keeping media work lazy-oriented.
13. Added scrollable desktop navigation so the expanded menu does not run off-screen.
14. Added iPhone/PWA metadata and Apple touch icon.
15. Added profile stats, Wall surface, follow/unfollow controls and clearer profile hierarchy.
16. Added Spaces, Community and Help & Support as lightweight integration surfaces rather than pretending they are already separate large products.

## Static verification

- JavaScript syntax checked with Node.
- Static HTML duplicate-ID check performed.
- Package contents inspected after modification.
- SQL inspected for new tables, policies, functions, indexes and storage-policy coverage.

## Important deployment note

Run the complete `schema.sql` in this package from top to bottom. The schema uses `drop policy if exists` / `create policy` patterns for rerunnable policy changes and contains the V13 additions.

## Known product boundary

The current Live system remains the existing one-to-one WebRTC/broadcast architecture. “Spaces” is a navigation/discovery surface, not a new multiparty live infrastructure. A true large-room Spaces product would require a separate realtime/SFU architecture and should not be faked as a finished feature.

The product uses **Connections** for mutual network relationships and **Following** for one-way thought subscriptions. They are intentionally separate.

No external proprietary Facebook/Twitter artwork is included. The bird is an original simple silhouette inspired by the requested visual language.
