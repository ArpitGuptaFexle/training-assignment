public class EventTriggerHandler {

    public static void checkCountEvent(Set<Id> accountIds) {
        if (accountIds.isEmpty()) return;

        List<Account> accountsToUpdate = new List<Account>();
        
        List<AggregateResult> activityCounts = [
            SELECT WhatId,
                   COUNT(Id) totalActivities
            FROM Task
            WHERE WhatId IN :accountIds
            GROUP BY WhatId
        ];

        for (Id accountId : accountIds) {
            Integer totalActivities = 0;
            Integer totalOpenActivities = 0;
            Integer totalClosedActivities = 0;
      
            for (AggregateResult ar : activityCounts) {
                Id whatId = (Id)ar.get('WhatId');
                if (whatId == accountId) {
                    totalActivities = (Integer)ar.get('totalActivities');
                    break; 
                }
            }

            List<Task> tasks = [SELECT Id, Status FROM Task WHERE WhatId = :accountId];
            for (Task task : tasks) {
                if (task.Status == 'Completed') {
                    totalClosedActivities++;
                } else {
                    totalOpenActivities++;
                }
            }


            System.debug('Account ID: ' + accountId);
            System.debug('Total Activities: ' + totalActivities);
            System.debug('Total Open Activities: ' + totalOpenActivities);
            System.debug('Total Closed Activities: ' + totalClosedActivities);

            accountsToUpdate.add(new Account(
                Id = accountId,
                Total_Activities__c = totalActivities,
                Total_Open_Activities__c = totalOpenActivities,
                Total_Closed_Activities__c = totalClosedActivities
            ));
        }


        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
    }
}