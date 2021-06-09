package App

import org.uqbar.xtrest.api.XTRest

class PerrunosApplicationService {				// clase ejecutable
	def static void main(String[] args) {		// metodo main que levantar el servicio 
		PerrunosBootstrap.crearDatosSiNoHay 	// crea el bootstrap si no hay datos
		//XTRest.start(16000, PerrunosRestAPI)		// levanta la rest api, el servico web con puerto 8082 , la clase que estas levantando 
		XTRest.start(Integer.parseInt(System.getenv("PORT")),PerrunosRestAPI) //TODO cuando compiles para subir a heroku descomenta esta linea y comenta la de arriba
	}
}