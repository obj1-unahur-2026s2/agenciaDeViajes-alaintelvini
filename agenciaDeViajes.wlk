class Packs{
    var duracionEnDias=0
    var precioBase=0
    const beneficios=[]
    var coordinador1

    method duracion(){
        return duracionEnDias
    }

    method cambiarDuracion(nuevaDuracion){
        duracionEnDias=nuevaDuracion
    }

    method precio(){
        return precioBase
    }

    method cambiarPrecio(nuevoPrecio){
        precioBase=nuevoPrecio
    }

    method agregarBeneficios(unBeneficio){
        beneficios.add(unBeneficio)
    }

    method coordinador(){
        return coordinador1
    }

    method listaDeBeneficios(){
        return beneficios
    }

    method cambiarDeCoordinador(nuevoCoordinador){
        coordinador1=nuevoCoordinador
    }

    method valorFinal(){
        return self.precio()+beneficios.filter({b=>b.estaVigente()}).sum({b=>b.costo()})
    }

    method esPackPremium(){

    }
}

class PacksNacionales inherits Packs{
    var provincia=""
    const listDeActividades=[]

    method provinciaDestino(){
        return provincia
    }

    method cambiarProvinvia(nuevaProvincia){
        provincia=nuevaProvincia
    }

    method agregarActividad(nuevaActividad){
        listDeActividades.add(nuevaActividad)
    }

    method listaDeActividades(){
        return listDeActividades
    }

    override method esPackPremium(){
        return duracionEnDias>10 and coordinador1.altamenteCalificado(self)
    }
}

class PacksInternacionales inherits Packs{
    var paisDestino=""
    var cantDeEscalas=0
    var esLugarInteres=true

    method paisDeDestino(){
        return paisDestino
    }

    method cambiarPais(nuevoPais){
        paisDestino=nuevoPais
    }

    method cantidadDeEscalas(){
        return cantDeEscalas
    }

    method cambiarEscalas(nuevaCantidad){
        cantDeEscalas=nuevaCantidad
    }

    method esLugarDeInteres(){
        return esLugarInteres
    }

    method siEsLugarDeInteres(){
        esLugarInteres=true
    }

    method noEsLugarDeInteres(){
        esLugarInteres=false
    }

    override method valorFinal(){
        return super()*1.20
    }

    override method esPackPremium(){
        return esLugarInteres and self.duracion()>20 and self.cantidadDeEscalas()==0
    }
}

class Coordinadores{
    var cantDeViajesRealizados=0
    var estaMotivado1=true
    var aniosExperiencia=0
    var rol1

    method cantidadDeViajesRealizados(){
        return cantDeViajesRealizados
    }

    method cambiarCantDeViajes(nuevaCant){
        cantDeViajesRealizados=nuevaCant
    }

    method estaMotivado(){
        return estaMotivado1
    }

    method noEstaMotivado(){
        estaMotivado1=false
    }

    method siEstaMotivado(){
        estaMotivado1=true
    }

    method aniosDeExperiencia(){
        return aniosExperiencia
    }

    method cambiarAniosDeExperiencia(nuevaCant){
        aniosExperiencia=nuevaCant
    }

    method rol(){
        return rol1
    }

    method cambiarDeRol(nuevoRol){
        if(nuevoRol!=guia and nuevoRol!=asistenteLogistico and nuevoRol!=acompaniante){
            self.error("no hay otro rol disponible")
        } else{
            rol1=nuevoRol
        }
    }

    method altamenteCalificado(){
      return  self.cantidadDeViajesRealizados()>20 and rol1.cumpleRequisito(self)
    }
}

object guia{

    method cumpleRequisito(coordinador){
        return coordinador.estaMotivado()
    }

}
object asistenteLogistico{

    method cumpleRequisito(coordinador){
        return coordinador.aniosDeExperiencia()>=3
    }
}
object acompaniante{
    method cumpleRequisito(coordinador){
        return true
    }
}

class BeneficiosEspeciales{
    var tipoBeneficio=""
    var costo1=0
    var estaVigente1=true

    method tipoDeBeneficio(){
        return tipoBeneficio
    }

    method cambiarBeneficio(nuevoBeneficio){
        tipoBeneficio=nuevoBeneficio
    }

    method costo(){
        return costo1
    }

    method cambiarCosto(nuevoCosto){
        costo1=nuevoCosto
    }

    method estaVigente(){
        return estaVigente1
    }

    method noEstaVigente(){
        estaVigente1=false
    }

    method siEstaVigente(){
        estaVigente1=true
    }
}

class PacksProvinciales inherits PacksNacionales{
    var cantCiudadesAViajar=0

    method cantidadDeCiudadesAViajar(){
        return cantCiudadesAViajar
    }

    method cambiarCantDeCiudadesAViajar(nuevaCant){
        cantCiudadesAViajar=nuevaCant
    }

    override method esPackPremium(){
        return listDeActividades.size()>=4 and
        cantCiudadesAViajar>5 and
        beneficios.filter({b=>b.estaVigente()}).size()>=3
    }

    override method valorFinal(){
        if(self.esPackPremium()){
            return 1.05 * super()
        } else{
            return super()
        }



  } 
}