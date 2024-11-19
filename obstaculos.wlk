import wollok.game.*
import juego.*
import pantallas.*
import nivel.*
import auto.*

class Obstaculos{
    var position=self.posicionAleatoria()

    method position()=position

    method image()=null

    method posicionAleatoria()=game.at(0.randomUpTo(game.width()-1).truncate(0), game.height()-1)

    method aparecer(){ 
        if (game.getObjectsIn(position).isEmpty())
            game.addVisual(self)
            game.onTick(100, self.identity().toString(), {self.bajar()})
    }
    
    method bajar(){
        if (position.y() < 4){
            game.removeTickEvent(self.identity().toString())
            self.removerVisualSiHay()
            }
        else{
            position= position.down(1)
        } 
   }

    method removerVisualSiHay(){
   		if (game.hasVisual(self))
   			game.removeVisual(self)	
   }

   method chocar()
   method esObstaculo() = true
   

}

class Obstaculo1 inherits Obstaculos{ //autoRojo resta 2
    override method image()="obstaculo1.png"

    override method chocar(){
        
        contadorMonedas.restarMonedas(2)
    }
}

class Obstaculo2 inherits Obstaculos{ //autoVioleta resta 2 y pierde vida
    override method image()="obstaculo2.png"

    override method chocar(){
        contadorMonedas.restarMonedas(2)
        vidas.perderVida(1)
    }
}

class Moneda inherits Obstaculos{
	
	override method image() = "moneda.png" 
	
	override method chocar(){
		game.sound("atraparMoneda.mp3").play()
		contadorMonedas.conseguirMoneda()
		game.removeVisual(self)
	}
    override method aparecer(){ // este modifica la velocidad a la que caen las monedas
        if (game.getObjectsIn(position).isEmpty())
            game.addVisual(self)
            game.onTick(200, self.identity().toString(), {self.bajar()})
    }
}