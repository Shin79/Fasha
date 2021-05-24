@isTest
public class TestUpdateAccountCA {
    
     @isTest 
     static void TestUpdateCawithOneOrder() {
        
        Account acc = DataFactoryTest.createAccountsOrderItem(3);
    
        
        Test.startTest();
        update acc;
        Test.stopTest();
        
        System.assert(true);
         
        Account ac = [SELECT Id, Name, Chiffre_d_affaire__c FROM Account WHERE Name = 'Compte test'];
        System.AssertEquals('Compte test', ac.Name);
        System.AssertEquals(300, ac.Chiffre_d_affaire__c);
     }
}