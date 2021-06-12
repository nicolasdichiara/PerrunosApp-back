package Clases

import javax.persistence.Entity
import org.eclipse.xtend.lib.annotations.Accessors
import javax.persistence.Id
import javax.persistence.GeneratedValue
import javax.persistence.GenerationType
import javax.persistence.Column
import javax.persistence.OneToOne
import javax.persistence.FetchType

@Entity
@Accessors
class Reporte {
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	Long idReporte
	
	@OneToOne(fetch=FetchType.EAGER)
	Usuario usuarioReportado
	
	@Column
	String detalle
}