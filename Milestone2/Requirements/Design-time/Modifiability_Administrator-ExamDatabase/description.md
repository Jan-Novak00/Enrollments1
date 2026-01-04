# Quality Requirement Scenario

- *Source of stimulus:* School administrator
- *Stimulus:* Changing to a different type of database
- *Environment:* Design time
- *Artifact:* Exam database
- *Response:* The database being used is changed successfuly, all the data is transfered to the new database and the system keeps functioning normally during and after the change.
- *Measurement:* 6 man-months of development and testing

## Story
The old database the school was using, becomes too expensive for the school, so the administrators want to switch to using a different cheaper one.

## Solution
The architecture is already mostly prepared for this change. 

Application Core communicates with the database mostly through a special component Exam Repository which handles all the database communication, which can be altered to use the new database or both of them during the change period.

Notification Worker is in the exact same situation, also only communicating with the database through the Notification Log component which is its only responsiblity.

The only other point of communication is the exception in Application Core, where it also communicates with the database through the component Statistics Service, who calculates the statistics as well as reads from the database. We can fix the problem by adding another component - Statistics Repository, which will serve as an intermediary between the business calculations and the database.