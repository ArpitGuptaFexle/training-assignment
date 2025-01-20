global class AccountSupportScoreBatchScheduler implements Schedulable {
    
    global void execute(SchedulableContext sc){
        AccountSupportScoreBatch ass = new AccountSupportScoreBatch();
        Database.executeBatch(ass, 200);
    }
}