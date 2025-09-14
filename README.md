# Ecommerce CDC Pipeline
## Setup
1. Install Docker, Python 3.10+, Java 21, Git.
2. Clone: `git clone <repo-url> && cd ecommerce-cdc-pipeline`.
3. Generate data: `cd data && python generate_inventory.py && cd ..`.
4. Generate Gradle Wrapper: `./gradlew wrapper --gradle-version 8.10`.
5. Build: `./gradlew clean build`.
6. Start: `docker compose up -d`.
7. Configure Debezium: Run `curl -X POST ...` (copy from Step 4.3).
8. Test: Run `tests/simulate_updates.py`, check endpoints (`curl -u admin:secret http://localhost:8080/health`).
## Testing
- PostgreSQL: `docker exec -it <postgres-id> psql ...`.
- Kafka: `docker exec -it <kafka-id> kafka-console-consumer ...`.
- Flink: http://localhost:8081.
- Spring Boot: `curl -u admin:secret http://localhost:8080/health`.
## Stop
- `docker compose down -v`