public class CourseAssignment {
    
    public static Map<String, List<recommendedCourse>> getSuggestedCourses (List<Student__c> students) {
        if(students != null){
        Set<String> stdName = new Set<String>();
        for (Student__c std: students){
            stdName.add(std.Name);
        }
        List<Preferences__c> stSkills = [SELECT Student__r.Name, Skill__r.Name FROM Preferences__c];
        	System.debug('список предпочтений: ' + stSkills);
        List<Discipline__c> crSkills = [SELECT Course__r.Name, Skill__r.Name FROM Discipline__c];
            System.debug('список дисциплин : ' + crSkills);
            // объявляем map студенты и его скилы
        Map<String, List<String>> stSkillMap = new Map<String, List<String>>();
        Map<Course__c, List<String>> crSkillMap = new Map<Course__c, List<String>>();
        Map<String, List<recommendedCourse>> result = new Map<String, List<recommendedCourse>>();
        
        // create Map Student: List<Skills>
        for (Preferences__c st: stSkills) {
            if(stSkillMap.containsKey(st.Student__r.Name)){
                List<String> skName = stSkillMap.get(st.Student__r.Name);
                System.debug('Текущий список предрочтений у '+ st.Student__r.Name +' : ' + skName);
                skName.add(st.Skill__r.Name);
                System.debug('Дополнение списка предпочтений у '+ st.Student__r.Name +' : ' + skName);
                stSkillMap.put(st.Student__r.Name, skName);
                System.debug('Map студента и всех его предпочтений '+ st.Student__r.Name +' : ' + skName);
            } else {
                stSkillMap.put(st.Student__r.Name, new List<String> {st.Skill__r.Name});
                System.debug('Текущая map студентов ипредпочтений : ' + stSkillMap);
            }
        }
            System.debug('map студентов и его скилов: ' + stSkillMap);
        // create Map Course: List<Skills>
        for (Discipline__c cr: crSkills) {
            Course__c courseName = new Course__c(Name = cr.Course__r.Name);
            if(crSkillMap.containsKey(courseName)){
                List<String> crName = crSkillMap.get(courseName);
                System.debug('Текущий список скиллов у '+ cr.Course__r.Name +' : ' + crName);                
                crName.add(cr.Skill__r.Name);
                System.debug('Дополнение списока скиллов у '+ cr.Course__r.Name +' : '  + crName);
                crSkillMap.put(courseName, crName);
                System.debug('Map курса и всех скилов '+ cr.Course__r.Name +' : '  + crSkillMap);
            } else {
                crSkillMap.put(courseName, new List<String> {cr.Skill__r.Name});
                System.debug('Текущая map курсов и скилов курса : ' + crSkillMap);
            }            
        }
            System.debug('map всех курсов и всех его скилов: ' + crSkillMap);
        //Проход по Map(студент--скилы студента)
        for (String name: stSkillMap.keySet()) {
            List<String> stSkillList = stSkillMap.get(name); 
            System.debug('Список предпочтений студента  : ' + stSkillList);
            Integer size = stSkillList.size();
            System.debug('Количество предпочтений у студента : ' + size);
            List<recommendedCourse> reCourse = new List<recommendedCourse>();
            System.debug('Инициализация переменной reCourse : ' + reCourse);
            //Проход по Map(курс--скилы курса)
            for (Course__c course: crSkillMap.keySet()){
                List<String> crSkillList = crSkillMap.get(course);
                System.debug('Лист курсов и скилов курса : ' + crSkillList);
                Integer count = 0;
                //проход по скилам судента
                for (String ss: stSkillList){
                	//содержится ли скилл в курсе
                    if(crSkillList.contains(ss)){
                        count++;
                        System.debug('В '+ course.Name +' содержится скилл : ' + ss);
                        continue;
                    } 
                    System.debug('В '+ course.Name +' не содержится скилл : ' + ss);
                }
                Integer percent = count * 100 / size;
                System.debug(name + '  ' + course + '  ' + percent);
                reCourse.add(new recommendedCourse(course, percent));
                System.debug('Для '+ name +' процент соответсвия '+ course.Name +' - '+ percent +'');
            }
            result.put(name, reCourse);
            System.debug('Для '+ name +' процент соответсвия всех курсов' + reCourse);
        }    
        System.debug('Процент соответствия для всех студентов' + result);
        return result;
        }
        return NULL;
        
    }
    
   public class recommendedCourse {
      public Integer percentCompliance;
      public Course__c course;
     
      public recommendedCourse(Course__c course, Integer compliance) {
          this.course = course;
          this.percentCompliance = compliance;
      }
   }
}