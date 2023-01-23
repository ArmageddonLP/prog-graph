FROM maven:3.8.1-openjdk-17

WORKDIR /
RUN mkdir -p /build
RUN mkdir -p /prog_graph/app
RUN mkdir -p /prog_graph/db

WORKDIR /build
COPY pom.xml /build/pom.xml
RUN mvn -B dependency:resolve dependency:resolve-plugins
COPY src /build/src
RUN mvn package -DskipTests
RUN cp /build/target/app.jar /prog_graph/app/app.jar

WORKDIR /
RUN rm -rf /build

WORKDIR /prog_graph/app
ENTRYPOINT ["java", "-jar", "app.jar", "--spring.profiles.active=${SYSTEM_ENV}"]