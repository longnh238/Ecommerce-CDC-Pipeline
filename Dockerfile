FROM eclipse-temurin:21-jdk-slim
WORKDIR /app
# Copy Gradle wrapper and build files first for caching
COPY gradlew gradlew.bat gradle/ ./
COPY settings.gradle build.gradle ./
COPY src/ ./src/
# Build
RUN ./gradlew build -x test
# Run
CMD ["java", "-Xmx2g", "-jar", "build/libs/ecommerce-cdc-pipeline.jar"]