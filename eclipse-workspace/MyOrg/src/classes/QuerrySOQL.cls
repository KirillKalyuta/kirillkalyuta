public class QuerrySOQL {
	    /*SELECT Contact__r.Name, Skill_for_SOQL__r.Name, Level__c FROM Skill_Assignment__c 
		WHERE Skill_for_SOQL__r.Name = 'English' 
		AND Level__c IN ('Medium','High','Expert')*/
    
      /*SELECT Departament__r.Name, AVG(Salary__c) 
        FROM Contact WHERE Departament__r.Name != null 
	GROUP BY Departament__r.Name HAVING AVG(Salary__c)<800*/
    
    /*SELECT Departament__r.Name, AVG(Salary__c) FROM Contact 
        WHERE Departament__r.Name != null 
        GROUP BY Departament__r.Name ORDER BY AVG(Salary__c) DESC LIMIT 1*/
    
    /*SELECT Name From Contact WHERE Name LIKE 'a%'*/
    
    /*SELECT Skill_for_SOQL__r.Name,COUNT(Id) From Skill_Assignment__c 
      GROUP BY Skill_for_SOQL__r.Name ORDER BY COUNT(Id) DESC LIMIT 3*/
}