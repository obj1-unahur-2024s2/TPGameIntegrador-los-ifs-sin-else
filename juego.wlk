import wollok.game.*
import pantallas.*
import nivel.*
import obstaculos.*
import auto.*

object juego{

    //Inicializacion del juego
    method iniciar(){
        self.configuracionInicial() 
        pantallaInicio.agregarVisual()
        keyboard.p().onPressDo{
            game.removeVisual(pantallaInicio)
		    instrucciones.agregarVisual()
		    keyboard.f().onPressDo{self.configurarNivelFacil()}//nivel Fácil
		    keyboard.d().onPressDo{self.configurarNivelDificil()}//nivel Dificil
            
        } 
    }


    //Configuracion basica
    method configuracionInicial(){ 
        game.title("Auto")
        game.width(15)
        game.height(20)
        game.cellSize(40)
    }

    //Configuracion del nivel facil
    method configurarNivelFacil(){
        pantallaModoFacil.agregarVisual()
         keyboard.c().onPressDo{modoFacil.configurar()}

    }
    //Configuracion del nivel dificil
    method configurarNivelDificil(){
        pantallaModoDificil.agregarVisual()
        keyboard.c().onPressDo{modoDificil.configurar()}
        
    }
    
    //Resetear objetos visuales
    method reset(){
        auto.reiniciar()
        vidas.reiniciar()
        contadorMonedas.reiniciar()
    }

    //Victoria
    method ganar(){
        self.finDelJuego()
        game.schedule(300, {
        game.sound("sonidoVictoria.mp3").play()
        pantallaVictoria.agregarVisual()
        keyboard.r().onPressDo({self.reiniciarElJuego()})
        })
        
    }


    //Derrota
    method derrota(){
        self.finDelJuego()
         game.schedule(300, {
        game.sound("gameOver.mp3").play()
        pantallaDerrota.agregarVisual()
        keyboard.r().onPressDo({self.reiniciarElJuego()})
         })
    }

    //Fin del juego
    method finDelJuego(){
        modoFacil.eliminarEventosObstaculosNivel()
        self.limpiarVisualesDeObstaculos()
        sonidoGeneral.parar()
        
    }
    //Limpiar todas las visuales del juego
    method limpiarVisualesDeObstaculos(){
       game.allVisuals().forEach({v => game.removeVisual(v)})
       game.removeVisual(auto)
       game.removeVisual(contadorMonedas)
       game.removeVisual(vidas)
       
     
       

    }

    method reiniciarElJuego(){
        self.reset()
        self.iniciar()

       

    }
     method removerVisualSiHay(pantalla){
   		if (game.hasVisual(pantalla))
   			game.removeVisual(pantalla)	
   }

}

object sonidoGeneral{
    const sonido = game.sound("backgroundMusic.mp3")

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
			juego.derrota()
	}
	
	method cantidadVidas() = vidas
	
	method reiniciar(){
		vidas = 3
	}

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


}