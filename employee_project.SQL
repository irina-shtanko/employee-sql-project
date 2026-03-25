-- =========================================
-- Project: Employee Management Database
-- Author: Irina Shtanko
-- Description: SQL project demonstrating joins, aggregations, and data analysis
-- =========================================


-- =========================================
-- CREATE TABLES
-- =========================================

CREATE TABLE filial (
    filial_id NUMBER PRIMARY KEY,
    filial_name VARCHAR2(100),
    city VARCHAR2(100)
);

CREATE TABLE department (
    department_id NUMBER PRIMARY KEY,
    department_name VARCHAR2(100)
);

CREATE TABLE persons (
    person_id NUMBER PRIMARY KEY,
    first_name VARCHAR2(50),
    last_name VARCHAR2(50),
    position_name VARCHAR2(100),
    salary NUMBER(10,2),
    hire_date DATE,
    department_id NUMBER,
    filial_id NUMBER
);

CREATE TABLE phones (
    phone_id NUMBER PRIMARY KEY,
    person_id NUMBER,
    phone_number VARCHAR2(20),
    phone_type VARCHAR2(20)
);

CREATE TABLE cars (
    car_id NUMBER PRIMARY KEY,
    person_id NUMBER,
    car_model VARCHAR2(100),
    plate_number VARCHAR2(20)
);


-- =========================================
-- INSERT DATA
-- =========================================

INSERT INTO filial VALUES (1, 'Head Office', 'Amsterdam');
INSERT INTO filial VALUES (2, 'West Branch', 'Rotterdam');
INSERT INTO filial VALUES (3, 'East Branch', 'Utrecht');

INSERT INTO department VALUES (1, 'Sales');
INSERT INTO department VALUES (2, 'Marketing');
INSERT INTO department VALUES (3, 'IT');
INSERT INTO department VALUES (4, 'HR');


INSERT INTO persons VALUES (1, 'Anna', 'Smirnova', 'Sales Manager', 3200, DATE '2022-03-15', 1, 1);
INSERT INTO persons VALUES (2, 'John', 'Smith', 'SQL Developer', 4000, DATE '2021-06-10', 3, 1);
INSERT INTO persons VALUES (3, 'Maria', 'Petrova', 'HR Specialist', 2800, DATE '2023-01-20', 4, 2);
INSERT INTO persons VALUES (4, 'David', 'Brown', 'Marketing Analyst', 3100, DATE '2020-11-01', 2, 1);
INSERT INTO persons VALUES (5, 'Olga', 'Koval', 'Sales Assistant', 2500, DATE '2024-02-12', 1, 3);
INSERT INTO persons VALUES (6, 'Michael', 'Johnson', 'IT Support', 3000, DATE '2022-09-05', 3, 2);
INSERT INTO persons VALUES (7, 'Natalia', 'Tkachenko', 'Marketing Specialist', 2950, DATE '2021-12-18', 2, 3);
INSERT INTO persons VALUES (8, 'Robert', 'Miller', 'HR Assistant', 2400, DATE '2024-05-01', 4, 2);
INSERT INTO persons VALUES (9, 'Irina', 'Shevchenko', 'Data Analyst', 3500, DATE '2022-07-22', 3, 1);
INSERT INTO persons VALUES (10, 'Alex', 'Wilson', 'Sales Manager', 3300, DATE '2019-03-11', 1, 2);
INSERT INTO persons VALUES (11, 'Elena', 'Bondar', 'Account Manager', 3400, DATE '2020-08-09', 1, 3);
INSERT INTO persons VALUES (12, 'Thomas', 'Anderson', 'Database Administrator', 4200, DATE '2018-04-25', 3, 1);
INSERT INTO persons VALUES (13, 'Sofia', 'Ivanova', 'HR Manager', 3600, DATE '2019-10-30', 4, 2);
INSERT INTO persons VALUES (14, 'Daniel', 'Garcia', 'BI Analyst', 3700, DATE '2021-01-14', 2, 3);
INSERT INTO persons VALUES (15, 'Kateryna', 'Melnyk', 'Junior SQL Developer', 2800, DATE '2024-06-01', 3, 1);


INSERT INTO phones VALUES (1, 1, '+31611111111', 'Mobile');
INSERT INTO phones VALUES (2, 2, '+31622222222', 'Work');
INSERT INTO phones VALUES (3, 3, '+31633333333', 'Mobile');
INSERT INTO phones VALUES (4, 4, '+31644444444', 'Work');
INSERT INTO phones VALUES (5, 5, '+31655555555', 'Mobile');
INSERT INTO phones VALUES (6, 6, '+31666666666', 'Work');

INSERT INTO cars VALUES (1, 1, 'Toyota Corolla', 'NL-101-AA');
INSERT INTO cars VALUES (2, 2, 'BMW 3 Series', 'NL-202-BB');
INSERT INTO cars VALUES (3, 4, 'Volkswagen Golf', 'NL-303-CC');
INSERT INTO cars VALUES (4, 6, 'Skoda Octavia', 'NL-404-DD');
INSERT INTO cars VALUES (5, 9, 'Audi A4', 'NL-505-EE');
INSERT INTO cars VALUES (6, 12, 'Mercedes C-Class', 'NL-606-FF');

COMMIT;


-- =========================================
-- QUERIES
-- =========================================

-- Employees with departments
SELECT 
    p.first_name,
    p.last_name,
    d.department_name
FROM persons p
JOIN department d
    ON p.department_id = d.department_id;

-- Employees with cars
SELECT 
    p.first_name,
    p.last_name,
    c.car_model
FROM persons p
LEFT JOIN cars c
    ON p.person_id = c.person_id;

-- Average salary by filial
SELECT 
    f.filial_name,
    ROUND(AVG(p.salary), 1) AS avg_salary
FROM persons p
JOIN filial f
    ON p.filial_id = f.filial_id
GROUP BY f.filial_name;

-- Employees in IT department
SELECT 
    p.first_name,
    p.last_name
FROM persons p
JOIN department d
    ON p.department_id = d.department_id
WHERE d.department_name = 'IT';

-- Employees with salary > 3000 and car
SELECT 
    p.first_name,
    p.last_name,
    p.salary,
    c.car_model
FROM persons p
JOIN cars c
    ON p.person_id = c.person_id
WHERE p.salary > 3000;