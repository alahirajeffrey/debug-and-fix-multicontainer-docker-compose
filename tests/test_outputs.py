import requests
import os
import subprocess
from dotenv import load_dotenv

load_dotenv()

def test_mongo_container_has_expected_env_vars():
    """Verify that mongodb has the proper environment variables."""
    username = os.getenv("MONGO_INITDB_ROOT_USERNAME")
    password = os.getenv("MONGO_INITDB_ROOT_PASSWORD")

    result = subprocess.run(
        [
            "docker",
            "exec",
            "mongodb",
            "printenv",
            "MONGO_INITDB_ROOT_USERNAME",
        ],
        capture_output=True,
        text=True,
    )

    assert result.returncode == 0
    assert result.stdout.strip() == username

    result = subprocess.run(
        [
            "docker",
            "exec",
            "mongodb",
            "printenv",
            "MONGO_INITDB_ROOT_PASSWORD",
        ],
        capture_output=True,
        text=True,
    )

    assert result.returncode == 0
    assert result.stdout.strip() == password

def test_mongodb_is_running():
    """Verify that mongodb is running"""
    result = subprocess.run(
        ["docker", "compose", "ps"],
        capture_output=True,
        text=True,
    )

    assert result.returncode == 0
    output = result.stdout.lower()
    assert "mongodb" in output

def test_api_is_running():
    """Verify the api server is running"""
    result = subprocess.run(
        ["docker", "compose", "ps"],
        capture_output=True,
        text=True,
    )

    assert result.returncode == 0
    output = result.stdout.lower()
    assert "api" in output



def test_health_status_code():
    """Verify the server returns the right status."""
    response = requests.get("http://localhost:3000/health")

    assert response.status_code == 200


def test_health_response():
    """Verify the server returns the right message."""
    response = requests.get("http://localhost:3000/health")

    assert response.json() == {
        "status": "healthy"
    }