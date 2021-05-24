@isTest
public class DataFactoryTest {
    
     public static Account createAccountsOrderItem(Integer numOrderPerAcct) {
         
        //creer un compte
        Account acc =  new Account(Name='Compte test', Description='test', Chiffre_d_Affaire__c=0);
        insert acc;

        // Create a Product        
        Product2 product = new Product2(Name = 'Boots', Family = 'Chaussures');
		insert product;

        // Insertion de produit dans Entrée au catalogue de prix        
        PricebookEntry pbe = new PricebookEntry(
            Pricebook2Id = Test.getStandardPriceBookId(),
            Product2Id = product.Id,
            UnitPrice = 100,
            IsActive = true
        );        
        insert pbe;

        // creer X commande 
        List<Order> commandes = new list<Order>();
        for(integer i=0; i<numOrderPerAcct; i++){
            Order comm = new Order(
            	Status = 'Draft',
                AccountId = acc.Id,
                EffectiveDate=date.today(),
                Description='Test',
                Pricebook2Id=pbe.PriceBook2Id               
            );
            commandes.add(comm);           
        }
        insert commandes; 
         
         
       // insertion  produits commandés 
       

       List<OrderItem> listoi = new List<OrderItem>();
       for (Integer j= 0; j<numOrderPerAcct; j++){
           OrderItem oi1 = new OrderItem(OrderId = commandes[j].id,
                                         PricebookEntryId =pbe.Id,
                                         UnitPrice=100,
                                         Quantity=1);
           
           listoi.add(oi1);
            
           
        }

         insert listoi;
  	
        
      	update commandes;
        update listoi;
       
        
         System.debug(acc);
         return acc;
         
         

	}
}