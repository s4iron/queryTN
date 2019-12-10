 8--queries home

--1. menu top 1 - paginas relacionadas--
-- comp1: nav g1-secondary-nav
--4 <a href> menu-item-5443 paginas relacionadas wordpress
/* Items de secondary-nav-menu */
SELECT p.* 
  FROM tNo_posts AS p 
  LEFT JOIN tNo_term_relationships AS tr 
	ON tr.object_id = p.ID
  LEFT JOIN tNo_term_taxonomy AS tt 
	ON tt.term_taxonomy_id = tr.term_taxonomy_id
 WHERE p.post_type = 'nav_menu_item' AND post_title != ''
   AND tt.term_id = 140; /* id secondary-nav-menu */
 
-- comp2: ul g1-social-icons-1
--4 <a href> g1-socials-item-icon url redes sociales wordpress

--2. menu top 2 banner principal tunota--
-- Comp3: menu g1-hamburger g1-hamburger-show g1-hamburger-m  
-- Opciones de menu>submenu wordpress

-- Comp4: banner principal tunota g1-id
-- 2 de imagenes banner principal 

-- Comp5: nav navegacion rapida
-- (4) url, label e imagen noticias  interes 
-- 1 <a href> top 10 noticias 

/* Items de menu nav-bar */
SELECT p.* 
  FROM tNo_posts AS p 
  LEFT JOIN tNo_term_relationships AS tr 
	ON tr.object_id = p.ID
  LEFT JOIN tNo_term_taxonomy AS tt 
	ON tt.term_taxonomy_id = tr.term_taxonomy_id
 WHERE p.post_type = 'nav_menu_item' AND post_title != ''
   AND tt.term_id = 139; /* menu nav-bar */
   
/* Items de secondary-nav-menu */
SELECT p.* 
  FROM tNo_posts AS p 
  LEFT JOIN tNo_term_relationships AS tr 
	ON tr.object_id = p.ID
  LEFT JOIN tNo_term_taxonomy AS tt 
	ON tt.term_taxonomy_id = tr.term_taxonomy_id
 WHERE p.post_type = 'nav_menu_item' AND post_title != ''
   AND tt.term_id = 140; /* id secondary-nav-menu */


--3. menu top 3 menu principal tunota 
-- Comp7: seccion central 
-- menu>submenu principal 
/* Items de menu nav-bar */
SELECT p.* 
  FROM tNo_posts AS p 
  LEFT JOIN tNo_term_relationships AS tr 
	ON tr.object_id = p.ID
  LEFT JOIN tNo_term_taxonomy AS tt 
	ON tt.term_taxonomy_id = tr.term_taxonomy_id
 WHERE p.post_type = 'nav_menu_item' AND post_title != ''
   AND tt.term_id = 139; /* menu nav-bar */
   
-- Comp8: seccion derecha 
-- funcionalidad buscar por
-- dos links envivo y emisoras

--4. menu articulo principal
-- Comp7: articulo principal
-- url, label e imagen noticia principal; url nación y política 
select
parent.post_type,
`parent`.`ID` AS `ID`,
`parent`.`post_title` AS `post_title`,
`parent`.`post_content` AS `post_content`, 
`parent`.`post_date` AS `post_date`,
group_concat(DISTINCT wordpress.tNo_term_taxonomy.taxonomy) as tiposcategory,
group_concat(DISTINCT wordpress.tNo_terms.slug) as tiposslug,
group_concat(DISTINCT wordpress.tNo_postmeta.meta_value) as valoresmeta,
group_concat(DISTINCT `child`.`ID` separator ',') AS `IDCHILDS`,
group_concat(DISTINCT `child`.`guid` separator ',') AS `CONTENT`,
feature_images.guid as featured_image,
parent.guid as url_post,
parent.post_status,
parent.comment_status
from `wordpress`.`tNo_posts` as `parent`
join `wordpress`.`tNo_posts` as `child` on(`parent`.`ID` = `child`.`post_parent`)
join wordpress.tNo_postmeta on (wordpress.tNo_postmeta.post_id = child.ID)
join wordpress.tNo_term_relationships ON (parent.ID = wordpress.tNo_term_relationships.object_id)
join wordpress.tNo_term_taxonomy ON (wordpress.tNo_term_relationships.term_taxonomy_id = wordpress.tNo_term_taxonomy.term_taxonomy_id)
join wordpress.tNo_terms ON (wordpress.tNo_terms.term_id = wordpress.tNo_term_taxonomy.term_id) 
LEFT join wordpress.tNo_posts as feature_images ON (parent.ID = feature_images.post_parent AND feature_images.post_type = 'attachment')
WHERE parent.post_type = 'post' AND wordpress.tNo_terms.slug like '%politica-de-honduras%'
group by `parent`.`ID` 
order by parent.post_date desc
Limit 0, 1;

-- Comp8: (4) colección articulos de interes 
-- url, label e imagen noticia interes; 
-- Url, label e imagen noticia 
--entretenimiento
select 
parent.post_type,
`parent`.`ID` AS `ID`,
`parent`.`post_title` AS `post_title`,
`parent`.`post_content` AS `post_content`, 
`parent`.`post_date` AS `post_date`,
group_concat(DISTINCT wordpress.tNo_term_taxonomy.taxonomy) as tiposcategory,
group_concat(DISTINCT wordpress.tNo_terms.slug) as tiposslug,
group_concat(DISTINCT wordpress.tNo_postmeta.meta_value) as valoresmeta,
group_concat(DISTINCT `child`.`ID` separator ',') AS `IDCHILDS`,
group_concat(DISTINCT `child`.`guid` separator ',') AS `CONTENT`,
feature_images.guid as featured_image,
parent.guid as url_post,
parent.post_status,
parent.comment_status
from `wordpress`.`tNo_posts` as `parent`
join `wordpress`.`tNo_posts` as `child` on(`parent`.`ID` = `child`.`post_parent`)
join wordpress.tNo_postmeta on (wordpress.tNo_postmeta.post_id = child.ID)
join wordpress.tNo_term_relationships ON (parent.ID = wordpress.tNo_term_relationships.object_id)
join wordpress.tNo_term_taxonomy ON (wordpress.tNo_term_relationships.term_taxonomy_id = wordpress.tNo_term_taxonomy.term_taxonomy_id)
join wordpress.tNo_terms ON (wordpress.tNo_terms.term_id = wordpress.tNo_term_taxonomy.term_id) 
LEFT join wordpress.tNo_posts as feature_images ON (parent.ID = feature_images.post_parent AND feature_images.post_type = 'attachment')
WHERE parent.post_type = 'post' AND wordpress.tNo_terms.slug like '%entretenimiento%'
--WHERE parent.post_type = 'post' AND wordpress.tNo_terms.slug like '%actualidad%'
--WHERE parent.post_type = 'post' AND wordpress.tNo_terms.slug like '%nacion%'
group by `parent`.`ID`
order by parent.post_date desc
--Limit 0, 2; -- noticias de actualidad 
Limit 0, 1; 

--5. contenido articulos
-- Comp9: columna contenido izquierda articulos 
-- noticia principal (comp7)
-- noticia entretenimiento (comp7) 
-- url, label e imagen noticia promovida
-- url, label e imagen noticia deportes
select 
parent.post_type,
`parent`.`ID` AS `ID`,
`parent`.`post_title` AS `post_title`,
`parent`.`post_content` AS `post_content`, 
`parent`.`post_date` AS `post_date`,
group_concat(DISTINCT wordpress.tNo_term_taxonomy.taxonomy) as tiposcategory,
group_concat(DISTINCT wordpress.tNo_terms.slug) as tiposslug,
group_concat(DISTINCT wordpress.tNo_postmeta.meta_value) as valoresmeta,
group_concat(DISTINCT `child`.`ID` separator ',') AS `IDCHILDS`,
group_concat(DISTINCT `child`.`guid` separator ',') AS `CONTENT`,
feature_images.guid as featured_image,
parent.guid as url_post,
parent.post_status,
parent.comment_status
from `wordpress`.`tNo_posts` as `parent`
join `wordpress`.`tNo_posts` as `child` on(`parent`.`ID` = `child`.`post_parent`)
join wordpress.tNo_postmeta on (wordpress.tNo_postmeta.post_id = child.ID)
join wordpress.tNo_term_relationships ON (parent.ID = wordpress.tNo_term_relationships.object_id)
join wordpress.tNo_term_taxonomy ON (wordpress.tNo_term_relationships.term_taxonomy_id = wordpress.tNo_term_taxonomy.term_taxonomy_id)
join wordpress.tNo_terms ON (wordpress.tNo_terms.term_id = wordpress.tNo_term_taxonomy.term_id) 
LEFT join wordpress.tNo_posts as feature_images ON (parent.ID = feature_images.post_parent AND feature_images.post_type = 'attachment')
WHERE parent.post_type = 'post' AND wordpress.tNo_terms.slug like '%deportes%'
--WHERE parent.post_type = 'post' AND wordpress.tNo_terms.slug like '%entretenimiento%'
--WHERE parent.post_type = 'post' AND wordpress.tNo_terms.slug like '%nacion%'
--WHERE parent.post_type = 'post' AND wordpress.tNo_terms.slug like '%politica-de-honduras%'
group by `parent`.`ID`
order by parent.post_date desc
Limit 0, 1;

-- Comp10: columna contenido central articulos
-- url, label e imagen noticia promovida mundo
-- url, label e imagen noticia promovida nacion
-- url, label e imagen noticia promovida mundial
select 
parent.post_type,
`parent`.`ID` AS `ID`,
`parent`.`post_title` AS `post_title`,
`parent`.`post_content` AS `post_content`, 
`parent`.`post_date` AS `post_date`,
group_concat(DISTINCT wordpress.tNo_term_taxonomy.taxonomy) as tiposcategory,
group_concat(DISTINCT wordpress.tNo_terms.slug) as tiposslug,
group_concat(DISTINCT wordpress.tNo_postmeta.meta_value) as valoresmeta,
group_concat(DISTINCT `child`.`ID` separator ',') AS `IDCHILDS`,
group_concat(DISTINCT `child`.`guid` separator ',') AS `CONTENT`,
feature_images.guid as featured_image,
parent.guid as url_post,
parent.post_status,
parent.comment_status
from `wordpress`.`tNo_posts` as `parent`
join `wordpress`.`tNo_posts` as `child` on(`parent`.`ID` = `child`.`post_parent`)
join wordpress.tNo_postmeta on (wordpress.tNo_postmeta.post_id = child.ID)
join wordpress.tNo_term_relationships ON (parent.ID = wordpress.tNo_term_relationships.object_id)
join wordpress.tNo_term_taxonomy ON (wordpress.tNo_term_relationships.term_taxonomy_id = wordpress.tNo_term_taxonomy.term_taxonomy_id)
join wordpress.tNo_terms ON (wordpress.tNo_terms.term_id = wordpress.tNo_term_taxonomy.term_id) 
LEFT join wordpress.tNo_posts as feature_images ON (parent.ID = feature_images.post_parent AND feature_images.post_type = 'attachment')
WHERE parent.post_type = 'post' AND wordpress.tNo_terms.slug like '%mundo%'
--WHERE parent.post_type = 'post' AND wordpress.tNo_terms.slug like '%nacion%'
--WHERE parent.post_type = 'post' AND wordpress.tNo_terms.slug like '%actualidad-mundial%'
group by `parent`.`ID`
order by parent.post_date desc
Limit 0, 1;

-- Comp11: columna contenido derecha articulos
-- url, banner futboleros
-- url, banner clima
-- form suscribe mailchimp

--6. Seccion videos destacados 
-- Comp12: video destadado 
-- url video, url noticia, label
select 
parent.post_type,
`parent`.`ID` AS `ID`,
`parent`.`post_title` AS `post_title`,
`parent`.`post_content` AS `post_content`, 
`parent`.`post_date` AS `post_date`,
group_concat(DISTINCT wordpress.tNo_term_taxonomy.taxonomy) as tiposcategory,
group_concat(DISTINCT wordpress.tNo_terms.slug) as tiposslug,
group_concat(DISTINCT wordpress.tNo_postmeta.meta_value) as valoresmeta,
group_concat(DISTINCT `child`.`ID` separator ',') AS `IDCHILDS`,
group_concat(DISTINCT `child`.`guid` separator ',') AS `CONTENT`,
feature_images.guid as featured_image,
parent.guid as url_post,
parent.post_status,
parent.comment_status
from `wordpress`.`tNo_posts` as `parent`
join `wordpress`.`tNo_posts` as `child` on(`parent`.`ID` = `child`.`post_parent`)
join wordpress.tNo_postmeta on (wordpress.tNo_postmeta.post_id = child.ID)
join wordpress.tNo_term_relationships ON (parent.ID = wordpress.tNo_term_relationships.object_id)
join wordpress.tNo_term_taxonomy ON (wordpress.tNo_term_relationships.term_taxonomy_id = wordpress.tNo_term_taxonomy.term_taxonomy_id)
join wordpress.tNo_terms ON (wordpress.tNo_terms.term_id = wordpress.tNo_term_taxonomy.term_id) 
LEFT join wordpress.tNo_posts as feature_images ON (parent.ID = feature_images.post_parent AND feature_images.post_type = 'attachment')
WHERE parent.post_type = 'post' AND wordpress.tNo_terms.slug like '%video%'
group by `parent`.`ID`
order by parent.post_date desc
Limit 0, 4;

-- Comp13: otros videos destacados
-- 3 url video, url noticia, label

--7. Sección Opinión Columna izquiera y central 
-- Comp14: sección opinión 3 columnas
-- 3 imagenes, url y label noticias de opinión

-- Comp15: seccion ver mas opiniones
-- url a opiniones

--8. Sección lo más visto derecha
-- Comp16: (4) el primer articulo se resalta, el resto en lista
-- url, imagen y label noticias mas vistas

--9. Sección otras categorias
-- Comp17: (4) noticias resaltadas de otras categorias
-- url, imagen y label noticias de otras categorias

--10. Sección de tu interés
-- Comp18: noticias actualidad (?) 
-- url, imagen y label noticias actualidad (?) 

--11. Sección últimas noticias que leíste
-- Comp19: con cookies guardar el id de las noticias para consultar esta seccion
-- url, imagen y label noticias antes vistas

--12. Sección footer 4 columnas 25% 
-- Comp20: 4 links de interes
SELECT p.* 
  FROM tNo_posts AS p 
  LEFT JOIN tNo_term_relationships AS tr 
	ON tr.object_id = p.ID
  LEFT JOIN tNo_term_taxonomy AS tt 
	ON tt.term_taxonomy_id = tr.term_taxonomy_id
 WHERE p.post_type = 'nav_menu_item' AND post_title != ''
   AND tt.term_id = 199; /* seccion terminos y condiciones */

--12. Sección footer 4 columnas 25% 
-- Comp21: Redes Sociales
-- url e imagen

Faceboook : https://www.facebook.com/tunotacom/
twiter : https://twitter.com/tunota_com
youtube : https://www.youtube.com/channel/UCPdYQU8nfVosqUON5USEN6w
instagram : https://www.instagram.com/tunota_com/
whatsapp = facebook

