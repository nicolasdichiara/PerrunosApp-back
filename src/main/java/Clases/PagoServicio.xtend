package Clases

import org.eclipse.xtend.lib.annotations.Accessors
import javax.persistence.Entity
import javax.persistence.Id
import javax.persistence.GeneratedValue
import javax.persistence.GenerationType
import javax.persistence.Column

@Entity
@Accessors
class PagoServicio {
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	Long idPago
	@Column
	String collectionId
	@Column
	String collectionStatus
	@Column
	String paymentId
	@Column
	String status
	@Column
	String externalReference
	@Column
	String paymentType
	@Column
	String merchantOrderId
	@Column
	String preferenceId
	@Column
	String siteId
	@Column
	String processingMode
	@Column
	String merchantAccountId
}

/*
 
ESTO VIENE DE MP
 
array (size=11)
'collection_id' => string '1230930108' (length=10)
'collection_status' => string 'approved' (length=8)
'payment_id' => string '1230930108' (length=10)
'status' => string 'approved' (length=8)
'external_reference' => string 'null' (length=4)
'payment_type' => string 'credit_card' (length=11)
'merchant_order_id' => string '1947145298' (length=10)
'preference_id' => string '665481827-fc56efdf-353b-4a7f-a3e5-60c7756cb33f' (length=46)
'site_id' => string 'MLA' (length=3)
'processing_mode' => string 'aggregator' (length=10)
'merchant_account_id' => string 'null' (length=4)

*/