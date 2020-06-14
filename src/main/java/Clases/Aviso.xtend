package Clases

import org.eclipse.xtend.lib.annotations.Accessors
import java.time.LocalDate
import java.time.LocalTime

@Accessors
class Aviso {
	
	Long idAviso
	
	Boolean recurrente
	Boolean lunes
	Boolean martes
	Boolean miercoles
	Boolean jueves
	Boolean viernes
	Boolean sabado
	Boolean domingo
	
	Boolean fechaParticular
	LocalDate fecha
	
	LocalTime horario
	
	String detalle
	
	Boolean activo
	
	TipoServicio tipoServicio
	
}