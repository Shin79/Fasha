public class TeamOrdersController {
    public List<AggregateResult> groupedResults{get;set;}
        public teamOrdersController() {
          groupedResults = new List<AggregateResult>();
          groupedResults = [SELECT COUNT(id) ordCount,
                            SUM(TotalAmount) ordSum,
                            owner.Name ordName,
                            AVG(TotalAmount) ordAvg 
                            FROM Order 
                            WHERE Status = 'Ordered'
                            GROUP BY owner.Name];
          for(AggregateResult ar : groupedResults){
              System.debug('Nombre de commandes' + ar.get('ordCount'));
              System.debug('Montant total des commandes ' + ar.get('ordSum'));
              System.debug('Nom du propriétaire ' +  ar.get('ordName'));
              System.debug('Montant moyen d\'une commande ' + ar.get('ordAvg'));
            }
      }  
  }