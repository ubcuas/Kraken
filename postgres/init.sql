--
-- PostgreSQL database cluster dump
--

-- Started on 2022-02-12 22:34:13 PST

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

CREATE ROLE krakendbuser;
ALTER ROLE krakendbuser WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'md58886a89ca0c4f6b8848f64bdac0865a3';
-- CREATE ROLE postgres;
-- ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS;






--
-- Databases
--

--
-- Database "template1" dump
--

\connect template1

--
-- PostgreSQL database dump
--

-- Dumped from database version 10.6 (Debian 10.6-1.pgdg90+1)
-- Dumped by pg_dump version 14.0

-- Started on 2022-02-12 22:34:13 PST

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

-- Completed on 2022-02-12 22:34:14 PST

--
-- PostgreSQL database dump complete
--

--
-- Database "krakendb" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 10.6 (Debian 10.6-1.pgdg90+1)
-- Dumped by pg_dump version 14.0

-- Started on 2022-02-12 22:34:14 PST

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 2871 (class 1262 OID 16385)
-- Name: krakendb; Type: DATABASE; Schema: -; Owner: krakendbuser
--

CREATE DATABASE krakendb WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8';


ALTER DATABASE krakendb OWNER TO krakendbuser;

\connect krakendb

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

--
-- TOC entry 199 (class 1259 OID 16433)
-- Name: logs; Type: TABLE; Schema: public; Owner: krakendbuser
--

CREATE TABLE public.logs (
    id integer NOT NULL,
    origin text,
    type text,
    message text,
    "timestamp" timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.logs OWNER TO krakendbuser;

--
-- TOC entry 198 (class 1259 OID 16431)
-- Name: logs_id_seq; Type: SEQUENCE; Schema: public; Owner: krakendbuser
--

CREATE SEQUENCE public.logs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE;


ALTER TABLE public.logs_id_seq OWNER TO krakendbuser;

--
-- TOC entry 2872 (class 0 OID 0)
-- Dependencies: 198
-- Name: logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: krakendbuser
--

ALTER SEQUENCE public.logs_id_seq OWNED BY public.logs.id;


--
-- TOC entry 197 (class 1259 OID 16421)
-- Name: telemetry; Type: TABLE; Schema: public; Owner: krakendbuser
--

CREATE TABLE public.telemetry (
    id integer NOT NULL,
    telemetrykey text,
    telemetryvalue text,
    telemetryunit text,
    "timestamp" timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.telemetry OWNER TO krakendbuser;

--
-- TOC entry 196 (class 1259 OID 16419)
-- Name: telemetry_id_seq; Type: SEQUENCE; Schema: public; Owner: krakendbuser
--

CREATE SEQUENCE public.telemetry_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE;


ALTER TABLE public.telemetry_id_seq OWNER TO krakendbuser;

--
-- TOC entry 2873 (class 0 OID 0)
-- Dependencies: 196
-- Name: telemetry_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: krakendbuser
--

ALTER SEQUENCE public.telemetry_id_seq OWNED BY public.telemetry.id;


--
-- TOC entry 2735 (class 2604 OID 16436)
-- Name: logs id; Type: DEFAULT; Schema: public; Owner: krakendbuser
--

ALTER TABLE ONLY public.logs ALTER COLUMN id SET DEFAULT nextval('public.logs_id_seq'::regclass);


--
-- TOC entry 2733 (class 2604 OID 16424)
-- Name: telemetry id; Type: DEFAULT; Schema: public; Owner: krakendbuser
--

ALTER TABLE ONLY public.telemetry ALTER COLUMN id SET DEFAULT nextval('public.telemetry_id_seq'::regclass);


--
-- TOC entry 2874 (class 0 OID 0)
-- Dependencies: 198
-- Name: logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: krakendbuser
--

-- SELECT pg_catalog.setval('public.logs_id_seq', 1, true);


--
-- TOC entry 2875 (class 0 OID 0)
-- Dependencies: 196
-- Name: telemetry_id_seq; Type: SEQUENCE SET; Schema: public; Owner: krakendbuser
--

-- SELECT pg_catalog.setval('public.telemetry_id_seq', 1, true);


--
-- TOC entry 2740 (class 2606 OID 16442)
-- Name: logs logs_pkey; Type: CONSTRAINT; Schema: public; Owner: krakendbuser
--

ALTER TABLE ONLY public.logs
    ADD CONSTRAINT logs_pkey PRIMARY KEY (id);


--
-- TOC entry 2738 (class 2606 OID 16430)
-- Name: telemetry telemetry_pkey; Type: CONSTRAINT; Schema: public; Owner: krakendbuser
--

ALTER TABLE ONLY public.telemetry
    ADD CONSTRAINT telemetry_pkey PRIMARY KEY (id);


-- Completed on 2022-02-12 22:34:14 PST

--
-- PostgreSQL database dump complete
--

--
-- Database "postgres" dump
--

\connect postgres

--
-- PostgreSQL database dump
--

-- Dumped from database version 10.6 (Debian 10.6-1.pgdg90+1)
-- Dumped by pg_dump version 14.0

-- Started on 2022-02-12 22:34:14 PST

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

-- Completed on 2022-02-12 22:34:14 PST

--
-- PostgreSQL database dump complete
--

-- Completed on 2022-02-12 22:34:14 PST

--
-- PostgreSQL database cluster dump complete
--

