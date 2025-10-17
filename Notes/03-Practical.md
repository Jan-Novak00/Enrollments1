# Practical 3
## Architecture Decomposition
- Business sub-domains:
    - *enrollment*
        - Change displayed UI based on click "zapsat"
        - rozdělit do dvou:
            - Direct enrollment
            - enrollment Condition setter
    - *Communication platform*
        - Sign up a student to a mailing list to get informed about being signed up for a course
        - notify student through the communication channel about the enrollment
        - notify student through the communication channel about the unenrollment

- Dependency
    - basic presentation:
        - Display available system features

- Technical layers:
    1. *Presentation*
        - *Sis messenger*
        - Display a message to a student
            - display enrollment cancellation confirmation message
            - display success message about enrollment cancellation
            - display error message about enrollment cancellation
            - display enrollment success message
            - display enrollment failure message
            - display validation errors and guidance
            - display confirmation after saving conditions
            - TODO + probably some features from bussiness layer
        - *Dashboard presenter*
        - display dashboard
            - study department officer
            - teacher
            - student
            - display enrollment conditions option (set the conditions) <- this open the UI
                - teacher and study department officer
            - display option "Enroll student to a course"
            - Display option to search for a course
            - TODO + probably some features from bussiness layer (so it will be named manager)
        - *Courses enrolment presenter*
        - Display available lecture and practical tickets to a student
            - je to naše, protože přednostní zápis
            - display lecture or practical detail (contains cancel enrollment button for lecture or practical to which the student is enrolled)
            - Display list of courses
                - student is enrolled to
                - with a specific name to a student
                - one teacher’s courses
            - Display a list of courses
            - display enrollment form
            - TODO + probably some features from bussiness layer (so it will be named manager)
        - *Student information presenter*
            - display student schedule (call API of schedule module)
            - display list of students
            - display student information
        - *Enrolment Condition manager*
        - display condition editor UI for course enrollment with:
            - existing conditions
            - available condition types and explanations
            - forms for each condition type
            - preview button and results section
            - exception management (allow/block students)
            - save/cancel actions
    2. *Business*
        -Handle user selection of different UI elements????
        Conditions manager
            validate condition input (dates, numeric ranges, course refs)
            evaluate whether a student satisfies the conditions
            combine multiple conditions
            enforce conditions on enrollment
        Cancellation
            check, if student can cancel enrollment (e.g. passed the date to which studnet can cancel enrollment by its own)
            allow to set cancel enrollment conditions for students (by study department officer)
            allow student to see cancel enrolement conditions
        Waitlist manager
            Add a student to the end of a waiting queue for a lecture or practical by their identifier
            Automatically sign up the first student in a waiting list to the ticket they're waiting for when there is free space
        Enrollment manager
            Allow selecting one lecture and one practical from a list of all available tickets
            Check whether a specific lecture or practical has free space for one more attendee
            Increase the number of attending students in a lecture or pracitcal by one
            Add a student to a list of signed up students for a lecture and/or practical
            Raise the number of the student’s potential credits for a semester. 
            Add a new course to the student’s list of courses.
    
        Notification Service
            notify student through the communication channel about the enrollment
            notify student through the communication channel about the unenrollment
            Sign up a student to a mailing list to get informed about being signed up for a course
        Access Control & Privacy
            enforce data privacy (only authorized users see student details)
            ensure only authorized teachers can view/edit their course conditions

    
    3. *Persistance*
        Enrollment:
        - *Authenticator* 
            - Use SSO to allow students to log in
            - Only allow authenticated students to enroll in courses

        - *Course information manager*
            - Fetch a list of available courses
            - Fetch a list of courses matching a search query
            - Fetch data about a course
            - Fetch current enrollment conditions for a course
            - Fetch all available tickets for a course
            - Change the list of enrolled students

        - *Student information manager*
            - Fetch a list of all students
            - Fetch a list of students matching a search query
            - Store data about unenrollment from a course for a given student
            - Store data about a new enrollment in a course for a given student
            - Fetch data about a student
 
        - *Cache*
            - Cache a list of available couses
            - Cache a list of students
            - Cache data about a course
            - Cache data about a student

        - *Ticket manager*
            - Fetch data for concrete lecture or practical (call API of schedule module)
            - Get a student's position in a waiting list for a specific lecture or practicle

        Enrollment condition editor:
        - *Enrollment condition manager*
            - Fetch available condition types and parameter metadata
