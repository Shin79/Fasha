@isTest
public class AccountRevenueBatchTest{
    @testSetup
    static void testSetUp(){
        // Appel de la classe de données de test 
        DataFactory.dataTestCreation(100);
        Order order = [SELECT Id,Status FROM Order LIMIT 1];
        // On met à jour le statut de la commande à "Ordered"
        order.Status = 'Ordered';
        update order;
    }
    @isTest
    static void testBatch(){
        Test.startTest();
        // On instancie et invoque le batch en appelant Database.executeBatch()
        AccountRevenue_Batch updateBatch = new AccountRevenue_Batch();
        Id batchId = Database.executeBatch(updateBatch);
        Test.stopTest();
        // On vérifie que la mise à jour a été faite correctement
        List<Account> accountsUpdated = [SELECT Id, Chiffre_d_affaire__c, (SELECT Id, Status, TotalAmount FROM Orders 
                                  WHERE Status = 'Ordered') 
                                  FROM Account 
                                  WHERE Id IN (SELECT AccountId FROM Order WHERE Status = 'Ordered')];      
        System.assertEquals(135000, accountsUpdated[0].Chiffre_d_affaire__c );
    }
}
