CREATE OR REPLACE VIEW egresados.fact_prueba_admision_edsup
 AS
 SELECT anyo_proceso,
    agno,
    rbd,
    cod_ense,
    mrun,
    nem,
    clec,
    mate,
    hcsoc,
    cien,
    ranking,
        CASE
            WHEN clec IS NOT NULL AND mate IS NOT NULL THEN (clec::integer + mate::integer) / 2
            ELSE NULL::integer
        END AS prom_cm,
    (rbd || '_'::text) || cod_ense AS rbd_codense_key,
    (clec IS NOT NULL AND mate IS NOT NULL)::integer AS participa_flg
   FROM egresados.prueba_admision_edsup
  WHERE anyo_proceso = (agno + 1);

ALTER TABLE egresados.fact_prueba_admision_edsup
    OWNER TO postgres;