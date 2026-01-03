# Quality Requirement Scenario

- *Source of stimulus:* Student
- *Stimulus:* Register for an exam. Stochastically (at certain times of the year), 1000 requests per second
- *Environment:* Normal operation
- *Artifact:* Application core
- *Response:* All requests processed
- *Measurement:* With an average latency of 5 s

## Story
During exam periods, many students will try to register for an exam at the same time. During the busiest times - when multiple teachers create exam terms at the same time - many students will try to sign up at once. It could be up to 1000 students signing up during one second. The requests should all be processed and any one student should not be made to wait longer than 5 seconds.

## Solution
We will need to solve two different problems. 

Firstly, we want to be able to run the Application Core with more instances - for this we will need to add a Load Balancer container between the Application core and the Web Application which can forward the requests to the different instances.

Secondly, we need to not overwhelm the database with requests. We can solve this by adding a Queue Manager container between the Application Core instances and the Exam Database. Application Core instances will put their exam registration requests into a queue where the Exam Database will take them from at its own pace. It will put confirmation of successful registrations into another queue, which the Application Core will read from.

This helps the database not be overwhelmed and process the requests at a controlled rate.