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
	
    public override void beforeInsert() {
        
		ContactTriggerHelper.checkDomainForEmail((List<Contact>)trigger.new);    
    }
}