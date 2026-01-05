# Quality Requirement Scenario

- *Source of stimulus:* Student (and teacher)
- *Stimulus:* School Information System (SIS) becomes unavailable or responds too slowly (timeouts).
- *Environment:* Normal operation (peak usage, e.g., exam-period week)
- *Artifact:* Application Core (EXA)
- *Response:* EXA continues to serve exam registration and exam-term browsing using the last known SIS master-data snapshot; if a required datum is missing, EXA fails fast with a clear “SIS temporarily unavailable” message.
- *Measurement:* 
  - 99% of requests that depend only on cached SIS data succeed during an SIS outage
  - Response time ≤ 3 s for these requests
  - Cached SIS data used for decisions is at most 24 h old

## Story
During exam periods, SIS sometimes has outages or heavy load. EXA must not become unusable just because SIS is down.
Students should still be able to browse exam terms and register, and teachers should still be able to work with exam terms,
as long as the decisions can be made from recently cached SIS master data (course requirements, enrolment/credit status).

## Solution
We introduce a dedicated **SIS Data Cache** (Redis) that stores periodic snapshots of the subset of SIS data needed by EXA.
A **SIS Sync Worker** refreshes the snapshots in the background (e.g., every N minutes/hours) and records the snapshot timestamp.

At runtime, the **Application Core** first tries to read the required data from SIS. If SIS calls time out or fail,
it falls back to the **SIS Data Cache**. If the snapshot is older than 24 hours or the required datum is missing,
the request is rejected quickly with a clear error (to avoid inconsistent decisions).

This keeps EXA operational during SIS outages while keeping decisions bounded by explicit freshness limits.
