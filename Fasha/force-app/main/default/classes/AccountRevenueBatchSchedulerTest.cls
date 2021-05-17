@isTest
public class AccountRevenueBatchSchedulerTest{
    @testSetup
    static void testSetUp(){
        // Appel de la classe de test 
        DataFactory.dataTestCreation(1);
        Order order = [SELECT Id,Status FROM Order LIMIT 1];
        // On met à jour le statut de la commande à "Ordered"
        order.Status = 'Ordered';
        update order;
    }
    @isTest
    static void testScheduleUpdateCA(){
        Test.startTest();
        AccountRevenueBatchScheduler updateScheduler = new AccountRevenueBatchScheduler();
        // Le batch est lancé tous les jours à 23 heures (S,M,H,Dm,M,Dw)
        String scheduler = '0 0 23 * * ?';
        // La méthode prend trois arguments (nom de la tâche,la planification de la tâche, la classe à tester)
        System.schedule('Schedule to update Account CA',scheduler,updateScheduler);
        Test.stopTest();
        // On vérifie que la mise à jour a été faite correctement
        List<Account> accountsUpdated = [SELECT Id, Chiffre_d_affaire__c, (SELECT Id, Status, TotalAmount FROM Orders 
                                  WHERE Status = 'Ordered') 
                                  FROM Account 
                                  WHERE Id IN (SELECT AccountId FROM Order WHERE Status = 'Ordered')];      
        System.assertEquals(1350, accountsUpdated[0].Chiffre_d_affaire__c );
    }
}