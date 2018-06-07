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
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: t_score; Type: TABLE; Schema: public; Owner: root; Tablespace: 
--

CREATE TABLE t_score (
    id integer NOT NULL,
    score integer NOT NULL,
    register_date date NOT NULL,
    u_id integer
);


ALTER TABLE t_score OWNER TO root;

--
-- Name: t_score_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE t_score_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE t_score_id_seq OWNER TO root;

--
-- Name: t_score_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE t_score_id_seq OWNED BY t_score.id;


--
-- Name: t_user; Type: TABLE; Schema: public; Owner: root; Tablespace: 
--

CREATE TABLE t_user (
    id integer NOT NULL,
    username character varying(10) NOT NULL,
    password character varying(8) NOT NULL
);


ALTER TABLE t_user OWNER TO root;

--
-- Name: t_user_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE t_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE t_user_id_seq OWNER TO root;

--
-- Name: t_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE t_user_id_seq OWNED BY t_user.id;


--
-- Name: t_word; Type: TABLE; Schema: public; Owner: root; Tablespace: 
--

CREATE TABLE t_word (
    id integer NOT NULL,
    word character varying(15) NOT NULL,
    length integer NOT NULL,
    u_id integer
);


ALTER TABLE t_word OWNER TO root;

--
-- Name: t_word_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE t_word_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE t_word_id_seq OWNER TO root;

--
-- Name: t_word_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE t_word_id_seq OWNED BY t_word.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY t_score ALTER COLUMN id SET DEFAULT nextval('t_score_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY t_user ALTER COLUMN id SET DEFAULT nextval('t_user_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY t_word ALTER COLUMN id SET DEFAULT nextval('t_word_id_seq'::regclass);


--
-- Data for Name: t_score; Type: TABLE DATA; Schema: public; Owner: root
--

COPY t_score (id, score, register_date, u_id) FROM stdin;
\.


--
-- Name: t_score_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('t_score_id_seq', 1, false);


--
-- Data for Name: t_user; Type: TABLE DATA; Schema: public; Owner: root
--

COPY t_user (id, username, password) FROM stdin;
\.


--
-- Name: t_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('t_user_id_seq', 1, false);


--
-- Data for Name: t_word; Type: TABLE DATA; Schema: public; Owner: root
--

COPY t_word (id, word, length, u_id) FROM stdin;
\.


--
-- Name: t_word_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('t_word_id_seq', 1, false);


--
-- Name: t_score_pkey; Type: CONSTRAINT; Schema: public; Owner: root; Tablespace: 
--

ALTER TABLE ONLY t_score
    ADD CONSTRAINT t_score_pkey PRIMARY KEY (id);


--
-- Name: t_user_pkey; Type: CONSTRAINT; Schema: public; Owner: root; Tablespace: 
--

ALTER TABLE ONLY t_user
    ADD CONSTRAINT t_user_pkey PRIMARY KEY (id);


--
-- Name: t_word_pkey; Type: CONSTRAINT; Schema: public; Owner: root; Tablespace: 
--

ALTER TABLE ONLY t_word
    ADD CONSTRAINT t_word_pkey PRIMARY KEY (id);


--
-- Name: t_score_u_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY t_score
    ADD CONSTRAINT t_score_u_id_fkey FOREIGN KEY (u_id) REFERENCES t_user(id);


--
-- Name: t_word_u_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY t_word
    ADD CONSTRAINT t_word_u_id_fkey FOREIGN KEY (u_id) REFERENCES t_user(id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

