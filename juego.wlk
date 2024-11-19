import wollok.game.*
import pantallas.*
import nivel.*
import obstaculos.*
import auto.*

object juego{
    const nivel1= new Nivel1()
    var nivel = nivel1

    method iniciar(){
        self.configuracionInicial() 
        game.addVisual(pantallaInicio) 
        keyboard.enter().onPressDo{instrucciones.configurar()} 
    }

    method configuracionInicial(){ 
        game.title("Auto")
        game.width(15)
        game.height(20)
        game.cellSize(40)
    }

    method configurar(){
        game.removeVisual(instrucciones1)
        nivel.configurar("generacion autoRojo", "generacion autoVioleta", "generacion monedas", "contador monedas")
    }

    method pasarASiguienteNivel(){
        game.removeVisual(pista)
        nivel.eliminarEventosObstaculosNivel("generacion autoRojo", "generacion autoVioleta", "generacion monedas", "contador monedas")
        self.limpiarVisualesDeObstaculos()
        game.addVisual(pasarDeNivel)
        nivel = nivel2
        game.removeVisual(auto)
        game.removeVisual(vidas)
        game.removeVisual(contadorMonedas)
        
        keyboard.enter().onPressDo{
             game.addVisual(vidas)
             game.addVisual(contadorMonedas)
             game.onTick(600, "generacion AutoRojo2", {new Obstaculo1().aparecer()}) 
             game.onTick(1200, "generacion AutoVioleta2", {new Obstaculo2().aparecer()})
             game.onTick(3000, "generacion monedas2", {new Moneda().aparecer()})
             game.onTick(10, "contador monedas2", {if (contadorMonedas.cantidadMonedas() == nivel.cantidad()) self.ganar()})
             }  
       
    }

    method reset(){
        auto.reiniciar()
        vidas.reiniciar()
        contadorMonedas.reiniciar()
    }

    method ganar(){
        self.limpiarVisualesDeObstaculos()
        nivel2.eliminarEventosObstaculosNivel("generacion AutoRojo2", "generacion AutoVioleta2", "generacion monedas2", "contador monedas2")
        game.removeVisual(pista)
        game.sound("success.mp3").play() 
        game.addVisual(pantallaVictoria)
        keyboard.enter().onPressDo{game.stop()}
    }

    method finDelJuego(){
        self.limpiarVisualesDeObstaculos()
        game.removeTickEvent("generacion autoRojo")
		game.removeTickEvent("generacion autoVioleta")
		game.removeTickEvent("generacion monedas")
		game.removeTickEvent("contador monedas")
        nivel2.eliminarEventosObstaculosNivel("generacion AutoRojo2", "generacion AutoVioleta2", "generacion monedas2", "contador monedas2")
        game.removeVisual(pista)
        sonidoGeneral.parar()
        game.sound("gameOver.mp3").play()
        game.addVisual(pantallaFinal) 
        keyboard.enter().onPressDo{game.stop()}
    }

    method limpiarVisualesDeObstaculos(){
       game.schedule(200,{game.allVisuals().filter({x => x.esObstaculo()}).forEach({x => game.removeVisual(x)})})

    }

    method esObstaculo() = false
}

object sonidoGeneral{
    const sonido = game.sound("sonidoManejo.mp3") //acá cambié la música por el sonido de manejo

    method sonar(){
        sonido.shouldLoop(true)
        game.schedule(1,{sonido.play()})
    }

    method configurar(){
		keyboard.v().onPressDo({sonido.volume(0.2)})
		keyboard.m().onPressDo({sonido.volume(1)})
	}

    method parar(){
        sonido.stop()
    }

    method pausar(){
        sonido.pause()
    }
}

object vidas {

    const position = game.at(11, 18.5)
	var vidas = 3
	
	method position() = position
	
	method image() = vidas.toString()+"Vida.png"
	
	method perderVida(cuantas){
		vidas = 0.max(vidas-cuantas)
		if (vidas == 0)
			juego.finDelJuego()
	}
	
	method cantidadVidas() = vidas
	
	method reiniciar(){
		vidas = 3
	}

     method esObstaculo() = false
}

object contadorMonedas{
	const position = game.at(1,18.5)
	var cantMoneda = 0
	
	method position() = position
	method image() = "contadorEn"+cantMoneda.toString()+".png"
	
	method conseguirMoneda(){
		cantMoneda += 1	
	}
	 
	method cantidadMonedas() = cantMoneda
	
	method restarMonedas(cantidad){
		cantMoneda = 0.max(cantMoneda-cantidad)
	}
		
    method reiniciar(){
        cantMoneda = 0
    }

    method esObstaculo() = false
}