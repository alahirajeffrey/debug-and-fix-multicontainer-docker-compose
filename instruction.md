# Nodejs and MongoDB connectivity

Debug and fix a multi-container Node.js and MongoDB application in Docker Compose where the web service fails to connect due to incorrect environment variable interpolations, port mappings, and missing npm build steps; update the Dockerfiles, docker-compose.yml, and entrypoint scripts so both containers atart correctly and the application passes health checks.

## Requirements

Requirements to test the project:

1. Docker compose
2. Postman

How to run:

1. Navigate to the directory
2. Create a `.env` file and populate with the `.env.example file`
3. Run the command `docker compose up --build` to build the application
4. Then run the command `docker compose up -d` to start the application
5. Open postman and make a request to `localhost:5000/health` to run the health checker

**NB:**

This project should:

1. Nodejs project should build correctly
2. MongoDB should start up
3. Nodejs application should start up
4. Nodejs application should connect to the mongodb with the right environment variable
5. Health checks should pass correctly
