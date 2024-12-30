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
trigger TriggerContact on Contact (before insert, after insert,after update, after delete, after undelete ) {
    if(Trigger.isInsert){
        
        if(Trigger.isBefore){
            
            ContacTriggerHandler.validateContactEmails(Trigger.new);
        }
    }
    
    
    else if(Trigger.isAfter){
        
        
    }
    
}