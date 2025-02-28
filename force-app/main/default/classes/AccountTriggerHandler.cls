/**
 *   Description       : Account Trigger Handler
 *
 *   Created By        : Arpit Gupta
 *
 *   Created Date      : 12/04/2024
 *
 *   Revision Logs     : V_1.0 - Created - Apex Assignment 3     
 * 
**/
public class AccountTriggerHandler {
    public static void createOpp(List<Account> newList){
        
        List<Opportunity> oppList=new List<Opportunity>();
        
        for(Account acc: newList){
            Opportunity opp = new Opportunity();
            opp.Name=acc.Name;
            opp.CloseDate=System.today();
            opp.StageName= 'Prospecting';
            opp.AccountId=acc.Id;
            oppList.add(opp);
        }
        if(!oppList.isEmpty()){
            insert oppList;
        }
        
    }
    
    public static void beforeInsert(List<Account> newList){
        for(Account acc: newList){
            acc.Description='Trigger invoked with Trigger Handler';
        }
    }
    public static void populateRating(List<Account> newList){
        for(Account acc: newList){
            
           // if(acc.Industry!=null && acc.Industry == 'Media'){
                
               // acc.Rating='Hot';
           acc.Description='Trigger invoked with Trigger Handler2';
            }
        }
}