CREATE TABLE IF NOT EXISTS task_status (
    status_id INTEGER PRIMARY KEY AUTOINCREMENT,
    status_name TEXT
);

INSERT INTO task_status (status_name) VALUES ('opened'), ('closed');

CREATE TABLE IF NOT EXISTS roles (
    role_id INTEGER PRIMARY KEY AUTOINCREMENT,
    role_name TEXT
);

INSERT INTO roles (role_name) VALUES ('admin'), ('user'), ('accountant');

CREATE TABLE IF NOT EXISTS users (
    user_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT
);

CREATE TABLE IF NOT EXISTS user_roles (
    user_role_id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER,
    role_id INTEGER,
    FOREIGN KEY(user_id) REFERENCES users(user_id),
    FOREIGN KEY(role_id) REFERENCES roles(role_id)
);

CREATE TABLE IF NOT EXISTS tasks (
    task_id INTEGER PRIMARY KEY AUTOINCREMENT,
    body TEXT,
    status_id INTEGER,
    assignee_id INTEGER,
    FOREIGN KEY(status_id) REFERENCES task_status(status_id),
    FOREIGN KEY(assignee_id) REFERENCES users(user_id)
);

CREATE TABLE IF NOT EXISTS task_audit (
    tr_id INTEGER PRIMARY KEY AUTOINCREMENT,
    task_id INTEGER,
    prev_status_id INTEGER,
    cur_status_id INTEGER,
    FOREIGN KEY(task_id) REFERENCES tasks(task_id),
    FOREIGN KEY (prev_status_id) REFERENCES task_status(status_id),
    FOREIGN KEY (cur_status_id) REFERENCES task_status(status_id)
);

CREATE TABLE IF NOT EXISTS bank (
    bank_id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER,
    balance REAL,
    FOREIGN KEY(user_id) REFERENCES users(user_id)
);

-- debit - начисление
-- credit - списание
CREATE TABLE IF NOT EXISTS bank_audit (
    tr_id INTEGER PRIMARY KEY AUTOINCREMENT,
    task_audit_tr_id INTEGER,
    bank_id INTEGER,
    debit REAL,
    credit REAL,
    FOREIGN KEY(task_audit_tr_id) REFERENCES task_audit(tr_id),
    FOREIGN KEY(bank_id) REFERENCES bank(bank_id)
);