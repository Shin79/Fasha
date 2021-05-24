@isTest
public class UpdateAccountCATest {
    @isTest
    static void testTriggerUpdateAccountCA() {
        DataFactory.dataTestCreation(200);
        
        List<Order> updateOrder = [SELECT Id, Status, TotalAmount
                                   FROM Order
                                   WHERE Account.Name = 'AccountTest1'];
        System.debug(updateOrder);
        
        for(Order order: updateOrder) {
            order.Status = 'Ordered';
        }

        Test.startTest();
        update updateOrder;
        System.debug(updateOrder);
        Test.stoptest();
        
        Account accResult = [SELECT Chiffre_d_affaire__c
                             FROM Account
                            WHERE Name = 'AccountTest1'];
        System.debug(accResult);
        System.assertEquals(270000, accResult.Chiffre_d_affaire__c);
    }
}