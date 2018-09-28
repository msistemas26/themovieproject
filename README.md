# Aplicación Movie Usando Clean-swift 

Esta es un ejemplo de como usar Clean Swift 

http://clean-swift.com/clean-swift-ios-architecture

# Descripción

La aplicación se conecta al siguiente servicio:  https://api.themoviedb.org/3 trae un listado de peliculas, las cuales se visualizan en la pagina principal.

La aplicacion permite consultar y visualizar datos offline usando realm como adminitrador de base de datos.


Siguiendo la estructura de Clean Arquitecture se definen las siguientes clases para cada scene:
* ViewController:  Aqui se encuentra la logica de la Vista
* Interactor: Aqui se reciben instrucciones de la vista y se administra la logica de la aplicación
* Presenter: Aqui se envian los resultados a la vista
* Model: este contiene la estructura de datos o el modelo perteneciente a la scene
* Router: Aqui se agregan los metodos de transision entre scenas

Features que contiene:
* Consultar peliculas de el servicio
* Almacenar peliculas en base de datos local
* Visualizar el detalle de las peliculas
* Ver una pelicula.
* Buscar peliculas por titulos.
* Filtrar pelicula por categoria (No implementado)

## Programación Basada en protocolos

La aplicación se encuentra escrita siguiendo la programación basada en protocolos, es por eso que encontraremos dentro de cada clase un protocolo que define su implentación.


```swift
// Ejemplos de protocolos
protocol ListCategoriesDisplayLogic: class
{
    func displayFetchedCategories(viewModel: ListCategories.FetchCategories.ViewModel)
}

protocol ListCategoriesBusinessLogic
{
    func fetchCategories(request: ListCategories.FetchCategories.Request)
}

protocol ListCategoriesDataStore
{
    var categories: [Category]? { get }
}
```

## Animaciones

Para mostrar el listado de categorias se implemento una animación que muestra el viewcontroller de categorias usando fade desde arriba hacia abajo, de igual forma hace dismiss con la misma animación.


```swift
class FadeUpToBottomTransitionAnimation: UIViewControllerAnimatedTransitioning {

}
```

![alt text](https://github.com/msistemas26/themovieproject/example/animation.gif "Animation")

## Offline

Para mostrar el listado de peliculas offline se implemento Realm como framework que permite de forma simple crear base de datos, consultar y guardar registros en ella.


```swift
func saveMovieIntoRealm(movies :[Movie], category: Category) {
        
        let realm = try! Realm()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        try! realm.write {
            for movie in movies {
                let realmMovie = RealmMovie()
                realmMovie.id = Int(movie.id)
                realmMovie.title = movie.title
                realmMovie.overview = movie.overview
                realmMovie.poster_path = movie.poster_path
                realmMovie.release_date = movie.release_date
                realmMovie.popularity = movie.popularity
                realmMovie.vote_average = 0.0
                realmMovie.video = movie.video
                realmMovie.category = category.path
                realm.add(realmMovie, update: true)
            }
		}
}
```


## Aplicación

![alt text](https://github.com/msistemas26/themovieproject/example/movie.gif "Ejemplos")
