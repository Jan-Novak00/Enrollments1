workspace "EnrollmentManager workspace" "This workspace documents the architecture of the EnrollmentManager system, a part of a student information system that handles student enrollments." {

    model {
        # software systems
        enrollmentManager = softwareSystem "Enrollment Manager" "Handles student enrollments and unenrollments, setting and checking enrollment conditions and managing waiting lists."  {
            
            notificationService = container "Notification Service" "Notifies users about changes in their schedule."
            waitingListManager = container "Waiting List Manager" "Manages waiting list - adds new students, removes expired waiting students, pops students when they can enroll. Updates waiting lists."
            ticketManager = container "Ticket Manager" "Manages course tickets."
            enrollmentAPI = container "Enrollment API" "API for enrollment and unenrollment."
            conditionsManager = container "Conditions Manager" "Allows setting and removing enrollment conditions."
            conditionsChecker = container "Conditions Checker" "Checks conditions."
            statisticsEngine = container "Statistics Engine" "Calculates course statistics."

            authenticator = container "Authenticator" "Authenticates the user."
            userDatabase = container "User database" "Contains information about all users." {
                tags "Database"
            }

            sisMessenger = container "SIS Messenger" "Allows viewing messages in SIS." {
                tags "Front end"
            }
            
            enrollmentPresenter = container "Enrollment Presenter" "Presents enrollment/unenrollment options" {
                tags "Front end"
            }
            coursePresenter = container "Course Presenter" "Presents course info." {
                tags "Front end"
            }

            statisticsPresenter = container "Statistics Presenter" "Presents course statistics" {
                tags "Front end"
            }

            conditionsPresenter = container "Conditions Presenter" "Presents conditions options" {
                tags "Front end"
            }
            studentPresenter = container "Student Information Presenter" "Presents information about student" {
                tags "Front end"
            }


        }

        scheduleModule = softwareSystem "Schedule Module" "Handles course management, scheduling, schedule preferences, viewing schedules and schedule reports." "Existing System"

        studentDatabase = softwareSystem "Student Database" "Stores information about students" "Existing System, Database"

        courseDatabase = softwareSystem "Course Database" "Stores information about courses" "Existing System, Database"

        dashboard = softwareSystem "SIS Dashboard" "Provides a user interface to students, teachers, and study department officers to interact with the Student Information System." "Existing System"

        sso = softwareSystem "Single Sign-On" "Allows users to log in with a single identity to access multiple related software systems." "Existing System"


        # actors
        student = person "Student" "Manages their own course enrollments."
        teacher = person "Teacher" "Manages enrollment conditions for their courses and occasionally student enrollments."
        studyDepartmentOfficer = person "Study Department Officer" "Manages student enrollments in exceptional situations."
        maneger = person "Maneger" "Manages courses."

        # relationships between users and HealthTracker
        student -> dashboard "Uses dashboard to enroll in and unenroll from courses, view their enrollments and sign up to waiting lists."
        teacher -> dashboard "Uses dashboard to set enrollment conditions for their course and enroll and unenroll students."
        studyDepartmentOfficer -> dashboard "Uses dashboard to enroll and unenroll students in exceptional situations."

        # relationships between external systems and enrollmentManager
        enrollmentManager -> scheduleModule "Makes API calls to read current schedule for a course from"

        enrollmentManager -> studentDatabase "Reads information about students from"

        enrollmentManager -> courseDatabase "Reads information about courses from"

        dashboard -> enrollmentManager "Manages enrollments on behalf of users using"

        sso -> enrollmentManager  "Verifies users' identities."

        maneger -> enrollmentManager "Maneges available courses."

        
        
        
        # Container relationships
        
        waitingListManager -> notificationService "Triggeres notificiation when waiting status changes."
        waitingListManager -> ticketManager "Requests student enrollment."
        waitingListManager -> courseDatabase "Updates waiting list."

        ticketManager -> courseDatabase "Updates enrolled student list."
        ticketManager -> studentDatabase "Updates schedule."
        
        enrollmentAPI -> ticketManager "Adds or removes tickets."
        enrollmentAPI -> conditionsChecker "Requests enrollment check."
        enrollmentAPI -> waitingListManager "Sets waiting list."
        
        conditionsChecker -> enrollmentAPI "Returns result of the check."
        conditionsChecker -> studentDatabase "Views student data."
        conditionsChecker -> courseDatabase "Views conditions."
        conditionsManager -> courseDatabase "Sets/removes conditions."
        

        authenticator -> userDatabase "Fetches authentication data."
        student -> authenticator "Requests authentication"
        teacher -> authenticator "Requests authentication"
        authenticator -> sso "Authenticates user"

        notificationService -> sisMessenger "Updates messages"
        student -> sisMessenger "Views messages"
        teacher -> sisMessenger "Views messages"

        enrollmentPresenter -> enrollmentAPI "Requests changes in enrollment."
        student -> enrollmentPresenter "Enrolls (unenrolls) to (from) the course."
        teacher -> enrollmentPresenter "Enrolls (unenrolls) student to (from) the course."
        studyDepartmentOfficer -> enrollmentPresenter "Enrolls (unenrolls) student to (from) the course."
        
        statisticsEngine -> courseDatabase "Calculates statistics."
        statisticsPresenter -> statisticsEngine "Requests statistics."
        maneger -> statisticsPresenter "Views statistics."
        

        conditionsPresenter -> conditionsManager "Requests conditions and changes them."
        teacher -> conditionsPresenter "Sets/views conditions."
        studyDepartmentOfficer -> conditionsPresenter "Views conditions."

        teacher -> studentPresenter "Views student info."
        studyDepartmentOfficer -> studentPresenter "Views student info."
        studentPresenter -> studentDatabase "Fetches data from the database."

        student -> coursePresenter "Views available courses and their info."
        coursePresenter -> courseDatabase "Requests course data."

        
    }

    views {

        systemContext enrollmentManager "enrollmentManagerSystemContextDiagram" {
            include enrollmentManager
            include scheduleModule
            include studentDatabase
            include courseDatabase
            include dashboard
            include sso
            include student
            include teacher
            include studyDepartmentOfficer
            include maneger
        }
        container enrollmentManager "enrollmentManagerContainerDiagram" {
            include *
            
        }
        

        theme default

        styles {
            element "Existing System" {
                background #999999
                color #ffffff
            }
            element "Database" {
                shape cylinder
            }
            element "Front end" {
                shape webBrowser
            }
        }
    }
}