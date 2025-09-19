# Step 1: Build Stage
FROM gradle:8.10.2-jdk21 AS build
WORKDIR /app
COPY --chown=gradle:gradle . /app
RUN gradle clean build -x test --no-daemon

# Step 2: Runtime Stage
FROM eclipse-temurin:21-jre
WORKDIR /app
COPY --from=build /app/build/libs/*.jar app.jar
EXPOSE 5671
ENTRYPOINT ["java", "-jar", "app.jar"]
