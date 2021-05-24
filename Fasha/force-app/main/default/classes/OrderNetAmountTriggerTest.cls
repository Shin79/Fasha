@isTest
public class OrderNetAmountTriggerTest {
    @isTest
    static void calculateNetAmount() {
        DataFactory.dataTestCreation(2);
        List<Order> updateOrder = [SELECT Id,Status FROM Order WHERE Account.Name = 'AccountTest1'];
        for(Order order : updateOrder){
            order.Status = 'Ordered';
            order.Frais_de_livraison__c = 50;
        }
        Test.startTest();
        update updateOrder;
        Test.stopTest();

        List<Order> orderResult = [SELECT Id,Montant_Net__c FROM Order WHERE Account.Name = 'AccountTest1'];
        System.debug(orderResult);
        System.assertEquals(1300,orderResult[1].Montant_Net__c);
    }
}
