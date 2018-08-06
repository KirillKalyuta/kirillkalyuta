public with sharing class ActivitiesController {
    public List<Task> taskList {get; set;}
    public List<Event> eventList {get; set;}
    
    public ActivitiesController() {
        List<Task> newTaskList = [SELECT Id, Status, WhatId, OwnerId, Subject, Type, TaskSubtype, ActivityDate FROM Task];        
        List<Event> newEventList= [SELECT Id, WhatId, Subject, ActivityDate, StartDateTime, EndDateTime, OwnerId, EventSubtype, Type FROM Event];
        this.taskList = newTaskList;
        this.eventList = newEventList;
        insert taskList;
        insert eventList;
    }
    
}