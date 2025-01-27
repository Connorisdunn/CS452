-- Insert sample data into the Contact table
INSERT INTO Contact (contact_id, phone_number, email_address, street, city, state, zip)
VALUES
    (1, '801-555-1234', 'manager1@golfstore.com', '123 Green St', 'Salt Lake City', 'UT', '84101'),
    (2, '801-555-5678', 'employee1@golfstore.com', '456 Fairway Ave', 'Provo', 'UT', '84604'),
    (3, '801-555-9101', 'employee2@golfstore.com', '789 Tee Ln', 'Orem', 'UT', '84057'),
    (4, '801-555-4321', 'store1@golfstore.com', '100 Clubhouse Dr', 'St. George', 'UT', '84770'),
    (5, '801-555-0001', 'store2@golfstore.com', '123 Bunker Ave', 'Orem', 'UT', '84057');

-- Insert sample data into the Store table
INSERT INTO Store (store_id, contact_id)
VALUES
    (1, 4),
    (2, 5);

-- Insert sample data into the Employee table
INSERT INTO Employee (employee_id, first_name, last_name, job_title, contact_id, store_id, manager_id)
VALUES
    (1, 'Alice', 'Johnson', 'Manager', 1, 1, NULL), -- Manager who is also an employee
    (2, 'John', 'Doe', 'Sales Rep', 2, 1, 1),        -- Employee reporting to the manager
    (3, 'Jane', 'Smith', 'Apparel Rep', 3, 1, 1);      -- Employee reporting to the manager

-- Insert sample data into the Manager table
-- The manager is linked back to the Employee table
INSERT INTO Manager (manager_id, first_name, last_name, employee_id, contact_id)
VALUES
    (1, 'Alice', 'Johnson', 1, 1); -- Matches the manager in Employee

-- Insert sample data into the Equipment table
INSERT INTO Equipment (equipment_id, name, brand, category, price)
VALUES
    (1, 'Golf Balls', 'Titleist', 'Golf Ball', 25.99),
    (2, 'Driver','Callaway', 'Club', 499.99),
    (3, 'Golf Shoes', 'Nike', 'Apparel', 129.99);

-- Insert sample data into the Stock table
INSERT INTO Stock (stock_id, store_id, equipment_id, quantity)
VALUES
    (1, 1, 1, 50),  -- Provo store stock of golf balls
    (2, 1, 2, 10),  -- Provo store stock of drivers
    (3, 2, 3, 25);  -- Salt Lake store stock of golf shoes
