import wollok.game.*
import juego.*
import pantallas.*


//Auto
object auto{
	var position=self.posicionInicial()
	var teclasConfiguradas = false
	
	method position()=position
	method posicionInicial() = game.at((game.width()/2), 5)
	
	method image()="autoPrincipal.png"

	method configurar(){	
		game.addVisual(self)
		self.configurarTeclas()
	} 
	
	method moverDerecha(){
		if (position.x() < game.width()-2)
			position = position.right(1)
	}
	
	method moverIzquierda(){ 
		if (position.x() > 0)
			position = position.left(1)
	}

	
	method configurarTeclas(){
		if(!teclasConfiguradas) {
            keyboard.right().onPressDo({ self.moverDerecha() })
            keyboard.left().onPressDo({ self.moverIzquierda() })
            teclasConfiguradas = true // Marca las teclas como configuradas
	}
	}
	method reiniciar(){
		game.removeVisual(self)
		position = self.posicionInicial()
		
	}
	
	
}