---
title: "Data Analytics Stack: Introduction"
summary: A practical guide to setting up an enterprise-level data analytics stack.
authors:
    - David Lopez Mejia (hola@davidlm.dev)
date: 2025-03-05
---

# Data Analytics Stack: A Practical Guide

## Introduction

Welcome to this hands-on guide for setting up an enterprise-level, collaboration-focused data analytics stack. This book is designed to help Analytics Engineering Xccelerators understand and deploy a modern data stack using best practices in CI/CD, data transformation, and version control.

This guide follows a structured approach, ensuring that each component is properly explained and its role within the stack is clear. You will start with a pre-configured "starter pack" that contains essential resources, allowing you to focus on learning how to build and optimize your data pipeline.

## Why This Stack Matters

A robust data analytics stack is essential for:

- **Scalability:** Ensuring the system can handle increasing amounts of data and users.
- **Efficiency:** Streamlining data processing to save time and resources.
- **Reproducibility:** Allowing analyses to be easily replicated and verified.
- **Maintainability:** Simplifying updates and modifications to the data pipeline.
- **Integration:** Facilitating seamless interaction between various tools and platforms.

By the end of this guide, you will have hands-on experience deploying and maintaining a structured data workflow that mirrors industry best practices.

## Getting Started

### Prerequisites

Before diving into the setup, ensure that you have the following installed on your system:

- **A containerization tool**
    - Docker and Docker Compose ([Installation Guide](https://docs.docker.com/get-docker/))
    - Podman ([Installation Guide](https://podman.io/docs/installation))
- **uv** ([Installation Guide](https://github.com/astral-sh/uv))
- **Git** ([Installation Guide](https://git-scm.com/downloads))

### Setting Up Your Environment

#### 1. Open the Starter Pack

The first step is to download and extract the starter pack from the provided zip file, then navigate to the project directory:

```bash
unzip starter_pack.zip -d data_analytics_stack
cd data_analytics_stack
```

#### 2. Install Dependencies

We will use `uv` for package management. Create a virtual environment for the project:

```bash
uv venv
```

Having created the virtual environment, install the required packages specified in `pyproject.toml`:

```bash
uv sync --dev --upgrade --resolution highest
```

This will install all the necessary dependencies for the project as defined in the `pyproject.toml` file.

#### 3. Start the Services

Use Docker Compose to spin up the necessary services:

```bash
docker compose up -d
```

This will start the PostgreSQL instance which will host the raw data.
