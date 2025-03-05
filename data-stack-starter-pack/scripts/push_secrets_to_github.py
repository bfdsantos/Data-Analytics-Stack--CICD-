import json
import logging
import os
import subprocess
from typing import List, Tuple

from nacl.encoding import Base64Encoder
from nacl.public import PublicKey, SealedBox

logging.basicConfig(
    level=logging.INFO, format="%(asctime)s - %(levelname)s - %(message)s"
)


def load_env_variables() -> None:
    if os.path.isfile(".env"):
        with open(".env") as f:
            for line in f:
                if line.strip() and not line.startswith("#"):
                    key, value = line.strip().split("=", 1)
                    os.environ[key] = value
        logging.info("Environment variables loaded successfully.")
    else:
        logging.error("'.env' file not found.")
        raise FileNotFoundError("'.env' file not found.")


def push_secrets_to_github(secret_name: str, encrypted_value: str, key_id: str) -> None:
    logging.info(f"Pushing secret '{secret_name}' to GitHub...")
    try:
        subprocess.run(
            [
                "gh",
                "api",
                "--method",
                "PUT",
                "-H",
                "Accept: application/vnd.github+json",
                "-H",
                "X-GitHub-Api-Version: 2022-11-28",
                f"/repos/{os.environ['REPO_URL']}/actions/secrets/{secret_name}",
                "-f",
                f"encrypted_value={encrypted_value}",
                "-f",
                f"key_id={key_id}",
            ],
            check=True,
        )
        logging.info(f"Secret '{secret_name}' pushed to GitHub successfully.")
    except subprocess.CalledProcessError as e:
        logging.error(f"Failed to push secret '{secret_name}' to GitHub: {e}")
        raise


def encrypt_message(message: str, public_key: str) -> str:
    public_key_bytes = Base64Encoder.decode(public_key.encode("utf-8"))
    public_key_obj = PublicKey(public_key_bytes)
    sealed_box = SealedBox(public_key_obj)
    encrypted = sealed_box.encrypt(message.encode("utf-8"))
    return Base64Encoder.encode(encrypted).decode("utf-8")


def get_public_key() -> Tuple[str, str]:
    try:
        public_key_response = subprocess.run(
            [
                "gh",
                "api",
                "-H",
                "Accept: application/vnd.github.v3+json",
                "-H",
                "X-GitHub-Api-Version: 2022-11-28",
                f"/repos/{os.environ['REPO_URL']}/actions/secrets/public-key",
            ],
            capture_output=True,
            text=True,
            check=True,
        )
        public_key_data = json.loads(public_key_response.stdout)
        key_id = public_key_data["key_id"]
        public_key = public_key_data["key"]
        return key_id, public_key
    except subprocess.CalledProcessError as e:
        logging.error(f"Failed to retrieve public key: {e}")
        raise


def select_secrets(secrets: List[str]) -> List[str]:
    print("Select the secrets to push to GitHub (comma separated):")
    for i, secret in enumerate(secrets, 1):
        print(f"{i}. {secret.split('=')[0]}")

    selected_indices = input("\nEnter the numbers of the secrets to push: ").split(",")
    return [secrets[int(index) - 1] for index in selected_indices]


def main() -> None:
    try:
        load_env_variables()

        with open(".env") as f:
            secrets = [
                line.strip() for line in f if line.strip() and not line.startswith("#")
            ]

        if not secrets:
            logging.warning("No secrets found in '.env' file.")
            return

        selected_secrets = select_secrets(secrets)
        key_id, public_key = get_public_key()

        for secret in selected_secrets:
            secret_name, message = secret.split("=", 1)
            encrypted_value = encrypt_message(message, public_key)
            push_secrets_to_github(secret_name, encrypted_value, key_id)

        logging.info("Secrets pushed to GitHub successfully!")
    except Exception as e:
        logging.error(f"An error occurred: {e}")


if __name__ == "__main__":
    main()
