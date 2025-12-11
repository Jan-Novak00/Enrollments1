# Quality Requirement Scenario

- *Source of stimulus:* Notification worker
- *Stimulus:* Unable to write log
- *Enviroment:* Normal operation
- *Artifact:* Exam database
- *Response:* Recover log
- *Meassurement:* 24 hours downtime

## More wordly descrition
After notification worker send a message it needs to log that the message was sent into Exam database. If the database is unavailable, we have 24 hours to solve the problem. The time condition is quite generous, because:
    - the logs does not directly affect users,
    - manily for maintanance purpuse.

## Propose solution
- We add new deploymentNode for fault detection - the monitor.
    - When primary database is not responding:
        - enforce synchronization
        - switch primary and secondary database
        - inform Notification log component about database switch
- We have to introduce way to synchronize primary and secondary database.
- We need to add functionality to Notification log component.
    - enable dynamicly switching database to writes logs.


