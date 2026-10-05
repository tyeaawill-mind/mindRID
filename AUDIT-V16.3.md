# mindRID V16.3 Audit

## Scope
- Rebalanced the supplied animated landing bird to a smaller, more elegant desktop/mobile proportion.
- Tightened and softened the three curved flight trails so they support the bird instead of competing with the wordmark.
- Preserved the supplied bird artwork, transparency, wing-flap animation and mindRID palette.
- Hardened password-recovery detection so Supabase recovery links work whether the redirect arrives with `?recovery=1` or with recovery tokens/type in the URL fragment.
- Prevented the normal session-render path from losing the recovery modal during auth-state races.

## Bird sizing
- Desktop: 112px image width.
- Tablet: 104px.
- Smartphone: 78px.
- Corresponding flight-line containers were reduced proportionally.

## Recovery
The app now recognizes:
- `?recovery=1`
- `#...type=recovery...`
- recovery access-token fragments

On `PASSWORD_RECOVERY`, the reset modal is opened and protected from the ordinary home-render race. Successful password update clears the recovery state and returns to `#home`.

## Validation
- JavaScript syntax check: passed.
- ZIP integrity: passed.
- `profiles.last_whisper_body` dependency: absent.
- Mobile Messages navigation: retained.
- Animated bird asset: retained with transparency and 10-frame animation.
