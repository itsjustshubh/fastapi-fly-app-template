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

1. **Deploy Your App**

   - Authenticate with Fly.io:

     ```bash
     flyctl auth login
     ```

   - Initialize your Fly.io app (if you haven’t done so already):

     ```bash
     fly launch --generate-name
     ```

2. **Push Changes**

   ```bash
   git add .
   git commit -m "Setup deployment workflow"
   git push origin master
   ```

   The GitHub Actions workflow will automatically deploy your app to Fly.io.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
