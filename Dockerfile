#FROM maven:3.6.3-openjdk-14-slim AS build
FROM maven:3.6.3-openjdk-17-slim AS build
RUN mkdir -p /workspace
WORKDIR /workspace
COPY pom.xml /workspace
COPY src /workspace/src
RUN mvn -B package --file pom.xml

FROM openjdk:17-slim
COPY --from=build /workspace/target/*jar-with-dependencies.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]
