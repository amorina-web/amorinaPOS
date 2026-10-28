# Amorina – Sistema de ventas

App web sin build (un solo `index.html`) + Supabase + Vercel. Todo en planes gratuitos.

## 1. Supabase
1. Crear proyecto en supabase.com.
2. **SQL Editor** → pegar `schema.sql` → Run.
3. **Authentication → Users → Add user**: tu email y contraseña (tildar "Auto confirm").
4. **Authentication → Sign In / Providers → Email**: desactivar **Allow new users to sign up** (así nadie más puede crearse una cuenta).
5. **Project Settings → API**: copiar *Project URL* y la clave *anon public*.
6. Pegarlas en las dos constantes del comienzo del script en `index.html`.

## 2. GitHub
Crear un repositorio y subir `index.html`, `schema.sql` y `README.md`.

## 3. Vercel
**Add New → Project** → importar el repositorio → Deploy (sin configurar nada más).
Cada `git push` publica solo la nueva versión.

## Uso en el celular
- Abrir la URL de Vercel y "Agregar a pantalla de inicio".
- El escáner pide permiso de cámara (funciona porque Vercel usa HTTPS).
- El código de barras de la etiqueta debe ser igual al **SKU** cargado en el producto.
- Flujo de compras: cargar compra → al llegar la mercadería, "Marcar como recibida" suma el stock y actualiza el costo de los productos vinculados.
