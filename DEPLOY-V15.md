mindRID V16 Deployment
What changed
Added account recovery / Forgot password.
Added secure password reset completion flow.
Added Messages to the signed-in mobile bottom navigation.
Added the visible “100% AI-assisted platform” guest-home tagline.
Cache-busted `app.js` to V16.
Supabase Auth setup
The password recovery flow uses Supabase Auth's built-in password reset mechanism.
In Supabase → Authentication → URL Configuration, make sure the production recovery URL is allowed:
`https://mindrid.com/?recovery=1`
If the project is also used on another domain, add the corresponding recovery URL for that domain.
Password recovery test
Open mindRID while signed out.
Choose Sign in.
Choose Forgot password?.
Enter the account email.
Confirm the reset email is received.
Open the link.
Choose a new password twice.
Confirm the success message.
Sign in with the new password.
Mobile Messages test
On a signed-in phone-width screen, the bottom navigation should show:
Home
For You
Explore
Messages
Me
Selecting Messages opens the existing private messaging route.
AI tagline
The guest landing page displays:
100% AI-assisted platform
This is a product/brand claim and should remain only if it accurately describes the deployed product's actual AI assistance.
Database
No new database tables are required for these V16 changes. Existing Supabase Auth handles password recovery.
