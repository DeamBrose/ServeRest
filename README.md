# ServeRest API Automation Tests (Karate Framework)

Este proyecto contiene pruebas automatizadas de API para la aplicación ServeRest, desarrolladas utilizando el framework [Karate](https://github.com/karatelabs/karate).

## Prerrequisitos

Asegúrate de tener instalado lo siguiente en tu sistema:

1.  **Java Development Kit (JDK):** Versión 17.
2.  **Apache Maven:** Para la gestión de dependencias y ejecución de pruebas.
3.  **Git:** Para clonar el repositorio.
4.  **IDE (Recomendado):** IntelliJ IDEA.

## Configuración

1.  **Clonar el Repositorio:**
    bash git clone https://github.com/DeamBrose/ServeRest.git
2.  **Instalar Dependencias:**
mvn clean install,
    Esto descargará Karate y las  dependencias definidas en el archivo `pom.xml`.

## Ejecución de Pruebas

Puedes ejecutar las pruebas de Karate utilizando Maven desde la línea de comandos.

### Ejecución General (Entorno 'dev')

Para ejecutar todas las pruebas configuradas en el `RunnerTest` utilizando el entorno 'dev' (probablemente definido en `karate-config.js`), usa el siguiente comando:

### Ejecutar por Tag Específico

Puedes ejecutar solo los escenarios o features que tengan una etiqueta específica. Esto es útil para ejecutar conjuntos de pruebas como regresión, smoke tests, etc.
mvn clean test -Dkarate.options="--tags @tu_etiqueta" -Dkarate.env=dev

### Ejecutar un Feature Específico

Puedes ejecutar un archivo `.feature` individual indicando su ruta en el classpath.
Ejemplo: 
1. classpath:bdd/apiUsuarios/putUsersById/putUsersById.feature
2. mvn clean test -Dkarate.options="classpath:ruta/al/feature/deseado.feature" -Dkarate.env=dev

## Informe
Estrategia de Automatización y Patrones (ServeRest API - Karate) Se emplea Karate para pruebas de API con enfoque BDD (Gherkin). 
La estrategia se basa en:
1. Organización: Features por funcionalidad API, Background para configuración común.
2. Reutilización: Helpers JavaScript (.js) para generación de datos y lógica común; call para reutilizar/encadenar escenarios y pasar datos.
3. Validación: Verificación de códigos de estado, contenido de mensajes y estructura de respuesta mediante schemas JSON.
4. Ejecución: Gestionada por Maven, con selección por tags y entornos (-Dkarate.env).Patrones Clave: BDD, Helper Utilities, Schema Validation, Scenario Chaining (call), Tagging.

 