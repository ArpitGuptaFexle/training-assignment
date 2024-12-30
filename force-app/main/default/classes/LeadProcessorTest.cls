/**
 *   Description       : This is for Batch Apex Assignment Test(LeadProcessorTest)
 *
 *   Created By        : Arpit Gupta
 *
 *   Created Date      : 12/18/2024
 *
 *   Revision Logs     : V_1.0 - Created - Apex Ass4
 * 
**/
@isTest
public class LeadProcessorTest {
    @isTest
    static void insertLead(){
        List<Lead> leads = new List<Lead>();
        for(Integer i = 0; i < 200; i++){
            Lead ls = new Lead();
            ls.LastName = 'Test' + i;
            ls.Company = 'CompanyTest' + i;
            leads.add(ls);
        }
        insert leads;

        Test.startTest();
        LeadProcessor lp = new LeadProcessor();
        Id batchId = Database.executeBatch(lp, 200);
        Test.stopTest();  
        
        Assert.areEqual(200, [SELECT Count() FROM Lead WHERE LeadSource = 'Dreamforce']);     

    }

    @isTest
    static void testScheduler() {
        // Set up the test data (e.g., leads)
        List<Lead> leads = new List<Lead>();
        for(Integer i = 0; i < 200; i++){
            Lead ls = new Lead();
            ls.LastName = 'TestLead' + i;
            ls.Company = 'Company' + i;
            leads.add(ls);
        }
        insert leads;

        // Schedule the job
        Test.startTest();
        String cronExpression = '0 0 2 * * ?'; // Schedule the job to run at 2 AM daily
        String jobName = 'LeadProcessorBatchJob';
        LeadProcessor scheduler = new LeadProcessor();
        System.schedule(jobName, cronExpression, scheduler);
        Test.stopTest();

        // Assert that the job was scheduled successfully
        CronTrigger job = [SELECT Id, CronExpression, State FROM CronTrigger WHERE CronJobDetail.Name = :jobName LIMIT 1];
        
        // Update the assertion to account for case sensitivity
        System.assertEquals('0 0 2 * * ?', job.CronExpression, 'Cron expression for the scheduled job is incorrect.');
        
        // Fix the comparison to handle case-sensitivity
        System.assertEquals('WAITING', job.State, 'Job state is not in WAITING state.');
    }
}