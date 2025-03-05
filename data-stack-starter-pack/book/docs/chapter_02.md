---
title: "Data Analytics Stack: Chapter 2"
summary: >
  This chapter provides an overview of the structure of a basic dbt project and explains how to
  professionalize it by using purpose-driven environments and macros.
authors:
  - David Lopez Mejia (hola@davidlm.dev)
date: 2025-03-05
---

# Data Analytics Stack: A Practical Guide

## Chapter 2: Getting Familiar with the Project

### Overview

In this chapter, we will explore the structure of a basic dbt project and understand how to professionalize it. We will discuss the importance of purpose-driven environments, the use of macros, and how these elements contribute to a robust data analytics stack.

### Understanding a Basic dbt Project

A dbt project typically consists of the following components:

- **Models:** SQL files that define the transformations applied to your data.
- **Sources:** Definitions of the raw data sources.
- **Seeds:** CSV files that are loaded into your data warehouse.
- **Snapshots:** Definitions of how to capture changes in your data over time.
- **Tests:** Assertions to validate your data.
- **Macros:** Reusable SQL snippets.
- **Documentation:** Descriptions of your models and their relationships.

### Initializing your dbt Project

To initialize a dbt project, you can use the following command:

```bash
dbt init webshop
```

In the starter pack you received, the staging layer is already set up for you. Make sure that when initializing the project, the contents of the `staging` directory are still there.

### Exploring the Project Structure

Let's take a look at the structure of a common dbt project:

```plaintext
dbt/
├── analyses/
├── macros/
├── models/
│   ├── dimensions/
│   ├── facts/
│   ├── intermediate/
│   ├── marts/
│   └── staging/
├── seeds/
├── snapshots/
└── tests/
```

Each directory serves a specific purpose in organizing your dbt project.

### Purpose-Driven Environments

In a professional setting, it is crucial to have separate environments for development, testing, and production. This ensures that changes can be tested thoroughly before being deployed to production.

#### Configuring Environments

In dbt, you can configure different environments in the profiles.yml file. Here is an example configuration:

```yaml
webshop:
  target: dev
  outputs:
    dev:
      dbname: dev_webshop
      host: localhost
      port: 2345
      schema: "{{ env_var('DBT_DEV_SCHEMA', 'dev') }}"
      user: "{{ env_var('POSTGRES_USER') }}"
      pass: "{{ env_var('POSTGRES_PASSWORD') }}"
      threads: 4
      type: postgres
```

### Using Macros

Macros in dbt allow you to create reusable SQL snippets, which can help in maintaining consistency and reducing redundancy in your SQL code.

#### Example Macros

Here are some examples of macros used in our project:

```sql
{% macro generate_alias_name(custom_alias_name=none, node=none) -%}
    {%- if custom_alias_name is none -%} {%- set table_name = node.name -%}
    {%- else -%} {%- set table_name = custom_alias_name | trim -%}
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
```

```sql
{% macro generate_schema_name(custom_schema_name, node) -%}
    {%- if not (
        target.name == "dev" or target.name == "test"
    ) and custom_schema_name is not none -%}
        {{ custom_schema_name | trim }}
    {%- else -%} {{ target.schema }}
    {%- endif -%}
{%- endmacro %}
```

### Conclusion

By understanding the structure of a basic dbt project and the importance of purpose-driven environments and macros, you are now equipped to professionalize your dbt project. In the next chapter, we will dive into splitting environments using containers.
