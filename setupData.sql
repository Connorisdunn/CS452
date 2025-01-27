-- Insert sample data into the Contact table
INSERT INTO Contact (contact_id, phone_number, email_address, street, city, state, zip)
VALUES
    (1, '801-555-1234', 'manager1@golfstore.com', '123 Green St', 'Salt Lake City', 'UT', '84101'),
    (2, '801-555-5678', 'employee1@golfstore.com', '456 Fairway Ave', 'Provo', 'UT', '84604'),
    (3, '801-555-9101', 'employee2@golfstore.com', '789 Tee Ln', 'Orem', 'UT', '84057'),
    (4, '801-555-4321', 'store1@golfstore.com', '100 Clubhouse Dr', 'St. George', 'UT', '84770'),
    (5, '801-555-0001', 'store2@golfstore.com', '123 Bunker Ave', 'Orem', 'UT', '84057'),
    (6, '801-555-1111', 'employee3@golfstore.com', '321 Putter Rd', 'Lehi', 'UT', '84043'),
    (7, '801-555-2222', 'employee4@golfstore.com', '654 Driver Dr', 'Ogden', 'UT', '84401'),
    (8, '801-555-3333', 'store3@golfstore.com', '987 Iron St', 'Park City', 'UT', '84060'),
    (9, '801-555-4444', 'store4@golfstore.com', '543 Wedge Way', 'Logan', 'UT', '84321'),
    (10, '801-555-5555', 'employee5@golfstore.com', '765 Fairway Blvd', 'Layton', 'UT', '84041'),
    (11, '801-555-6666', 'manager5@golfstore.com', '789 Birdie Rd', 'Heber City', 'UT', '84032'),
    (12, '801-555-7777', 'employee6@golfstore.com', '444 Eagle St', 'Cedar City', 'UT', '84720'),
    (13, '801-555-8888', 'store5@golfstore.com', '567 Sand Trap Ln', 'Moab', 'UT', '84532'),
    (14, '801-555-9999', 'employee7@golfstore.com', '222 Drive Ln', 'Bountiful', 'UT', '84010'),
    (15, '801-555-1212', 'store6@golfstore.com', '321 Green Blvd', 'Vernal', 'UT', '84078');

-- Insert sample data into the Store table
INSERT INTO Store (store_id, contact_id)
VALUES
    (1, 4),
    (2, 5),
    (3, 8),
    (4, 9),
    (5, 13),
    (6, 15);

-- Insert sample data into the Employee table
INSERT INTO Employee (employee_id, first_name, last_name, job_title, salary, manager_id, store_id, hire_date, contact_id)
VALUES
    (1, 'Alice', 'Johnson', 'Manager', 20.01, NULL, 1, '01/01/2000', 1),
    (2, 'John', 'Doe', 'Sales Rep', 15.99, 1, 1, '07/22/2005', 2),
    (3, 'Jane', 'Smith', 'Apparel Rep', 12.00, 1, 1, '10/27/2009', 3), 
    (4, 'Emily', 'Brown', 'Cashier', 13.50, 1, 1, '04/15/2015', 6),
    (5, 'Michael', 'Davis', 'Sales Rep', 16.25, 1, 2, '09/10/2012', 7),
    (6, 'Sarah', 'Wilson', 'Manager', 22.50, NULL, 3, '05/20/2005', 8),
    (7, 'Chris', 'Taylor', 'Cashier', 14.00, 6, 3, '11/11/2018', 10),
    (8, 'Oliver', 'Grant', 'Manager', 23.00, NULL, 5, '03/15/2010', 11),
    (9, 'Sophia', 'Green', 'Cashier', 14.50, 8, 5, '08/09/2016', 12),
    (10, 'Liam', 'Reed', 'Apparel Rep', 15.75, NULL, 6, '05/25/2020', 14);

-- Insert sample data into the Manager table
-- The manager is linked back to the Employee table
INSERT INTO Manager (manager_id, employee_id, store_id)
VALUES
    (1, 1, 1),
    (2, 6, 3),
    (3, 8, 2);

-- Insert sample data into the Equipment table
INSERT INTO Equipment (equipment_id, name, brand, category, price)
VALUES
    (1, 'Golf Balls', 'Titleist', 'Golf Ball', 25.99),
    (2, 'Driver','Callaway', 'Club', 499.99),
    (3, 'Golf Shoes', 'Nike', 'Apparel', 129.99),
    (4, 'Putter', 'TaylorMade', 'Club', 249.99),
    (5, 'Golf Bag', 'Ping', 'Accessories', 199.99),
    (6, 'Gloves', 'FootJoy', 'Apparel', 24.99);

-- Insert sample data into the Stock table
INSERT INTO Stock (stock_id, store_id, equipment_id, quantity)
VALUES
    (1, 1, 1, 50),
    (2, 1, 2, 10),
    (3, 2, 3, 25),
    (4, 2, 4, 15),
    (5, 3, 5, 30),
    (6, 3, 6, 60), 
    (7, 4, 1, 40), 
    (8, 4, 2, 5),
    (9, 5, 3, 40),
    (10, 6, 4, 20);
