({
	init : function(component, event, helper) {
		
        component.set("v.columns", [
            {label: 'Commercial', fieldName: 'Name', type: 'text'},
            {label: 'Panier moyen',fieldName: 'avgSum', type: 'currency', typeAttributes: { currencyCode: 'EUR' }},
            {label: 'Nombre de commandes', fieldName: 'ordCount'},
            {label: 'Montant des commandes', fieldName: 'ordSum', type: 'currency', typeAttributes: { currencyCode: 'EUR', maximumSignificantDigits: 5}}
        ])
        // 1/La fonction JS appelle la méthode sumOrdersBySales du contrôleur Apex côté serveur 
        const fetchData = component.get("c.sumOrdersBySales");
        // 3/Lorsque la réponse du serveur est retournée, on exécute la fonction de rappel qui paramètre l'attribut data sur la valeur des données retournées 
        fetchData.setCallback(this, function(response) {
            console.log(response.getReturnValue());
            component.set("v.data", response.getReturnValue());
        });
        // 2/On place les requêtes serveur en file d'attente
        $A.enqueueAction(fetchData);
	}
})