@isTest
public class OrderTriggerTest {
	// Création des enregistrements de test communs pour les méthodes de la classe avec l'annotation @testSetup
    @testSetup
	static void testSetup() {
		// Création d'un produit
		Product2 product1 = new Product2(Name = 'Baskets', Family = 'Chaussures');
		insert product1;
        
		// Entrée du produit au catalogue de prix
		PricebookEntry priceBook = new PricebookEntry(
			Pricebook2Id = Test.getStandardPricebookId(),
			Product2Id = product1.Id,
			UnitPrice = 200,
			IsActive = true);
		insert priceBook;
        
		// Création d'un compte test sans commande et un compte test avec commande 
		Account testAccountNoOrder = new Account(Name = 'TestAcc');
		Account testAccountWithOrder = new Account(Name = 'TestAccWithOrder', Chiffre_d_affaire__c = 1000);
		insert new Account[]{testAccountNoOrder, testAccountWithOrder};
	}
    // Méthode de test qui met à jour le CA d'un compte pour une première commande 
    @isTest
	static void updateAccountCAWithFirstOrder(){
		Account acc = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Name = 'TestAcc'];
        acc.Chiffre_d_affaire__c = 0;
        update acc;
		PricebookEntry pbe = [SELECT Id, Pricebook2Id FROM PricebookEntry WHERE UnitPrice = 200];
		Test.startTest();
		// Création d'une commande 
		Order o1 = new Order(AccountId = acc.Id, Status = 'Draft', Pricebook2Id = pbe.Pricebook2Id, EffectiveDate = date.today());
		insert o1;
		// Insertion du produit dans la commande 
		OrderItem oi1 = new OrderItem(OrderId = o1.Id, PricebookEntryId = pbe.Id, Quantity=1, UnitPrice = 200);
		insert oi1;
		// Mise à jour de la commande à "Ordered"
		o1.Status = 'Ordered';
		update o1; 
		Test.stopTest();
		Account accAfterUpdate = [SELECT Id,Chiffre_d_affaire__c FROM Account WHERE Name = 'TestAcc'];
		// Vérification de l'assertion
		System.assertEquals(200, accAfterUpdate.Chiffre_d_affaire__c);
	}
    
    // Méthode de test qui met à jour un compte avec un chiffre d'affaire existant 
    @isTest
	static void updateAccountCAWithOrders(){
		Account acc = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Name = 'TestAccWithOrder'];
		PricebookEntry pbe = [SELECT Id, Pricebook2Id FROM PricebookEntry WHERE UnitPrice = 200];
		System.assertEquals(1000, acc.Chiffre_d_affaire__c,'The revenu should be Null');
		Test.startTest();
		// Création d'une commande 
		Order o1 = new Order(AccountId = acc.Id, Status = 'Draft', Pricebook2Id = pbe.Pricebook2Id, EffectiveDate = date.today());
		insert o1;
		// Insertion du produit dans la commande
		OrderItem oi1 = new OrderItem(OrderId = o1.Id, PricebookEntryId = pbe.Id, Quantity=1, UnitPrice = 200);
		insert oi1;
		// Mise à jour de la commande à "Ordered"
		o1.Status = 'Ordered';
		update o1; 
		Test.stopTest();
		Account accAfterUpdate = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Name = 'TestAccWithOrder'];
		// Vérification de l'assertion
		System.assertEquals(1200, accAfterUpdate.Chiffre_d_affaire__c);
	}
    
    

}