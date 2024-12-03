import wollok.game.*
import juego.*

import nivel.*
import obstaculos.*
import auto.*

class Pantalla{
    const position=game.at(0,0)
    var property image
    method position() = position
    method image()=image 
    
    method agregarVisual(){
        if(!game.hasVisual(self)){
            game.addVisual(self)
        }
    }
}


object pantallaInicio inherits Pantalla(image = "pantallaIntro.jpeg"){}
object pista inherits Pantalla(image="pistaDeJuego.gif"){}
object instrucciones inherits Pantalla (image="pantallaInstrucciones.jpeg"){}
object pantallaDerrota inherits Pantalla(image = "pantallaDerrota.jpeg"){}
object pantallaVictoria inherits Pantalla(image="pantallaVictoria.jpeg"){}
object pasarDeNivel inherits Pantalla(image="pantallaNextLevel.png"){}
object pantallaModoDificil inherits Pantalla(image ="pantallaDificil.jpeg"){}
object pantallaModoFacil inherits Pantalla(image = "pantallaFacil.jpeg"){}

