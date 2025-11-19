workspace "EnrollmentManager workspace" "This workspace documents the architecture of the EnrollmentManager system, a part of a student information system that handles student enrollments." {

    model {
        # software systems
        enrollmentManager = softwareSystem "Enrollment Manager" "Handles student enrollments and unenrollments, setting and checking enrollment conditions and managing waiting lists."  {

            notificationService = container "Notification Service" "Notifies users about changes in their schedule."
            enrollmentAPI = container "Enrollment API" "API for ticket managment. Manages enrollment, unenrollment and waiting lists."
            conditionsManager = container "Conditions Manager" "Allows setting and removing enrollment conditions."
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
        #student -> dashboard "Uses dashboard to enroll in and unenroll from courses, view their enrollments and sign up to waiting lists."
        #teacher -> dashboard "Uses dashboard to set enrollment conditions for their course and enroll and unenroll students."
        #studyDepartmentOfficer -> dashboard "Uses dashboard to enroll and unenroll students in exceptional situations."

        # relationships between external systems and enrollmentManager
        enrollmentManager -> scheduleModule "Makes API calls to read current schedule for a course from"

        enrollmentManager -> studentDatabase "Reads information about students from"

        enrollmentManager -> courseDatabase "Reads information about courses from"

        dashboard -> enrollmentManager "Manages enrollments on behalf of users using"

        sso -> enrollmentManager  "Verifies users' identities."

        maneger -> enrollmentManager "Maneges available courses."




        # Container relationships

        enrollmentAPI -> notificationService "Triggeres notificiation when waiting status changes."
        enrollmentAPI -> courseDatabase "Updates waiting list."

        enrollmentAPI -> courseDatabase "Updates enrolled student list."
        enrollmentAPI -> studentDatabase "Updates schedule."

        enrollmentAPI -> studentDatabase "Views student data."
        enrollmentAPI -> courseDatabase "Views conditions."

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

        dashboard -> coursePresenter "Delivers to the user's web browser."
        dashboard -> studentPresenter "Delivers to the user's web browser."
        dashboard -> conditionsPresenter "Delivers to the user's web browser."
        dashboard -> enrollmentPresenter "Delivers to the user's web browser."


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

        dynamic EnrollmentManager {
            title "Core feature 1: Student enrolls himself in a course"
            description "The student meets all course conditions and the course capacity has not yet been filled."
            student -> enrollmentPresenter "Requests enrollment in a course"
            enrollmentPresenter -> enrollmentAPI "Requests the student enrollment in the course"
            enrollmentAPI -> courseDatabase "Fetches the course enrollment conditions"
            enrollmentAPI -> courseDatabase "Updates enrolled student list"
            enrollmentAPI -> studentDatabase "Adds the course in the student's course list"
            enrollmentAPI -> notificationService "Triggers notification about the student successful enrollment into the course"
            notificationService -> sisMessenger "Requests to show enrollment success message to the student"
            autoLayout lr
        }

        dynamic EnrollmentManager {
            title "Core feature 2: Student cancels own enrollment in a course"
            description "The student requests course enrollment cancellation for a course, which enrollment cancellation conditions has been met."
            student -> enrollmentPresenter "Requests enrollment course cancellation"
            enrollmentPresenter -> enrollmentAPI "Requests the student enrollment course cancellation"
            enrollmentAPI -> notificationService "Requests confirmation message about course enrollment cancellation"
            notificationService -> sisMessenger "Requests to show confirmation message about course enrollment cancellation message to the student"
            student -> enrollmentPresenter "Confirms enrollment course cancellation"
            enrollmentPresenter -> enrollmentAPI "Confirms the student enrollment course cancellation"
            enrollmentAPI -> courseDatabase "Fetches the course enrollment cancellation conditions"
            enrollmentAPI -> courseDatabase "Updates enrolled student list"
            enrollmentAPI -> studentDatabase "Remove the course from the student's course list"
            enrollmentAPI -> notificationService "Triggers notification about the student successful course enrollment cancellation"
            notificationService -> sisMessenger "Requests to show course enrollment cancellation success message to the student"
            autoLayout lr
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
