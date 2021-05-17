public class TeamOrdersBySalesController {
    // Les méthodes incluses dans les classes avec l'annotation @AuraEnabled sont appelées depuis le composant Aura 
    @AuraEnabled
    public static List<AggregateResult> sumOrdersBySales(){
        	//Retourne une liste AggregateResult avec le propriétaire de la commande, la somme des commandes, le panier moyen et le nombre de commandes
			List<AggregateResult> groupedResults = [SELECT Owner.Name, 
                                                    SUM(TotalAmount) ordSum,
                                                    AVG(TotalAmount) avgSum,
                                                    COUNT(id) ordCount 
                                                    FROM Order 
                                                    WHERE Status = 'Ordered' 
                                                    GROUP BY Owner.Name];
			return groupedResults;
    }

}