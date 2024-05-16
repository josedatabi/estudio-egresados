CREATE OR REPLACE VIEW egresados.dim_clientes
 AS
 SELECT clientes.cli_rbd,
    clientes.cli_sigla,
    clientes.cli_sost,
    clientes.cli_color,
        CASE
            WHEN clientes.cli_rbd = 8625 THEN 'INDUSTRIAL SAN VICENTE DE PAUL'::text
            ELSE t1.nom_rbd
        END AS nom_rbd
   FROM datos_maestros.clientes
     LEFT JOIN ( SELECT mineduc_directorio.rbd,
            mineduc_directorio.nom_rbd
           FROM datos_maestros.mineduc_directorio) t1 ON t1.rbd = clientes.cli_rbd;

ALTER TABLE egresados.dim_clientes
    OWNER TO postgres;
