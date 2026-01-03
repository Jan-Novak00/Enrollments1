# Quality Requirement Scenario

- *Source of stimulus:* School Information System
- *Stimulus:* Requests room availability information
- *Environment:* Normal operation
- *Artifact:* Room availability service
- *Response:* Send requested availability data in machine readable format
- *Measurement:* 100 % of data sent


## Story
The Room availability service provides the School Information System with a machine readable export of current exam schedules to ensure synchronized room management across the university.

## Solution
The Room availability service will feature a dedicated API module designed to export availability data directly into a machine readable format upon request. This module will be accessible via a HTTP REST service  for the school information system.
