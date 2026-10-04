# mindRID V15 Deployment

## What changed
1. Added account recovery / Forgot password.
2. Added secure password reset completion flow.
3. Added Messages to the signed-in mobile bottom navigation.
4. Added the visible “100% AI-assisted platform” guest-home tagline.
5. Cache-busted `app.js` to V15.

## Supabase Auth setup
The password recovery flow uses Supabase Auth's built-in password reset mechanism.

In **Supabase → Authentication → URL Configuration**, make sure the production recovery URL is allowed:

`https://mindrid.com/?recovery=1`

If the project is also used on another domain, add the corresponding recovery URL for that domain.

## Password recovery test
1. Open mindRID while signed out.
2. Choose **Sign in**.
3. Choose **Forgot password?**.
4. Enter the account email.
5. Confirm the reset email is received.
6. Open the link.
7. Choose a new password twice.
8. Confirm the success message.
9. Sign in with the new password.

## Mobile Messages test
On a signed-in phone-width screen, the bottom navigation should show:
- Home
- For You
- Explore
- Messages
- Me

Selecting **Messages** opens the existing private messaging route.

## AI tagline
The guest landing page displays:
**100% AI-assisted platform**

This is a product/brand claim and should remain only if it accurately describes the deployed product's actual AI assistance.

## Database
No new database tables are required for these V15 changes. Existing Supabase Auth handles password recovery.
