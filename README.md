
# FastAPI App Deployment on Fly.io

This repository contains a simple FastAPI application that can be deployed on Fly.io. Follow the instructions below to get your app running.

## Prerequisites

1. **Fly CLI**: Install the Fly CLI by following the instructions at [Fly.io CLI installation](https://fly.io/docs/hands-on/install-flyctl/).
2. **GitHub Repository**: Fork this repository to your GitHub account.

## Getting Started

### Clone the Repository

```bash
git clone https://github.com/itsjustshubh/fastapi-fly-app-template.git
cd fastapi-fly-app-template
```

### Setup Poetry (Optional)

If you prefer using Poetry for dependency management, follow these steps:

1. **Initialize Poetry Project**

    ```bash
    poetry new fastapi-app
    cd fastapi-app
    poetry shell
    ```

2. **Add FastAPI Dependency**

    ```bash
    poetry add fastapi
    ```

### FastAPI Application

The FastAPI application is located in `main.py`:

```python
from fastapi import FastAPI

app = FastAPI()

@app.get("/")
async def read_root():
    return {"message": "Hello, World!"}
```

### Running Locally

1. **Development Mode**

    ```bash
    fastapi dev
    ```

2. **Production Mode**

    ```bash
    fastapi run
    ```

### Deploy to Fly.io

1. **Prepare Fly.io Configuration**

    Create a `fly.toml` file in the root of your project with the following content:

    ```toml
    [app]
    name = "your-app-name"
    region = "ams" # Amsterdam region, adjust if needed

    [build]
    dockerfile = "Dockerfile"

    [[services]]
    http_checks = []
    internal_port = 8000
    processes = ["web"]
    protocol = "tcp"

    [services.ports]
    http = 80
    ```

2. **Create a `Dockerfile`**

    Add a `Dockerfile` in the root directory of your project:

    ```Dockerfile
    # Start with a base image that includes Python
    FROM python:3.9-slim

    # Set environment variables
    ENV PYTHONDONTWRITEBYTECODE=1
    ENV PYTHONUNBUFFERED=1

    # Set the working directory
    WORKDIR /app

    # Install dependencies
    COPY pyproject.toml poetry.lock* /app/
    RUN pip install poetry && poetry install --no-dev

    # Copy the application code
    COPY . /app/

    # Expose the port FastAPI runs on
    EXPOSE 8000

    # Command to run the application
    CMD ["poetry", "run", "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
    ```

3. **Deploy Your App**

    - Authenticate with Fly.io:

      ```bash
      flyctl auth login
      ```

    - Initialize your Fly.io app (if you haven’t done so already):

      ```bash
      flyctl apps create your-app-name
      ```

    - Deploy your app:

      ```bash
      flyctl deploy
      ```

    Your app will be accessible at `https://your-app-name.fly.dev/`.

### GitHub Actions for Continuous Deployment

The provided GitHub Actions workflow (`.github/workflows/deploy.yml`) automates the deployment process. It triggers on pushes to the `master` branch and deploys the app to Fly.io.

1. **Set Up Secrets**

    - Go to your repository's settings on GitHub.
    - Navigate to "Secrets and variables" > "Actions".
    - Add a new secret with the name `FLY_API_TOKEN` and your Fly.io API token.

2. **Push Changes**

    ```bash
    git add .
    git commit -m "Setup deployment workflow"
    git push origin master
    ```

    The GitHub Actions workflow will automatically deploy your app to Fly.io.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
