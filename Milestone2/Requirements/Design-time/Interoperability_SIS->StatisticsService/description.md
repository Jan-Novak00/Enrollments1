# Quality Requirement Scenario

- *Source of stimulus:* School Information System
- *Stimulus:* Requests examination reports about last academic year
- *Enviroment:* Normal operation
- *Artifact:* Statistics Service
- *Response:* Send requested reports
- *Meassurement:* 100 % reports process

## Story
School management wants to evaluate last academic years and via School Information System aggregates all reports from  it's sub-module so they can be further process into complex analysis.

## Solution
The C4 model are already well prepared for that scenario. There is a single component, which is responsible for that - Statistics Service from Application Core. The API already provide a way to receive aggregated reports. We have to only ensure that the reports presents data in machine readable format and that we documented the data format.
