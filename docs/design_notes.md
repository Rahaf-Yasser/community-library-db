# Database Design Notes

## Problem Statement
A community library needs a database to track books, authors, members, and borrowing activity.

## Entities and Attributes
- **authors**: author_id (PK), name, bio
- **books**: book_id (PK), title, author_id (FK), genre, publication_year, isbn
- **members**: member_id (PK), name, email, phone, join_date
- **loans**: loan_id (PK), book_id (FK), member_id (FK), loan_date, due_date, returned_date

## Relationships
- One Author → Many Books (1:N)
- One Member → Many Loans (1:N)
- One Book → Many Loans (1:N)
- Books ↔ Members (Many-to-Many via the loans table)

## Normalization
The schema is normalized to **3NF**. All non-key attributes depend solely on the primary key, and there are no transitive dependencies.