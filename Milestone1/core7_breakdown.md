### Feature: Teacher sets enrolment conditions for a course

As a teacher, I need to be able to set the enrolment conditions to my course so I can specify the subset of students for which the course is aimed at.

#### Feature breakdown
1. Teacher opens their dashboard and selects the course they want to manage.  
2. System fetches course data and current enrolment conditions.  
3. System displays condition editor UI with existing conditions and available condition types (e.g. required completed courses, minimum year of study, study programme, study form, credits, student groups, enrolment period, allowed/blocked student lists).  
4. Teacher selects one or more condition types to add and fills in the required parameters.  
5. System validates the entered conditions (dates, numeric ranges, references).  
6. System displays preview results and summary (number matching, number excluded, common exclusion reasons).  
7. Teacher saves the new conditions.  
8. System persists the conditions and activates them for future enrolments.   
9. System enforces these conditions during enrolment attempts and provides clear reason codes when students do not meet conditions.

##### Displaying responsibilities
- display teacher dashboard  
- display list of teacher’s courses and course management options  
- display enrolment conditions option  
- display condition editor UI with:
  - existing conditions
  - available condition types and explanations
  - forms for each condition type
  - preview button and results section
  - exception management (allow/block students)
  - save/cancel actions  
- display validation errors and guidance   
- display confirmation after saving conditions  

##### Data handling responsibilities
- fetch current enrolment conditions  
- fetch available condition types and parameter metadata  
- fetch student attributes for preview/evaluation    

##### Condition validation and enforcement responsibilities
- validate condition input (dates, numeric ranges, course refs, etc.)  
- evaluate whether a student satisfies a single condition  
- combine multiple conditions  
- enforce conditions on enrollment  

##### Authorization responsibilities
- ensure only authorized teachers can view/edit their course conditions  
- allow study officers to override or edit if permitted  

##### Performance & privacy responsibilities
- fetch only required student attributes   
- enforce data privacy (only authorized users see student details)