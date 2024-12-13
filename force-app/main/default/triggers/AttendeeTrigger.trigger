/**
 *   Description       : Attendee Trigger
 *
 *   Created By        : Arpit Gupta
 *
 *   Created Date      : 11/29/2024
 *
 *   Revision Logs     : V_1.0 - Created - Apex Assignment 2     
 * 
**/
trigger AttendeeTrigger on Attendee__c (before insert, before update, before delete, after insert, after update, after delete,after undelete) {
    
    new AttendeeTriggerHandler().run();
    /*if(Trigger.isBefore){
        

        }
    if(Trigger.isAfter){
        if(Trigger.isInsert || Trigger.isUpdate || Trigger.isDelete){
            AttendeeTriggerHandler.handleAttendeeUpdate(Trigger.new, Trigger.oldMap);
        }
        
    }*/
    
}