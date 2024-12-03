import wollok.game.*
import juego.*
import auto.*
import pantallas.*
import obstaculos.*


//Molde de nivel
class Nivel{
	//Configuracion inicial del nivel
	method configurar(){
		juego.configuracionInicial()
		sonidoGeneral.configurar()
		self.agregarFondo()
		self.configurarVisuales()
		self.generarMonedas("generacion monedas", "contador monedas")
		self.generarObstaculos("generacion autoRojo", "generacion autoVioleta")
		self.generarObstaculosNuevos("generacion autoGris", "generacion autoNaranja")
		game.onCollideDo(auto, {a => a.chocar()})
	}

	//Agregar fondo
	method agregarFondo(){
		if(!game.hasVisual(pista)){
			game.addVisual(pista)
		}
		sonidoGeneral.sonar()
	}

	method agregarAuto(){
			auto.configurar()
		
	}
	//Configuraciones de las visuales
	method configurarVisuales(){
		self.agregarAuto()
		game.addVisual(contadorMonedas)
		game.addVisual(vidas)
	}

	//Generacion de monedas
	method generarMonedas(monedas, contador){
		game.onTick(3000, monedas, {new Moneda().aparecer()})
        game.onTick(10, contador, {if (contadorMonedas.cantidadMonedas() == self.cantidadParaGanar()) self.ganar()})
	}

	//Generacion de obstaculos
	method generarObstaculos(autosRojos, autosVioletas){
		game.onTick(600, autosRojos, {new Obstaculo1().aparecer()}) 
        game.onTick(1200, autosVioletas, {new Obstaculo2().aparecer()})
	}
	method generarObstaculosNuevos(autosGrises, autosNaranjas){
		game.onTick(800, autosGrises, {new Obstaculo3().aparecer()}) 
        game.onTick(1000, autosNaranjas, {new Obstaculo4().aparecer()})
	}

	//Eliminacion de eventos
	method eliminarEventosObstaculosNivel(){
		game.removeTickEvent("generacion autoRojo")
		game.removeTickEvent("generacion autoVioleta")
		game.removeTickEvent("generacion autoGris") 
		game.removeTickEvent("generacion autoNaranja")
		game.removeTickEvent("generacion monedas")
		game.removeTickEvent("contador monedas")
	}

	//Eliminacion de visuales
	method eliminarObjetosVisualesDelNivel(){
		game.removeVisual(auto)
        game.removeVisual(vidas)
        game.removeVisual(contadorMonedas)
	}

	//Cantidad necesaria de monedas para ganar
	method cantidadParaGanar() = 10

	//Victoria
	method ganar(){
		juego.ganar()
	}
}


//Modo Facil
object modoFacil inherits Nivel{
	override method generarObstaculosNuevos(autosGrises, autosNaranjas){
		
	}

	override method configurar(){
		game.removeVisual(pantallaModoFacil)
		super()
		
		
	}
}

//Modo dificil
object modoDificil inherits Nivel{

	override method configurar(){
		game.removeVisual(pantallaModoDificil)
		super()
	}

	override method generarMonedas(monedas, contador){
		game.onTick(2000, monedas, {new Moneda().aparecer()})
        game.onTick(10, contador, {if (contadorMonedas.cantidadMonedas() == self.cantidadParaGanar()) juego.ganar()})
	}

	override method generarObstaculos(autosRojos, autosVioletas){
		game.onTick(600, autosRojos, {new Obstaculo1().aparecer()}) 
        game.onTick(1000, autosVioletas, {new Obstaculo2().aparecer()})
	}

	override method cantidadParaGanar() = 20

}