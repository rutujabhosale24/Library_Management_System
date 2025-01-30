--------------------------------------------- BASIC QUERIES ------------------------------------------------------------------------
-- 1 --
INSERT INTO Books(isbn, book_title, category, rental_price, status, author, publisher)
VALUES('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');
SELECT * FROM books;

-- 2 --
SELECT * FROM issued_status
WHERE issued_emp_id = 'E101';

-- 3 --
SELECT * FROM Members WHERE reg_date >= date_sub(curdate(),INTERVAL 365 day );

-- 4 --
SELECT issued_member_id,COUNT(*) FROM issued_status GROUP BY issued_member_id HAVING COUNT(*) > 1;

-- 5 --
SELECT emp_name,salary,
CASE
when salary > 60000 then 'Good Salary'
when salary > 50000 then 'Average Salary'
else 'Poor Salary' 
END as Salary_Satus 
FROM Employees; 

-- 6 -- 
SELECT Book_title FROM Books WHERE Book_title LIKE 'The%';

-- 7 --
SELECT * FROM Employees WHERE Salary BETWEEN 50000 AND 70000;

----------------------------------------------------------- SUB-QUERIES ------------------------------------------------------------------------

-- 1 --
SELECT max(Salary) FROM Employees WHERE Salary < (SELECT max(Salary) FROM Employees);

-- 2 --
SELECT emp_name,Salary FROM Employees WHERE Salary = (SELECT max(Salary) FROM Employees);

-- 3 --
SELECT * FROM Employees WHERE Position IN (SELECT Position FROM Employees WHERE Emp_name="John Doe" OR Emp_name="Emily Davis") AND (Emp_name<>"John Doe" AND Emp_name<> "Emily Davis");

-- 4 --
SELECT * FROM Books WHERE Category = (SELECT Category FROM Books WHERE Book_title="The Alchemist");

-- 5 --
SELECT Emp_ID,Emp_name,Salary FROM Employees WHERE SALARY > ANY(SELECT Salary FROM Employees WHERE Emp_ID = "E102");

---------------------------------------------------------------------- JOINS ---------------------------------------------------------------------

-- 1 --
SELECT b.category,SUM(b.rental_price),COUNT(*) FROM 
issued_status as ist
INNER JOIN
Books as b
ON b.isbn = ist.issued_book_isbn
GROUP BY Category;

-- 2 --
SELECT e1.emp_name as employee ,e2.emp_name as manager FROM 
employees as e1
JOIN 
branch as b
ON e1.branch_id = b.branch_id    
JOIN
employees as e2
ON e2.emp_id = b.manager_id;

-- 3 --
SELECT Books.Book_title FROM 
issued_status as ist
LEFT JOIN
Books
ON ist.Issued_book_isbn = Books.ISBN
LEFT JOIN
return_status as rs
ON rs.issued_id = ist.issued_id
WHERE rs.return_id IS NULL;

-- 4 --
SELECT e.emp_name,COUNT(ist.issued_id) as no_book_issued FROM
issued_status as ist
JOIN
employees as e
ON e.emp_id = ist.issued_emp_id
GROUP BY e.emp_name;

-- 5 --
SELECT m.Member_name,count(*) as No_of_Issued_Books FROM
Members as m
LEFT JOIN
issued_status as ist
ON m.member_id = ist.issued_member_id
GROUP BY m.Member_name;

