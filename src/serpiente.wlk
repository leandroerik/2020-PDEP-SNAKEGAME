import wollok.game.*
import objetos.*
import snakeGame.*
import direcciones.*
import niveles.*

class CuerpoSnake {
	var property anterior
	var property siguiente
	var property image
	var property position
	var property posicionPrevia
	
	method desplazarseA(nuevaPosicion) {
		posicionPrevia = position
		position = nuevaPosicion
		if(siguiente != null){
			siguiente.moverseA(posicionPrevia)
		}
	}
	
	method moverseA(nuevaPosicion) {
		self.desplazarseA(nuevaPosicion)
		self.cambiarImagen(anterior.image())
	}
	
	method cambiarImagen(unaImagen) { image= unaImagen }
	
	method choqueConSnake() {
		snakeGame.lost()
	}
	
}

object cabezaSnake inherits CuerpoSnake(anterior = null, siguiente = primeraParte, image = "cabeza-derecha.png", position = game.at(4,2), posicionPrevia = game.at(3,2)) {
	
	override method moverseA(nuevaPosicion) {
		self.desplazarseA(nuevaPosicion)
		serpiente.direccion().cabezaSegunDirecc()
	}
}

object primeraParte inherits CuerpoSnake(anterior = cabezaSnake, siguiente = null, image = "cuerpo-horizontal.png", position = game.at(3,2), posicionPrevia = game.at(2,2)) {
	override method moverseA(nuevaPosicion) {
		self.desplazarseA(nuevaPosicion)
		serpiente.direccion().cuerpoSegunDirecc(self)
	}
}
object locura{
	
	method direccion(unaDireccion) = unaDireccion.contraria()
}
object normal{
	
	method direccion(unaDireccion) = unaDireccion
	
}

object serpiente {
	const cuerpo = [cabezaSnake, primeraParte]
	var direccion = derecha
	var miVelocidad 
	
	var property estado = normal //puede ser normal o locura
	
	method cuerpo() = cuerpo
	method direccion() = direccion
	

	method cambiarEstado(nuevoEstado) { estado = nuevoEstado }
	
	method direccionElegida(unaDireccion) { direccion = estado.direccion(unaDireccion) }
	
	method nuevaPosicionAAvanzar() = direccion.siguientePosicion(cabezaSnake.position())
	
	method agregarParteACuerpo() {
		const parte = new CuerpoSnake(anterior = cuerpo.last(), siguiente = null, image = cuerpo.last().image(), position = cuerpo.last().posicionPrevia(), posicionPrevia = null)
		cuerpo.last().siguiente(parte)
		cuerpo.add(parte)
		game.addVisual(parte)
	}
	
	method comienzaAMoverse(velocidad) {
		miVelocidad = velocidad
		game.onTick(velocidad, "movimientoSnake", { cabezaSnake.moverseA(self.nuevaPosicionAAvanzar()) })
		
	}
	
	method detenerse() { game.removeTickEvent("movimientoSnake") }
	
	method desaparecer() { cuerpo.forEach( {unaParte => game.removeVisual(unaParte)} ) }
	
	method aparecer() { cuerpo.forEach( {unaParte => game.addVisual(unaParte)} ) }
	
	method reiniciar() {
		self.desaparecer()
		self.cambiarEstado(normal)
		
		cuerpo.forEach( {unaParte => 
			if(cuerpo.size() > 2){
				cuerpo.remove(cuerpo.last())
				cuerpo.last().siguiente(null)
			}
		})
		
		self.volverAColorOriginal()
		
		direccion = derecha
		
		cabezaSnake.position(game.at(4,2))
		cabezaSnake.posicionPrevia(game.at(3,2))
		cabezaSnake.image("cabeza-derecha.png")
		
		primeraParte.anterior(cabezaSnake)
		primeraParte.position(game.at(3,2))
		primeraParte.posicionPrevia(game.at(2,2))
		primeraParte.image("cuerpo-horizontal.png")
		
		self.aparecer()
	}
	
	
	// CAMBIO DE COLORES
	method volverAColorOriginal() {
		arriba.volverAColorOriginal()
		abajo.volverAColorOriginal()
		izquierda.volverAColorOriginal()
		derecha.volverAColorOriginal()
	}
	
	method cambiarColorARojo() {
		arriba.cambiarColorARojo()
		abajo.cambiarColorARojo()
		izquierda.cambiarColorARojo()
		derecha.cambiarColorARojo()
	}
	
	method cambiarColorAAzul() {
		arriba.cambiarColorAAzul()
		abajo.cambiarColorAAzul()
		izquierda.cambiarColorAAzul()
		derecha.cambiarColorAAzul()
	}
	
	 method cambiarColorAAmarillo() {
		arriba.cambiarColorAAmarillo()
		abajo.cambiarColorAAmarillo()
		izquierda.cambiarColorAAmarillo()
		derecha.cambiarColorAAmarillo()
	}
}
