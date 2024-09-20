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

/* el peso es 300 kilos si está con los misiles o 200 en otro caso. En cuanto a la peligrosidad es 100 si está
 con los misiles y 0 en otro caso. */
object bateriaAntiAerea {
	var tieneMisiles = false
	method tieneMisiles(_tieneMisiles) {
		tieneMisiles = _tieneMisiles
	}
	method peso() { return if (tieneMisiles) 300 else 200 }
	method nivelDePeligrosidad() { return if (tieneMisiles) 100 else 0 }
}

/* un contenedor puede tener otras cosas adentro. El peso es 100 + la suma de todas las cosas que estén adentro.
 Es tan peligroso como el objeto más peligroso que contiene. Si está vacío, su peligrosidad es 0.*/
object contenedorPortuario{
	const cosasQueContiene = []
	method cargar(cosa) {
		cosasQueContiene.add(cosa)
	}
	method peso() { return 100 + self.pesoDelContenido() }
	method pesoDelContenido() {
		return cosasQueContiene.sum({ cosa => cosa.peso() })
	}
	method nivelDePeligrosidad() { return self.nivelDePeligrosidadDelContenidoMasPeligroso() }
	method noContieneNada() { return cosasQueContiene.isEmpty() }
	method nivelDePeligrosidadDelContenidoMasPeligroso() {
		return if (self.noContieneNada()) 0 else self.cosaMasPeligrosaQueContiene().nivelDePeligrosidad()
	}
	method cosaMasPeligrosaQueContiene() {
		return cosas.maxIfEmpty({cosa => cosa.nivelDePeligrosidad()} , null )
	}
}
/* Residuos radioactivos: el peso es variable y su peligrosidad es 200.*/
object residuosRadioactivos {
	var property peso = 0
	method nivelDePeligrosidad() { return 200 } 
}

/* es una cobertura que envuelve a cualquier otra cosa. El peso es el peso de la cosa que tenga adentro. 
El nivel de peligrosidad es la mitad del nivel de peligrosidad de lo que envuelve.*/
object embalajeDeSeguridad {
	method peso() { return 0 }
	method nivelDePeligrosidad() { return 0 }
}