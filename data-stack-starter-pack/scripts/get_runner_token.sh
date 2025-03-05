#!/bin/bash

set -e  # Exit on error

# Load environment variables
if [ -f .env ]; then
    export $(grep -v '^#' .env | xargs)
fi

# Function to create a new runner token
create_token() {
    echo "Requesting new runner token..."
    RESPONSE=$(gh api --method POST \
        -H "Accept: application/vnd.github+json" \
        -H "X-GitHub-Api-Version: 2022-11-28" \
    "/repos/$REPO_URL/actions/runners/registration-token")

    NEW_TOKEN=$(echo "$RESPONSE" | jq -r .token)
    EXPIRES_AT=$(echo "$RESPONSE" | jq -r .expires_at)

    # Update .env file
    sed -i.bak '/RUNNER_TOKEN=/d' .env
    sed -i.bak '/RUNNER_TOKEN_EXPIRES_AT=/d' .env
    echo "RUNNER_TOKEN=$NEW_TOKEN" >> .env
    echo "RUNNER_TOKEN_EXPIRES_AT=$EXPIRES_AT" >> .env

    echo "New token obtained and saved to .env!"
}

create_token
