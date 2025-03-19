{% macro generate_alias_name(custom_alias_name=none, node=none) -%}
    {%- if custom_alias_name is none -%} {%- set table_name = node.name -%}
    {%- else -%} {%- set table_name = custom_alias_name ~ "_" ~ node.name | trim -%}
    {%- endif -%}

    {%- if target.name == "dev" or target.name == "test" -%}
        {#- Get the custom schema name -#}
        {%- set schema_prefix = node.unrendered_config.schema | trim %}

        {#- Highlight if schema hasn't been assigned right -#}
        {%- if not schema_prefix -%} {%- set schema_prefix = "NO_ASSIGNED_SCHEMA" %} {%- endif -%}

        {{ schema_prefix ~ "__" ~ table_name }}

    {%- else -%} {{ table_name }}
    {%- endif -%}
{%- endmacro %}
