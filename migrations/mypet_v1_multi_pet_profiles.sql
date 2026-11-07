create table public.pets (
 id uuid primary key default gen_random_uuid(),
 user_id uuid not null references auth.users(id) on delete cascade,
 name text not null check(length(trim(name)) between 1 and 80),
 breed text not null default '' check(length(breed)<=100),
 birth date not null,
 sex text not null default 'Mascul' check(sex in ('Mascul','Femelă')),
 breeder text not null default '' check(length(breeder)<=100),
 chip text not null default '' check(length(chip)<=30),
 created_at timestamptz not null default now(),
 unique(id,user_id)
);
create index pets_user_id_idx on public.pets(user_id);
alter table public.pets enable row level security;
revoke all on public.pets from anon;
grant select,insert,update,delete on public.pets to authenticated;
create policy pets_read on public.pets for select to authenticated using((select auth.uid())=user_id);
create policy pets_insert on public.pets for insert to authenticated with check((select auth.uid())=user_id and (select public.enzo_recent_password()));
create policy pets_update on public.pets for update to authenticated using((select auth.uid())=user_id and (select public.enzo_recent_password())) with check((select auth.uid())=user_id and (select public.enzo_recent_password()));
create policy pets_delete on public.pets for delete to authenticated using((select auth.uid())=user_id and (select public.enzo_recent_password()));
alter table public.health_records add column pet_id uuid;
insert into public.pets(user_id,name,breed,birth,breeder,chip)
select distinct user_id,'Quintus Enzo','Staffordshire Bull Terrier','2026-05-25'::date,'Transilvania Staff SBT','642096302089370' from public.health_records;
update public.health_records r set pet_id=p.id from public.pets p where p.user_id=r.user_id;
alter table public.health_records alter column pet_id set not null;
alter table public.health_records add constraint health_records_pet_owner_fkey foreign key(pet_id,user_id) references public.pets(id,user_id) on delete cascade;
create index health_records_pet_id_user_id_idx on public.health_records(pet_id,user_id);
create policy records_insert_recent_required on public.health_records as restrictive for insert to authenticated with check((select public.enzo_recent_password()));
create policy records_update_recent_required on public.health_records as restrictive for update to authenticated using((select public.enzo_recent_password())) with check((select public.enzo_recent_password()));
create policy records_delete_recent_required on public.health_records as restrictive for delete to authenticated using((select public.enzo_recent_password()));
