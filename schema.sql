-- Part 1

CREATE TABLE authors (
       id SERIAL PRIMARY KEY,
       name VARCHAR(100),
       email VARCHAR(100)
   );

CREATE TABLE books (
       id SERIAL PRIMARY KEY,
       title VARCHAR(200),
       isbn VARCHAR(20),
       publication_year INTEGER,
       author_id INTEGER REFERENCES authors(id)
   );

-- Insert authors
   INSERT INTO authors (name, email) VALUES ('F. Scott Fitzgerald', 'scott@example.com');
   INSERT INTO authors (name, email) VALUES ('George Orwell', 'george@example.com');

   -- Insert books (link to authors via author_id)
   INSERT INTO books (title, isbn, publication_year, author_id)
       VALUES ('The Great Gatsby', '9780743273565', 1925, 1);
   INSERT INTO books (title, isbn, publication_year, author_id)
       VALUES ('Tender Is the Night', '9780684801544', 1934, 1);
   INSERT INTO books (title, isbn, publication_year, author_id)
       VALUES ('1984', '9780451524935', 1949, 2);

-- Query to Verify
   SELECT b.title, b.isbn, b.publication_year, a.name, a.email
   FROM books b
   JOIN authors a ON b.author_id = a.id;

-- Part 2

CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100)
);
CREATE TABLE book_categories (
    book_id INTEGER REFERENCES books(id),
    category_id INTEGER REFERENCES categories(id),
    PRIMARY KEY (book_id, category_id)
);
INSERT INTO categories (name) VALUES
    ('Classic'),
    ('Dystopian'),
    ('Fiction');


-- The Great Gatsby: Classic, Fiction
INSERT INTO book_categories (book_id, category_id) VALUES (1, 1), (1, 3);

-- Tender Is the Night: Classic, Fiction
INSERT INTO book_categories (book_id, category_id) VALUES (2, 1), (2, 3);

-- 1984: Dystopian, Fiction
INSERT INTO book_categories (book_id, category_id) VALUES (3, 2), (3, 3);

SELECT 
    b.id AS book_id,
    b.title,
    b.isbn,
    b.publication_year,
    a.id AS author_id,
    a.name AS author_name,
    a.email AS author_email,
    c.id AS category_id,
    c.name AS category_name
FROM 
    books b
JOIN 
    authors a ON b.author_id = a.id
JOIN 
    book_categories bc ON b.id = bc.book_id
JOIN 
    categories c ON bc.category_id = c.id
ORDER BY 
    b.title;

SELECT 
    b.id AS book_id,
    b.title,
    b.isbn,
    b.publication_year,
    a.id AS author_id,
    a.name AS author_name,
    a.email AS author_email,
    STRING_AGG(c.name, ', ') AS category_list
FROM 
    books b
JOIN 
    authors a ON b.author_id = a.id
JOIN 
    book_categories bc ON b.id = bc.book_id
JOIN 
    categories c ON bc.category_id = c.id
GROUP BY 
    b.id, b.title, b.isbn, b.publication_year, a.id, a.name, a.email
ORDER BY 
    b.title;
