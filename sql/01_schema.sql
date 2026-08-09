
DROP TABLE IF EXISTS authors CASCADE;
CREATE TABLE authors (
    author_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    bio TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE authors IS 'Authors who have written books in the library';
COMMENT ON COLUMN authors.author_id IS 'Unique identifier for each author';
COMMENT ON COLUMN authors.name IS 'Full name of the author';


DROP TABLE IF EXISTS books CASCADE;
CREATE TABLE books (
    book_id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    author_id INTEGER NOT NULL,
    genre TEXT,
    publication_year INTEGER,
    isbn TEXT UNIQUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT fk_book_author 
        FOREIGN KEY (author_id) 
        REFERENCES authors(author_id)
        ON DELETE RESTRICT,
    
    CONSTRAINT chk_publication_year 
        CHECK (publication_year >= 0 AND publication_year <= EXTRACT(YEAR FROM CURRENT_DATE))
);

COMMENT ON TABLE books IS 'Books available in the library inventory';
COMMENT ON COLUMN books.book_id IS 'Unique identifier for each book';
COMMENT ON COLUMN books.title IS 'Book title';
COMMENT ON COLUMN books.author_id IS 'Foreign key to authors table';
COMMENT ON COLUMN books.genre IS 'Book genre/category';
COMMENT ON COLUMN books.publication_year IS 'Year the book was published';
COMMENT ON COLUMN books.isbn IS 'International Standard Book Number (unique)';


CREATE INDEX idx_books_author_id ON books(author_id);
CREATE INDEX idx_books_genre ON books(genre);
CREATE INDEX idx_books_title ON books(title);


DROP TABLE IF EXISTS members CASCADE;
CREATE TABLE members (
    member_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    phone TEXT,
    join_date DATE NOT NULL DEFAULT CURRENT_DATE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT chk_email_format 
        CHECK (email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$')
);

COMMENT ON TABLE members IS 'Library members who can borrow books';
COMMENT ON COLUMN members.member_id IS 'Unique identifier for each member';
COMMENT ON COLUMN members.name IS 'Full name of the member';
COMMENT ON COLUMN members.email IS 'Email address (unique, used for communication)';
COMMENT ON COLUMN members.join_date IS 'Date the member joined the library';


CREATE INDEX idx_members_email ON members(email);


DROP TABLE IF EXISTS loans CASCADE;
CREATE TABLE loans (
    loan_id SERIAL PRIMARY KEY,
    book_id INTEGER NOT NULL,
    member_id INTEGER NOT NULL,
    loan_date DATE NOT NULL DEFAULT CURRENT_DATE,
    due_date DATE NOT NULL,
    returned_date DATE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT fk_loan_book 
        FOREIGN KEY (book_id) 
        REFERENCES books(book_id)
        ON DELETE RESTRICT,
    
    CONSTRAINT fk_loan_member 
        FOREIGN KEY (member_id) 
        REFERENCES members(member_id)
        ON DELETE CASCADE,
    
    CONSTRAINT chk_loan_due_date 
        CHECK (due_date >= loan_date),
    
    CONSTRAINT chk_returned_after_loan 
        CHECK (returned_date IS NULL OR returned_date >= loan_date)
);

COMMENT ON TABLE loans IS 'Records of books borrowed by members';
COMMENT ON COLUMN loans.loan_id IS 'Unique identifier for each loan transaction';
COMMENT ON COLUMN loans.book_id IS 'Foreign key to books table';
COMMENT ON COLUMN loans.member_id IS 'Foreign key to members table';
COMMENT ON COLUMN loans.loan_date IS 'Date the book was borrowed';
COMMENT ON COLUMN loans.due_date IS 'Date the book is expected to be returned';
COMMENT ON COLUMN loans.returned_date IS 'Date the book was actually returned (NULL = still out)';


CREATE INDEX idx_loans_book_id ON loans(book_id);
CREATE INDEX idx_loans_member_id ON loans(member_id);
CREATE INDEX idx_loans_due_date ON loans(due_date) WHERE returned_date IS NULL;
CREATE INDEX idx_loans_returned_date ON loans(returned_date);



DROP VIEW IF EXISTS current_loans;
CREATE VIEW current_loans AS
SELECT 
    l.loan_id,
    b.title AS book_title,
    a.name AS author_name,
    m.name AS member_name,
    m.email AS member_email,
    l.loan_date,
    l.due_date,
    EXTRACT(DAY FROM (CURRENT_DATE - l.loan_date)) AS days_borrowed
FROM loans l
JOIN books b ON l.book_id = b.book_id
JOIN authors a ON b.author_id = a.author_id
JOIN members m ON l.member_id = m.member_id
WHERE l.returned_date IS NULL;


DROP VIEW IF EXISTS overdue_loans;
CREATE VIEW overdue_loans AS
SELECT 
    l.loan_id,
    b.title AS book_title,
    m.name AS member_name,
    m.email AS member_email,
    l.due_date,
    EXTRACT(DAY FROM (CURRENT_DATE - l.due_date)) AS days_overdue
FROM loans l
JOIN books b ON l.book_id = b.book_id
JOIN members m ON l.member_id = m.member_id
WHERE l.returned_date IS NULL 
  AND CURRENT_DATE > l.due_date;