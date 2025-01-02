/**
 *   Description       : This is for Batchable Apex Assignment (LeadProcessor)
 *
 *   Created By        : Arpit Gupta
 *
 *   Created Date      : 12/18/2024
 *
 *   Revision Logs     : V_1.0 - Created - Apex Ass4
 * 
**/
global class LeadProcessor implements
	Database.Batchable<sObject>,Database.Stateful{
    
    global Integer recordsProcessed=0;
    
    global Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('SELECT Id, LeadSource FROM Lead');
    }
    
    global void execute(Database.BatchableContext bc ,List<Lead> scope){
        
        List<Lead> leads=new List<Lead>();
        for(Lead ls: scope){
            ls.LeadSource='Dreamforce';
            //leads.add(ls);
            recordsProcessed=recordsProcessed+1;
        }
        update scope;
        
    }
    
    global void finish(Database.BatchableContext bc){
        System.debug('Total Records:'+recordsProcessed);
    }
        
    /*global void execute(SchedulableContext sc) {

        LeadProcessor lp = new LeadProcessor();
        Database.executeBatch(lp, 200);
        String cronExpression = '0 0 2 * * ?'; 
        String jobName = 'LeadProcessorBatchJob';
        LeadProcessor scheduler = new LeadProcessor();
        System.schedule(jobName, cronExpression, scheduler);
    }*/
}


/*
 * 	LeadProcessor myBatchObject = new LeadProcessor();
   	Database.executeBatch(myBatchObject);

*/