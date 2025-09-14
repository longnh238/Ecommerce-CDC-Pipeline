FROM eclipse-temurin:21-jdk-slim
WORKDIR /app
COPY . .
RUN ./gradlew build -x test
CMD ["java", "-Xmx2g", "-jar", "build/libs/ecommerce-cdc-pipeline.jar"]