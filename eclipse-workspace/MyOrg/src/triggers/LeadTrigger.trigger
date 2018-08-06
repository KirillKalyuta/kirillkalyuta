trigger LeadTrigger on Lead (after insert) { //логику из триггера нужно выностить в Trigger Handler
    List<String> leadSourceList = new List<String>(); 
    for(Lead lead : Trigger.new){
        if(!leadSourceList.contains(lead.LeadSource)){
            leadSourceList.add(lead.LeadSource);
        }
    }
    System.debug(leadSourceList);
    List<Campaign> campaignList = [SELECT Name, Parent.Name, Id, StartDate, EndDate From Campaign WHERE Parent.Name IN :leadSourceList];
    List<Campaign> parentCampaignList = [SELECT Name From Campaign WHERE Name IN :leadSourceList];
    List<String> parentNameList = new List<String>();
    for(Campaign campaign : parentCampaignList){
            parentNameList.add(campaign.Name);
    }   
    System.debug(parentNameList);
    List<CampaignMember> campaignMemberList= new List<CampaignMember>();
    for(Lead lead : Trigger.new){      
        String leadSource = lead.LeadSource;
        if(!parentNameList.contains(leadSource)){
            lead.addError('Campaign do not exist. Enter corect "Lead Sorce"');
        }
        DateTime data = lead.CreatedDate;
        Date createDate = Date.newInstance(data.year(),data.month(),data.day());
        for(Campaign campaign : campaignList){
            if(campaign.Parent.Name == leadSource && campaign.StartDate < createDate && campaign.EndDate > createDate){ // проверить стоит на >= дате, 
                                                                                                                        //иначе в кайние дни триггер будет работать некорректно
                campaignMemberList.add(
                new CampaignMember(
                	LeadId = lead.Id,
                    campaignId = campaign.Id
                ));
            }
        }
    }
    insert campaignMemberList;
}
//просмотри правила отбивки скобок пробелами в правилах оформления кода