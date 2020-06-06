package EntityManager

import javax.persistence.EntityManagerFactory
import javax.persistence.Persistence

class EntityManager {
	static final EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("Aerolinea")
	static EntityManager instance = null

	private new() {
	}

	static def getInstance() {
		if (instance === null) {
			instance = new EntityManager
		}
		instance
	}

	def getEntityManager() {
		entityManagerFactory.createEntityManager
	}

}
