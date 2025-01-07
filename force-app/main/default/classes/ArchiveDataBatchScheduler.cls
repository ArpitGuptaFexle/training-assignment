global class ArchiveDataBatchScheduler implements Schedulable {
    global void execute(SchedulableContext SC) {
        ArchiveDataBatch batch = new ArchiveDataBatch();
        Database.executeBatch(batch);
    }
}

/*
String cronExp = '0 1 * * * ?'; 
System.schedule('MyBatchJob', cronExp, new ArchiveDataBatchScheduler());

*/