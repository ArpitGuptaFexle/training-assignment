/**
 *   Description       : Trigger Handler for Contact
 *
 *   Created By        : Arpit Gupta
 *
 *   Created Date      : 12/04/2024
 *
 *   Revision Logs     : V_1.0 - Created - Apex Assignment 3     
 * 
**/
public class ContactTriggerHandler extends TriggerHandler {
    
    /**
    *   @description    :   This method used to for beforeInsert for Check Domain.
    *
    *   @arg            :   
    *
    *   @return         :   Void
    *
    *   @Revision Log   :   V_1.0 - Created - Arpit Gupta - 12/12/2024 
    * 
    **/
	
    public override void beforeInsert() {
        
		ContactTriggerHelper.checkDomainForEmail((List<Contact>)trigger.new);
        ContactTriggerHelper.checkRecordIdObjectAndPickList((List<Contact>)trigger.new, (Map<Id,Contact>)trigger.oldMap);
    }
    
    /**
    *   @description    :   This method used to do beforeUpdate to check RecordIdObject And PickList.
    *
    *   @arg            :   
    *
    *   @return         :   Void
    *
    *   @Revision Log   :   V_1.0 - Created - Arpit Gupta - 01/07/2025 
    * 
    **/
    
    public override void beforeUpdate(){
        ContactTriggerHelper.checkRecordIdObjectAndPickList((List<Contact>)trigger.new, (Map<Id,Contact>)trigger.oldMap);

    }
}