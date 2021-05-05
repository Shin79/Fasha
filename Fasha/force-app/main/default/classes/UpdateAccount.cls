public class UpdateAccount {
    // Méthode de classe qui met à jour le CA du compte 
    public static void updateAccountAmount(Set<Id> accountsId, Map<Id,Decimal> amount) {
        List<Account> accToUpdate = [SELECT Id, Chiffre_d_affaire__c 
                                     FROM Account 
                                     WHERE Id IN :accountsId];
        for(Account acc : accToUpdate){
            if(acc.Chiffre_d_affaire__c != null){
                acc.Chiffre_d_affaire__c += amount.get(acc.Id);
            }else {
                acc.Chiffre_d_affaire__c = amount.get(acc.Id); 
            }
        update(accToUpdate);    
        }
    }
}