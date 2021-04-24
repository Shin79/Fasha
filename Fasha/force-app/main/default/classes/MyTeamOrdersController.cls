public with sharing class MyTeamOrdersController {
    public Decimal SumOrders{
        get{
            AggregateResult[] groupedResults = [SELECT SUM(TotalAmount) total FROM Order];
           return (Decimal) groupedResults[0].get('total');
        }
        set;
    }
    
}