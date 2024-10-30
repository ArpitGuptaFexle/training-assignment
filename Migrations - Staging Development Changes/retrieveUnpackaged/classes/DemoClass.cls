public class DemoClass {
    public List<Contact> contactList{get;set;}
    public void getContactDetails(){
        contactList = [select id, name, isDeleted from contact where isDeleted = true ALL ROWS ];
    }
    
    public static void getContactDetails1(){
        List<Contact> ContactList1 =[Select id,name,isDeleted from contact where isDeleted =true ALL ROWS];
        System.debug('check Deleted Data ::: '+contactList1);
    }

}