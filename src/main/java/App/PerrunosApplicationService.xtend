package App

import org.uqbar.xtrest.api.XTRest

class PerrunosApplicationService {
	def static void main(String[] args) {
		PerrunosBootstrap.crearDatos 
		XTRest.start(8081, PerrunosRestAPI)
	}
}