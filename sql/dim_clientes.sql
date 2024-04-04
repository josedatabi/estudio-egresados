create or replace  view egresados.dim_clientes as 
SELECT cli_rbd, cli_sigla, cli_sost, cli_color, 
case when cli_rbd=8625 then 'INDUSTRIAL SAN VICENTE DE PAUL' else
nom_rbd end as nom_rbd
	FROM datos_maestros.clientes
	left join (SELECT rbd,  nom_rbd
FROM datos_maestros.mineduc_directorio) as t1 on t1.rbd=cli_rbd
	;