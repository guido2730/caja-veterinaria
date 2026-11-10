# Caja veterinaria

## Hosting y despliegue
- La app se publica en **GitHub Pages** desde la rama `main`. **No usa Vercel** (ni Netlify): no consultar ni usar herramientas de Vercel.
- Cada merge a `main` dispara el workflow "pages build and deployment". Para confirmar que se publicó, mirar ese workflow en GitHub Actions (tarda ~1 min).
- No hay CI propio ni plantilla de PR.

## Service worker
- `sw.js` sirve desde caché. Al cambiar `index.html` u otros archivos de la app, subir `CACHE` (`caja-vN`) para que los teléfonos se actualicen.
- Tras publicar, el teléfono puede tardar una o dos aperturas completas en tomar la versión nueva.

## Datos
- Backend: Supabase (`supabase/schema.sql`).
- En el dispositivo todo vive en IndexedDB (base `caja_meta`, almacén `kv`): tablas en `data:<tabla>`, estado de sincronización en `map:<tabla>`, fotos en `foto:<id>`. `localStorage` queda solo para preferencias y como respaldo si IndexedDB no está disponible; `storeInit()` migra los datos viejos.
- Las fotos de productos se sincronizan por la tabla `photos`.
- Borrar los datos del sitio en el teléfono puede perder datos locales no sincronizados.

## Idioma
- Interfaz y comunicación con el usuario en español.
