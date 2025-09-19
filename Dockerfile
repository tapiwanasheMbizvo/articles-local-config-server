# Step 1: Build Stage
FROM maven:3.9.6-eclipse-temurin-21 AS build
WORKDIR /app
COPY --chown=maven:maven . /app
RUN mvn clean package -DskipTests

# Step 2: Runtime Stage
FROM eclipse-temurin:21-jre
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 5671
ENTRYPOINT ["java", "-jar", "app.jar"]

 