import wollok.game.*
import juego.*
import auto.*
import pantallas.*
import obstaculos.*

class Nivel1{
	method configurar(autoRojo, autoViol, genMonedas, contadorMoneda){ 
		juego.configuracionInicial()
		sonidoGeneral.configurar()
		self.agregarFondo()
		self.configurarVisuales()
		self.generarMonedas(genMonedas, contadorMoneda)
		self.generarObstaculos(autoRojo, autoViol)
		game.onCollideDo(auto,{a => a.chocar()})
	} 

	method configurarVisuales(){ 
		auto.configurar()
		game.addVisual(contadorMonedas)
		game.addVisual(vidas) 
	}

	method eliminarEventosObstaculosNivel(autoRojo, autoVioleta, genMonedas, contMonedas){
		game.removeTickEvent(autoRojo)
		game.removeTickEvent(autoVioleta)
		game.removeTickEvent(genMonedas)
		game.removeTickEvent(contMonedas)

	}



	method agregarFondo(){
		game.addVisual(pista)
		sonidoGeneral.sonar()
	}

	method generarMonedas(mon1, mon2){
        game.onTick(3000, mon1, {new Moneda().aparecer()})
        game.onTick(10, mon2, {if (contadorMonedas.cantidadMonedas() == self.cantidad()) self.ganar()})
    }

	method generarObstaculos(auto1, auto2){
		game.onTick(600, auto1, {new Obstaculo1().aparecer()}) 
        game.onTick(1200, auto2, {new Obstaculo2().aparecer()})
	}

	method cantidad()= 10

	method ganar(){
		juego.pasarASiguienteNivel()
	}

}

object nivel2 inherits Nivel1{
	override method configurar(autoRojo, autoViol, genMonedas, contadorMoneda){
		juego.reset() 
		super(autoRojo, autoViol, genMonedas, contadorMoneda)
	}

	override method cantidad() = 20

	override method ganar(){
        juego.ganar()
    }

}

