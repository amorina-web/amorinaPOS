-- Amorina: pegar completo en Supabase > SQL Editor > Run

create table config (id int primary key default 1 check (id = 1), margen numeric not null default 100);
insert into config (id) values (1);

create table medios_pago (
  id bigint generated always as identity primary key,
  nombre text not null,
  recargo numeric not null default 0
);
insert into medios_pago (nombre, recargo) values ('Efectivo',0),('Transferencia',0),('Débito',0),('Crédito',10);

create table productos (
  id bigint generated always as identity primary key,
  nombre text not null,
  sku text not null unique,
  talle text,
  costo numeric not null default 0,
  precio numeric not null default 0,
  stock int not null default 0
);

create table ventas (
  id bigint generated always as identity primary key,
  fecha timestamptz not null default now(),
  subtotal numeric not null,
  recargo numeric not null default 0,
  total numeric not null,
  medio_pago text not null
);
create table venta_items (
  id bigint generated always as identity primary key,
  venta_id bigint not null references ventas(id) on delete cascade,
  producto_id bigint references productos(id) on delete set null,
  nombre text, sku text, talle text,
  cantidad int not null,
  precio numeric not null
);

create table compras (
  id bigint generated always as identity primary key,
  fecha timestamptz not null default now(),
  proveedor text not null,
  envio numeric not null default 0,
  estado text not null default 'pendiente',
  recibida_el timestamptz
);
create table compra_items (
  id bigint generated always as identity primary key,
  compra_id bigint not null references compras(id) on delete cascade,
  producto_id bigint references productos(id) on delete set null,
  descripcion text,
  cantidad int not null,
  costo numeric not null default 0
);

create function ajustar_stock(p_id bigint, p_delta int) returns void
language sql as $$ update productos set stock = stock + p_delta where id = p_id $$;

-- Seguridad: solo usuarios logueados pueden leer y escribir
do $$
declare t text;
begin
  foreach t in array array['config','medios_pago','productos','ventas','venta_items','compras','compra_items'] loop
    execute format('alter table %I enable row level security', t);
    execute format('create policy "solo logueados" on %I for all to authenticated using (true) with check (true)', t);
  end loop;
end $$;
