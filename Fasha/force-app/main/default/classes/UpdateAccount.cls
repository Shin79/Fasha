public class UpdateAccount {
    // Méthode de classe qui met à jour le CA du compte 
    public static void updateAccountAmount(Set<Id> accountsId, Map<Id,Decimal> amount) {
        List<Account> accToUpdate = [SELECT Id, Chiffre_d_affaire__c 
                                     FROM Account 
                                     WHERE Id IN :accountsId];
        for(Account acc : accToUpdate){
            // Si le CA est != null, alors, on concatène le montant de la commande au CA du compte
            if(acc.Chiffre_d_affaire__c != null){
                acc.Chiffre_d_affaire__c += amount.get(acc.Id);
            }else {
            // Sinon, on met le montant de la commande dans le champ CA du compte
                acc.Chiffre_d_affaire__c = amount.get(acc.Id); 
            }
        // On met à jour la requête
        update(accToUpdate);    
        }
    }
}