## Crear y ejecutar scripts con argumentos pasado CLI

```bash
touch script.sh
```

```sh
echo "Hello world"
```

Para ejecutar un script tenemos que referenciar el `path` al script.

```bash
./script.sh
bash: ./script.sh: Permission denied
```

Nos da un negación de permisos. Esto ocurre porque es el modo por defecto cuando se crea un fichero, tienes permisos de escritura y de lectura, pero no de ejecución.

```bash
ls -l
-rw-r--r--  1 jaimesalaszancada  staff  18 21 Aug 00:58 script.sh
```

Vamos a cambiar los permisos sobre este fichero.

```bash
chmod u+x script.sh
```
* _u+x_ signifaca darle permisos de ejecución al usuario.

Si lo volvemos a ejecutar

```bash
./script.sh
Hello world
```

En bash pasamos parámetros en la CLI después del script y separados por un especio, y los podemos referenciar dentro des script por orden. Por ejemplo podemos modificar _scrpt.sh_ de la siguiente manera:

```diff
-echo "Hello world"
+echo "$1 world"
```

Ahora podemos ejecutar: 

```bash
./script.sh hola
hola world
```

## Ejemplo de uso

Hagamos algo más realista, generar la estructura inicial de un nuevo proyecto en JavaScript. Crear `init-js.sh`

```sh
echo "Initializing JS prokect at $(pwd)"
git init 
npm init -y # create package.json withh all defaults
mkdir src
touch src/index.js 
code . # open the current directory
```

No nos olvidemos de darle permisos de ejecución al fichero:

```bash
chmod u+x init-js.sh
```

El problema es que si queremos ejecutar el script en un directorio en particular tenemos que pegarlo y ejecutarlo ahí, como alternativa a esto podemos modificar `PATH`.

```bash
echo $PATH
```

Esto es, una colección de directorio, separados por `:`, donde la `shell` busca los ejecutables.

/Users/jaimesalaszancada/.nvm/versions/node/v10.16.0/bin:
/usr/local/bin:
/usr/bin:
/bin:
/usr/sbin:/sbin:/Users/jaimesalaszancada/.nvm/versions/node/v10.16.0/bin

Podemos localizar un ejecutable en concreto utilizando el comando `which`

```bash
which minikube
/usr/local/bin/minikube
```

> https://gist.github.com/nex3/c395b2f8fd4b02068be37c961301caa7

## Almacenar y Uasar valores con las Variables de Bash

Podemos almacenar y leer unavariable de la siguiente manera:

```bash
$ var=123
$ echo $var
123
```

El alacnace de esta variable es sólo para esta sesión. Esta varaiable será visible por cualquier script que sea ejecutado en este contexti. Vamos a crear un nuevo script __script_a.sh__. 