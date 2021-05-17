//Mise en place d'un planificateur Apex avec l'interface Schedulable 
global class AccountRevenueBatchScheduler implements Schedulable{
    global void execute(SchedulableContext sc) {
        // Implémentation du batch AccountCABatch
        AccountRevenue_Batch accUpdate = new AccountRevenue_Batch();
        database.executeBatch(accUpdate);
    }
}
