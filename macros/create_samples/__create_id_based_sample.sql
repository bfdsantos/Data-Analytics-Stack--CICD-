{% macro __create_id_based_sample(node, source_database, source_schema) %}
    {%- do log("Creating an ID-based sample for source " ~ node.name) %}
    {%- set config = node.config %}
    {%- set ref_column = config.get("ref_column") %}
    {%- set filter_column = config.get("filter_column") | default(ref_column) %}
    {%- set ref_table = config.get("ref_table") %}

    {%- if ref_column is none -%}
        {%- do exceptions.raise_compiler_error(
            "ref_column is not set for source " ~ node.name
        ) -%}
    {%- endif -%}

    {%- if ref_table is none -%}
        {%- do exceptions.raise_compiler_error("ref_table is not set for source " ~ node.name) -%}
    {%- endif -%}

    {%- set ref_table_exists %}
        SELECT COUNT(*)
        FROM {{ target.dbname }}.information_schema.tables
        WHERE table_schema = '{{ target.schema }}'
        AND table_name = '{{ ref_table }}'
    {%- endset %}

    {%- set ref_table_count = run_query(ref_table_exists) %}
    {%- if ref_table_count == 0 -%}
        {%- do exceptions.raise_compiler_error(
            "Reference table " ~ ref_table ~ " does not exist in " ~ target.schema
        ) -%}
    {%- endif -%}

    {%- set model_sql %}
        CREATE TABLE IF NOT EXISTS {{ target.dbname }}.{{ target.schema }}.{{ node.name }} AS
        SELECT *
        FROM {{ source_database }}.{{ source_schema }}.{{ node.name }}
        WHERE "{{ filter_column }}" IN (
            SELECT DISTINCT "{{ ref_column }}"
            FROM {{ target.dbname }}.{{ target.schema }}.{{ ref_table }}
        )
    {%- endset %}

    {%- do run_query(model_sql) -%}
    {%- do log("Sample based on ID for " ~ node.name ~ " complete.") -%}
{% endmacro %}
