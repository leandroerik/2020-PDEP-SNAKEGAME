import wollok.game.*
import snakeGame.*
import direcciones.*
import titulosYfondos.*
import serpiente.*
import niveles.*

class ObjetoAleatorio {
	var property image
	var property position
	
	method posicionAleatoria(limite) {
		const x = limite.randomUpTo(game.width()-limite).truncate(0)
		const y = limite.randomUpTo(game.height()-limite).truncate(0)
		const posicionTentativa = game.at(x, y)
		if (self.puedoIrEn(posicionTentativa)) {
			position = posicionTentativa		
		} else {
			self.posicionAleatoria(limite)
		}
	}
	
	method puedoIrEn(posicionTentativa) = posicionTentativa.allElements().isEmpty()
	
}


object fruta inherits ObjetoAleatorio(image = "manzana.png", position = game.at(15,14)) {
	var property vecesComida = 0
	var property limite = 3
	
	
	method choqueConSnake() {
		snakeGame.reproducirSonido("eating-apple.wav")
		vecesComida += 1
		self.posicionAleatoria(1)
		serpiente.agregarParteACuerpo()
		if(vecesComida == limite){
			game.removeVisual(self)
			
			if(snakeGame.nivel().siguiente() != null) {
				hoyo.posicionAleatoria(2)
				game.addVisual(hoyo)
			}else {
				nido.posicionAleatoria(4)
				game.addVisual(nido)
			}
			
		}
		
		pociones.generarEfectos()
	}
	
	method reiniciarConteo() {
		vecesComida = 0
	}
	
	method inicializar(nuevoLimite) {
		self.reiniciarConteo()
		limite = nuevoLimite
		self.posicionAleatoria(1)
		game.addVisual(self)
	}
}

object hoyo inherits ObjetoAleatorio(image = "hoyo.png", position = game.at(27,14)) {
		
	method choqueConSnake() {
		snakeGame.reproducirSonido("level-up.wav")
		serpiente.detenerse()
		game.removeVisual(self)
		snakeGame.jugando(false)
		snakeGame.pasarASiguienteNivel()
	}
}

object nido inherits ObjetoAleatorio(image = "nest.png", position = game.at(15,1)) {
	
	method choqueConSnake() {
		snakeGame.win()
	}
}


object pociones {
	var property volverANormal = 20
	var property aparecioDescrip = false
	var property velocidadPocion = 200
	const conjunto = [pocionRoja,pocionAmarilla,pocionAzul]
	
	method generarEfectos(){
		if(snakeGame.nivel().siguiente() != null){
			conjunto.forEach({ unaPocion => unaPocion.aparecer() })
			conjunto.forEach({ unaPocion => unaPocion.volverANormalidad() })
			
		}	
	}
	
	method desaparecer() {
		conjunto.forEach({ unaPocion => unaPocion.desaparecer() })
	}
	
	method reaunudarJuego() {
		self.aparecioDescrip(true)
		game.removeVisual(descripPotions)
		serpiente.comienzaAMoverse(velocidadPocion)
	}
}


class Pocion inherits ObjetoAleatorio{
	var property aparecerEn = 5
	var property direccionesContrarias = false
	var property velocidad = 200
	
	override method posicionAleatoria(_) {
		const direcciones = [derecha,izquierda,arriba,abajo]
		const posTentativas = []
		
		direcciones.forEach({ unaDireccion => posTentativas.add(self.posicionTentativa(unaDireccion)) })
		position = self.posicionRandom(posTentativas)
	}
	
	method posicionRandom(posiciones) {
		posiciones.filter({ unaPosicion => self.puedoIrEn(unaPosicion) })
		const pos = 0.randomUpTo(posiciones.size()-1).truncate(0)
		return posiciones.get(pos)
	}
	
	method posicionTentativa(unaDireccion) = unaDireccion.siguientePosicion(fruta.position())
	
	
	method aparecer() {
		const iniciar = 0.max(snakeGame.nivel().limiteFruta() - aparecerEn)
		if(iniciar == fruta.vecesComida()){
			self.posicionAleatoria(0)
			game.addVisual(self)
		}
	}
	
	
	method desaparecer() {
		if(game.hasVisual(self)) {
			game.removeVisual(self)
		}
	}
	
	
	method choqueConSnake() {
		pociones.volverANormal(fruta.vecesComida() + 3)
		game.removeVisual(self)
		self.cambiarColorDeSnake()
		serpiente.detenerse()
		serpiente.cambiarEstado(normal)
		if(not pociones.aparecioDescrip()){
			game.addVisual(descripPotions)
			pociones.velocidadPocion(velocidad)
		}else {
			serpiente.comienzaAMoverse(velocidad)
		}
	}
	
	method volverANormalidad() {
		if(fruta.vecesComida() == pociones.volverANormal()){
			serpiente.cambiarEstado(normal)
			serpiente.detenerse()
			serpiente.volverAColorOriginal()
			serpiente.comienzaAMoverse(200)
		}
	}
	
	method cambiarColorDeSnake()
	
}

object pocionRoja inherits Pocion(image = "potion-red.png", position = game.at(14,9), aparecerEn = 4, velocidad = 280, direccionesContrarias = true) {
	
	// DIRECCIONES OPUESTAS
	
	override method cambiarColorDeSnake() {
		serpiente.cambiarColorARojo()
	}
	override method choqueConSnake() {
		super()
		serpiente.cambiarEstado(locura)
	}
}


object pocionAmarilla inherits Pocion(image = "potion-yellow.png", position = game.at(14,8), aparecerEn = 5, velocidad = 100) {
	
	// RAPIDO
	
	override method cambiarColorDeSnake() {
		serpiente.cambiarColorAAmarillo()
	}
}

object pocionAzul inherits Pocion(image = "potion-blue.png", position = game.at(14,7), aparecerEn = 6, velocidad = 330) {
	
	// LENTO
	
	override method cambiarColorDeSnake() {
		serpiente.cambiarColorAAzul()
	}
}



class Muro{
	var property position
	var property image = "muro.png"
	
	method choqueConSnake() {
		if(game.hasVisual(self)){
			snakeGame.lost()
		}
	}
}
