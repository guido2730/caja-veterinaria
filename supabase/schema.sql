-- Caja Veterinaria: tablas para sincronizar entre dispositivos.
-- Pegar en Supabase > SQL Editor > Run (en el proyecto nuevo de la caja).
--
-- ANTES: Authentication > Sign In / Providers (o Settings) > desactivar "Allow new users to sign up".
-- Sin eso, cualquiera podría crearse una cuenta y entrar a los datos.

do $$
declare t text;
begin
  foreach t in array array['products','services','movements','sessions','stocklog','settings'] loop
    execute format('create table if not exists public.%I (
      id text primary key,
      data jsonb not null,
      updated_at timestamptz not null default now()
    )', t);
    execute format('alter table public.%I enable row level security', t);
    execute format('drop policy if exists "solo usuarios autenticados" on public.%I', t);
    execute format('create policy "solo usuarios autenticados" on public.%I
      for all to authenticated using (true) with check (true)', t);
  end loop;
end $$;
