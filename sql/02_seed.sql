
INSERT INTO authors (name, bio) VALUES
    ('Jane Austen', 'English novelist known for her six major novels.'),
    ('Charles Dickens', 'One of the most influential novelists of the Victorian era.'),
    ('F. Scott Fitzgerald', 'American novelist and short story writer.'),
    ('Harper Lee', 'American novelist best known for "To Kill a Mockingbird".'),
    ('George Orwell', 'English novelist, essayist, journalist, and critic.'),
    ('J.R.R. Tolkien', 'English writer, poet, philologist, and academic.'),
    ('Agatha Christie', 'English writer best known for her detective novels.'),
    ('Ernest Hemingway', 'American novelist, short-story writer, and journalist.'),
    ('Virginia Woolf', 'English writer and one of the leading modernist authors.'),
    ('Mark Twain', 'American writer, humorist, and lecturer.');


INSERT INTO books (title, author_id, genre, publication_year, isbn) VALUES
    ('Pride and Prejudice', 1, 'Romance', 1813, '978-0141439518'),
    ('Sense and Sensibility', 1, 'Romance', 1811, '978-0141439662'),
    ('Emma', 1, 'Romance', 1815, '978-0141439587'),
    ('Great Expectations', 2, 'Classic', 1861, '978-0141439563'),
    ('A Tale of Two Cities', 2, 'Historical Fiction', 1859, '978-0141439600'),
    ('David Copperfield', 2, 'Classic', 1850, '978-0141439440'),
    ('The Great Gatsby', 3, 'Fiction', 1925, '978-0743273565'),
    ('Tender Is the Night', 3, 'Fiction', 1934, '978-0684801544'),
    ('To Kill a Mockingbird', 4, 'Fiction', 1960, '978-0061120084'),
    ('Go Set a Watchman', 4, 'Fiction', 2015, '978-0062409850'),
    ('Nineteen Eighty-Four', 5, 'Dystopian', 1949, '978-0451524935'),
    ('Animal Farm', 5, 'Dystopian', 1945, '978-0451526342'),
    ('The Hobbit', 6, 'Fantasy', 1937, '978-0547928227'),
    ('The Lord of the Rings: The Fellowship of the Ring', 6, 'Fantasy', 1954, '978-0547928210'),
    ('The Lord of the Rings: The Two Towers', 6, 'Fantasy', 1954, '978-0547928203'),
    ('The Lord of the Rings: The Return of the King', 6, 'Fantasy', 1955, '978-0547928197'),
    ('Murder on the Orient Express', 7, 'Mystery', 1934, '978-0062693662'),
    ('Death on the Nile', 7, 'Mystery', 1937, '978-0062073556'),
    ('The Old Man and the Sea', 8, 'Fiction', 1952, '978-0684801223'),
    ('A Farewell to Arms', 8, 'War', 1929, '978-0684801469'),
    ('Mrs Dalloway', 9, 'Modernist', 1925, '978-0156628709'),
    ('To the Lighthouse', 9, 'Modernist', 1927, '978-0156907392'),
    ('The Adventures of Tom Sawyer', 10, 'Adventure', 1876, '978-0142437179'),
    ('The Adventures of Huckleberry Finn', 10, 'Adventure', 1884, '978-0142437174');


INSERT INTO members (name, email, phone, join_date) VALUES
    ('Alice Johnson', 'alice.johnson@email.com', '555-0101', '2024-01-15'),
    ('Bob Smith', 'bob.smith@email.com', '555-0102', '2024-02-01'),
    ('Carol Williams', 'carol.w@email.com', '555-0103', '2024-03-10'),
    ('David Brown', 'david.brown@email.com', '555-0104', '2024-04-05'),
    ('Eva Martinez', 'eva.m@email.com', '555-0105', '2024-05-20'),
    ('Frank Wilson', 'frank.wilson@email.com', '555-0106', '2024-06-15'),
    ('Grace Lee', 'grace.lee@email.com', '555-0107', '2024-07-01'),
    ('Henry Taylor', 'henry.t@email.com', '555-0108', '2024-08-01'),
    ('Irene Anderson', 'irene.a@email.com', '555-0109', '2024-09-05'),
    ('James Thomas', 'james.t@email.com', '555-0110', '2024-10-01');

INSERT INTO loans (book_id, member_id, loan_date, due_date, returned_date) VALUES
    -- Current loans (not returned)
    (1, 1, '2025-01-01', '2025-01-15', NULL),
    (3, 2, '2025-01-02', '2025-01-16', NULL),
    (7, 3, '2025-01-03', '2025-01-17', NULL),
    (11, 4, '2025-01-04', '2025-01-18', NULL),
    (13, 5, '2025-01-05', '2025-01-19', NULL),
    (17, 6, '2025-01-06', '2025-01-20', NULL),
    (19, 7, '2025-01-07', '2025-01-21', NULL),
    (21, 8, '2025-01-08', '2025-01-22', NULL),
    (23, 9, '2025-01-09', '2025-01-23', NULL),
    (5, 10, '2025-01-10', '2025-01-24', NULL),
    
    -- Overdue loans (not returned, past due date)
    (2, 1, '2024-12-15', '2024-12-29', NULL),
    (4, 3, '2024-12-16', '2024-12-30', NULL),
    (8, 5, '2024-12-17', '2024-12-31', NULL),
    (12, 7, '2024-12-18', '2025-01-01', NULL),
    (14, 9, '2024-12-19', '2025-01-02', NULL),
    (18, 2, '2024-12-20', '2025-01-03', NULL),
    (20, 4, '2024-12-21', '2025-01-04', NULL),
    (22, 6, '2024-12-22', '2025-01-05', NULL),
    (24, 8, '2024-12-23', '2025-01-06', NULL),
    (6, 10, '2024-12-24', '2025-01-07', NULL),
    
    -- Returned loans
    (9, 1, '2024-11-01', '2024-11-15', '2024-11-14'),
    (10, 2, '2024-11-05', '2024-11-19', '2024-11-18'),
    (15, 3, '2024-11-10', '2024-11-24', '2024-11-23'),
    (16, 4, '2024-11-15', '2024-11-29', '2024-11-28'),
    (2, 5, '2024-11-20', '2024-12-04', '2024-12-03'),
    (4, 6, '2024-11-25', '2024-12-09', '2024-12-08'),
    (6, 7, '2024-12-01', '2024-12-15', '2024-12-14'),
    (8, 8, '2024-12-05', '2024-12-19', '2024-12-18'),
    (1, 9, '2024-12-10', '2024-12-24', '2024-12-23'),
    (3, 10, '2024-12-12', '2024-12-26', '2024-12-25'),
    
    -- More returned loans for history
    (11, 1, '2024-10-01', '2024-10-15', '2024-10-14'),
    (13, 2, '2024-10-05', '2024-10-19', '2024-10-18'),
    (17, 3, '2024-10-10', '2024-10-24', '2024-10-23'),
    (19, 4, '2024-10-15', '2024-10-29', '2024-10-28'),
    (21, 5, '2024-10-20', '2024-11-03', '2024-11-02'),
    (23, 6, '2024-10-25', '2024-11-08', '2024-11-07'),
    (5, 7, '2024-11-01', '2024-11-15', '2024-11-14'),
    (7, 8, '2024-11-05', '2024-11-19', '2024-11-18'),
    (12, 9, '2024-11-10', '2024-11-24', '2024-11-23'),
    (14, 10, '2024-11-15', '2024-11-29', '2024-11-28');

SELECT setval('authors_author_id_seq', (SELECT MAX(author_id) FROM authors));
SELECT setval('books_book_id_seq', (SELECT MAX(book_id) FROM books));
SELECT setval('members_member_id_seq', (SELECT MAX(member_id) FROM members));
SELECT setval('loans_loan_id_seq', (SELECT MAX(loan_id) FROM loans));