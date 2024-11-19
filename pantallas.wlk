import wollok.game.*
import juego.*

import nivel.*
import obstaculos.*
import auto.*

class Pantalla{
    const position=game.at(0,0)
    var image
    method position() = position
    method image()=image 

	method esObstaculo() = false
}


const pantallaInicio= new Pantalla(image="pInicio.png")
const pista=new Pantalla(image="pistaPantalla.png") 
const instrucciones1= new Pantalla (image="pantallaInstrucciones.png")
const pantallaFinal = new Pantalla(image = "pantallaLose.jpg")
const pantallaVictoria = new Pantalla(image="pantallaWin.jpg")
const pasarDeNivel = new Pantalla(image="pantallaNextLevel.png")

object instrucciones inherits Pantalla(image="pantallaInstrucciones.png"){ 
	method configurar(){
		game.removeVisual(pantallaInicio)
		game.addVisual(self)
		keyboard.s().onPressDo{juego.configurar()}
		keyboard.enter().onPressDo{juego.configurar()}
	}
	
}