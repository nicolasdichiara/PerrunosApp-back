# PerrunosApp-back
Repositorio de Perrunos

Para setear el ambiente de trabajo se necesita:

1- Instalar la JDK 1.8
2- Setear variable JAVA_HOME y ponerla en el path
3- Instalar MAVEN
4- Setear variable MAVEN_HOME y ponerla en el path
5- Instalar Eclipse
6- Instalar Xtend https://www.eclipse.org/xtend/download.html

Docuemntación Explicada en http://wiki.uqbar.org/wiki/articles/xtend-principal.html

Para compilar un nuevo jar en la carpeta build, hay un archivo llamado compile.xml, click derecho > Run As > Ant Build. Esto generará un nuevo jar en la carpeta out

Comandos Heroku
1- Instalar heroku CLI https://devcenter.heroku.com/articles/heroku-cli#download-and-install
2- Loguearse con comando heroku login en la consola de git
3- Correr el comando heroku plugins:install java
4- Para subir un nuevo jar correr el comando heroku deploy:jar perruunosapp.jar --app perrunosapp parado en la carpeta out
5- Para ver el log correr el comando heroku logs --tail
