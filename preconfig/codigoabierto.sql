--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: login; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE login (
    usr character varying(15) NOT NULL,
    pwd character varying(50) NOT NULL
);


--
-- Name: palabra; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE palabra (
    id_palabra integer NOT NULL,
    palabra character varying(25) NOT NULL,
    puntos integer NOT NULL,
    usr character varying(15)
);


--
-- Name: palabra_id_palabra_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE palabra_id_palabra_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: palabra_id_palabra_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE palabra_id_palabra_seq OWNED BY palabra.id_palabra;


--
-- Name: palabra_x_puntaje; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE palabra_x_puntaje (
    correl integer NOT NULL,
    id_palabra integer,
    id_puntaje integer
);


--
-- Name: palabra_x_puntaje_correl_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE palabra_x_puntaje_correl_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: palabra_x_puntaje_correl_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE palabra_x_puntaje_correl_seq OWNED BY palabra_x_puntaje.correl;


--
-- Name: puntaje; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE puntaje (
    id_puntaje integer NOT NULL,
    puntaje integer NOT NULL,
    usr character varying(15),
    fecha timestamp without time zone NOT NULL
);


--
-- Name: puntaje_id_puntaje_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE puntaje_id_puntaje_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: puntaje_id_puntaje_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE puntaje_id_puntaje_seq OWNED BY puntaje.id_puntaje;


--
-- Name: id_palabra; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY palabra ALTER COLUMN id_palabra SET DEFAULT nextval('palabra_id_palabra_seq'::regclass);


--
-- Name: correl; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY palabra_x_puntaje ALTER COLUMN correl SET DEFAULT nextval('palabra_x_puntaje_correl_seq'::regclass);


--
-- Name: id_puntaje; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY puntaje ALTER COLUMN id_puntaje SET DEFAULT nextval('puntaje_id_puntaje_seq'::regclass);


--
-- Data for Name: login; Type: TABLE DATA; Schema: public; Owner: -
--

COPY login (usr, pwd) FROM stdin;
Luis	root
Francisco	root
Gabriel	root
Jonathan	root
LUis	root
Luias	roo
Luis el hacjer	root
\.


--
-- Data for Name: palabra; Type: TABLE DATA; Schema: public; Owner: -
--

COPY palabra (id_palabra, palabra, puntos, usr) FROM stdin;
2	oso	60	Luis
3	perro	100	Luis
4	lel	60	Luis
5	cuaderno	160	Gabriel
6	Lol	60	Gabriel
\.


--
-- Name: palabra_id_palabra_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('palabra_id_palabra_seq', 6, true);


--
-- Data for Name: palabra_x_puntaje; Type: TABLE DATA; Schema: public; Owner: -
--

COPY palabra_x_puntaje (correl, id_palabra, id_puntaje) FROM stdin;
3	2	1
\.


--
-- Name: palabra_x_puntaje_correl_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('palabra_x_puntaje_correl_seq', 3, true);


--
-- Data for Name: puntaje; Type: TABLE DATA; Schema: public; Owner: -
--

COPY puntaje (id_puntaje, puntaje, usr, fecha) FROM stdin;
1	100	Luis	2018-06-06 00:00:00
\.


--
-- Name: puntaje_id_puntaje_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('puntaje_id_puntaje_seq', 1, true);


--
-- Name: login_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY login
    ADD CONSTRAINT login_pkey PRIMARY KEY (usr);


--
-- Name: palabra_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY palabra
    ADD CONSTRAINT palabra_pkey PRIMARY KEY (id_palabra);


--
-- Name: puntaje_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY puntaje
    ADD CONSTRAINT puntaje_pkey PRIMARY KEY (id_puntaje);


--
-- Name: palabra_usr_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY palabra
    ADD CONSTRAINT palabra_usr_fkey FOREIGN KEY (usr) REFERENCES login(usr);


--
-- Name: palabra_x_puntaje_id_palabra_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY palabra_x_puntaje
    ADD CONSTRAINT palabra_x_puntaje_id_palabra_fkey FOREIGN KEY (id_palabra) REFERENCES palabra(id_palabra) ON DELETE CASCADE;


--
-- Name: palabra_x_puntaje_id_puntaje_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY palabra_x_puntaje
    ADD CONSTRAINT palabra_x_puntaje_id_puntaje_fkey FOREIGN KEY (id_puntaje) REFERENCES puntaje(id_puntaje) ON DELETE CASCADE;


--
-- Name: puntaje_usr_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY puntaje
    ADD CONSTRAINT puntaje_usr_fkey FOREIGN KEY (usr) REFERENCES login(usr);


--
-- PostgreSQL database dump complete
--
