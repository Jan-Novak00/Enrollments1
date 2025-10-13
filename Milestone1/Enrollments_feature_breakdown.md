# Core features and responsibilities
## Feature: Enrolling in lectures and practicals

As a student, I need to be able to enroll myself to a specific lecture and practical so I can join the course.

### Feature breakdown

1. The student enters their login information into the student information system.
2. The system verifies the login.
3. Steps 1 and 2 are repeated until the login is correct.
4. The system shows the student all the available features.
5. The student selects the option to enroll into a new course.
6. The student types the name of the course they want to enroll in.
7. The system contacts the database that stores the available information about courses.
8. The system asks the database for courses matching the typed name.
9. These courses are displayed to the student.
10. The student selects the course they want to enroll in.
11. The system fetches the available tickets for the lectures and/or practicals.
12. The system displays these tickets to the student.
13. The student selects the lecture and/or practical they want to attend.
14. The system tries to increase the number of enrolled students for the particular lecture and/or practical by one.
15. If the capacity was full:
    * a) The system gets the student's unique identifier from
    their profile.
    * b) The system uses this identifier to add the student onto the waiting list for the lecture and/or practical.
    * c) The student is signed up to a mailing list that will inform them should they get into the lecture and/or practical.
    * d) A message informing about the failed enrollment in the course and the student's position on the waiting list is displayed.
16. If the number of attending students was successfuly raised by one:
    * a) The system adds the student to the list of enrolled students in the lecture and/or practical.
    * b) The system adds the course to the student's list of courses.
    * c) The system adds the specific lecture and/or practical to the student's schedule.
    * d) A message informing about the successful enrollment is displayed.

### Responsibilities

##### Authentication responsibilities
* Use SSO to allow students to log in
* Only allow authenticated students to enroll in courses

##### Presentation responsibilities
* Display available system features
* Change displayed UI based on user input
* Display option to search for a course
* Display a list of courses with a specific name to a student
* Display available lecture and practical tickets to a student
* Display a message to a student

##### Input handling responsibilities
* Handle user selection of different UI elements
* Allow user to type into a search box
* Extract input from search box
* Handle user selection of an item in a list
* Allow selecting one lecture and one practical from a list of all available tickets

##### Data search responsibilities
* Contact database storing information about courses
* Perform a search query for a course with a specific name
* End connection with a database

##### Data fetching responsibilities
* Fetch a list of courses matching a search query
* Fetch all available tickets for a course

##### Manipulating course attendance responsibilities
* Acquire an exclusive write lock for a specific lecture or practical while manipulating it
* Check whether a specific lecture or practical has free space for one more attendee
* Increase the number of attending students in a lecture or pracitcal by one
* Free a write lock on a specific lecture or practical
* Add a student to a list of signed up students for a lecture and/or practical

##### Profile management responsibilities
* Get a student's unique identifier from their profile

##### Waiting list responsibilities
* Add a student to the end of a waiting queue for a lecture or practical by their identifier
* Get a student's position in a waiting list
* Automatically sign up the first student in a waiting list to the ticket they're waiting for when there is free space

##### Mailing responsibilities
* Sign up a student to a mailing list to get informed about being signed up for a course

##### Student course management responsibilities
* Add a new course to the student's list of courses
* Raise the number of student's potential credits for a semester by a specific amount

##### Schedule manipulation responsibilities
* Add a ticket to a student's schedule

## Feature: Student enrolment cancellation
As a student, I need to be able to cancel my enrolment to lecture and practical so I can change my mind about my study.

### Feature breakdown
1. A student opens their dashboard and selects schedule.
2. The system displays the student schedule.
3. The student selects the lecture or practical, for which they wish to cancel their enrolment.
4. The system fetches selected item details.
5. The system displays the fetched item details.
6. The student clicks on enrollment cancellation button.
7. The system shows confirmation message over the item detail, if the student really want to cancel their enrolment.
8. The student confirms the cancellation process (or decline it and than the systems dismiss the confirmation message).
9. The system checks if the student is allowed to cancel their enrolment.
10. The system records the cancellation (if it has been allowed).
11. The system displays student's schedule along with message if enrolment cancellation succeed (if not the message contains error message).

### Responsibilities

##### Displaying responsibilities
- display student dashboard (call API of main module)
- display student schedule (call API of schedule module)
- display lecture or practical detail (contains cancel enrollment button for lecture or practical to which the student is enrolled)
- display enrolment cancellation confirmation message
- display success message about enrolment cancellation
- display error message about enrolment cancellation

##### Data handling responsibilities
- fetch data for concrete lecture or practical (call API of schedule module)
- propagete information about student enrolment cancallation (update database)

## Feature: Student Enrollment Management
As a study department officer, I need to be able to enroll and unenroll students from a course so that I can handle eligible student's individual needs.

### Feature breakdown
1. Study department officer open their dashboard and select option to enroll or to unenroll a student into/from a course.
2. The system fetches data about students from the database.
3. The system displays a list of students.
4. Study department officer looks up the student in the list and selects them.
5. The system fetches data about the student from the database.
6. The system displays the student information, including a list of enrolled courses.
7. If study department officer wants to add the student into the course:
    a. Study department officer selects an option "Enroll student to a course"
    b. The system shows a form for entrollment.
    c. Study department officer searches for the course and selects it.
    d. The system fetches and diplays data about lectures and practicals of the given course.
    e. Study department officer selects desired lecture and practical and confirms the selection.
    f. The system updates the database.
    g. The system notifies the student about the change through the communication channel
8. If study department officer wants to unenroll the student from the course:
    a. Study department officer selects the given course from the list.
    b. The system shows an option to unenroll the student.
    c. Study department officer selects the option to unenetroll the student.
    d. The system updates the database.
    e. The system notifies the student about the change through the communication channel


### Responsibilities

##### Display responsibilities
- display study department dashboard
- display list of students
- display student information
- display list of courses a given student is enrolled to
- display option "Enroll student to a course"
- display enrollment form
- display available course lectures and practicals
- display option to unenroll the course

#### Data handling responsibilities
- fetch and cache data about the student from the database
- fetch and cache a list of students in the database
- fetch and cache a list of available courses in the database
- store data about unenrollment for a given student
- store data about new enrollment for a given student
- fetch and cache the data about a course

#### Data search resposibilities
- search in the list of students
- search int the list of courses

#### Notification responsibilities
- notify student through the communication channel about the enrollment
- notify student through the communication channel about the unenrollment

## Feature: Teacher sets enrolment conditions for a course

As a teacher, I need to be able to set the enrolment conditions to my course so I can specify the subset of students for which the course is aimed at.

### Feature breakdown
1. The teacher opens their dashboard and selects the course they want to manage.
2. The system fetches course data and current enrolment conditions.
3. The system displays condition editor UI with existing conditions and available condition types (e.g. required completed courses, minimum year of study, study programme, study form, credits, student groups, enrolment period, allowed/blocked student lists).
4. The teacher selects one or more condition types to add and fills in the required parameters.
5. The system validates the entered conditions (dates, numeric ranges, references).
6. The system displays preview results and summary (number matching, number excluded, common exclusion reasons).
7. The teacher saves the new conditions.
8. The system persists the conditions and activates them for future enrolments.
9. The system enforces these conditions during enrolment attempts and provides clear reason codes when students do not meet conditions.

#### Displaying responsibilities
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

#### Data handling responsibilities
- fetch current enrolment conditions
- fetch available condition types and parameter metadata
- fetch student attributes for preview/evaluation

#### Condition validation and enforcement responsibilities
- validate condition input (dates, numeric ranges, course refs, etc.)
- evaluate whether a student satisfies a single condition
- combine multiple conditions
- enforce conditions on enrollment

#### Authorization responsibilities
- ensure only authorized teachers can view/edit their course conditions
- allow study officers to override or edit if permitted

#### Performance & privacy responsibilities
- fetch only required student attributes
- enforce data privacy (only authorized users see student details)
