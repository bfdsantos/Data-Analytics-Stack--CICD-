{% macro __create_random_sample(node, source_database, source_schema) %}
    {%- do log("Creating a random sample for source " ~ node.name) %}
    {%- set config = node.config %}
    {%- if target.name == "dev_samples" -%} {%- set sample_size = config.get("dev_sample_size") %}
    {%- else %} {%- set sample_size = config.get("test_sample_size") %}
    {%- endif -%}

    {%- if sample_size is none -%}
        {%- do exceptions.raise.compiler_error(
            target.name ~ "_sample_size is not set for source " ~ node.name
        ) -%}
    {%- endif -%}

    {%- set model_sql %}
        CREATE TABLE IF NOT EXISTS {{ target.dbname }}.{{ target.schema }}.{{ node.name }} AS
        WITH numbered_rows AS (
            SELECT *, RANDOM(1, {{ 100 // sample_size }}) AS sample_id
            FROM {{ source_database }}.{{ source_schema }}.{{ node.name }}
        )
        SELECT *
        FROM numbered_rows
        WHERE sample_id = 1
    {%- endset %}

    {%- do run_query(model_sql) -%}
    {%- do log("Sample for " ~ node.name ~ " complete.") -%}
{% endmacro %}
