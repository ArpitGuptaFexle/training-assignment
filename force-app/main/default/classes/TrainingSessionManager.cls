/**
 *   Description       : Managing Training_Session__c records, handling creation, reading, updating, deleting 
 *                       and bulk operations efficiently.
 *
 *   Created By        : Arpit Gupta
 *
 *   Created Date      : 11/29/2024
 *
 *   Revision Logs     : V_1.0 - Created - Apex Assignment 2
 *                 
 * 
**/
public class TrainingSessionManager {
    
    /**
    *   @description    :   This method used to Create a Enum.
    *
    *   @arg            :  
    *
    *   @return         :   Void
    *
    *   @Revision Log   :   V_1.0 - Created - Arpit - 11/30/2024 - S1T3
    * 
    **/
    public enum trainingSessionCategory { WEBINAR, WORKSHOP }
    
    /**
    *   @description    :   This method used Create or Insert the values to Records in Object .
    *
    *   @arg            :   String trainingSessionName,String locationName
    *
    *   @return         :   Void
    *
    *   @Revision Log   :   V_1.0 - Created - Arpit - 11/30/2024 - S1T1.1
    * 
    **/
     
    public static void createTrainingSession(String trainingSessionName,String locationName){
        
        List<Training_Session__c> trainingSessionList = new List<Training_Session__c>();
        
        for(Integer i=0; i<5; i++){
                // Training_Session__c trainingSession= new Training_Session__c();
                // trainingSession.Locations__c='Location xyz'+i;
                //trainingSession.Name = 'Trainee'+ i;
 
            trainingSessionList.add(new Training_Session__c (Name= trainingSessionName +(i+1),Locations__c=locationName+(i+1)));
            
                //trainingSessionList.add(new Training_Session__c());    
        }
        try{
            
        	insert trainingSessionList;
            
    	}
        catch(Exception e){
            
            System.debug(e);
            
        }
    }
    
    /**
    *   @description    :   This method use to Read the records from training Session
    *
    *   @arg            :  
    *
    *   @return         :   Void
    *
    *   @Revision Log   :   V_1.0 - Created - Arpit - 11/30/2024 - S1T1.2 
    * 
    **/
    
    public static void readTrainingSession(){
		
		List<Training_Session__c> trainingSessions = [SELECT Name, Locations__c, Training_Topics__c, RecordTypeId 
                                                      FROM Training_Session__c 
                                                      LIMIT 5];
        if(trainingSessions.isEmpty()){
            
            System.debug('No Records Found');
        }
        else{
            
            for(Training_Session__c trainingSession :trainingSessions){
                
            	System.debug('Training Session Details:'+ '  ' +
                             'Training Name:' + trainingSession.Name + 
                             'Location:'+ trainingSession.Locations__c+ '  '+ 
                             'Training Topics:' + trainingSession.Training_Topics__c+'  '+
                             'Record Type:'+ trainingSession.RecordTypeId);
            }    
		}
	}
    
    
    /**
    *   @description    :   This method is used to Update the Training Session Records.
    *
    *   @arg            :  
    *
    *   @return         :   Void
    *
    *   @Revision Log   :   V_1.0 - Created - Arpit - 11/30/2024 - S1T1.3 
    * 
    **/
    public static void updateTrainingSession(){
        
        List<Training_Session__c> trainingSessionsToUpdate =[SELECT Name,ID,Locations__c
                                                 	         FROM Training_Session__c 
                                                 	         WHERE Locations__c 
                                                             LIKE 'Jaipur%' ];
		//trainingSessionsToUpdate.Name='AAArpit';
        if(!trainingSessionsToUpdate.isEmpty()){
            
            for(Training_Session__c trainingSession: trainingSessionsToUpdate){
            
                trainingSession.Locations__c='Jaipur';
            }
        }
        try{
		
            UPDATE trainingSessionsToUpdate;
        }
        catch(Exception e){
            
            System.debug(e);
        }
    }
	
	/**
    *   @description    :  This method is used to Delete the training session Records.
    *
    *   @arg            :  
    *
    *   @return         :  Void
    *
    *   @Revision Log   :   V_1.0 - Created - Arpit - 11/30/2024 - S1T1.4
    * 
    **/    
  
    public static void deleteTrainingSession(){
        List<Training_Session__c> trainingSessionsToDelete =[SELECT Id,Name,Locations__c
                                           		             FROM   Training_Session__c 
                                            	             WHERE  Locations__c
                                                             LIKE   'Jaipur%'];
        try{
            
        	delete trainingSessionsToDelete;
        }
        catch(Exception e){
            
            System.debug(e);
        }
    }
    
    
    //S3T1
    /*
    public static void fetchRelatedAttendees(){
        List<Training_Session__c> fetchSession = [SELECT Name, Locations__c ,(SELECT Name,Email__c
                                                                              FROM Attendees__r) 
                                                  FROM Training_Session__c 
                                                  WHERE Name='AAArpit' ];
		System.debug(fetchSession[0].Attendees__r[0]);
        //for(Training_Session__c tr : fetchSession )
       		//System.debug('@@@@@'+tr.Attendees__r[0].name);
    }
	*/

    /**
    *   @description    :   This method used to Fetch all Records from Training Session and Attendees.
    *
    *   @arg            : 
    *
    *   @return         :   Void
    *
    *   @Revision Log   :   V_1.0 - Created - Arpit - 11/30/2024 - S3T1
    * 
    **/
	
    
    public static void fetchAllTrainingSessions(){
        
        list<Training_Session__c> allTrainingSessions =[SELECT Name,Locations__c,Training_Topics__c,RecordTypeId,(SELECT Name,Email__c 
                                                                                                                  FROM Attendees__r) 
                                                        FROM Training_Session__c ];
        if(!allTrainingSessions.isEmpty()){
            
        	for(Training_Session__c trainingSession: allTrainingSessions){
                
            	System.debug(trainingSession.Name+'  '+
                             trainingSession.Locations__c +'  '+
                             trainingSession.Training_Topics__c+'  '+
                             trainingSession.RecordTypeId+'  '+
                             trainingSession.attendees__r);
            }
            
        }
        
    }

    /**
    *   @description    :   This method used to Fetch all Related Attendees of Training Session.
    *
    *   @arg            : 
    *
    *   @return         :   Void
    *
    *   @Revision Log   :   V_1.0 - Created - Arpit - 11/30/2024 -S2T1
    * 
    **/

    public static void fetchAllRelatedAttendees() {

        List<Training_Session__c> trainingSessions = [SELECT Id, Name, (SELECT Name 
                                                                        FROM Attendees__r) 
                                                      FROM Training_Session__c 
                                                      WHERE Id = :'a05dM0000099s5dQAA'
                                                      LIMIT 1
        ];
        
        if (!trainingSessions.isEmpty() && (trainingSessions[0]?.Attendees__r) != null) {

            for (Attendee__c attendee : trainingSessions[0].Attendees__r) {

                System.debug( 'Attendee Name: ' + attendee.Name);
            }
        } else {

            System.debug('No attendee found for this session.');
        }
    }
    
    /**
    *   @description    :   This method used to Bulk Insert to Training Session.
    *
    *   @arg            : 
    *
    *   @return         :   Void
    *
    *   @Revision Log   :   V_1.0 - Created - Arpit - 11/30/2024 - A2S2T1
    * 
    **/

    public static void bulkInsertTrainingSessions(){

        List<Training_Session__c> trainingSessionsToInsert=new List<Training_Session__c>{
            new Training_Session__c(Name='BulkInsert',Locations__c='BulkInsertLocation'),
            new Training_Session__c(Name='BulkInsert1',Locations__c='BulkInsertLocation1'),
            new Training_Session__c(Name='BulkInsert2',Locations__c='BulkInsertLocation2'),
            new Training_Session__c()
        };
        
        Database.SaveResult[] saveResultrainingSession=Database.insert(trainingSessionsToInsert,False);
        
        for(Database.SaveResult sr: saveResultrainingSession){

            if(sr.isSuccess()){

                System.debug(System.label.Insertion_Successful+ sr.getID());
            }
            else{

                for(Database.Error err: sr.getErrors()){

                     System.debug(err.getStatusCode());
					 System.debug(err.getFields());
                }
            }
        }
    } 
    
    /**
    *   @description    :   This method used to Bulk Update to Training Session.
    *
    *   @arg            : 
    *
    *   @return         :   Void
    *
    *   @Revision Log   :   V_1.0 - Created - Arpit - 11/30/2024 - A2S2T1
    * 
    **/
    public static void bulkUpdateTrainingSessions(){
        
        List<Training_Session__c> trainingSessionsToUpdate = [SELECT Name,ID,Locations__c 
                                                              FROM   Training_Session__c 
                                                              WHERE  Locations__c 
                                                              LIKE   'Jaipur%'];
        if(!trainingSessionsToUpdate.isEmpty()){
            
            for(Training_Session__c trainingSession: trainingSessionsToUpdate){
            
                trainingSession.Locations__c='London';
            }
        }
        Database.SaveResult[] saveResultrainingSession = Database.Update(trainingSessionsToUpdate,false);
        
        for(Database.SaveResult sr: saveResultrainingSession){
            
            if(sr.isSuccess()){
                
                System.debug(System.label.Updation+ sr.getID());
            }
            else{
                
                for(Database.Error err: sr.getErrors()){
                    
                     System.debug(err.getStatusCode());
					 System.debug(err.getFields());
                }
            }
        }
    }
    
    /**
    *   @description    :   This method used to Bulk delete to Training Session.
    *
    *   @arg            : 
    *
    *   @return         :   Void
    *
    *   @Revision Log   :   V_1.0 - Created - Arpit - 11/30/2024 - A2S2T1
    * 
    **/
    
    public static void bulkdelete(){
        
        List<Training_Session__c> trainingSessionsToDelete =[SELECT Id,Name,Locations__c
                                                             FROM   Training_Session__c 
                                                             WHERE  Name
                                                             LIKE   'DML%'];
        if (!trainingSessionsToDelete.isEmpty()) {

        	Database.DeleteResult[] drList =Database.delete(trainingSessionsToDelete,false);
        
        	for(Database.DeleteResult dr: drList){
            
            if(dr.isSuccess()){
                
                System.debug(System.label.Deletion+ dr.getID());
            }
            else{
                
                for(Database.Error err: dr.getErrors()){
                    
                     System.debug(err.getStatusCode());
					 System.debug(err.getFields());
                }
            }
        }
        
     }
    }
    
    /**
    *   @description    :   This method used to Fetch Session Date.
    *
    *   @arg            : 
    *
    *   @return         :   Void
    *
    *   @Revision Log   :   V_1.0 - Created - Arpit - 11/30/2024 - A2S1T2
    * 
    **/
    public static void fetchSessionDateAndType(){
        //STR 012dM000003l5FRQAY
        //DATE 2024-12-02 

        date sessionDate=date.newInstance(2024,12,02);
        list<Training_Session__c> trainingSessions=[SELECT Name, Session_Date__c, Locations__c, RecordTypeId
                                      				FROM   Training_Session__c
                                     				WHERE  Session_Date__c= :sessionDate];

        System.debug(trainingSessions);
    }
    
    
    
    /**
    *   @description    :   This method used to Fetch Session Date.
    *
    *   @arg            : 
    *
    *   @return         :   Void
    *
    *   @Revision Log   :   V_1.0 - Created - Arpit - 11/30/2024 - A1S1T2
    * 
    **/
    public static void addAttendees() {
        
        List<Training_Session__c> trainingSessionList =[SELECT Name, Session_Date__c, Locations__c, RecordTypeId
                                      					FROM   Training_Session__c];

        Set<Training_Session__c> trainingSessionSet = new Set<Training_Session__c>();
        
        for(Training_Session__c trainingSession: trainingSessionList){
            //Added records without any duplicate records
            
            trainingSessionSet.add(trainingSession);
        }
        
        System.debug(trainingSessionSet);
    }
    
}