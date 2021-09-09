Dockerfile:
FROM openjdk:11.0.5-jdk  (run a java image being a java program which also helps in removing a layer of "Install Java" in the image."
ADD *.jar app.jar  (ADD command helps to add copied *.jar artifacts on th runtime in the docker dir which is otherwise empty)
ENTRYPOINT java -jar app.jar  (Entrypoint is executing the program java for the created application app.jar when container will spinoff from our image)
    
