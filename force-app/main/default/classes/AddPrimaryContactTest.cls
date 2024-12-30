/**
 *   Description       : This is for Queueable Apex Assignment(AddPrimaryContactTest)
 *
 *   Created By        : Arpit Gupta
 *
 *   Created Date      : 12/18/2024
 *
 *   Revision Logs     : V_1.0 - Created - Apex Ass4
 * 
**/
@isTest
public class AddPrimaryContactTest {
    @isTest
    static void setup(){
        List<Account> accList= new List<Account>();
        for(Integer i=0;i<100;i++){
            if(i<50)
                accList.add(new Account(Name='Account'+i,BillingState='NY'));
                
            else
                accList.add(new Account(Name='Account'+i,BillingState='CA'));
  
        }
        insert accList;
        
        
        Contact con = new Contact(LastName='TestContact');
        AddPrimaryContact apc = new AddPrimaryContact(con,'NY');
        
        Test.startTest();
        System.enqueueJob(apc);
        Test.stopTest();
        
        Assert.areEqual(50,[SELECT Count() FROM Contact]);

    }

}