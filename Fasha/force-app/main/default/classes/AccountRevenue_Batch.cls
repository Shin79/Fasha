global class AccountRevenue_Batch implements Database.Batchable<sObject>{
    // Appel de la méthode start pour collecter les enregistrements à passer à la méthode d'interface execute
    global Database.QueryLocator start(Database.BatchableContext info){ 
        //Requeter seulement les comptes qui ont au moins une commande avec le Status 'Ordered'
        return Database.getQueryLocator([SELECT Id,Chiffre_d_affaire__c FROM Account WHERE Id IN (SELECT AccountId FROM Order WHERE Status='Ordered')]);
    }
    // Exécution du batch pour effectuer le traitement requis pour chaque lot de données
    global void execute(Database.BatchableContext info, List<Account> scope){      
        list<Order> listOrders =  [SELECT Id, TotalAmount, AccountId FROM Order];
        
         for(Account myAccount : scope){
             myAccount.Chiffre_d_affaire__c = 0;
            for(Order order : listOrders){
                if(order.AccountId == myAccount.Id){
                    myAccount.Chiffre_d_affaire__c += order.TotalAmount;
                }                   
            }
        }       
        // Mise à jour de la liste de comptes
        update scope;
    }        
    // Pas de post-traitement
    global void finish(Database.BatchableContext info){     

    } 
 }