public with sharing class LeadCreateController {
    public String countOfRows {get; set;}
    public List<Lead> leadList {get; set;}
                                                
	public void addCoutLeads() {
        Integer countOfLeads = Integer.valueOf(countOfRows);
        if (countOfLeads<=1000) {
            leadList = new List<Lead>();
        	for (Integer i = 0; i < countOfLeads; i++) {
            	leadList.add(new Lead());
            }            
        } else {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'You enter incorrect Count of Leads!'));            
        }
    }	
    
	public void save() {
        try {
            insert leadList;
        } catch (DmlException de) {
            Integer countOfErrors = de.getNumDML();
            for (Integer i = 0; i < countOfErrors ; i++) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Error in raw '
                                                           + (de.getDmlIndex(i) + 1) + ':' + de.getDmlMessage(i)));
            }
        }
    }
	
	public PageReference cancel() {
        PageReference pageRef = ApexPages.currentPage();
        return pageRef;
    }
}