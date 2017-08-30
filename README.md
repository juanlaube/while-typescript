# While

Implementación del lenguaje While en TypeScript.


### Dependencias

1. Descargar e instalar [Node.js](https://nodejs.org).

1. Instalar [Gulp](http://gulpjs.com). Gulp es una herramienta de ejecución de tareas. Lo utilizaremos para coordinar la generación de la gramatica y compilar los fuentes en TypeScript.
```
npm install -g gulp-cli
```

1. Instalar [Nearley](http://nearley.js.org). Nearley es un generador de parser basado en el  [parser de earley](https://en.wikipedia.org/wiki/Earley_parser).
```
npm install -g nearley
```


## Build

Clonar el repositorio y moverse en un terminal al directorio de trabajo.

Instalar dependencias utilizando `npm install`.

Gulp se encargará de generar la gramatica y compilar los fuentes. Para compilar el proyecto, ejecutar `gulp` desde un terminal.
