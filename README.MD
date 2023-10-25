# Mi Proyecto

Mi proyecto es una aplicación Ruby que implementa un Sistema de Gestión de Productos a través de una API web. Esta aplicación utiliza el framework Rack para gestionar las rutas y solicitudes HTTP, y se ejecuta en un servidor web ligero llamado Thin.

# Características Principales

**Autenticación JWT**: Los usuarios pueden autenticarse mediante JSON Web Tokens (JWT) para acceder a recursos protegidos.

**Gestión de Productos**: Los usuarios autenticados pueden ver una lista de productos existentes y agregar nuevos productos a través de llamadas asincrónicas.

**Persistencia de Datos**: Los productos se almacenan en un archivo JSON para mantener la información entre sesiones.

## Requisitos

- Ruby (versión 3.2.2)

## Gemas Utilizadas

A continuación, se enumeran las gemas que se han utilizado en este proyecto:

- **bundler (2.4.21)**: Utilizado para administrar las gemas del proyecto.
- **dotenv (2.8.1)**: Utilizado para cargar variables de entorno desde el archivo .env.
- **jwt (2.7.1)**: Utilizado para trabajar con tokens JWT.
- **rack (2.2.3)**: Utilizado para construir la aplicación web en Ruby.(la version de rack no DEBE ser mayor a esta version)
- **thin (1.7.2)**: Utilizado como servidor web ligero para el proyecto.
- **thread (0.2.2)**: Utilizado para realizar llamadas asincrónicas en la aplicación.

# Como levantar el Proyecto

- Asegúrate de tener Ruby instalado en tu sistema. La versión recomendada es Ruby 3.2.2.
- Clona este repositorio en tu máquina: ................................
- Asegúrate de navegar al directorio del proyecto.
- Instala las gemas necesarias una por una utilizando el comando gem install. Por ejemplo, para instalar la gema "jwt (2.7.1)", ejecuta: gem install jwt -v 2.7.1. Repite este paso para cada una de las gemas listadas en la sección "Gemas Utilizadas".
- Una vez que hayas instalado las gemas, inicia el servidor Thin para ejecutar la aplicación: ruby app.rb
- La aplicación estará disponible en http://localhost:5000.
