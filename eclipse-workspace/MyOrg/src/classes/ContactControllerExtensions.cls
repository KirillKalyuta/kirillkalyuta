public without sharing class ContactControllerExtensions {

    public ApexPages.StandardSetController controller { get; set; }

    public String sortDir {
        get {
            if (sortDir == null) {
                sortDir = 'ASC';
            }
            return sortDir;
        }
        set;
    }

    public String sortColumnName {
        get {
            if (sortColumnName == null) {
                sortColumnName = 'Name';
            }
            return sortColumnName;
        }
        set;
    }    

    public ContactControllerExtensions(ApexPages.StandardSetController stController) {
        this.controller = reloadContactList();
    }

    public void Filter() {
        sortDir = sortDir == 'ASC' ? 'DESC' : 'ASC';
        controller = reloadContactList();
    }
    
    private ApexPages.StandardSetController reloadContactList() {
        String query = 'Select Name, Title, Account.Name, Phone, Email, MobilePhone, Owner.Name from Contact order by ' + sortColumnName + ' ' + sortDir;
        ApexPages.StandardSetController setCon = new ApexPages.StandardSetController(Database.getQueryLocator(query));
        return setCon;
    }

    public List<Contact> getContacts() {
        return controller.getRecords();
    }

}