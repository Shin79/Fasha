@isTest
public class TeamOrdersBySalesControllerTest {
   @testSetup
   static void testSetUp(){
       // Appel de la classe de données de test 
       DataFactory.dataTestCreation(1);
       Order order = [SELECT Id,Status FROM Order LIMIT 1];
       // On met à jour le statut de la commande à "Ordered"
       order.Status = 'Ordered';
       update order;
   }
     @isTest 
     static void testOrdersBySales() {        
        Test.startTest();
       	List<AggregateResult> groupedResults = TeamOrdersBySalesController.sumOrdersBySales();
        Test.stopTest();
        
        System.assert(groupedResults.size()>0);
        System.assertEquals(1350, groupedResults[0].get('ordSum'));       
     }
}