{% macro sample_data(source_schema, source_table, sample_size=25) %}
    {% set sql %}
        CREATE SCHEMA IF NOT EXISTS {{ target.schema }};
        DROP TABLE IF EXISTS {{ target.schema }}.{{ source_table }};
        CREATE TABLE {{ target.schema }}.{{ source_table }} AS
        WITH numbered_rows AS (        
            SELECT *, random(1, {{ 100 // sample_size}}) as sample_id
            FROM {{ source_schema }}.{{ source_table }}
            )
        SELECT *
        FROM numbered_rows
        WHERE sample_id=1 ---- it will return 25% of my original data as a sampl
        ----ORDER BY random_order
        ----LIMIT {{ sample_size }}
    {% endset %}

    {% do log(sql, info=True) %}

    {% do run_query(sql) %}
{% endmacro %}