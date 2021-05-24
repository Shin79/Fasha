trigger OrderTrigger on Order (after update ) {
    // Appel du déclencheur après la mise à jour d'une commande
    if (Trigger.isAfter) {    
        // A la mise à jour, on appelle la méthode du handler avec pour paramètres le mappage des ID des anciennes et nouvelles versions des enregistrements  
        OrderTriggerHandler handler = new OrderTriggerHandler();	
        handler.updateAccountsFromOrder(Trigger.oldMap, Trigger.newMap);
    }
}