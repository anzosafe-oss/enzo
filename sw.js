const CACHE='enzo-shell-v1.0.0';
const FILES=['./','./index.html','./app.js','./manifest.webmanifest','./vendor/supabase.min.js','./icons/favicon-32.png','./icons/apple-touch-icon.png','./icons/icon-192.png','./icons/icon-512.png','./icons/logo-original.png'];
self.addEventListener('install',e=>e.waitUntil(caches.open(CACHE).then(c=>c.addAll(FILES)).then(()=>self.skipWaiting())));
self.addEventListener('activate',e=>e.waitUntil(caches.keys().then(keys=>Promise.all(keys.filter(k=>k.startsWith('enzo-shell-')&&k!==CACHE).map(k=>caches.delete(k)))).then(()=>self.clients.claim())));
self.addEventListener('fetch',e=>{const u=new URL(e.request.url);if(e.request.method!=='GET'||u.origin!==self.location.origin||!FILES.some(p=>new URL(p,self.registration.scope).href===u.href))return;e.respondWith(fetch(e.request).then(r=>{if(r.ok){const copy=r.clone();caches.open(CACHE).then(c=>c.put(e.request,copy))}return r}).catch(()=>caches.match(e.request)))});
