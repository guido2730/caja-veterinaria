-- Fotos de productos: tabla nueva para sincronizar las fotos entre dispositivos.
-- Pegar en Supabase > SQL Editor > Run (proyecto de la caja: usrbmmnnqecurmvwlodl).
-- Se puede correr más de una vez sin problema. No toca ninguna tabla existente.

create table if not exists public.photos (
  id text primary key,
  data jsonb not null,
  updated_at timestamptz not null default now()
);

alter table public.photos enable row level security;

drop policy if exists "solo usuarios autenticados" on public.photos;
create policy "solo usuarios autenticados" on public.photos
  for all to authenticated using (true) with check (true);
