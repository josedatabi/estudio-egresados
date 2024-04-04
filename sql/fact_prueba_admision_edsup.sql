create or replace view egresados.fact_prueba_admision_edsup as 
SELECT anyo_proceso, agno, rbd, cod_ense, mrun
, nem, clec, mate, hcsoc, cien, ranking,
case 
when (clec is not null) and(mate is not null) then (clec+mate)/2
end as prom_cm,
 rbd ||'-'||cod_ense as rbd_codense_key
	FROM egresados.prueba_admision_edsup;