import wollok.game.*
import objetos.*
import direcciones.*
import titulosYfondos.*
import niveles.*
import serpiente.*

object snakeGame {
	var property nivel = nivel1
	var property jugando = false
	var property perdio = false
	
	method iniciar() {
		self.configurarJuego()
		self.agregarPersonajes()
		self.configurarTeclas()
		self.configurarAcciones()
		game.start()
	}
	
	method configurarJuego() {
		game.title("Snake Game")
		game.width(32)
		game.height(18)
		game.cellSize(35)
	}
	
	method agregarPersonajes() {
		
		serpiente.aparecer()
		nivel.iniciar()
	}
	
	method configurarTeclas() {
		
		// TECLAS DE DIRECCION
		keyboard.up().onPressDo({

				serpiente.direccionElegida(arriba)
			
		})
		keyboard.down().onPressDo({
	
				serpiente.direccionElegida(abajo)
			
		})
		keyboard.left().onPressDo({
			
				serpiente.direccionElegida(izquierda)
			
		})
		keyboard.right().onPressDo({
			
				serpiente.direccionElegida(derecha)
			
		})
		
		
		// TECLAS SPACE, ENTER, X Y Q
		keyboard.space().onPressDo({ pociones.reaunudarJuego() })
		keyboard.enter().onPressDo({ 
			if(not jugando and not perdio)
				nivel.empezarAJugar()
		})
		keyboard.x().onPressDo({ 
			if(not jugando and perdio){
				nivel.reiniciarNivel()
			}
		})
		keyboard.q().onPressDo({
			if(not jugando)
				game.schedule(100, {game.stop()})
		})
	}
	
	method configurarAcciones() {
		game.onCollideDo(cabezaSnake, {visualColisionado => visualColisionado.choqueConSnake()})
	}
	
	method reproducirSonido(unSonido) {
		const sonido = game.sound(unSonido)
		sonido.play()
	}
	
	method pasarASiguienteNivel() {
		serpiente.volverAColorOriginal()
		pociones.desaparecer()
		nivel = nivel.siguiente()
		if(nivel != null){
			nivel.iniciar()
		}
	}
	
	method nivel() = nivel
	
	method lost() {
		serpiente.detenerse()
		self.reproducirSonido("lose.wav")
		jugando = false
		perdio = true
		game.addVisual(youLost)
	}
	
	method win() {
		serpiente.detenerse()
		self.reproducirSonido("win.wav")
		game.addVisual(youWon)
		self.over()
	}
	
	method over() {
		game.schedule(3000, {game.stop()})
	}
}
