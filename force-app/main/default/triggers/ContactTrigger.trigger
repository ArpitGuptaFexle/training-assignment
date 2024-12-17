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
trigger ContactTrigger on Contact (before insert, after insert, after update,before update, after delete, after undelete ) {
    
    new ContactTriggerHandler().run();

}