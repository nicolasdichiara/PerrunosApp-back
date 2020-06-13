package App

import org.uqbar.xtrest.api.XTRest

class PerrunosApplicationService {
	def static void main(String[] args) {
		PerrunosBootstrap.crearDatosSiNoHay 
		XTRest.start(8082, PerrunosRestAPI)
	}
}