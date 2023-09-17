# Fast track installation

## Requirements:
* Compatible with macOS or Unix-based systems
* Docker must be installed on your machine

## Installation steps
1. Wait for all health checks to complete and for the Puma server to start running.
```bash
$ docker compose build
$ docker compose up
```
2. Run the following commands to migrate the database and import necessary data.
```bash
$ make migrate
$ make import_prompts
```
3. Open your web browser and navigate to `http://localhost:3000`
