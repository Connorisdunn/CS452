-- Table: Employee
CREATE TABLE Employee (
    employee_id BIGINT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    job_title VARCHAR(50) NOT NULL,
    salary DOUBLE NOT NULL,
    manager_id BIGINT,
    store_id BIGINT,
    hire_date DATE NOT NULL,
    contact_id BIGINT,
    FOREIGN KEY (manager_id) REFERENCES Manager(manager_id),
    FOREIGN KEY (store_id) REFERENCES Store(store_id),
    FOREIGN KEY (contact_id) REFERENCES Contact(contact_id)
);

-- Table: Manager
CREATE TABLE Manager (
    manager_id BIGINT PRIMARY KEY,
    employee_id BIGINT UNIQUE,
    store_id BIGINT UNIQUE,
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id),
    FOREIGN KEY (store_id) REFERENCES Store(store_id)
);

-- Table: Store
CREATE TABLE Store (
    store_id BIGINT PRIMARY KEY,
    contact_id BIGINT,
    FOREIGN KEY (contact_id) REFERENCES Contact(contact_id)
);

-- Table: Stock
CREATE TABLE Stock (
    stock_id BIGINT PRIMARY KEY,
    store_id BIGINT NOT NULL,
    equipment_id BIGINT NOT NULL,
    quantity BIGINT NOT NULL,
    FOREIGN KEY (store_id) REFERENCES Store(store_id),
    FOREIGN KEY (equipment_id) REFERENCES Equipment(equipment_id)
);

-- Table: Equipment
CREATE TABLE Equipment (
    equipment_id BIGINT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    brand VARCHAR(50) NOT NULL,
    category VARCHAR(75) NOT NULL,
    price DOUBLE NOT NULL
);

-- Table: Contact
CREATE TABLE Contact (
    contact_id BIGINT PRIMARY KEY,
    phone_number BIGINT NOT NULL,
    email_address VARCHAR(50) NOT NULL,
    street VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state CHAR(2) NOT NULL,
    zip SMALLINT NOT NULL
);
