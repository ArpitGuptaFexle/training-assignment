/**
 *   Description       : This is for Queueable Apex Assignment (AddPrimaryContact)
 *
 *   Created By        : Arpit Gupta
 *
 *   Created Date      : 12/18/2024
 *
 *   Revision Logs     : V_1.0 - Created - Apex Ass4
 * 
**/
public class AddPrimaryContact implements Queueable{
    private Contact con;
    private String stateAbrivation;
    
    public AddPrimaryContact(Contact con,String stateAbrivation){
        this.con=con;
        this.stateAbrivation=stateAbrivation;
    }
    
    public void execute(QueueableContext qc){
        List<Account> accList=[SELECT Id, BillingState
                               FROM Account 
                               WHERE BillingState= :stateAbrivation 
                               LIMIT 200]; 
        List<Contact> conList = new List<Contact>();
        for(Account acc: accList){
            
            Contact conl = con.clone(false,false,false,false);
            conl.AccountId=acc.Id;
                
            conList.add(conl);

        }
        
        insert conList;

	}
}

/*
    Contact con = new contact(LastName='TestQueue');
    AddPrimaryContact apc= new AddPrimaryContact(con,'NY');
    System.enqueueJob(apc);
*/