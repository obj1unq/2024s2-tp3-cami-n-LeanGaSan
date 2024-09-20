import cosas.*

object camion {
	const property cosas = []
	const tara = 1000		
	method cargar(cosa) {
		cosas.add(cosa)
	}

	method descargar(cosa) {
		cosas.remove(cosa)
	}

	//si el peso de cada uno de los objetos cargados es un número par.
	method todoPesoPar() {
		return cosas.all({ cosa => cosa.peso().even()}) // Está bien, pero tendría que hacer un mensaje para cada objeto que me diga si su peso es par. 
	}
// indica si hay alguno de los objetos cargados que tiene exactamente el peso indicado.

	method hayAlgunoQuePesa(peso) {
		return cosas.any({ cosa => cosa.peso() == peso })
	}
/* devuelve el primer objeto cargado que encuentre, cuyo nivel de peligrosidad coincida exactamente con 
el valor indicado. */
	method elDeNivel(nivel) {
		return cosas.max({ cosa => cosa.nivelDePeligrosidad() == nivel})
	}

//es la suma del peso del camión vacío (tara) y su carga. La tara del camión es de 1000 kilos.	
	method pesoTotal() {
		return tara + self.pesoTotalDeLaCarga()
	}

	method pesoTotalDeLaCarga() {
		return cosas.sum({ cosa => cosa.peso()})
	}

//excedidoDePeso(): indica si el peso total es superior al peso máximo, que es de 2500 kilos.
	method excedidoDePeso() {
		return self.pesoTotal() > 2500
	}

//devuelve una colección con los objetos cargados que superan el nivel de peligrosidad indicado.
	method objetosQueSuperanPeligrosidad(nivel) {
		return cosas.filter({ cosa => cosa.peso() > nivel})
	}

//devuelve una colección con los objetos cargados que son más peligrosos que la cosa indicada.
	method objetosMasPeligrososQue(cosa) {
		return cosas.filter({ cosaDelCamion => cosaDelCamion.nivelPeligrosidad() > cosa.nivelPeligrosidad()})
	}

//Puede circular si no está excedido de peso, y además, ninguno de los objetos cargados supera el nivel máximo de peligrosidad indicado.
	method puedeCircularEnRuta(nivelMaximoPeligrosidad) {
		return not self.excedidoDePeso() && self.esSeguro(nivelMaximoPeligrosidad)
	}

	method esSeguro(nivel) {
		return self.objetosQueSuperanPeligrosidad(nivel).isEmpty() 
	}

	////AGREGADOS////
/* indica si el peso de alguna de las cosas que tiene el camión está en ese intervalo*/
	method tieneAlgoQuePesaEntre(min, max) {
		return 
	}
}
