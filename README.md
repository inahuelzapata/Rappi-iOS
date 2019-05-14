# Rappi-iOS

## Requisitos

Para poder correr la aplicación, necesitará cumplir con los siguientes requisitos.

- Xcode 10.2
- Cocoapods


## Instalación

Una vez clonado el proyecto, se debe instalar las dependencias del proyecto, a través de Cocoapods.

```bash
$ cd Rappi
$ pod install
```

Una vez terminado abrir el archivo `Rappi.xcworkspace`.

## Extras

El proyecto usa Swift 5 como lenguaje principal. 

Está instalada una build phase que corre SwiftLint al buildear el proyecto, por lo cual si no se tiene instalada la versión o no es la versión `0.3.1` pueden llegar a verse que no se corresponden al de la última versión estable de este.

## Componentes

Los componentes de la aplicación se pueden agrupar en los siguientes:

- Networking
- CrossFunctional
- Feature
- Error
- Domain

A continuación, describiré los componentes anteriormente nombrados y a su vez su subcomponentes.

### Networking
#### RequestBuilder
#### RequestExecutor
#### RequestProvider
#### ResponseParser

#### Headable
#### Endpoint

### CrossFunctional
Acá tenemos cada componente que pueda llegar a ser reutilizado en más de un objeto en específico, protocolos, o extensiones de código.

### Feature
Por cada feature de la app, tendremos una feature. Sería el equivalente a un módulo VIPER o a un caso de uso.

#### Business
#### Display
#### Presenter
#### Provider
#### View


### Error
Acá tenemos los errores tipados que podemos llegar a handlear a lo largo de toda la aplicación.

### Domain
Acá están los objetos de dominio, que recibo desde el backend, se mantienen como `struct`s para evitar la mutabilidad de estos mismos.

## Consultas

### Single Responsibility Principle

Es el primer principio dentro de lo que son los Principios SOLID de Robert C. Martin (más conocido como Uncle Bob), y se refiere a que un objeto debería tener una responsabilidad única, lo cual a la hora de cambiar un comportamiento en específico no afecta a las demás que si pasaría en caso de tener más de una responsabilidad en un objeto, lo cual se llama `coupling`.

### Buen código / Código limpio
En mi opinión, el código limpio es aquel que es fácil de mantener, escalar y de leer. 

Aquel que no sea basa permanente en el estado de un objeto para realizar una acción específica, y que es fácil de testear.

Entre las cosas que encuentro fundamentales para alcanzar mi definición de código limpio:

- Pure functions
- Dependency Injection
- Tests
- Alineamiento con los principios SOLID (en especial el SRP y ISP)
- Composición por sobre herencia
- Relacionar objetos mediante abstracciones/protocolos en lugar de implementaciones en concreto