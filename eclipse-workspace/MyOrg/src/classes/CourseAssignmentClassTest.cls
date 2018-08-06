@isTest(SeeAllData=false)
public with sharing class CourseAssignmentClassTest {
    static testMethod void MyTest(){

        List<Student__c> students = new List<Student__c>();
        List<Course__c> courses = new List<Course__c>();
        List<Skill__c> skills = new List<Skill__c>();
        List<Preferences__c> preferenceses = new List<Preferences__c>();
        List<Discipline__c> disciplines = new List<Discipline__c>();
        //---------------------Students-------------------------------------
        //Student - aleksey
        Student__c student = new Student__c(
                Name = 'Aleksey'
        );
        students.add(student);
        insert(student);
        //Student - Igor
        Student__c student1 = new Student__c(
                Name = 'Igor'
        );
        Student__c student2 = new Student__c(
                Name = 'StudentNull'
        );
        students.add(student2);
        insert(student2);

        //---------------------Courses-------------------------------------
        Course__c course = new Course__c(
                Name = 'BackEnd'
        );
        courses.add(course);
        insert(course);
        Course__c course1 = new Course__c(
                Name = 'FrontEnd'
        );
        courses.add(course1);
        insert(course1);
        Course__c course2 = new Course__c(
                Name = 'Language'
        );
        courses.add(course2);
        insert(course2);

        //---------------------Skills-------------------------------------
        Skill__c skill = new Skill__c(
                Name = 'HTML'
        );
        skills.add(skill);
        insert(skill);
        Skill__c skill1 = new Skill__c(
                Name = 'English'
        );
        skills.add(skill1);
        insert(skill1);
        Skill__c skill2 = new Skill__c(
                Name = 'Russian'
        );
        skills.add(skill2);
        insert(skill2);
        Skill__c skill3 = new Skill__c(
                Name = 'Java'
        );
        skills.add(skill3);
        insert(skill3);
        Skill__c skill4 = new Skill__c(
                Name = 'JavaScript'
        );
        skills.add(skill4);
        insert(skill4);

        //---------------------Preferences-------------------------------------
        //Aleksey--English
        Preferences__c preferences = new Preferences__c(
                Student__c = student.Id,
                Skill__c = skill1.Id
        );
        //Aleksey--Java
        preferenceses.add(preferences);
        insert(preferences);
        Preferences__c preferences1 = new Preferences__c(
                Student__c = student.Id,
                Skill__c = skill3.Id
        );
        //Aleksey--JavaScript
        preferenceses.add(preferences1);
        insert(preferences1);
        Preferences__c preferences2 = new Preferences__c(
                Student__c = student.Id,
                Skill__c = skill4.Id
        );
        preferenceses.add(preferences2);
        insert(preferences2);
        //Aleksey--Russian
        Preferences__c preferences3 = new Preferences__c(
                Student__c = student.Id,
                Skill__c = skill2.Id
        );
        preferenceses.add(preferences3);
        insert(preferences3);
        //Igor--English
        Preferences__c preferences4 = new Preferences__c(
                Student__c = student1.Id,
                Skill__c = skill.Id
        );
        preferenceses.add(preferences4);
        insert(preferences4);

        //---------------------Disciplines-------------------------------------

        //BackEnd--Java
        /*Discipline__c discipline = new Discipline__c(
                Course__c = course,
                Skill__c = skill3
        );
        disciplines.add(discipline);
        insert(discipline);*/
        //FrontEnd--HTML
        Discipline__c discipline1 = new Discipline__c(
                Course__c = course1.Id,
                Skill__c = skill.Id
        );
        disciplines.add(discipline1);
        insert(discipline1);
        //FrontEnd--JavaScript
        Discipline__c discipline2 = new Discipline__c(
                Course__c = course1.Id,
                Skill__c = skill4.Id
        );
        disciplines.add(discipline2);
        insert(discipline2);
        //Language--English
        Discipline__c discipline3 = new Discipline__c(
                Course__c = course2.Id,
                Skill__c = skill1.Id
        );
        disciplines.add(discipline3);
        insert(discipline3);
        Discipline__c discipline4 = new Discipline__c(
                Course__c = course2.Id,
                Skill__c = skill2.Id
        );
        disciplines.add(discipline4);
        insert(discipline4);

        Test.startTest();
        Map<String, List<CourseAssignment.recommendedCourse>> resultMap = CourseAssignment.getSuggestedCourses(students);
        Map<String, List<CourseAssignment.recommendedCourse>> resultMapNull = CourseAssignment.getSuggestedCourses(null);

        System.assertEquals(resultMapNull, null);

        for(CourseAssignment.recommendedCourse c : resultMap.get('Aleksey')){
            if( c.course == course1){
                system.assertEquals(c.percentCompliance, 25);
            }
            if( c.course == course2){
                system.assertEquals(c.percentCompliance, 50);
            }
        }
        Test.stopTest();
    }
}