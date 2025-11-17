workspace "EnrollmentManager workspace" "This workspace documents the architecture of the EnrollmentManager system, a part of a student information system that handles student enrollments." {

    model {
        # software systems
        enrollmentSystem = softwareSystem "Enrollment System" "Handles student enrollments and unenrollments, setting and checking enrollment conditions and managing waiting lists."  {
            
            notificationService = container "Notification Service" "Notifies users about changes in their schedule." {
                templateEngine = component "Template Engine"
                channelDispatcher = component "Channel Dispatcher"
                mailingListManager = component "Mailing List Manager"
                notificationDatabase = component "Notification Database" "Notification view on student database."{
                    tags "Database"
                }
                
            }
            
            enrollmentManager = container "Enrollment Manager" "Conteiner for ticket managment. Manages enrollment, unenrollment and waiting lists." {
               
                enrollmentAPI = component "Enrollment API" "Handles requests for enrollment/unenrollment"
                ticketCapacityHandler = component "Ticket Capacity Handler"
                ticketStore = component "Ticket Store Adapter"¨
                enrollmentWriter = component "Enrollment Writer"
                scheduleWriter = component "Schedule Writer"

                waitQueue = component "Wait Queue Service"
                autoEnroll = component "Auto-Enroll Worker"

                condReader = component "Condition Reader"
                predicateLib = component "Predicate Library"
                condEvaluator = component "Condition Evaluator"
                condSchemaDatabase = component "Condition Schema Database" {
                    
                    tags "Database"
                }       
            }
            
            conditionsManager = container "Conditions Manager" "Allows setting and removing enrollment conditions." {
                conditionAPI = component "Condition Management API"
                conditionSchemaDatabase = component "Condition Schema" {
                    tags "Database"
                }
                
            }
            statisticsEngine = container "Statistics Engine" "Calculates course statistics." {

                statisticsAPI = component "Statistics API"
                statisticsCalculator = component "Statistics calculator" "Calculates statistics"
                statisticsLibrary = component "Statistics library" "Provides basic methods for statistical data analysis."
                statisticsDataFetcher = component "Statistics data fetcher"
                statisticsCache = component "Statistics cache" "Cahces statistics results"

            }


            sisMessenger = container "SIS Messenger" "Allows viewing messages in SIS." {
                tags "Front end"
                messageView = component "Message view" {
                    tags "Front end"
                } 
                messageController = component "Message controller"

            }
            
            enrollmentPresenter = container "Enrollment Presenter" "Presents enrollment/unenrollment options" {
                tags "Front end"
                courseTicketView = component "Course ticket view" {
                    tags "Front end"
                }
                waitingListView = component "Waiting list view" {
                    tags "Front end"
                }        
                
                courseTicketController = component "Course ticket controller"
                waitingListController = component "Waiting list controller"
                

            }
            coursePresenter = container "Course Presenter" "Presents course info." {
                tags "Front end"
                courseSearchView = component "Course search" {
                    tags "Front end"
                }
                courseSearchController = component "Course search controller"
                courseOverviewView = component "Course overview" {
                    tags "Front end"
                }
                courseOverviewController = component "Course overview controller"
            }

            statisticsPresenter = container "Statistics Presenter" "Presents course statistics" {
                tags "Front end"
                statisticsQueryView = component "Course statistics query view"{
                    tags "Front end"
                }  
                statisticsQueryController = component "Course statistics query controller"
            }

            conditionsPresenter = container "Conditions Presenter" "Presents conditions options" {
                tags "Front end"
                conditionSetterView = component "Condition setter view"{
                    tags "Front end"
                }  
                conditionListView = component "Condition list view"{
                    tags "Front end"
                }
                conditionSetterContoller = component "Condition setter contoller"
                conditionListController = component "Condition list controller"

            }
            studentPresenter = container "Student Information Presenter" "Presents information about student" {
                tags "Front end"
                
                studentInfoView = component "Student info view" {
                    tags "Front end"
                }  
                studentInfoController = component "Student info component"
                
                studentSearchView = component "Student search view"{
                    tags "Front end"
                } 
                studentSearchController = component "Student search component"

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
        enrollmentSystem -> scheduleModule "Makes API calls to read current schedule for a course from"

        enrollmentSystem -> studentDatabase "Reads information about students from"

        enrollmentSystem -> courseDatabase "Reads information about courses from"

        dashboard -> enrollmentSystem "Manages enrollments on behalf of users using"

        sso -> enrollmentSystem  "Verifies users' identities."

        maneger -> enrollmentSystem "Maneges available courses."

        sso -> sisMessenger "Verifies user"
        sso -> enrollmentPresenter "Verifies user"
        sso -> conditionsPresenter "Verifies user"
        sso -> statisticsPresenter "Verifies user"
        sso -> studentPresenter "Verifies user"

        
        
        
        # Container relationships
        
        autoEnroll -> notificationService "Triggeres notificiation when waiting status changes."
        enrollmentManager -> courseDatabase "Updates waiting list."

        enrollmentManager -> courseDatabase "Updates enrolled student list."
        enrollmentManager -> studentDatabase "Updates schedule."

        enrollmentManager -> studentDatabase "Views student data."
        enrollmentManager -> courseDatabase "Views conditions."
        
        conditionSchemaDatabase -> courseDatabase "Sets/removes conditions."

        notificationService -> sisMessenger "Updates messages"
        student -> sisMessenger "Views messages"
        teacher -> sisMessenger "Views messages"

        enrollmentPresenter -> enrollmentAPI "Requests changes in enrollment."
        student -> enrollmentPresenter "Enrolls (unenrolls) to (from) the course."
        teacher -> enrollmentPresenter "Enrolls (unenrolls) student to (from) the course."
        studyDepartmentOfficer -> enrollmentPresenter "Enrolls (unenrolls) student to (from) the course."
        
        statisticsDataFetcher -> courseDatabase "Fetches data"
        statisticsQueryController -> statisticsAPI "Requests statistics."
        maneger -> statisticsPresenter "Views statistics."
        
        conditionsPresenter -> conditionAPI "Requests conditions and changes them."
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
        dashboard -> sisMessenger "Delivers to the users's web browser."


        
        ticketCapacityHandler -> ticketStore "Read capacity/enrolled; write increments"
        ticketCapacityHandler -> enrollmentWriter "On success: update enrolled roster"
        ticketCapacityHandler -> scheduleWriter "On success: update schedule"
        ticketCapacityHandler -> autoEnroll "On full: push to waiting list"
        ticketStore -> courseDatabase "R/W ticket records"
        enrollmentWriter -> studentDatabase "Update student course list"
        scheduleWriter -> studentDatabase "Update schedule entries"
        
        # Enrollemnt Manager components
        autoEnroll -> waitQueue "Update waiting list"
        waitQueue -> courseDatabase "Persist queue state"
        autoEnroll -> ticketStore "Update tickets when pop."

        enrollmentAPI -> ticketCapacityHandler "Request (un)enrollment."
        enrollmentAPI -> autoEnroll "Request removal from waiting list."
        ticketCapacityHandler -> autoEnroll "Request waiting list update when user unenrolls."


        ticketCapacityHandler -> condEvaluator "Check conditions"
        condReader -> condSchemaDatabase "Fetch conditions."
        condEvaluator -> condReader "Fetch condition graph"
        condEvaluator -> predicateLib "Invoke predicates (GPA, credits, role, time windows)"
        condEvaluator -> studentDatabase "Fetch student attributes"
        condSchemaDatabase -> courseDatabase "Fetch course conditions"


        # Statistics Engine
        statisticsAPI -> statisticsCalculator "Requests calculation"
        statisticsCalculator -> statisticsDataFetcher "Requests data fetch"
        statisticsLibrary -> statisticsCalculator "Provides statistical methods."
        statisticsCalculator -> statisticsCache "Updates"
        statisticsCalculator -> statisticsCache "Reads"

        # Enrollment Presenter
        waitingListController -> enrollmentManager "Requests waiting list update"
        courseTicketController -> enrollmentManager "Requests (un)enrollment"
        waitingListView -> waitingListController "Handles waiting list requests"
        courseTicketView -> courseTicketController "Handles (un)enrollment requests."

        dashboard -> courseTicketView "delivers"
        dashboard -> waitingListView "delivers"

        # Course Presenter
        dashboard -> courseSearchView "delivers"
        dashboard -> courseOverviewView "delivers
        courseSearchController -> courseDatabase "Fetches available courses based on user filters."
        courseSearchView -> courseSearchController "Requests course list"
        courseOverviewView -> courseOverviewController "Requests course data"
        courseOverviewController -> courseDatabase "Fetches course data"

        # Statistics view
        statisticsQueryView -> statisticsQueryController "Sets statistics to be calculated"

        # Condition Presenter
        conditionListView -> conditionListController "Request conditions"
        conditionListController -> conditionAPI "Request conditions info"
        conditionSetterContoller -> conditionAPI "Requests conditions change"
        conditionSetterView -> conditionSetterContoller "Requests condition change"
        dashboard -> conditionListView "Delivers"
        dashboard -> conditionSetterView "Delivers"

        # Student Presenter
        studentInfoView -> studentInfoController "Gets data about student"
        studentInfoController -> studentDatabase "Fetches data from databse"
        studentSearchView -> studentSearchController "Gets data about students"
        studentSearchController -> studentDatabase "Fetches data about students"
        dashboard  -> studentInfoView "Delivers"
        dashboard -> studentSearchView "Delivers"

        # SIS Messenger
        dashboard -> messageView "Delivers"
        messageView -> messageController "Gets messages"
        notificationService -> messageController "Pushes messages"

        # Notification Service
        channelDispatcher -> templateEngine "Render message"
        channelDispatcher -> mailingListManager "Publish to mailing lists"
        channelDispatcher -> notificationDatabase "Write delivery logs"
        channelDispatcher -> studentDatabase "Lookup contact addresses"
        notificationDatabase -> studentDatabase "Stores and loads notifications and logs."

        #Conditions manager
        conditionAPI -> conditionSchemaDatabase "Create/Update/Delete condition definitions"
        #conditionSchemaDatabase -> courseDatabase "R/W conditions"
        


    }

    views {

        systemContext enrollmentSystem "enrollmentSystemContextDiagram" {
            include enrollmentSystem
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
        container enrollmentSystem "enrollmentSystemContainerDiagram" {
            include *
            exclude courseTicketView
            exclude waitingListView
            exclude courseSearchView
            exclude courseOverviewView
            exclude conditionListView
            exclude conditionSetterView
            exclude studentInfoView
            exclude studentSearchView
            exclude messageView
            
        }
        component enrollmentManager "enrollmentManagerComponeentDiagram" {
            include *
        }
        component statisticsEngine "statisticsEnginComponentDiagram" {
            include *
        }
        component enrollmentPresenter "enrollmentPresenterComponentDigram" {
            include *
        }
        component coursePresenter "coursePresenterComponentDiagram" {
            include *
        }
        
        component statisticsPresenter "statisticsPresenterComponentDiagram" {
            include *
        }
        component conditionsPresenter "conditionsPresenterComponentDiagram" {
            include *
        }
        component studentPresenter "studentPresenterComponentDiagram" {
            include *
        }
        component sisMessenger "sisMessengerComponentDiagram" {
            include *
        }
        component notificationService "notificationServiceComponentDiagram" {
            include *
        }
        component conditionsManager "conditionsManagerComponentDiagram" {
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
