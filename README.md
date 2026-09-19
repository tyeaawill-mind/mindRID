mindRID — Reliable Recovery Build
This is the controlled recovery baseline for mindRID.
It uses plain HTML, CSS and JavaScript with Supabase. No build system, Node application, Edge Function, Gmail integration, or welcome email is included.
Replace the existing website files with this package. Then run `schema.sql` in the Supabase SQL Editor.
The first goal is reliability of the core loop: open → account → Whisper → open Whisper → reply.
This recovery package also includes: Saved Whispers (`public.saves`), private one-to-one Messages, and expandable image/video/audio media. Run the full `schema.sql` in Supabase before testing. The script explicitly reloads the PostgREST schema cache so the `public.saves` table is visible to the browser API.
