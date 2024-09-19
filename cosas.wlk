object knightRider {
	method peso() { return 500 }
	method nivelPeligrosidad() { return 10 }
}

//Bumblebee: pesa 800 kilos y su nivel de peligrosidad es 15 si está transformado en auto o 30 si está como robot.
object bumblebee {
	var estado = auto
	method peso() { return 800 }
	method nivelDePeligrosidad() { return self.estado().nivelDePeligrosidad() }
	method estado() { return estado }
}

object auto {
	method nivelDePeligrosidad() { return 15 }
}

object robot {
	method nivelDePeligrosidad() { return 30 }
}

//
object name {
  
}
