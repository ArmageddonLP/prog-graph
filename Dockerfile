FROM maven:3.8.1-openjdk-17

WORKDIR /
RUN mkdir -p /build
RUN mkdir -p /app

WORKDIR /build
COPY pom.xml /build/pom.xml
RUN mvn -B dependency:resolve dependency:resolve-plugins
COPY src /build/src
RUN mvn package -DskipTests
RUN cp /build/target/app.jar /app/app.jar

WORKDIR /
RUN rm -rf /build

WORKDIR /app
ENTRYPOINT ["java", "-jar", "app.jar"]