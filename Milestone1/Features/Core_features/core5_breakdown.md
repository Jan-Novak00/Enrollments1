### Feature: Student Enrollment Management
As a study department officer, I need to be able to enroll and unenroll students from a course so that I can handle eligible student's individual needs.

#### Feature breakdown
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


#### Responsibilities

##### Display responsibilities
- display study department dashboard
- display list of students
- display student information
- display list of courses a given student is enrolled to
- display option "Enroll student to a course"
- display enrollment form
- display available course lectures and practicals
- display option to unenroll the course

##### Data handling responsibilities
- fetch and cache data about the student from the database
- fetch and cache a list of students in the database
- fetch and cache a list of available courses in the database
- store data about unenrollment for a given student
- store data about new enrollment for a given student
- fetch and cache the data about a course

##### Data search resposibilities
- search in the list of students
- search int the list of courses

##### Notification responsibilities
- notify student through the communication channel about the enrollment
- notify student through the communication channel about the unenrollment
