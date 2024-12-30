global class LeadProcessorSchedule implements Schedulable {
    
    global void execute(SchedulableContext sc) {

        LeadProcessor lp = new LeadProcessor();
        Database.executeBatch(lp, 200);
        String cronExpression = '0 0 2 * * ?'; 
        String jobName = 'LeadProcessorBatchJob';
        LeadProcessor scheduler = new LeadProcessor();
        System.schedule(jobName, cronExpression, scheduler);
    }
    
}