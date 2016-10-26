
Existing fields
*encounter_id	int(11)	NO	PRI		auto_increment
encounter_type	int(11)	NO	MUL		
patient_id	int(11)	NO	MUL	0	
location_id	int(11)	YES	MUL		
form_id	int(11)	YES	MUL		
encounter_datetime	datetime	NO	MUL		
creator	int(11)	NO	MUL	0	
date_created	datetime	NO			
voided	tinyint(1)	NO		0	
voided_by	int(11)	YES	MUL		
date_voided	datetime	YES			
void_reason	varchar(255)	YES			
changed_by	int(11)	YES	MUL		
date_changed	datetime	YES			
visit_id	int(11)	YES	MUL		
uuid	char(38)	NO	UNI		


Fields in omrs_encounter
uuid	            char(38)	NO	PRI	
patient_uuid        char(38)
encounter_type      varchar(50)
location            varchar(50)
datetime            datetime
age at encounter



	