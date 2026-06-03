-- Run this once in Supabase SQL Editor.
-- This project is a personal shared album, so these policies allow public read/write
-- through the site's publishable key. Do not store private data here.

create extension if not exists pgcrypto;

create table if not exists public.place_notes (
  place_id text primary key,
  note text not null default '',
  updated_at timestamptz not null default now()
);

create table if not exists public.place_photos (
  id uuid primary key default gen_random_uuid(),
  place_id text not null,
  storage_path text not null unique,
  public_url text not null,
  caption text,
  created_at timestamptz not null default now()
);

alter table public.place_notes enable row level security;
alter table public.place_photos enable row level security;

drop policy if exists "place_notes_public_read" on public.place_notes;
drop policy if exists "place_notes_public_insert" on public.place_notes;
drop policy if exists "place_notes_public_update" on public.place_notes;
drop policy if exists "place_notes_public_delete" on public.place_notes;

create policy "place_notes_public_read"
on public.place_notes for select
using (true);

create policy "place_notes_public_insert"
on public.place_notes for insert
with check (true);

create policy "place_notes_public_update"
on public.place_notes for update
using (true)
with check (true);

create policy "place_notes_public_delete"
on public.place_notes for delete
using (true);

drop policy if exists "place_photos_public_read" on public.place_photos;
drop policy if exists "place_photos_public_insert" on public.place_photos;
drop policy if exists "place_photos_public_delete" on public.place_photos;

create policy "place_photos_public_read"
on public.place_photos for select
using (true);

create policy "place_photos_public_insert"
on public.place_photos for insert
with check (true);

create policy "place_photos_public_delete"
on public.place_photos for delete
using (true);

insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values (
  'memory-photos',
  'memory-photos',
  true,
  10485760,
  array['image/jpeg', 'image/png', 'image/webp']
)
on conflict (id) do update
set
  public = excluded.public,
  file_size_limit = excluded.file_size_limit,
  allowed_mime_types = excluded.allowed_mime_types;

drop policy if exists "memory_photos_public_read" on storage.objects;
drop policy if exists "memory_photos_public_insert" on storage.objects;
drop policy if exists "memory_photos_public_delete" on storage.objects;

create policy "memory_photos_public_read"
on storage.objects for select
using (bucket_id = 'memory-photos');

create policy "memory_photos_public_insert"
on storage.objects for insert
with check (bucket_id = 'memory-photos');

create policy "memory_photos_public_delete"
on storage.objects for delete
using (bucket_id = 'memory-photos');
