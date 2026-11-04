# Carnet de Sanatate Enzo
Aplicație statică pentru GitHub Pages, cu Supabase Auth și baza de date `public.health_records`.

## Publicare
1. Încarcă în rădăcina repository-ului `enzo` fișierele index.html, app.js, manifest.webmanifest, sw.js și folderul vendor.
2. Settings → Pages → Deploy from a branch → main → /(root) → Save.
3. Deschide adresa afișată de GitHub Pages și autentifică-te cu utilizatorul creat în Supabase Authentication.

## Date și acces
Cheia publishable din app.js este destinată codului din browser. Nu introduce aici parole, chei secret sau service_role.
Tabelul trebuie să aibă RLS și politicile proprii pentru select/insert/update. Înregistrarea publică trebuie să rămână închisă.
Datele existente în Google Sheets nu sunt importate automat. Code.gs nu este folosit în această variantă.

## Testare
Autentificare; adăugare în fiecare categorie; modificare; reîncărcare; verificare pe al doilea dispozitiv; deconectare.
Testează cu înregistrări marcate TEST. Ștergerea este disponibilă după rularea SETUP_DELETE.sql în Supabase SQL Editor. Fiecare ștergere cere confirmare și este definitivă.

## Offline
Interfața poate fi disponibilă offline după prima vizită. Citirea și salvarea datelor necesită internet; nu există coadă de salvări offline.
## Actualizări
La schimbarea fișierelor, schimbă și numărul CACHE în sw.js. Fișierele sunt cerute mai întâi din rețea.
## Biblioteca
vendor/supabase.min.js: @supabase/supabase-js 2.49.8, distribuția UMD; licență MIT. Vezi SUPABASE-LICENSE.txt.

## Versiunea 4
Include iconițe locale, corecția Safari, titlul categoriei în card și ștergere cu confirmare.
Rulează SETUP_DELETE.sql în Supabase SQL Editor înainte de testarea ștergerii. Nu modifică sau șterge date existente.
