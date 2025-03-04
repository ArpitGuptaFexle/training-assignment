public with sharing class assignmentAccountController {
    @auraEnabled(cacheable= true)
    public static List<Account> getAccount() {
        try{
            return [SELECT Id,Name,Website, Phone FROM Account];
        }
        catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        }

    }
}