create or replace view  egresados.fact_egresados as 
select * from 
(SELECT agno, rbd, cod_ense, cod_grado, let_cur,  mrun
, sit_fin_r, rbd ||'-'||cod_ense as rbd_codense_key, (sit_fin_r='P')::int as egresado_flg,(sit_fin_r='R')::int as repitente_flg ,(sit_fin_r in('Y','T'))::int as retirado_flg 
,row_number() over (partition by agno, rbd,mrun order by sit_fin_r asc) as rn
	FROM egresados.egresados) as t1 where rn=1
