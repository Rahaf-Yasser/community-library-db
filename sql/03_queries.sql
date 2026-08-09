
\echo '=== Currently Borrowed Books ==='
SELECT 
    b.title AS "Book Title",
    a.name AS "Author",
    m.name AS "Borrower",
    m.email AS "Email",
    l.loan_date AS "Borrowed On",
    l.due_date AS "Due Date",
    EXTRACT(DAY FROM (CURRENT_DATE - l.loan_date)) AS "Days Borrowed"
FROM loans l
JOIN books b ON l.book_id = b.book_id
JOIN authors a ON b.author_id = a.author_id
JOIN members m ON l.member_id = m.member_id
WHERE l.returned_date IS NULL
ORDER BY l.due_date ASC;


\echo '=== Overdue Loans ==='
SELECT 
    b.title AS "Book Title",
    m.name AS "Borrower",
    m.email AS "Member Email",
    l.due_date AS "Due Date",
    EXTRACT(DAY FROM (CURRENT_DATE - l.due_date)) AS "Days Overdue"
FROM loans l
JOIN books b ON l.book_id = b.book_id
JOIN members m ON l.member_id = m.member_id
WHERE l.returned_date IS NULL 
  AND CURRENT_DATE > l.due_date
ORDER BY EXTRACT(DAY FROM (CURRENT_DATE - l.due_date)) DESC;


\echo '=== Most Borrowed Books ==='
SELECT 
    b.title AS "Book Title",
    a.name AS "Author",
    COUNT(l.loan_id) AS "Total Borrows"
FROM books b
LEFT JOIN loans l ON b.book_id = l.book_id
JOIN authors a ON b.author_id = a.author_id
GROUP BY b.book_id, a.name, b.title
ORDER BY COUNT(l.loan_id) DESC
LIMIT 10;



\echo '=== Members with Most Loans ==='
SELECT 
    m.name AS "Member Name",
    m.email AS "Email",
    COUNT(l.loan_id) AS "Total Loans",
    COUNT(CASE WHEN l.returned_date IS NULL THEN 1 END) AS "Current Loans",
    COUNT(CASE WHEN l.returned_date IS NULL AND CURRENT_DATE > l.due_date THEN 1 END) AS "Overdue Loans"
FROM members m
LEFT JOIN loans l ON m.member_id = l.member_id
GROUP BY m.member_id, m.name, m.email
ORDER BY COUNT(l.loan_id) DESC;


\echo '=== Available Books ==='
SELECT 
    b.book_id AS "ID",
    b.title AS "Book Title",
    a.name AS "Author",
    b.genre AS "Genre"
FROM books b
JOIN authors a ON b.author_id = a.author_id
WHERE b.book_id NOT IN (
    SELECT DISTINCT book_id 
    FROM loans 
    WHERE returned_date IS NULL
)
ORDER BY b.title;


\echo '=== Genre Popularity ==='
SELECT 
    b.genre AS "Genre",
    COUNT(l.loan_id) AS "Total Loans",
    COUNT(DISTINCT l.member_id) AS "Unique Borrowers"
FROM books b
LEFT JOIN loans l ON b.book_id = l.book_id
WHERE b.genre IS NOT NULL
GROUP BY b.genre
ORDER BY COUNT(l.loan_id) DESC;



\echo '=== Members Who Have Never Borrowed ==='
SELECT 
    m.name AS "Member Name",
    m.email AS "Email",
    m.join_date AS "Joined"
FROM members m
LEFT JOIN loans l ON m.member_id = l.member_id
WHERE l.loan_id IS NULL
ORDER BY m.join_date;


\echo '=== Borrowing Activity by Month ==='
SELECT 
    TO_CHAR(l.loan_date, 'YYYY-MM') AS "Month",
    COUNT(l.loan_id) AS "New Loans",
    COUNT(CASE WHEN l.returned_date IS NOT NULL THEN 1 END) AS "Returns",
    COUNT(l.loan_id) - COUNT(CASE WHEN l.returned_date IS NOT NULL THEN 1 END) AS "Net Change"
FROM loans l
GROUP BY TO_CHAR(l.loan_date, 'YYYY-MM')
ORDER BY "Month" DESC;


\echo '=== Most Borrowed Authors ==='
SELECT 
    a.name AS "Author",
    COUNT(l.loan_id) AS "Total Borrows",
    COUNT(DISTINCT b.book_id) AS "Distinct Books",
    COUNT(DISTINCT l.member_id) AS "Distinct Borrowers"
FROM authors a
JOIN books b ON a.author_id = b.author_id
LEFT JOIN loans l ON b.book_id = l.book_id
GROUP BY a.author_id, a.name
ORDER BY COUNT(l.loan_id) DESC
LIMIT 10;


\echo '=== Loan Duration Statistics ==='
SELECT 
    EXTRACT(DAY FROM (returned_date - loan_date)) AS "Days Borrowed",
    COUNT(*) AS "Number of Loans"
FROM loans
WHERE returned_date IS NOT NULL
GROUP BY EXTRACT(DAY FROM (returned_date - loan_date))
ORDER BY "Days Borrowed";


\echo '=== Books Currently Overdue by Member ==='
SELECT 
    m.name AS "Member Name",
    m.email AS "Email",
    COUNT(l.loan_id) AS "Overdue Count"
FROM loans l
JOIN members m ON l.member_id = m.member_id
WHERE l.returned_date IS NULL 
  AND CURRENT_DATE > l.due_date
GROUP BY m.member_id, m.name, m.email
ORDER BY COUNT(l.loan_id) DESC;


\echo '=== Top 5 Most Borrowed Books ==='
SELECT 
    b.title AS "Book",
    a.name AS "Author",
    COUNT(l.loan_id) AS "Loan Count",
    STRING_AGG(DISTINCT m.name, ', ') AS "Borrowed By"
FROM books b
JOIN authors a ON b.author_id = a.author_id
LEFT JOIN loans l ON b.book_id = l.book_id
LEFT JOIN members m ON l.member_id = m.member_id
GROUP BY b.book_id, b.title, a.name
ORDER BY COUNT(l.loan_id) DESC
LIMIT 5;