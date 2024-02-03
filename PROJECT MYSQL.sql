CREATE DATABASE library;
USE library;
CREATE TABLE  branch(
   branch_no INT  NOT NULL PRIMARY KEY,
   brnch_address VARCHAR(225),
   manager_id INT NOT NULL,
   contact_no VARCHAR(10)
);
CREATE TABLE employe(
emp_id INT PRIMARY KEY,
emp_name VARCHAR(30),
emp_position VARCHAR(50),
salary INT,
branch_no INT,
FOREIGN KEY(branch_no) REFERENCES branch(branch_no)
);
CREATE TABLE customer(
customer_id INT PRIMARY KEY,
customer_name VARCHAR(40),
customer_address VARCHAR(255),
reg_date DATE
);
CREATE TABLE issue_status(
issue_id INT PRIMARY KEY,
issued_cust INT,
issued_bookname VARCHAR(30),
issue_date DATE,
isbn_book INT,
FOREIGN KEY(issued_cust) REFERENCES customer(customer_id),
FOREIGN KEY(isbn_book) REFERENCES books(isbn)
);

CREATE TABLE returnstatus(
return_id INT NOT NULL,
return_cust VARCHAR(40),
return_bookname VARCHAR(40),
return_date DATE,
isbn_book2 INT NOT NULL,
FOREIGN KEY(isbn_book2) REFERENCES books(isbn)
);
CREATE TABLE books(
isbn INT NOT NULL PRIMARY KEY,
book_title VARCHAR(40),
catagory VARCHAR(40),
rental_price INT NOT NULL,
author VARCHAR(40),
publisher VARCHAR(40),
b_status ENUM('yes', 'no'));


INSERT INTO branch()
VALUES
(10, 'oorkam,vengara', 1, 9947305050),
(11, 'karimbili,vengara', 2, 9945478050),
(12, 'oorkam,melmuri', 3, 9952486570),
(13, 'vettam', 4, 9925436845),
(14, 'oorkara', 5, 9947455050),
(15, 'ottam,malappuram',6,  9958305650);

INSERT INTO employe()
VALUES
(101, 'shameer', 'manager', 125000, 11),
(103, 'sham', 'tl', 92450, 13),
(104, 'ameer', 'sales', 25000, 11),
(105, 'akhil', 'tl', 92500, 10),
(106, 'ameen', 'manager', 225000, 15),
(107, 'anees', 'ass.manager', 155000, 15),
(108, 'jhon', 'tl', 95800, 10),
(109, 'nadira', 'manager', 125000, 10);

INSERT INTO customer()
VALUES
(1001, 'farhan', 'mt(H), vengara', '2023-01-15'),
(1002, 'farhan', 'ch(H), karimbili', '2023-11-05'),
(1003, 'farhan', 'ct(H), vankulam', '2023-04-15'),
(1004, 'farhan', 'gh(H), malppuram', '2023-02-10'),
(1005, 'farhan', 'cc(H), calicut', '2023-02-14'),
(1006, 'farhan', 'ap(H), ramapuram', '2023-04-15'),
(1007, 'farhan', 'nh(H), kuttaaloor', '2023-01-15');

INSERT INTO books()
VALUES
(10, 'orphan', 'a', 450, 'manu', 'kuttu', 'no'),
(11, 'chemmin', 'a', 650, 'ali', 'shameer', 'yes'),
(12, 'ormakal', 'a', 150, 'malu', 'naseef', 'no'),
(13, '12thman', 'b', 520, 'sharanya', 'akhil', 'yes'),
(14, 'the darkesthour', 'a', 400, 'sahla', 'banu', 'yes'),
(15, 'firstmen', 's', 450, 'habeeb', 'shameem', 'yes'),
(16, 'phantom', 'e', 550, 'navas', 'anees', 'no'),
(17, 'high', 'a', 520, 'ameed', 'shahul', 'yes'),
(18, 'orp', 's', 540, 'manuppa', 'niyas', 'yes'),
(19, 'adujeevitham', 'e', 570, 'thakayi', 'vc', 'no'),
(20, 'oyam', 'c', 590, 'thunchan', 'vallathol', 'yes');

INSERT INTO returnstatus()
VALUES
(11, 'farhan', 'orphan', '2023-01-15', 10),
(12, 'farhan', '12thman', '2023-02-15', 16),
(13, 'farhan', 'the darkesthour', '2023-01-25', 11),
(14, 'farhan', 'firstmen', '2023-01-15', 12);

INSERT INTO issue_status()
VALUES
(1, 1001, 'orphan', '2023-01-15', 10),
(4, 1005, 'chemmin', '2023-02-05', 11),
(6, 1005, '12thman', '2023-04-25', 12),
(11, 1004, 'the darkesthour', '2023-06-25', 13),
(12, 1003, 'firstmen', '2023-06-15', 14),
(9, 1007, 'orp', '2023-01-14', 15),
(8, 1001, 'phantom', '2023-01-15', 16),
(10, 1002, 'oyam', '2023-08-05', 17);

#Retrieve the book title, category, and rental price of all available books.
SELECT book_title, catagory, rental_price FROM books WHERE b_status = 'yes';

# List the employee names and their respective salaries in descending order of salary.
SELECT emp_name, salary FROM employe ORDER BY  salary DESC;

#Retrieve the book titles and the corresponding customers who have issued those books.
SELECT 	b.book_title, c.customer_id, c.customer_name FROM books AS b RIGHT JOIN  issue_status AS i ON  book_title = issued_bookname
RIGHT JOIN customer AS c ON customer_id = issued_cust;

#Display the total count of books in each category.
SELECT COUNT(catagory), catagory FROM books GROUP BY catagory;

#Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000
SELECT emp_name, emp_position, salary FROM employe WHERE salary > 50000;

#List the customer names who registered before 2022-01-01 and have not issued any books yet.
SELECT customer_id, customer_name FROM customer
WHERE reg_date < '2022-01-01' AND
    customer_id IN (SELECT customer_id FROM customer JOIN issue_status ON customer_id <> issued_cust);

# Display the branch numbers and the total count of employees in each branch.
SELECT branch_no, COUNT(branch_no) FROM employe GROUP BY branch_no;

#Display the names of customers who have issued books in the month of June 2023.
SELECT C.customer_id, C.customer_name FROM customer C JOIN issue_status I 
ON C.customer_id = I.issued_cust 
WHERE I.issue_date BETWEEN '2023-06-01' AND '2023-06-30';

# Retrieve book_title from book table containing history
SELECT book_title FROM books WHERE catagory = 'history';

#Retrieve the branch numbers along with the count of employees for branches having more than 5 employees
SELECT branch_no, COUNT(emp_id) FROM employe GROUP BY branch_no;