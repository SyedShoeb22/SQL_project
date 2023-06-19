--
-- postgresql database dump
--

-- dumped from database 
-- dumped by pg_dump 

set statement_timeout = 0;
set lock_timeout = 0;
set idle_in_transaction_session_timeout = 0;
set client_encoding = 'utf8';
set standard_conforming_strings = on;
select pg_catalog.set_config('search_path', '', false);
set check_function_bodies = false;
set xmloption = content;
set client_min_messages = warning;
set row_security = off;

-- drop database parch_and_posey;
--
-- name: parch_and_posey; type: database; schema: -; owner: -
--

create database parch_and_posey with template = template0 encoding = 'utf8' lc_collate = 'english_united states.1252' lc_ctype = 'english_united states.1252';


set statement_timeout = 0;
set lock_timeout = 0;
set idle_in_transaction_session_timeout = 0;
set client_encoding = 'utf8';
set standard_conforming_strings = on;
select pg_catalog.set_config('search_path', '', false);
set check_function_bodies = false;
set xmloption = content;
set client_min_messages = warning;
set row_security = off;

set default_table_access_method = heap;

--
-- name: accounts; type: table; schema: public; owner: -
--

create table public.accounts (
    id integer not null,
    name character varying not null,
    website character varying,
    lat numeric,
    long numeric,
    primary_poc character varying,
    sales_rep_id integer
);


--
-- name: orders; type: table; schema: public; owner: -
--

create table public.orders (
    id integer not null,
    account_id integer not null,
    occurred_at timestamp without time zone not null,
    standard_qty integer,
    gloss_qty integer,
    poster_qty integer,
    total integer,
    standard_amt_usd numeric,
    gloss_amt_usd numeric,
    poster_amt_usd numeric,
    total_amt_usd numeric
);


--
-- name: region; type: table; schema: public; owner: -
--

create table public.region (
    id integer not null,
    name character varying not null
);


--
-- name: sales_reps; type: table; schema: public; owner: -
--

create table public.sales_reps (
    id integer not null,
    name character varying not null,
    region_id integer not null
);


--
-- name: web_events; type: table; schema: public; owner: -
--

create table public.web_events (
    id integer not null,
    account_id integer not null,
    occurred_at timestamp without time zone not null,
    channel character varying not null
);


--
-- name: accounts accounts_pkey; type: constraint; schema: public; owner: -
--

alter table only public.accounts
    add constraint accounts_pkey primary key (id);


--
-- name: orders orders_pkey; type: constraint; schema: public; owner: -
--

alter table only public.orders
    add constraint orders_pkey primary key (id);


--
-- name: region region_pkey; type: constraint; schema: public; owner: -
--

alter table only public.region
    add constraint region_pkey primary key (id);


--
-- name: sales_reps sales_reps_pkey; type: constraint; schema: public; owner: -
--

alter table only public.sales_reps
    add constraint sales_reps_pkey primary key (id);


--
-- name: web_events web_events_pkey; type: constraint; schema: public; owner: -
--

alter table only public.web_events
    add constraint web_events_pkey primary key (id);


--
-- name: accounts accounts_sales_rep_id_fkey; type: fk constraint; schema: public; owner: -
--

alter table only public.accounts
    add constraint accounts_sales_rep_id_fkey foreign key (sales_rep_id) references public.sales_reps(id) on delete cascade;


--
-- name: orders orders_account_id_fkey; type: fk constraint; schema: public; owner: -
--

alter table only public.orders
    add constraint orders_account_id_fkey foreign key (account_id) references public.accounts(id) on delete cascade;


--
-- name: sales_reps sales_reps_region_id_fkey; type: fk constraint; schema: public; owner: -
--

alter table only public.sales_reps
    add constraint sales_reps_region_id_fkey foreign key (region_id) references public.region(id) on delete cascade;


--
-- name: web_events web_events_account_id_fkey; type: fk constraint; schema: public; owner: -
--

alter table only public.web_events
    add constraint web_events_account_id_fkey foreign key (account_id) references public.accounts(id) on delete cascade;


--
-- postgresql database dump complete
--

