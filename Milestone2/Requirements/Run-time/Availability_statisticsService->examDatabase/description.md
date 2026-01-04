# Quality Requirement Scenario
- *Source of stimulus:* Statistics service
- *Stimulus:* Unable to load data from the database
- *Environment:* Normal operation
- *Artifact:* Exam database
- *Response:* Load data from secondary database
- *Meassurement:* use of secondary databse for at most 24 hours

## More worldly description
When statistics service tries to fetch data for the user and the database times out, we have 24 hours to fix the problem. Meanwhile the system will fetch data from the secondary database and use those for statistical analysis. It is not mission critical to aggregate statistical data from completely up-to-date data, so it is fine to use slightly older data from the secondary database.


## Proposed solution
- We need a component "Database synchroniser" to synchronise primary and secondary database and "Monitor" which will monitor database status
    - When primary database is down, monitor will enforce synchonisation, swich primary and secondary database and inform statistical service of the change
    - Database synchroniser ensures that primary and secondary databases are synchronised
    - on L4 level in statistical service we need to provide new functionality (extend data fetching module) for database switching
- When the primary database is down we can try to fix it in the next 24 hours, while the secondary database hides the fault from the user. Then we switch back to primary database.
- We reuse the solution used in Availibility_NotificationWorker->ExamDatabase.
