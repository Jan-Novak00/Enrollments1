# Enrolment system

## Core features and responsibilities

### Feature: Student enrolment cancellation
As a student, I need to be able to cancel my enrolment to lecture and practical so I can change my mind about my study.

#### Feature breakdown
1. A student opens their dashboard and selects schedule.
2. The system displays the student schedule.
3. The student selects the lecture or practical, for which they wish to cancel their enrolment.
4. The system fetches selected item details.
5. The system displays the fetched item details.
6. The student clicks on enrollment cancellation button.
7. The system shows confirmation message over the item detail, if the student really want to cancel their enrolment.
8. The student confirms the cancellation process (or decline it and than the systems dismiss the confirmation message).
9. The system checks if the student is allowed to cancel their enrolment.
10. The system records the cancellation (if it has been allowed).
11. The system displays student's schedule along with message if enrolment cancellation succeed (if not the message contains error message).

#### Responsibilities

##### Displaying responsibilities
- display student dashboard (call API of main module)
- display student schedule (call API of schedule module)
- display lecture or practical detail (contains cancel enrollment button for lecture or practical to which the student is enrolled)
- display enrolment cancellation confirmation message
- display success message about enrolment cancellation
- display error message about enrolment cancellation

##### Data handling responsibilities
- fetch data for concrete lecture or practical (call API of schedule module)
- propagete information about student enrolment cancallation (update database)

##### Cancel enrolment validation
- check, if student can cancel enrolment (e.g. passed the date to which studnet can cancel enrolment by its own)
- allow to set cancel enrolment conditions for students (by study department officer)
- allow student to see cancel enrolement conditions
