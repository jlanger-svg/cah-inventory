# Audi Hampton Physical Inventory — Production v1

Mobile-first React PWA for physical dealership inventory reconciliation.

## What it does
- Imports Audi inventory XLSX/CSV without changing the source file.
- Detects VIN by header (`Serial`, `VIN`, etc.) and stock by header (`Vehicle`, `Stock`, etc.).
- Reads the *printed* 17-character VIN using on-device OCR; no barcode is required.
- Matches OCR against the known inventory and can resolve a unique one-character OCR error.
- Captures timestamp, employee, latitude, longitude, and reported GPS accuracy.
- Shared Supabase audit: multiple iPhone/Android devices see the same scan results in near real time.
- Database uniqueness prevents the same VIN from counting twice.
- Saves valid VINs that are not in the uploaded inventory as exceptions.
- Exports a reconciled CSV and Google Earth KML.
- Can be installed to the phone home screen as a PWA.

## Fastest deployment
Read `DEPLOYMENT-GUIDE.md`. It walks through Supabase and Netlify from a blank account.

## Local development
1. Copy `.env.example` to `.env` and fill in Supabase values.
2. `npm install`
3. `npm run dev`

Camera and geolocation should be tested over HTTPS on a real phone. `localhost` is allowed by browsers for development, but another computer's LAN IP generally is not treated as a secure context.

## Security note
The included database policy is intentionally simple for an internal v1: any authenticated app user (including anonymous sign-in) can participate. Do not publish the app URL broadly. Before wider/company deployment, replace anonymous access with staff email/SSO and tighten RLS policies.
