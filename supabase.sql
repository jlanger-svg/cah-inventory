create extension if not exists pgcrypto;

create table if not exists public.inventory_sessions (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  source_file text,
  created_at timestamptz not null default now(),
  created_by uuid default auth.uid()
);

create table if not exists public.inventory_vehicles (
  id uuid primary key default gen_random_uuid(),
  session_id uuid not null references public.inventory_sessions(id) on delete cascade,
  vin text not null,
  stock text,
  description text,
  original_data jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now(),
  unique(session_id, vin)
);

create table if not exists public.inventory_scans (
  id uuid primary key default gen_random_uuid(),
  session_id uuid not null references public.inventory_sessions(id) on delete cascade,
  vehicle_id uuid references public.inventory_vehicles(id) on delete cascade,
  vin text not null,
  stock text,
  employee_name text not null,
  latitude double precision,
  longitude double precision,
  accuracy_m double precision,
  source text not null default 'manual',
  scanned_at timestamptz not null default now(),
  created_by uuid default auth.uid(),
  unique(session_id, vin)
);

create table if not exists public.inventory_exceptions (
  id uuid primary key default gen_random_uuid(),
  session_id uuid not null references public.inventory_sessions(id) on delete cascade,
  vin text not null,
  employee_name text not null,
  latitude double precision,
  longitude double precision,
  accuracy_m double precision,
  source text not null default 'manual',
  scanned_at timestamptz not null default now(),
  created_by uuid default auth.uid()
);

alter table public.inventory_sessions enable row level security;
alter table public.inventory_vehicles enable row level security;
alter table public.inventory_scans enable row level security;
alter table public.inventory_exceptions enable row level security;

-- Internal v1: any authenticated (including anonymous) app user may read/write audit data.
create policy "authenticated sessions" on public.inventory_sessions for all to authenticated using (true) with check (true);
create policy "authenticated vehicles" on public.inventory_vehicles for all to authenticated using (true) with check (true);
create policy "authenticated scans" on public.inventory_scans for all to authenticated using (true) with check (true);
create policy "authenticated exceptions" on public.inventory_exceptions for all to authenticated using (true) with check (true);

alter publication supabase_realtime add table public.inventory_scans;
alter publication supabase_realtime add table public.inventory_exceptions;
