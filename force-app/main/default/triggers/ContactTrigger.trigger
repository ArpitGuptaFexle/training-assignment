/**
 *   Description       : Trigger for Contact
 *
 *   Created By        : Arpit Gupta
 *
 *   Created Date      : 12/04/2024
 *
 *   Revision Logs     : V_1.0 - Created - Apex Assignment 3     
 * 
**/

/*
trigger ContactTrigger on Contact (before insert, after insert, after update,before update, after delete, after undelete ) {
    
    new ContactTriggerHandler().run();

}
*/
/*
trigger ContactTrigger on Contact(after Insert, after Update, after Delete, after Undelete){
    if(trigger.isAfter && (trigger.isInsert || trigger.isUpdate || trigger.isUndelete)){
        ContactTriggerHandler.checkCountContact(trigger.new, trigger.oldMap);
        
    }
    if(trigger.isAfter && trigger.isDelete){
        ContactTriggerHandler.checkCountContact(NULL, trigger.oldMap);
    }
}
*/
/*
trigger ContactTrigger on Contact(before Insert){
    if(trigger.isInsert && trigger.isBefore){
        ContactImageHandler.checkImage(trigger.new);
    }
    
}

*/
/*
trigger ContactTrigger on Contact(before Insert){
    if(trigger.isBefore && trigger.isInsert){
        System.debug('@@@@@@@@@@@@@Triigggggger');
        SmartyStreetAPIContactTriggerHandler.verifyContactMailingAdress(trigger.new);
    }
}
*/
trigger ContactTrigger on Contact (after insert) {
    if (Trigger.isAfter && Trigger.isInsert ) {
        SmartyStreetAPIContactTriggerHandler.verifyContactMailingAdress(trigger.new);
    }
}