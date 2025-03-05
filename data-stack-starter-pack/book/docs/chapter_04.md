---
title: "Data Analytics Stack: Chapter 4"
summary: >
  This chapter covers the principles and objectives of CI/CD, common practices, using GitHub Actions,
  and setting up workflows with a self-hosted runner.
authors:
  - David Lopez Mejia (hola@davidlm.dev)
date: 2025-03-05
---

# Data Analytics Stack: A Practical Guide

## Chapter 4: CI/CD with GitHub Actions

### Overview

In this chapter, we will explore the principles and objectives of Continuous Integration and Continuous Deployment (CI/CD). We will discuss common practices, using GitHub Actions, and setting up workflows with a self-hosted runner.

### Principles and Objectives of CI/CD

CI/CD is a set of practices that aim to improve the software development process by automating the integration and deployment of code changes. The main principles and objectives of CI/CD include:

- **Automation:** Automating the build, test, and deployment processes to reduce manual effort and minimize errors.
- **Continuous Integration:** Frequently integrating code changes into a shared repository to detect and fix issues early.
- **Continuous Deployment:** Automatically deploying code changes to production after passing all tests and checks.
- **Feedback:** Providing rapid feedback to developers on the quality and stability of their code changes.
- **Collaboration:** Encouraging collaboration among team members by making the integration and deployment processes transparent and accessible.

### Common Practices in CI/CD

Some common practices in CI/CD include:

- **Version Control:** Using a version control system (e.g., Git) to manage code changes and collaborate with team members.
- **Automated Testing:** Writing and running automated tests to ensure code quality and prevent regressions.
- **Build Automation:** Automating the build process to compile and package code changes.
- **Deployment Automation:** Automating the deployment process to ensure consistent and reliable releases.
- **Monitoring and Logging:** Monitoring the performance and stability of deployed applications and logging relevant information for troubleshooting.

### Using GitHub Actions

GitHub Actions is a powerful platform for automating workflows directly within your GitHub repository. It allows you to define custom workflows using YAML files and provides a wide range of pre-built actions to perform common tasks.

### Setting Up Workflows with a Self-Hosted Runner

In this project, we will use a self-hosted runner to execute our CI/CD workflows. A self-hosted runner is a machine that you manage and configure to run GitHub Actions workflows.

#### Configuring the Self-Hosted Runner

In this project, we included a self-hosted runner docker image that you can use to set up your runner environment. To configure a self-hosted runner, you need to:

1. Register the runner with your GitHub repository. You can use the commands in the Taskfile.
2. Run the self-hosted runner container on your machine. This will run when you start up your docker-compose environment.
3. Configure the runner to execute workflows for your repository.

#### Creating Workflow Files

Workflow files are YAML files that define the steps and actions to be executed in your CI/CD pipeline. These files are stored in the `.github/workflows` directory of your repository.

Here are some key components to include in your workflow files:

- **Triggers:** Define the events that trigger the workflow (e.g., push, pull request).
- **Jobs:** Define the jobs to be executed, including the steps and actions for each job.
- **Environment Variables:** Set environment variables to configure the workflow and pass sensitive information securely. You can use GitHub Secrets to store sensitive information.
- **Steps:** Define the individual steps to be executed within each job, including actions for checking out code, installing dependencies, running tests, and deploying code.

### Conclusion

By understanding the principles and objectives of CI/CD, common practices, and using GitHub Actions with a self-hosted runner, you can automate your development and deployment processes effectively. In the next chapter, we will explore advanced topics and best practices for maintaining and optimizing your data analytics stack.
