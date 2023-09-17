# Fast track installation

1. Run app via docker compose, wait all health checks till puma starts
```bash
$ docker compose build
$ docker compose up
```

2. Migrate and import data
```bash
$ make migrate
$ make import_prompts
```

3. Open http://localhost:3000 in browser
