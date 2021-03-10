# Описание событий в системе
По шаблону Actor - Command + Data -> Event

| Actor              | Command                      | Data              | Event                    |
| ------------------ | ---------------------------- | ----------------- | ------------------------ |
| User               | Login to Task Dashboard      | Auth info         | Open Task Dasboard       |
| User               | Create task                  | Task info         | Task.created             |
| Admin              | Assign Tasks                 | Task info         | Task.assigned            |
| Task.assigned      | Notify User                  | User, Task        | User.notified            |
| User               | Show assigned tasks          | Task              | Open Personal Dashboard  |
| User               | Mark task done               | Task              | Task.closed              |
| Accountant, Admin  | Login to Account Dashboard   | Auth info         | Open Account Dashboard   |
| User               | Open Personal Account        | Audit             | Open Personal Account    |
| User               | Show audit log               | Audit, Task       | Show Audit log           |
| Task.created       | Add task cost                | -                 | Tast.costAdded           |
| Task.assigned      | Add audit entry              | Task, Audit, User | AuditEntry.created       |
| Task.closed        | Add audit entry              | Task, Audit, User | AuditEntry.created       |
| DayEnd             | Calculate payment            | Audit             | Payment.calculated       |
| Payment.calculated | Notify user                  | User, Payment     | User.notified            |
| Payment.calculated | Reset Account                | Payment, Audit    | AuditEntry.created       |
| Admin              | Login to analytics Dashboard | Auth              | Open Analytics Dashboard |
| Admin              | Show saldo                   | Audit             | Show saldo               |
| Admin              | Show most expensive          | Audit             | Show most expensive      |