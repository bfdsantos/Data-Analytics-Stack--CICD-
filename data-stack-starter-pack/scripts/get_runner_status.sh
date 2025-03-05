#!/bin/bash

set -e  # Exit on error

# Load environment variables
if [ -f .env ]; then
    export $(grep -v '^#' .env | xargs)
fi

# Function to get runner status
get_runner_status() {
    echo "Getting runner status..."
    RESPONSE=$(gh api \
        -H "Accept: application/vnd.github+json" \
        -H "X-GitHub-Api-Version: 2022-11-28" \
    "/repos/$REPO_URL/actions/runners")

    RUNNER_STATUS=$(echo "$RESPONSE" | jq -r --arg RUNNER_NAME "$RUNNER_NAME" '.runners[] | select(.name == $RUNNER_NAME) | {name: .name, status: .status, busy: .busy}')

    if [ -z "$RUNNER_STATUS" ]; then
        echo "Runner with name $RUNNER_NAME not found."
    else
        echo "Runner status: $RUNNER_STATUS"
    fi
}

# Call the function
get_runner_status
