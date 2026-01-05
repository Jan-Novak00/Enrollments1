# Quality Requirement Scenario

- *Source of stimulus:* School management / product owner
- *Stimulus:* Add a new notification delivery channel (e.g., SMS or push notifications) in addition to e-mail
- *Environment:* Design time
- *Artifact:* Notification Worker (notification subsystem)
- *Response:* The new delivery channel is implemented and enabled without modifying the existing event-specific notifiers (registration, room reservation, results). Existing e-mail notifications keep working unchanged.
- *Measurement:* ≤ 1 man-month of development + testing

## Story
The school starts receiving complaints that important last‑minute updates (example newly posted grades) are missed because students do not check e-mail frequently enough. Management decides to introduce an additional notification channel (for example SMS or mobile push notifications), while keeping the current e‑mail notifications.

## Solution
Introduce a **Notification Dispatcher** component in the Notification Worker as an *intermediary* (a classic “reduce coupling” modifiability tactic):

- Event-specific notifiers are responsible only for **building a notification request** (who, what happened, message template/parameters).
- They send the request to **Notification Dispatcher**.
- **Notification Dispatcher** centralizes:
  - selection of delivery channel(s) (e-mail today; SMS/push later),
  - calling the concrete channel adapter(s) (e.g., Email Sender),
  - writing delivery status and metadata via **Notification Log**.

With this change, adding a new delivery channel becomes localized:
- add a new sender/adapter component (e.g., `Sms Sender`) and wire it to Notification Dispatcher,
- no changes are needed in the existing notifiers.
