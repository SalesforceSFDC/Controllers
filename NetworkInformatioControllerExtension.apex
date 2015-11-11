public with sharing NetworkInformationControllerExtension {
    Transient List<Network_Information__c> allNetworkInfoList{get;set;}
    public Network_Information__c networkInformationObj{get;set;}
    public string viewMode{get;set;}
    public String redirectUrl{get;set;}
    public NetworkInformationControllerExtension(ApexPages.StandardController controller) {
        
        //property to hold parent view url to solve cross domain issue
        redirectUrl = controller.view().getUrl();
        networkInformationObj = (Network_Information__c)controller.getRecord();
          if(Network_Information__c != null && !String.isBlank(networkInformationObj.Id)) {
            allnetworkInformationList = new List<Network_Information__c>();
            networkInformationObj = new Network_Information__c();
              allnetworkInformationList = [select Id, Network_Information__c from Network_Information__c where Network_Information__c = : networkInformationObj.ID
            ORDER BY LastModifiedDate DESC LIMIT 1];
          if(allnetworkInformationList.size() >0){
          networkInformationObj = allnetworkInformationList.get(0);
              viewMode = 'read';
              }else{
              viewMode = 'edit';
    }
}
              else{
              viewMode = 'edit';
    }
}

 //--------------methods to controll read or write mode of page
 public void showEdit(){
        viewMode = 'edit';
    }
    
    public void hideEdit(){
        viewMode = 'read';
    }


  //--------------override method save
public void save(){

  //----------updating current Account record
  update acct;

  //---------updating or creating networkInformation record
  networkInformationObj.Account__c = acct.Id;
  upsert networkInformationObj;
  viewMode = 'read';
	}
}
