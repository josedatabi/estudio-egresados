
create or replace view egresados.fact_matricula_edsup as 
SELECT cat_periodo, mrun, anio_ing_carr_ori, anio_ing_carr_act, tipo_inst_1, tipo_inst_2, tipo_inst_3, cod_inst, nomb_inst, cod_carrera, nomb_carrera
, modalidad, jornada, dur_total_carr, nivel_carrera_1, nivel_carrera_2, area_conocimiento, cine_f_97_area, cine_f_97_subarea, area_carrera_generica
, cine_f_13_area, cine_f_13_subarea, agno, rbd, cod_ense, (row_number() over (partition by mrun order by cat_periodo)=1)::int as prim_carrera
	FROM egresados.matricula_edsup;