import wollok.game.*
import juego.*
import pantallas.*


object auto{
	var position=self.posicionInicial()
	
	method position()=position
	method posicionInicial() = game.at((game.width()/2), 5)
	
	method image()="autoPrincipal.png"

	method configurar(){
		game.addVisual(self)
		keyboard.right().onPressDo{self.moverDerecha()}
		keyboard.left().onPressDo{self.moverIzquierda()}
	} 
	
	method moverDerecha(){
		if (position.x() < game.width()-2)
			position = position.right(1)
	}
	
	method moverIzquierda(){ 
		if (position.x() > 0)
			position = position.left(1)
	}

	method moverArriba(){ 
		if (position.y() <= game.height()/2)
			position=position.up(1)
	}

	method moverAbajo(){ //mueve mi autito abajo
		if (position.y() > 3)
			position=position.down(1)
	}
	
	method reiniciar(){
		position = self.posicionInicial()
	}

	method esObstaculo() = false
	
}