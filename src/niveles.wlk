import wollok.game.*
import snakeGame.*
import serpiente.*
import objetos.*
import titulosYfondos.*


class Nivel {
	const property siguiente
	const property titulo
	var property murosInternos = false
	const property limiteFruta
	const property imagenMuro = "muro.png"
	const posMurosInternos = []
	
	
	
	
	const ancho = 32 //game.width()
    const alto = 18 //game.height()
    
	const posCasillasLaterales = []
	const posCasillasCentrales = []
	
	method generarBordes() {
		(0 .. ancho-1).forEach({ i => posCasillasCentrales.add(new Position(x=i, y=0)) }) // borde abajo
		(0 .. ancho-1).forEach({ i => posCasillasCentrales.add(new Position(x=i, y=alto-1)) }) // borde arriba
		
		(1 .. alto-2).forEach({ i => posCasillasLaterales.add(new Position(x=0, y=i)) }) // borde izquierdo
		(1 .. alto-2).forEach({ i => posCasillasLaterales.add(new Position(x=ancho-1, y=i)) }) // borde derecho
	}
	
	method dibujar(posiciones){
		posiciones.forEach({ unaPosicion => 
			const casilla = new Muro(position = unaPosicion, image = imagenMuro)
			game.addVisual(casilla)
		})
	}
	
	method agregarMurosInternos(unBool) {
		if(unBool){
			(5 .. ancho-5).forEach({ i => posMurosInternos.add(new Position(x=i, y=3)) })
			(5 .. ancho-5).forEach({ i => posMurosInternos.add(new Position(x=i, y=alto-5)) })
			self.dibujar(posMurosInternos)
		}
		
	}
	
	method dibujarBordes() {
		self.generarBordes()
		self.dibujar(posCasillasLaterales)
		self.dibujar(posCasillasCentrales)
	}
		
	
	method iniciar() {
		serpiente.reiniciar()
		self.dibujarBordes()
		self.agregarMurosInternos(murosInternos)
		fruta.inicializar(limiteFruta)
		game.addVisual(titulo)
	}
	
	method empezarAJugar() {
		game.removeVisual(titulo)
		serpiente.comienzaAMoverse(200)
		snakeGame.jugando(true)
	}
	
	method reiniciarNivel() {
		game.removeVisual(youLost)
		pociones.desaparecer()
		serpiente.reiniciar()
		serpiente.comienzaAMoverse(200)
		snakeGame.jugando(true)
		snakeGame.perdio(false)
		if(not game.hasVisual(hoyo)){
			fruta.reiniciarConteo()
		}
	}
}


object nivel1 inherits Nivel(siguiente = nivel2, titulo = start, limiteFruta = 10) {
	
} 


object nivel2 inherits Nivel(siguiente = nivel3, titulo = level1, limiteFruta = 7, murosInternos = true) {
	
}

object nivel3 inherits Nivel(siguiente = null, titulo = level2, limiteFruta = 3, imagenMuro = "rocas.png", murosInternos = true) {
	override method iniciar() {
		game.addVisual(underground)
		super()
	}
}


