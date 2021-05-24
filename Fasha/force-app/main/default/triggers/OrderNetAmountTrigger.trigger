trigger OrderNetAmountTrigger on Order (before update) {
	//On itère sur chaque nouvelle version des commandes
    for(Order order : trigger.new) {
            if(order.TotalAmount != null && order.Frais_de_livraison__c != null){
            // On calcule le montant net en soustrayant le montant total aux frais de livraison
            order.Montant_Net__c = order.TotalAmount - order.Frais_de_livraison__c;
            } 
    }
}