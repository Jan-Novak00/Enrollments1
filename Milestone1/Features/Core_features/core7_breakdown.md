### Feature: Teacher sets enrolment conditions for a course

As a teacher, I need to be able to set the enrolment conditions to my course so I can specify the subset of students for which the course is aimed at.

#### Feature breakdown
1. The teacher enters their login information into the student information system.
2. The system verifies the login. 
3. Steps 1 and 2 are repeated until the login is correct. 
4. The teacher dashboard is shown to the teacher.
5. The teacher selects the option to manage their courses.
6. The system gets a teacher's unique identificator from their profile.
7. The system fetches a list of all the courses that this teacher teaches using their identificator.
8. The system displays a list of these courses to the teacher.
9. The teacher selects the course they want to manage.
10. The system fetches course data.
11. The system displays course data and managmenet options along with the option to edit the course conditons.
12. The teacher selects the option to edit the course's conditions.
13. The system fetches current enrollment conditions for this course. 
14. The system displays condition editor UI with existing conditions, options to add or remove conditions and an option to return back to the general course management page.
15. If the teacher chooses to add a condition:
  * a) The system fetches available condition types (e.g. required completed courses, minimum year of study, study programme, study form, credits, student groups, enrollment period, allowed/blocked student lists).
  * b) The list of possible conditions is shown to the teacher.
  * c) The teacher selects one or more condition types to add and fills in the required parameters.
  * d) The system validates the entered conditions (dates, numeric ranges, references).
  * e) In case of failed validation, a message is displayed to the teacher.
  * f) The system fetches relevant data about students for summary purposes.
  * g) The system calculates preview results and summary (number matching, number excluded, common exclusion reasons).
  * h) The system displays these results. 
  * i) The teacher saves the new conditions.
  * j) The system persists the new conditions for this course.
  * k) The system displays a message about the successful change.
  * l) The new conditions are activated for any future enrollment attempts. The system enforces these conditions and provides clear reason codes when students do not meet them.
16. If the teacher choose to remove a condition:
  * a) The list of all current conditions is displayed to the teacher.
  * b) The teacher picks which conditions they want to remove.
  * c) The system asks for confirmation about removing each condition.
  * d) If not confirmed, the following steps are ignored.
  * e) The database holding the current conditions for this course is updated, removing these conditions.
  * f) During future enrollment attempts, these conditions will no longer be enforced.
17. The system fetches the updated list of current conditions.
18. The condition editor is shown again with the updated list of conditions.

##### Displaying responsibilities
- display teacher dashboard  
- display a list of one teacher's courses 
- display course data
- display course management options with the option to change enrollment conditions
- display condition editor UI with:
  - existing conditions
  - options to add new conditions
  - options to remove existing conditions
  - return option
- display a list of available condition types and explanations
- display a form for a condition type
- display preview results and summary for a course's conditions 
- display validation errors and guidance   
- display save/cancel actions 
- display confirmation after saving conditions
- display an ask for confirmation of deleting a condition

##### Data fetching responsibilities
- fetch a list of one teacher's courses
- fetch course data for one course
- fetch current enrollment conditions for a course 
- fetch available condition types and parameter metadata  
- fetch student attributes for preview/evaluation    

##### Data storing responsibilities
- persist new conditions added to a course
- remove stored conditions

##### Condition editing responsibilites
- allow the selection of a condition to add
- gather data from the form for adding a condition
- validate condition input (dates, numeric ranges, course refs, etc.)
- allow the selection of which conditions to remove
- ask for confirmation before removing a condition

##### Condition evaluation responsibilities
- evaluate whether a student satisfies a single condition  
- combine multiple conditions  
- calculate the number of students satisfying a course's conditions
- calculate the number of students being excluded by a coure's conditions
- gather the most common reasons for students not meeting a course's conditions

##### Condition enforcement responsibilities
- enforce conditions on enrollment
- only enforce current conditions

##### Profile management responsibilities
- get a teacher's unique identifier from their profile

##### Authentication responsibilities
- use SSO to allow teachers to log in

##### Authorization responsibilities
- ensure only authorized teachers can view/edit their course conditions  
- allow study officers to override or edit if permitted  

##### Performance & privacy responsibilities
- fetch only required student attributes   
- enforce data privacy (only authorized users see student details)