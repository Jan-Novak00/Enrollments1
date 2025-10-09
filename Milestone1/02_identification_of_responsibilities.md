# Enrolment system

## Core features and responsibilities

### Feature: Student enrolment cancellation
As a student, I need to be able to cancel my enrolment to lecture and practical so I can change my mind about my study.

#### Feature breakdown
1. A student opens their dashboard and selects schedule.
2. The system fetches the schedule from schedules module.
3. The system displays the fetched data to the student.
4. The student selects the lecture or practical, for which they wish to cancel their enrolment.
5. The system fetches selected item details.
6. The system displays the fetched item details.
7. The student clicks on enrollment cancellation button.
8. The system shows confirmation message over the item detail, if the student really want to cancel their enrolment.
9. The student confirms the cancellation process (or decline it and the systems dismiss the confirmation message).
10. The system checks if the student is allowed to cancel their enrolment.
11. The system records the cancellation (if it has been allowed).
12. The system displays student's schedule along with message if enrolment cancellation succeed (if not the message contains error message).

#### Responsibilities

- **text below isn't structure in requested way (probably remove it after the homework from 2. practical is finnished) (TODO).**

# Second practical
## Features
1. As a student, I need to be able to enroll myself to specific lecture and practical so I can join the course.
As a student, I need to be able to cancel my enrolment to lecture and practical so I can change my mind about my study.
3. As a teacher, I need to be able to enroll a student to my lecture or practical so I can control the capacity and the schedule of the course.
4. TODO
5. As a study department officer, I need to be able to enroll and enroll a student to specific lecture and practical so I can handle student eligible individual needs.
6. As a manager, I need to be able to view statistical reports (even going back to history) so I can improve the course in the future.
7. As a teacher, I need to be able to set the enrolment conditions to my course so I can I specify the subset of students for which is the course aim at.
8. As a teacher, I need to be able (communication) TODO

## Feature classification
1. core
    - 1
    - 2
    - 5
    - 7
    - 4
2. auxiliary
    - 8 -> because user can use an external communication channel
    - 6 -> first I need set up courses, than I can improve them
    - 3 -> it can be handle with cooperation of study department

## Feature breakdown
### 5
1. A study department officer open their dashboard and select option to enroll a student into a course.
2. The system fetches from schedule module informations about currently taught courses.
3. Study department officer selects the given course.
4. Study department officer look up for the student.
5. The system fetches data from the database.
6. The system shows the search results.
7. Study department officer TODO

## Identify responsibilities
### 5
