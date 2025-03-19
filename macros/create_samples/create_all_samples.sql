{% macro create_all_samples(source_schema, source_database=target.dbname) %}
    {%- for node in graph.sources.values() %}
        {%- do run_query("CREATE SCHEMA IF NOT EXISTS " ~ target.schema) %}
        {%- set config = node.config %}
        {%- set sampling_method = config.get("sampling_method") %}

        {%- if sampling_method == "random_sample" %}
            {{ __create_random_sample(node, source_database, source_schema) }}
        {%- elif sampling_method == "sample_by_id" %}
            {{ __create_id_based_sample(node, source_database, source_schema) }}
        {%- elif sampling_method == "full_sample" %}
            {{ __create_full_sample(node, source_database, source_schema) }}
        {%- else %}
            {%- do exceptions.raise_compiler_error(
                "Unknown sampling_method for source " ~ node.name
            ) -%}
        {%- endif -%}
    {%- endfor %}
{% endmacro %}
