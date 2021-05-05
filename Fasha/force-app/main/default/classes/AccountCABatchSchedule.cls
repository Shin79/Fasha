global class AccountCABatchSchedule implements Schedulable{
    global void execute(SchedulableContext sc) {
        // Implémentation du batch AccountCABatch
        AccountCABatch accUpdate = new AccountCABatch();
        database.executeBatch(accUpdate);
    }
}
