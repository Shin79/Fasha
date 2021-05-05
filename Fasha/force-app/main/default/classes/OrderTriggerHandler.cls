public class OrderTriggerHandler {
	// On ajoute la logique du trigger pour la mise à jour du Chiffre d'affaire dans la classe Handler
	public Set<Id> setAccountsIds = new set<Id>();
	public Map<Id,Decimal> accountIdWithAmountsToAdd = new Map<Id,Decimal>();

	public void updateAccountsFromOrder(Map<Id,Order> orderOldMap, Map<Id,Order> orderNewMap){        
		for(Order myOrder : orderNewMap.values()){         
				// Si le statut de la commande est à "Ordered" et qu'il a été modifié
                if (orderOldMap.get(myOrder.Id).Status != myOrder.Status && myOrder.Status == 'Ordered')  {
					accountIdWithAmountsToAdd.put(myOrder.AccountId, myOrder.TotalAmount);
                    setAccountsIds.add(myOrder.AccountId);
				}
			}	
        UpdateAccount.updateAccountAmount(setAccountsIds,accountIdWithAmountsToAdd);
	}
}