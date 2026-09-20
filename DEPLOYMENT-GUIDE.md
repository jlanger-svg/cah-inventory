# Bring Audi Hampton Inventory Live — Step by Step

You do not need to know React or SQL. This deployment uses Supabase for the shared database and Netlify for HTTPS hosting.

## Part 1 — Create the Supabase backend
1. Create/sign in to a Supabase account and create a new project.
2. Give the project a name such as `audi-hampton-inventory` and save the database password somewhere secure.
3. Wait for the project to finish provisioning.
4. Open **SQL Editor** in the Supabase dashboard.
5. Create a new query. Open the included file `supabase.sql`, copy all of it, paste it into the SQL Editor, and click **Run**.
6. Open **Authentication** settings and make sure **Anonymous Sign-Ins** are enabled. This v1 uses anonymous authentication so dealership staff do not need individual passwords.
7. Open the project's API/settings page and copy the **Project URL** and the **publishable/anon key**. Do NOT use or expose the `service_role`/secret key.

## Part 2 — Put the project in GitHub
1. Create a new private GitHub repository named `audi-hampton-inventory`.
2. Upload the contents of this project folder to that repository. The files such as `package.json`, `src`, and `public` must be at the repository root.
3. Do not upload a real `.env` file. `.env.example` is safe because it contains placeholders only.

## Part 3 — Deploy with Netlify
1. Sign in to Netlify and choose **Add new project / Import an existing project**.
2. Connect GitHub and select the `audi-hampton-inventory` repository.
3. Netlify should detect the included `netlify.toml`. Build command is `npm run build`; publish directory is `dist`.
4. Before deploying, add two environment variables in the site's environment-variable settings:
   - `VITE_SUPABASE_URL` = your Supabase Project URL
   - `VITE_SUPABASE_ANON_KEY` = your Supabase publishable/anon key
5. Deploy the site. Netlify will give you an HTTPS `*.netlify.app` address.
6. Optional: in Netlify site settings, change the generated site name to something memorable if the desired name is available.

## Part 4 — First phone test
1. Open the Netlify HTTPS address on an iPhone or Android phone.
2. Enter your employee name.
3. Choose **Start new audit from XLSX/CSV** and select the Audi inventory export.
4. The first phone creates the shared audit. Other phones open the same URL, enter their names, and select that audit under **Recent shared audits**.
5. Open **Scan**, tap **Start camera**, and grant camera permission.
6. When the browser asks for location, choose **Allow While Using** / equivalent and enable precise location if the phone offers that choice. The app itself does not force precise location; it records what the browser supplies.
7. Point the camera at the printed windshield VIN and tap **Read VIN**.
8. Confirm that the stock number, VIN, scanner name, coordinates and GPS accuracy appear.
9. On a second phone, verify that the located count updates and the vehicle shows as found.

## Part 5 — Google Earth test
1. Scan several cars in different positions.
2. Open **Export** and choose **Export Google Earth KML**.
3. Open/import the KML in Google Earth. Each scan with coordinates is a placemark named with the stock number (or VIN when stock is unavailable).
4. Also export the reconciled CSV. The original dealership columns are preserved and the app adds: status, timestamp, scanner, latitude, longitude and GPS accuracy.

## Part 6 — Add to Home Screen
### iPhone
Open the live site in Safari, use Share, choose **Add to Home Screen**, and add it.

### Android
Open the live site in Chrome and use **Install app** or **Add to Home screen** (wording varies by browser/device).

## Operational test before trusting it
Test at least 10–15 vehicles under different windshield conditions: direct sun, shade, glare, dirty glass and different VIN plate styles. Compare every OCR result with the physical VIN. GPS accuracy can vary substantially near buildings and indoors; the exported `GPS Accuracy (m)` field is there so the coordinate is not presented with false precision.

## If OCR cannot read a VIN
Change the camera angle to reduce reflections, move closer while keeping all 17 characters visible, and scan again. Manual VIN entry remains available. The app deliberately avoids accepting a weak OCR result as a different vehicle.

## Production-hardening after the pilot
The v1 database uses anonymous authenticated users for low-friction internal testing. Before distributing the URL widely, move to staff email/SSO authentication and stricter row-level security. A custom domain is optional; the Netlify HTTPS address is enough for the pilot.
