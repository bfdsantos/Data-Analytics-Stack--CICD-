{% macro __create_full_sample(node, source_database, source_schema) %}
    {%- do log("Creating a full sample for source " ~ node.name) %}
    {%- set model_sql %}
        CREATE TABLE IF NOT EXISTS {{ target.dbname }}.{{ target.schema }}.{{ node.name }} AS
        SELECT *
        FROM {{ source_database }}.{{ source_schema }}.{{ node.name }}
    {%- endset %}

    {%- do run_query(model_sql) -%}
    {%- do log("Full sample for " ~ node.name ~ " complete.") -%}
{% endmacro %}
