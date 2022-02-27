import wollok.game.*
import snakeGame.*
import objetos.*
import direcciones.*
import niveles.*
import serpiente.*


// TITULOS
object start {
	method position() = game.at(0,0)
	method image() = "start.png"
}

object level1 {
	method position() = game.at(0,0)
	method image() = "level-1.png"
}

object level2 {
	method position() = game.at(0,0)
	method image() = "level-2.png"
}

object level3 {
	method position() = game.at(0,0)
	method image() = "level-3.png"
}

object youLost {
	method position() = game.at(0,0)
	method image() = "you-lost.png"
}

object youWon {
	method position() = game.at(0,0)
	method image() = "you-won.png"
}

object descripPotions {
	method position() = game.at(0,0)
	method image() = "potionsDescrip.png"
}


// FONDOS
object underground {
	method position() = game.at(0,0)
	method image() = "tierra.png"
}
