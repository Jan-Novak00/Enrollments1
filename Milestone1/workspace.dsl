workspace "EnrollmentManager workspace" "This workspace documents the architecture of the EnrollmentManager system, a part of a student information system that handles student enrollments." {

    model {
        # software systems
        enrollmentManager = softwareSystem "EnrollmentManager" "Handles student enrollments and unenrollments, setting and checking enrollment conditions and managing waiting lists."  {


            !docs docs
        }

        scheduleModule = softwareSystem "Schedule Module" "Handles course management, scheduling, schedule preferences, viewing schedules and schedule reports." "Existing System"

        studentDatabase = softwareSystem "Student Database" "Stores information about students" "Existing System"

        courseDatabase = softwareSystem "Course Database" "Stores information about courses" "Existing System"

        dashboard = softwareSystem "SIS Dashboard" "Provides a user interface to students, teachers, and study department officers to interact with the Student Information System." "Existing System"

        sso = softwareSystem "Single Sign-On" "Allows users to log in with a single identity to access multiple related software systems." "Existing System"

        # actors
        student = person "Student" "Manages their own course enrollments."
        teacher = person "Teacher" "Manages enrollment conditions for their courses and occasionally student enrollments."
        studyDepartmentOfficer = person "Study Department Officer" "Manages student enrollments in exceptional situations."

        # relationships between users and HealthTracker
        student -> dashboard "Uses dashboard to enroll in and unenroll from courses, view their enrollments and sign up to waiting lists."
        teacher -> dashboard "Uses dashboard to set enrollment conditions for their course and enroll and unenroll students."
        studyDepartmentOfficer -> dashboard "Uses dashboard to enroll and unenroll students in exceptional situations."

        # relationships between external systems and enrollmentManager
        enrollmentManager -> scheduleModule "Makes API calls to read current schedule for a course from"

        enrollmentManager -> studentDatabase "Reads information about students from"

        enrollmentManager -> courseDatabase "Reads information about courses from"

        dashboard -> enrollmentManager "Manages enrollments on behalf of users using"

        enrollmentManager -> sso "Verifies users' identities."
    }

    views {

        systemContext enrollmentManager "enrollmentManagerSystemContextDiagram" {
            include *
            include student
            include teacher
            include studyDepartmentOfficer
        }

        theme default

        styles {
            element "Existing System" {
                background #999999
                color #ffffff
            }
        }
    }
}