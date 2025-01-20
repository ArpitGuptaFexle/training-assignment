global class AccountSupportScoreBatch implements Database.Batchable<sObject>, Database.Stateful {
    
    global Date dateAfter30 = System.Today() - 30;
    global Date dateAfter60 = System.Today() - 60;
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT Id, AccountId, Priority, CreatedDate FROM Case WHERE Status != \'Closed\'');
    }
    
    global void execute(Database.BatchableContext bc, List<Case> caseList) {
        
        Map<Id, Decimal> accountSeverityMap = new Map<Id, Decimal>();
        
        for (Case c : caseList) {
            if (c.AccountId != NULL && c.Priority != NULL) {
                Decimal severity = scoreCalculation(c);
                
                if (accountSeverityMap.containsKey(c.AccountId)) {
                    accountSeverityMap.put(c.AccountId, accountSeverityMap.get(c.AccountId) + severity);
                } else {
                    accountSeverityMap.put(c.AccountId, severity);
                }
            }
        }
        
        
        List<Account> accList = [SELECT Id, Support_Score__c FROM Account WHERE Id IN :accountSeverityMap.keySet()];
        
        for (Account acc : accList) {
            acc.Support_Score__c = (acc.Support_Score__c != NULL ? acc.Support_Score__c : 0) + accountSeverityMap.get(acc.Id);
        }
        
        try {
            update accList;
        } catch (DmlException e) {
            System.debug('Error while updating accounts: ' + e.getMessage());
        }
    }
    
    private Decimal scoreCalculation(Case c) {
        Decimal severity = 0;
        
        if (c.Priority == 'High') {
            severity += 3;
        } else if (c.Priority == 'Medium') {
            severity += 2;
        } else if (c.Priority == 'Low') {
            severity += 1;
        }
        
        if (c.CreatedDate.Date() >= dateAfter30) {
            severity += 1;
        }
        if (c.CreatedDate.Date() < dateAfter60) {
            severity -= 1;
        }
        
        return (decimal)severity;
    }
    
    
    global void finish(Database.BatchableContext bc) {
        System.debug('Batch processing completed.');
    }
}