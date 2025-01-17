global class AccountSupportScoreBatch implements Database.Batchable<sObject>, Database.Stateful{
    
    global Decimal Severity = 0;
    global Date dateAfter30 = System.Today()-30;
    global Date dateAfter60 = System.Today()-60;
    
    global Database.QueryLocator start(Database.BatchableContext bc){
        
        String StatusA = 'New';
        
        return Database.getQueryLocator('SELECT Id, Priority, Status FROM Case WHERE Status = StatusA');
        
    }
    
    global void execute (Database.BatchableContext bc, List<Case> caseList){
        
        set<Id> accId = new Set<Id>();
        
        for(Case c: caseList){
            
            if(c.AccountId != NULL && c.Priority != NULL){
                
                if(c.Priority == 'High') {
                    
                    if(c.CreatedDate.Date() < dateAfter30){
                    
                    Severity += 4;
                    
                	}
                    if(c.CreatedDate.Date() < dateAfter60){
                        Severity += 2;  
                    }
                }
                
                if(c.Priority == 'Medium') {
                    
                    if(c.CreatedDate.Date() < dateAfter30){
                    
                    Severity += 3;
                    
                	}
                    if(c.CreatedDate.Date() < dateAfter60){
                        Severity += 1;  
                    }
                }
                
                if(c.Priority == 'Low') {
                    
                    if(c.CreatedDate.Date() < dateAfter30){
                    
                    Severity += 2;
                    
                	}
                    if(c.CreatedDate.Date() < dateAfter60){
                        Severity += 0;  
                    }
                }
               
                
                accId.add(c.AccountId);
            }  
        }
        
        List<Account> accList =[SELECT Support_Score__c, Id FROM Account WHERE ID IN : accId];
        
        for(Account acc: accList){
            
            acc.Support_Score__c = acc.Support_Score__c + Severity;
        }
        
        try{
            
            UPDATE accList;
        }
        catch(Exception e){
            System.debug('Got Error :' + e.getMessage());
        }   
    }
    
    global void finish(Database.BatchableContext bc){
        
        System.debug('Total Severity :' + Severity);
        
    }
    
}