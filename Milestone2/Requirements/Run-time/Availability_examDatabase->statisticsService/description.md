# Quality Requirement Scenario
- *Source of stimulus:* Statistics service
- *Stimulus:* Unable to load data from the database
- *Environment:* Normal operation
- *Artifact:* Exam database
- *Response:* Retry and load data from cache
- *Meassurement:* 15s downtime

## More worldly description
When statistics service tries to fetch data for the user and the database does not respond, the application has 15 seconds for retry and in the case of repeated error in reading data from the database, the application loads data from cache - it is not mission critical to aggregate statistical data from completely up-to-date data. Set timeframe is enough time to send another network request and in case of repeated error to send request to the cache.
