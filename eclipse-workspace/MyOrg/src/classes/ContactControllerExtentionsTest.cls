@isTest
public with sharing class ContactControllerExtentionsTest {

    @TestSetup
    static void setup() {
        List<Contact> conList = new List<Contact>();
        Contact con1 = New Contact();
        con1.LastName = 'Test';
        con1.Email = '1@mail.ru';
        conlist.add(con1);
        Contact con2 = New Contact();
        con2.LastName = 'Test';
        con2.Email = '2@mail.ru';
        conlist.add(con2);
        Contact con3 = New Contact();
        con3.LastName = 'Test';
        con3.Email = '3@mail.ru';
        conlist.add(con3);

        insert conList;

    }

    @isTest
    public static  void checkController() {

        List<Contact> conList = [SELECT Name, Email
        FROM Contact];
        Test.startTest();
        ApexPages.StandardSetController stdSetController = new ApexPages.StandardSetController(conList);
        ContactControllerExtensions myController = new ContactControllerExtensions(stdSetController);
        myController.sortColumnName = 'Email';
        myController.Filter();
        myController.sortDir = 'DESC';        
        stdSetController = myController.controller;
        List <Contact> contactList = myController.getContacts();
        List<Contact> outputList = stdSetController.getRecords();
        Test.stopTest();

        System.assertEquals(outputList[0].Email, '3@mail.ru');
        System.assertEquals(3, contactList.size());

    }

}