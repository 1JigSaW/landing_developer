PGDMP     #    /                y            avito    13.3    13.3     �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    33117    avito    DATABASE     b   CREATE DATABASE avito WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Russian_Russia.1251';
    DROP DATABASE avito;
                jigsaw    false            {           1247    33127 
   offer_type    TYPE     A   CREATE TYPE public.offer_type AS ENUM (
    'buy',
    'sell'
);
    DROP TYPE public.offer_type;
       public          jigsaw    false            �            1255    33193    add_em(integer, integer)    FUNCTION     u   CREATE FUNCTION public.add_em(x integer, y integer) RETURNS integer
    LANGUAGE sql
    AS $$
    SELECT x + y;
$$;
 3   DROP FUNCTION public.add_em(x integer, y integer);
       public          jigsaw    false            �            1255    33194 [   search(public.offer_type, integer, character varying, character varying, character varying)    FUNCTION     �  CREATE FUNCTION public.search(of_type public.offer_type, price integer, category character varying, word_1 character varying, word_2 character varying) RETURNS void
    LANGUAGE sql
    AS $$
SELECT o.id, 
(CASE WHEN offer_type = 'buy' THEN 'ЉгЇ«о'
WHEN offer_type = 'sell' THEN 'Џа®¤ ¬'
END), cat.title, CONCAT(u.first_name, ' ', u.last_name) author, o.title, 
CONCAT(SUBSTRING(o.full_text, 0, 30), ' ') announce, o.price
FROM offers o
JOIN users u
ON u.id = o.user_id
JOIN category_offer co
ON o.id = co.offer_id
JOIN categories cat
ON cat.id = co.category_id
WHERE offer_type = of_type
AND o.price < price 
AND cat.title = category 
AND o.title LIKE '%word_1%'
AND o.title LIKE '%word_2%';
$$;
 �   DROP FUNCTION public.search(of_type public.offer_type, price integer, category character varying, word_1 character varying, word_2 character varying);
       public          jigsaw    false    635            �            1259    33131    offers    TABLE       CREATE TABLE public.offers (
    id integer NOT NULL,
    created_at timestamp with time zone,
    user_id integer,
    offer_type public.offer_type,
    title character varying,
    full_text character varying,
    price numeric,
    picture character varying(100)
);
    DROP TABLE public.offers;
       public         heap    jigsaw    false    635            �            1255    33223    search_4(public.offer_type)    FUNCTION     s  CREATE FUNCTION public.search_4(of_type public.offer_type) RETURNS public.offers
    LANGUAGE sql
    AS $$
SELECT o.id, o.created_at, o.user_id, o.offer_type, o.title, o.full_text, o.price, o.picture
FROM offers o
JOIN users u
ON u.id = o.user_id
JOIN category_offer co
ON o.id = co.offer_id
JOIN categories cat
ON cat.id = co.category_id
WHERE offer_type = of_type
$$;
 :   DROP FUNCTION public.search_4(of_type public.offer_type);
       public          jigsaw    false    635    201            �            1255    33232 ]   search_6(public.offer_type, integer, character varying, character varying, character varying)    FUNCTION     :  CREATE FUNCTION public.search_6(of_type public.offer_type, price integer, category character varying, word_1 character varying, word_2 character varying) RETURNS public.offers
    LANGUAGE sql
    AS $$
SELECT o.id, o.created_at, o.user_id,
o.offer_type, o.title, o.full_text, o.price, o.picture
FROM offers o
JOIN users u
ON u.id = o.user_id
JOIN category_offer co
ON o.id = co.offer_id
JOIN categories cat
ON cat.id = co.category_id
WHERE offer_type = of_type
AND o.price < price 
AND cat.title = category 
AND o.title LIKE '%word_1%'
AND o.title LIKE '%word_2%';
$$;
 �   DROP FUNCTION public.search_6(of_type public.offer_type, price integer, category character varying, word_1 character varying, word_2 character varying);
       public          jigsaw    false    201    635            �            1259    33175 
   categories    TABLE     �   CREATE TABLE public.categories (
    id integer NOT NULL,
    title character varying(255),
    picture character varying(100),
    slug character varying(100)
);
    DROP TABLE public.categories;
       public         heap    jigsaw    false            �            1259    33180    category_offer    TABLE     V   CREATE TABLE public.category_offer (
    category_id integer,
    offer_id integer
);
 "   DROP TABLE public.category_offer;
       public         heap    jigsaw    false            �            1259    33157    comments    TABLE     �   CREATE TABLE public.comments (
    id integer NOT NULL,
    created_at timestamp with time zone,
    user_id integer,
    offer_id integer,
    comment_text character varying(1000)
);
    DROP TABLE public.comments;
       public         heap    jigsaw    false            �            1259    33118    users    TABLE       CREATE TABLE public.users (
    id integer NOT NULL,
    created_at timestamp with time zone,
    first_name character varying(255),
    last_name character varying(255),
    password_hash character varying(255),
    email character varying(100),
    avatar character varying(100)
);
    DROP TABLE public.users;
       public         heap    jigsaw    false            �          0    33175 
   categories 
   TABLE DATA           >   COPY public.categories (id, title, picture, slug) FROM stdin;
    public          jigsaw    false    203   �'       �          0    33180    category_offer 
   TABLE DATA           ?   COPY public.category_offer (category_id, offer_id) FROM stdin;
    public          jigsaw    false    204   �'       �          0    33157    comments 
   TABLE DATA           S   COPY public.comments (id, created_at, user_id, offer_id, comment_text) FROM stdin;
    public          jigsaw    false    202   '(       �          0    33131    offers 
   TABLE DATA           g   COPY public.offers (id, created_at, user_id, offer_type, title, full_text, price, picture) FROM stdin;
    public          jigsaw    false    201   �(       �          0    33118    users 
   TABLE DATA           d   COPY public.users (id, created_at, first_name, last_name, password_hash, email, avatar) FROM stdin;
    public          jigsaw    false    200   j)       A           2606    33179    categories categories_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.categories DROP CONSTRAINT categories_pkey;
       public            jigsaw    false    203            ?           2606    33164    comments comments_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.comments DROP CONSTRAINT comments_pkey;
       public            jigsaw    false    202            =           2606    33138    offers offers_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.offers
    ADD CONSTRAINT offers_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.offers DROP CONSTRAINT offers_pkey;
       public            jigsaw    false    201            ;           2606    33125    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            jigsaw    false    200            E           2606    33183 .   category_offer category_offer_category_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.category_offer
    ADD CONSTRAINT category_offer_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(id) ON DELETE CASCADE;
 X   ALTER TABLE ONLY public.category_offer DROP CONSTRAINT category_offer_category_id_fkey;
       public          jigsaw    false    204    2881    203            F           2606    33188 +   category_offer category_offer_offer_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.category_offer
    ADD CONSTRAINT category_offer_offer_id_fkey FOREIGN KEY (offer_id) REFERENCES public.offers(id) ON DELETE CASCADE;
 U   ALTER TABLE ONLY public.category_offer DROP CONSTRAINT category_offer_offer_id_fkey;
       public          jigsaw    false    2877    201    204            D           2606    33170    comments comments_offer_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_offer_id_fkey FOREIGN KEY (offer_id) REFERENCES public.offers(id) ON DELETE CASCADE;
 I   ALTER TABLE ONLY public.comments DROP CONSTRAINT comments_offer_id_fkey;
       public          jigsaw    false    201    2877    202            C           2606    33165    comments comments_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;
 H   ALTER TABLE ONLY public.comments DROP CONSTRAINT comments_user_id_fkey;
       public          jigsaw    false    200    2875    202            B           2606    33139    offers offers_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.offers
    ADD CONSTRAINT offers_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;
 D   ALTER TABLE ONLY public.offers DROP CONSTRAINT offers_user_id_fkey;
       public          jigsaw    false    2875    200    201            �   M   x�3�LJL/���M7�LN,N�2�L�I-�LN�	�By\Ɯ��� !3Ό�R�BNǼ����f��<0�+F��� ��      �      x�3�4�2�4�2bNc�=... q�      �   |   x�m�;
1Dk���
k���gIc0��?D��nv���{���l���CR�V	�\�������F_!�qD�!�����r���05�F_��j�k}���p���0R�/k�'�x�?A��_��D���9Z      �   �   x���A
�0����KC�d�B���ܤ���V���ۛXAp�����Fn����x�v�(�B}��\�����*�u�s�U2��'݇+�{�)S�(��\!�D����o���r��r�1�L[u�\զj�&����Wnŷ*�Lh�iT�q�ӝ�R��|Dr      �   �   x�]̱
�0@���+ܥ!辰I'W7GA��Mjb ���7n"���A A� 57��kBqeH�n+$���Y���ֹ�d�/.]����󼂏�N�
y�h��r�0�������r�W�ܭT2�`1b�� �r*�     