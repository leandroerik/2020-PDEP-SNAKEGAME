import objetos.*
import serpiente.*

class Direccion {
	var property imagenCabeza
	var property imagenCuerpo
	
	method cabezaSegunDirecc() { cabezaSnake.cambiarImagen(imagenCabeza) }
	method cuerpoSegunDirecc(unaParte) { unaParte.cambiarImagen(imagenCuerpo) }
}



object arriba inherits Direccion(imagenCabeza = "cabeza-arriba.png", imagenCuerpo = "cuerpo-vertical.png") {
	method siguientePosicion(unaPosicion) = unaPosicion.up(1)
	method contraria() = abajo
	
	method cambiarColorARojo() {
		imagenCabeza = "cabezaRoja-arriba.png"
		imagenCuerpo = "cuerpoRojo-vertical.png"
	}
	
	method cambiarColorAAzul() {
		imagenCabeza = "cabezaAzul-arriba.png"
		imagenCuerpo = "cuerpoAzul-vertical.png"
	}
	
	method cambiarColorAAmarillo() {
		imagenCabeza = "cabezaAmarilla-arriba.png"
		imagenCuerpo = "cuerpoAmarillo-vertical.png"
	}
	
	method volverAColorOriginal() {
		imagenCabeza = "cabeza-arriba.png"
		imagenCuerpo = "cuerpo-vertical.png"
	}
}

object abajo inherits Direccion(imagenCabeza = "cabeza-abajo.png", imagenCuerpo = "cuerpo-vertical.png") {
	method siguientePosicion(unaPosicion) = unaPosicion.down(1)
	method contraria() = arriba
	
	method cambiarColorARojo() {
		imagenCabeza = "cabezaRoja-abajo.png"
		imagenCuerpo = "cuerpoRojo-vertical.png"
	}
	
	method cambiarColorAAzul() {
		imagenCabeza = "cabezaAzul-abajo.png"
		imagenCuerpo = "cuerpoAzul-vertical.png"
	}
	
	method cambiarColorAAmarillo() {
		imagenCabeza = "cabezaAmarilla-abajo.png"
		imagenCuerpo = "cuerpoAmarillo-vertical.png"
	}
	
	method volverAColorOriginal() {
		imagenCabeza = "cabeza-abajo.png"
		imagenCuerpo = "cuerpo-vertical.png"
	}
}

object izquierda inherits Direccion(imagenCabeza = "cabeza-izquierda.png", imagenCuerpo = "cuerpo-horizontal.png") {
	method siguientePosicion(unaPosicion) = unaPosicion.left(1)
	method contraria() = derecha
	
	method cambiarColorARojo() {
		imagenCabeza = "cabezaRoja-izquierda.png"
		imagenCuerpo = "cuerpoRojo-horizontal.png"
	}
	
	method cambiarColorAAzul() {
		imagenCabeza = "cabezaAzul-izquierda.png"
		imagenCuerpo = "cuerpoAzul-horizontal.png"
	}
	
	method cambiarColorAAmarillo() {
		imagenCabeza = "cabezaAmarilla-izquierda.png"
		imagenCuerpo = "cuerpoAmarillo-horizontal.png"
	}
	
	method volverAColorOriginal() {
		imagenCabeza = "cabeza-izquierda.png"
		imagenCuerpo = "cuerpo-horizontal.png"
	}
}

object derecha inherits Direccion(imagenCabeza = "cabeza-derecha.png", imagenCuerpo = "cuerpo-horizontal.png") {
	method siguientePosicion(unaPosicion) = unaPosicion.right(1)
	method contraria() = izquierda
	
	method cambiarColorARojo() {
		imagenCabeza = "cabezaRoja-derecha.png"
		imagenCuerpo = "cuerpoRojo-horizontal.png"
	}
	
	method cambiarColorAAzul() {
		imagenCabeza = "cabezaAzul-derecha.png"
		imagenCuerpo = "cuerpoAzul-horizontal.png"
	}
	
	method cambiarColorAAmarillo() {
		imagenCabeza = "cabezaAmarilla-derecha.png"
		imagenCuerpo = "cuerpoAmarillo-horizontal.png"
	}
	
	method volverAColorOriginal() {
		imagenCabeza = "cabeza-derecha.png"
		imagenCuerpo = "cuerpo-horizontal.png"
	}
}