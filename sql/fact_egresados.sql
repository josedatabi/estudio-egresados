-- Active: 1708134373133@@127.0.0.1@5432@databi
CREATE OR REPLACE VIEW egresados.fact_egresados
 AS
 SELECT agno,
    rbd,
    cod_ense,
    cod_grado,
    let_cur,
    mrun,
    sit_fin_r,
    rbd_codense_key,
    egresado_flg,
    repitente_flg,
    retirado_flg,
    rn,
        CASE
            WHEN sit_fin_r = 'P'::text THEN 'Egresado'::text
            WHEN sit_fin_r = 'R'::text THEN 'Repitente'::text
            WHEN sit_fin_r = ANY (ARRAY['Y'::text, 'T'::text]) THEN 'Retirado'::text
            ELSE NULL::text
        END AS sit_fin_desc
   FROM ( SELECT egresados.agno,
            egresados.rbd,
            egresados.cod_ense,
            egresados.cod_grado,
            egresados.let_cur,
            egresados.mrun,
            egresados.sit_fin_r,
            (egresados.rbd || '_'::text) || egresados.cod_ense AS rbd_codense_key,
            (egresados.sit_fin_r = 'P'::text)::integer AS egresado_flg,
            (egresados.sit_fin_r = 'R'::text)::integer AS repitente_flg,
            (egresados.sit_fin_r = ANY (ARRAY['Y'::text, 'T'::text]))::integer AS retirado_flg,
            row_number() OVER (PARTITION BY egresados.agno, egresados.rbd, egresados.mrun ORDER BY egresados.sit_fin_r) AS rn
           FROM egresados.egresados) t1
  WHERE rn = 1;

ALTER TABLE egresados.fact_egresados
    OWNER TO postgres;
