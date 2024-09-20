object knightRider {
	method peso() { return 500 }
	method nivelPeligrosidad() { return 10 }
}

//Bumblebee: pesa 800 kilos y su nivel de peligrosidad es 15 si está transformado en auto o 30 si está como robot.
object bumblebee {
	var estado = auto
	method peso() { return 800 }
	method nivelDePeligrosidad() { return self.nivelDePeligrosidadSegunElEstado() }
	method estado() { return estado }
	method nivelDePeligrosidadSegunElEstado() { return self.estado().nivelDePeligrosidad() }
}

object auto {
	method nivelDePeligrosidad() { return 15 }
}

object robot {
	method nivelDePeligrosidad() { return 30 }
}

// cada ladrillo pesa 2 kilos, la cantidad de ladrillos que tiene puede variar. La peligrosidad es 2.
object paqueteDeLadrillos {
	var cantLadrillos = 0
	method peso() {	return 2 * cantLadrillos }
	method cantLadrillos(_cantLadrillos) {
		cantLadrillos = _cantLadrillos
	}
	method nivelDePeligrosidad() { return 2 }
}

// Arena a granel: el peso es variable, la peligrosidad es 1.
object arenaAGranel {
	var property peso = 0
	method nivelDePeligrosidad() { return 1 } 
}

/*el peso es 300 kilos si está con los misiles o 200 en otro caso. En cuanto a la peligrosidad es 100 si está
 con los misiles y 0 en otro caso. */
object bateriaAntiAerea {
	var tieneMisiles = false
	method tieneMisiles(_tieneMisiles) {
		tieneMisiles = _tieneMisiles
	}
	method peso() { return if (tieneMisiles) 300 else 200 }
}