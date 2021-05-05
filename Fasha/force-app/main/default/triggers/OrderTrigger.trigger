trigger OrderTrigger on Order (after update ) {
    // Appel du déclencheur après la mise à jour d'une commande
    if (Trigger.isUpdate) {    
        OrderTriggerHandler handler = new OrderTriggerHandler();	
        handler.updateAccountsFromOrder(Trigger.oldMap, Trigger.newMap);
    }
}