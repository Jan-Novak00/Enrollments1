### Feature: Enrolling in lectures and practicals

As a student, I need to be able to enroll myself to a specific lecture and practical so I can join the course.

#### Feature breakdown

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
    * e) The system shows student the option to set maximum waiting time.
    * f) The system dequeues first student in the waiting list, if any student unenrolls from the course.
    * g) If the student is dequeued from the waiting list in time:
         - The system informs the student of being signed in to the lecture/practical.
         - Continue form the step 16.
16. If the number of attending students was successfuly raised by one:
    * a) The system adds the student to the list of enrolled students in the lecture and/or practical.
    * b) The system adds the course to the student's list of courses.
    * c) The system adds the specific lecture and/or practical to the student's schedule.
    * d) A message informing about the successful enrollment is displayed.

#### Responsibilities

##### Authentication responsibilities
* Use SSO to allow students to log in
* Only allow authenticated students to enroll in courses

##### Presentation responsibilities
* Display available system features
* Change displayed UI based on user input
* Display option to search for a course
* Display a list of courses with a specific name to a student
* Display available lecture and practical tickets to a student
* Display the capacity of a given ticket
* Display a message to a student
* Display waiting list information (position in the waiting list and maximum waiting time)
* Display maximum waiting time option

##### Input handling responsibilities
* Handle user selection of different UI elements
* Allow user to type into a search box
* Extract input from search box
* Handle user selection of an item in a list
* Allow selecting one lecture and one practical from a list of all available tickets
* Allow user to set maximum waiting time

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
* Set maximum waiting time to each student in the waiting list
* Get a student's position in a waiting list
* Dequeue student from top of the list waiting list, if any student unenrolls from the ticket
* Update waiting list when someone leaves the list
* Eliminate students from the waiting list if they have exceeded maximum waiting time
* Automatically sign up the first student in a waiting list to the ticket they're waiting for when there is free space

##### Mailing responsibilities
* Sign up a student to a mailing list to get informed about being signed up for a course

##### Student course management responsibilities
* Add a new course to the student's list of courses
* Raise the number of student's potential credits for a semester by a specific amount

##### Schedule manipulation responsibilities
* Add a ticket to a student's schedule

#### Enrollment verification responsibilities
* Verify, that the student is not yet signed in to the course
* Verify, that the student is allowed to enroll based on prerequisities or study status
