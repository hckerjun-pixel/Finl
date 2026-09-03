# Meesho Shop — Emerald (Flat · Render Ready)

Completely **flat** project (no folders). Easy to upload from phone and push to GitHub.

## Fixes in this build
- **Login loop fixed**: session token is trusted; login gate no longer re-opens on every 401. Stable `SESSION_SECRET` so tokens survive restarts.
- **Premium OTP UI**: Send OTP / Verify buttons with emerald gradient + outlined Resend.
- **Payment flow**: uses live Meesho `paymentinfo` for dynamic UPI/QR (original Meesho QR when API returns it). Confirm after pay via payment_status.
- **Emerald green gradient UI** throughout.
- **Flat files only** — no nested folders.

## Deploy on Render (phone-friendly)

1. Create empty GitHub repo.
2. Upload **all files from this zip root** (no subfolders needed).
3. Render → New Web Service → connect repo.
4. Settings:
   - Build: `pip install -r requirements.txt`
   - Start: `uvicorn app:app --host 0.0.0.0 --port $PORT`
5. **Important env var** (stops login-again-and-again after restart):
   - `SESSION_SECRET` = any long random string (e.g. `my-super-secret-32chars-xyz`)
   - `WEBAPP_URL` = your https://xxxx.onrender.com

## Local run
```bash
pip install -r requirements.txt
mkdir -p state
export SESSION_SECRET=local-dev-secret
uvicorn app:app --host 0.0.0.0 --port 8000
```

## Files (all at root)
```
app.py                  FastAPI backend
meesho_api.py           Meesho API client
index.html              Full SPA (Emerald)
leaflet.js / leaflet.css / telegram-web-app.js
layers.png / layers-2x.png / marker-icon.png
requirements.txt
Procfile
start.sh
bot.py / bot_config.json   optional Telegram launcher
.gitignore
README.md
```

`state/` is created automatically at runtime (not in the repo).

## Payment note
Prepaid flow requests real Meesho paymentinfo → dynamic UPI intent / QR. After you pay in any UPI app, tap **Check payment status** (or it polls) → order confirmed when Meesho marks paid. New-account first-order discount is applied when Meesho’s API returns FOD for that account.

If login still loops after deploy: set `SESSION_SECRET` and hard-refresh the browser (clear site data once).
