# Enzo — version 5
GitHub Pages + Supabase. Private viewing with persistent login; password confirmation unlocks add, update and delete for five minutes. Reloading the page resets the local edit lock. Expired/revoked sessions or browser storage clearing require login again. Private browsing may not preserve the session after closing.

## Upgrade from v4
1. Run SETUP_PRIVATE_EDIT.sql in Supabase SQL Editor. It adds restrictive policies; no records are deleted. Existing own-record policies remain required.
2. Upload index.html, app.js, sw.js, manifest.webmanifest, icons/ and vendor/ to the repository root. Include SUPABASE-LICENSE.txt. SQL files do not need to be uploaded to GitHub.
3. Wait for Pages publication, close and reopen the app, then test sign-in, read, password confirmation, add, update, cancel and delete with disposable test records.
4. After 5 minutes reading should remain available, while editing requests a password again.

## Fresh installation only
The base health_records schema and own-record select/insert/update policies must already exist. Run SETUP_DELETE.sql for delete permission, then SETUP_PRIVATE_EDIT.sql. Public sign-up should remain disabled.

No private records or passwords are bundled. Publishable configuration is intentionally public. Google Sheets records have not been migrated.
