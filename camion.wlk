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

/* Puede circular si no está excedido de peso, y además, ninguno de los objetos cargados supera el nivel máximo de
 peligrosidad indicado.*/
	method puedeCircularEnRuta(nivelMaximoPeligrosidad) {
		return not self.excedidoDePeso() && self.esSeguro(nivelMaximoPeligrosidad)
	}

	method esSeguro(nivel) {
		return self.objetosQueSuperanPeligrosidad(nivel).isEmpty() 
	}

	////AGREGADOS////
/* indica si el peso de alguna de las cosas que tiene el camión está en ese intervalo*/
	method tieneAlgoQuePesaEntre(min, max) {
		return cosas.any({ cosa => min < cosa.peso() && max > cosa.peso() })
	}

/* la cosa más pesada que tenga el camión. Ojo que lo que se pide es _la cosa_ y no su peso. */
	method cosaMasPesada() {
		return cosas.max({ cosa => cosa.peso() })
	}

/* devuelve una lista con _los pesos_ de cada cosa que tiene el camión. */
	method pesos() {
		return cosas.map({ cosa => cosa.peso() })
	}

/* la suma de la cantidad de bultos que está transportando. KnightRider, arena a granel y residuos
radioactivos son 1 bulto. Bumblebee y embalaje de seguridad son dos. Paquete de ladrillos es 1 hasta 100 ladrillos,
2 de 101 a 300, 3 301 o más. Batería antiaérea: 1 si no tiene misiles, 2 si tiene. Contenedor portuario: 1 + los bultos
que tiene adentro.*/
	method totalBultos() {
		return cosas.sum({cosa => cosa.bultosQueRepresenta() })
	}

////TRANSPORTE////
	method transportar(destino, camino){ 
	  	self.valirdarTransportar(destino, camino)
	  	destino.almacenar(cosas)
	}

	method valirdarTransportar(destino, camino){
	  	if ( not self.excedidoDePeso() || not self.puedePasarPor(camino)  || not self.sePuedeAlmacenarEn(destino) ) {
			self.error("No se puede hacer el transporte. El camion se excede de peso o, el camion no puede pasar por el camino " + camino +  " o, no se puede dejar la carga en " + destino)
	   	}
	}

	method puedePasarPor(camino) {
		return camino.dejaCircular(self)
	}

	method sePuedeAlmacenarEn(destino) {
	  	return destino.sePuedeAlmacenar(cosas)
	}

}
//almacen y viaje
object almacen {
  	const property cosasAlmacenadas = []
  	var property cantidadDeBultosDisponible = 3 
  	method almacenar(cosas) {
		self.validarAlmacenar(cosas) 
		cosasAlmacenadas.addAll(cosas)
		cantidadDeBultosDisponible = cantidadDeBultosDisponible - self.bultosOcupaCosas(cosas)
  	}
  	method validarAlmacenar(cosas){
		return 
			if (not self.sePuedeAlmacenar(cosas)){
				self.error("no hay suficiente espacio para almacenar" + cosas)
			}
	}
 	method sePuedeAlmacenar(cosas) {
		return cantidadDeBultosDisponible >= self.bultosOcupaCosas(cosas)
  	}

  	method bultosOcupaCosas(cosas) {
		return cosas.sum({ cosa => cosa.bultos() })
  	}
}

object ruta9 {
  	method nivelPeligrosidad() { return 11 }
  	method pesoMaximoSoportable() { return 2500 }
  	method dejaCircular(transporte) {
		return transporte.puedeCircularEnRuta(self.nivelPeligrosidad())
  	}
}

object caminosVecinales {
	var property pesoMaximoSoportable = 2500
  	method nivelPeligrosidad() { return 11 } 
 	method dejaCircular(transporte) {
		return transporte.pesoTotal() <= pesoMaximoSoportable
  	}
}
