FROM maven:3.9.11-eclipse-temurin-17-alpine AS build
WORKDIR /app
COPY . .
RUN --mount=type=secret,id=maven_settings,target=/root/.m2/settings.xml \
    mvn clean deploy -Dcheckstyle.skip

FROM eclipse-temurin:17-jre-alpine AS runtime
WORKDIR /app
COPY --from=build /app/target/*.jar ./app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"] 
