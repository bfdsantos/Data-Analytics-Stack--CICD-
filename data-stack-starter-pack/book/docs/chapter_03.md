---
title: "Data Analytics Stack: Chapter 3"
summary: >
  This chapter covers how to split environments in dbt using containers, macros for data sampling,
  creating custom schemas for each developer, and using environment variables.
authors:
  - David Lopez Mejia (hola@davidlm.dev)
date: 2025-03-05
---

# Data Analytics Stack: A Practical Guide

## Chapter 3: Splitting Environments Using Containers

### Overview

In this chapter, we will learn how to split environments in dbt using containers. We will also explore how to use macros for data sampling, create custom schemas for each developer, and use environment variables to inject necessary configurations.

### Splitting Environments

To manage different environments (development, testing, production), we can use Docker or Podman to create isolated environments. This ensures that each environment has its own configuration and dependencies. By editing the `docker-compose.yml` file, define services for each environment, such as dev, test, and prod databases.

#### Setting Up Docker Compose

In the provided `docker-compose.yml` file, define your services and their configurations. Ensure you have separate services for each environment (e.g., dev, test, prod). This will help you manage and isolate the environments effectively.

### Using Macros for Data Sampling

Macros in dbt allow you to create reusable SQL snippets. One possible use case is data sampling, which helps in testing with a subset of data. For this project, you need to create macros that will sample data in different ways, such as random sampling, full sampling, and column-dependent sampling.

### Creating Custom Schemas for Each Developer Using Macros

To avoid conflicts, each developer can work in their own schema. You can use macros to dynamically create schemas based on environment variables. This approach ensures that each developer has a unique schema to work with, preventing any overlap or conflicts.

### Using Environment Variables

Environment variables allow you to inject configurations dynamically. You can set environment variables in your Docker Compose file or your local environment. These variables can be used to configure your dbt project, such as setting database credentials or schema names.

The most common way to set environment variables is through a `.env` file. This file should not be committed to version control to avoid exposing sensitive information. Instead, you can provide a template file (e.g., `.env.template` or `.env_example`) with placeholders for the actual values.

### Conclusion

By splitting environments using containers, using macros for data sampling, creating custom schemas for each developer, and leveraging environment variables, you can create a robust and flexible data analytics stack. In the next chapter, we will explore setting up CI/CD with GitHub Actions.
