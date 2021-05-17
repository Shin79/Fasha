@isTest
public class DataFactory {
    public static void dataTestCreation(Integer numberOfOrders) {
        // Création de comptes test
        Account acc1 = new Account(Name = 'AccountTest1');
        insert acc1; 
        Account acc2 = new Account(Name = 'AccountTest2');
        insert acc2;
        //Création d'un produit test
        Product2 product1 = new Product2(Name = 'Boots', Family = 'Chaussures');
        insert product1;

        // Entrée du produit au catalogue de prix
        PricebookEntry pbe = new PricebookEntry(
            Pricebook2Id = Test.getStandardPricebookId(),
            Product2Id = product1.Id,
            UnitPrice = 300,
            IsActive = true
        );
        Insert pbe;

        // Création d'une liste de commandes 
        List<Order> orders = new List<Order>();
        for(Integer i=0;i<numberOfOrders;i++){
            Order o1 = new Order(AccountId = acc1.Id, Pricebook2Id=pbe.Pricebook2Id, EffectiveDate=date.today(), Status='Draft');
            orders.add(o1);
        }
        insert orders;

        // Création d'une liste de produits commandés
        List<Order> insertedOrders = [SELECT Id FROM ORDER WHERE AccountId=:acc1.Id];
        List<OrderItem> orderItems = new List<OrderItem>();
        for(Order order : insertedOrders){
        OrderItem oi1 = new OrderItem (OrderId = order.Id, PricebookEntryId = pbe.Id, Quantity=1, UnitPrice = 350);
        orderItems.add(oi1);
        OrderItem oi2 = new OrderItem (OrderId = order.Id, PricebookEntryId = pbe.Id, Quantity=5, UnitPrice = 200);
        orderItems.add(oi2);        
        }
        insert orderItems;
    }
}