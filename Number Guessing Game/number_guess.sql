--
-- PostgreSQL database dump
--

-- Dumped from database version 12.22 (Ubuntu 12.22-0ubuntu0.20.04.4)
-- Dumped by pg_dump version 12.22 (Ubuntu 12.22-0ubuntu0.20.04.4)

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

DROP DATABASE number_guess;
--
-- Name: number_guess; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE number_guess WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guess OWNER TO freecodecamp;

\connect number_guess

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

SET default_table_access_method = heap;

--
-- Name: users; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    username character varying(22) NOT NULL,
    played_games integer NOT NULL,
    best_game_guesses integer NOT NULL
);


ALTER TABLE public.users OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_id_seq OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.users VALUES (88, 'user_1761314509306', 2, 605);
INSERT INTO public.users VALUES (87, 'user_1761314509307', 5, 221);
INSERT INTO public.users VALUES (90, 'user_1761314567720', 2, 348);
INSERT INTO public.users VALUES (89, 'user_1761314567721', 5, 15);
INSERT INTO public.users VALUES (92, 'user_1761314583659', 2, 281);
INSERT INTO public.users VALUES (91, 'user_1761314583660', 5, 11);
INSERT INTO public.users VALUES (93, 'mostafa', 1, 13);
INSERT INTO public.users VALUES (95, 'user_1761314689919', 2, 77);
INSERT INTO public.users VALUES (94, 'user_1761314689920', 5, 406);
INSERT INTO public.users VALUES (97, 'user_1761314835581', 2, 769);
INSERT INTO public.users VALUES (96, 'user_1761314835582', 5, 122);
INSERT INTO public.users VALUES (99, 'user_1761314865727', 2, 801);
INSERT INTO public.users VALUES (98, 'user_1761314865728', 5, 26);
INSERT INTO public.users VALUES (101, 'user_1761314890461', 2, 593);
INSERT INTO public.users VALUES (100, 'user_1761314890462', 5, 457);
INSERT INTO public.users VALUES (103, 'user_1761314895536', 2, 303);
INSERT INTO public.users VALUES (102, 'user_1761314895537', 5, 266);
INSERT INTO public.users VALUES (105, 'user_1761314899776', 2, 502);
INSERT INTO public.users VALUES (104, 'user_1761314899777', 5, 47);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.users_user_id_seq', 105, true);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- PostgreSQL database dump complete
--

