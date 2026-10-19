DROP DATABASE IF EXISTS day2;

create database day2;
use day2;

DROP TABLE IF EXISTS books;

CREATE TABLE books (
    book_id INT IDENTITY(1,1) PRIMARY KEY,
    title VARCHAR(100),
    author_fname VARCHAR(100),
    author_lname VARCHAR(100),
    released_year INT,
    stock_quantity INT,
    pages INT
);

Select * from books

INSERT INTO
    books (
        title,
        author_fname,
        author_lname,
        released_year,
        stock_quantity,
        pages
    )
VALUES
    (
        'The Namesake',
        'Jhumpa',
        'Lahiri',
        2003,
        32,
        291
    ),
    (
        'Norse Mythology',
        'Neil',
        'Gaiman',
        2016,
        43,
        304
    ),
    ('American Gods', 'Neil', 'Gaiman', 2001, 12, 465),
    (
        'Interpreter of Maladies',
        'Jhumpa',
        'Lahiri',
        1996,
        97,
        198
    ),
    (
        'A Hologram for the King: A Novel',
        'Dave',
        'Eggers',
        2012,
        154,
        352
    ),
    ('The Circle', 'Dave', 'Eggers', 2013, 26, 504),
    (
        'The Amazing Adventures of Kavalier & Clay',
        'Michael',
        'Chabon',
        2000,
        68,
        634
    ),
    ('Just Kids', 'Patti', 'Smith', 2010, 55, 304),
    (
        'A Heartbreaking Work of Staggering Genius',
        'Dave',
        'Eggers',
        2001,
        104,
        437
    ),
    ('Coraline', 'Neil', 'Gaiman', 2003, 100, 208),
    (
        'What We Talk About When We Talk About Love: Stories',
        'Raymond',
        'Carver',
        1981,
        23,
        176
    ),
    (
        'Where I''m Calling From: Selected Stories',
        'Raymond',
        'Carver',
        1989,
        12,
        526
    ),
    ('White Noise', 'Don', 'DeLillo', 1985, 49, 320),
    (
        'Cannery Row',
        'John',
        'Steinbeck',
        1945,
        95,
        181
    ),
    (
        'Oblivion: Stories',
        'David',
        'Foster Wallace',
        2004,
        172,
        329
    ),
    (
        'Consider the Lobster',
        'David',
        'Foster Wallace',
        2005,
        92,
        343
    );

select * from books;

SELECT
    CONCAT('pi', 'ckle');

SELECT
    CONCAT(author_fname, ' ', author_lname) AS author_name
FROM
    books;

SELECT
    CONCAT_WS('-', title, author_fname, author_lname) as "BookName-Author"
FROM
    books;

SELECT
    SUBSTRING('Hello World', 1, 4);


SELECT
    SUBSTRING(title, 1, 10) AS 'short title'
FROM
    books;


SELECT
    CONCAT (
        SUBSTRING(title, 1, 10),
        '...'
    ) AS 'short title'
FROM
    books;

SELECT
    REPLACE('Hello World', 'Hell', '%$#@');

SELECT
    REPLACE('Hello World', 'l', '7');

SELECT
    REPLACE('Hello World', 'o', '0');

SELECT
    REPLACE('HellO World', 'o', '*');

SELECT
    REPLACE('cheese bread coffee milk', ' ', ' and ');

SELECT
    REPLACE(title, 'e ', '3')
FROM
    books;

SELECT
    REPLACE(title, ' ', '-')
FROM
    books;

SELECT
    REVERSE('Hello World');

SELECT
    REVERSE('meow meow');

SELECT
    REVERSE(author_fname)
FROM
    books;

SELECT
    CONCAT('woof', REVERSE('woof'));

SELECT
    CONCAT(author_fname, REVERSE(author_fname))
FROM
    books;

SELECT
    len('Hello World');

SELECT
    len(title) as length,
    title
FROM
    books;

SELECT
    author_lname,
    len(author_lname) AS 'length'
FROM
    books;

SELECT
    CONCAT(
        author_lname,
        ' is ',
        len(author_lname),
        ' characters long'
    ) as lnamelength
FROM
    books;

SELECT
    UPPER('Hello World');

SELECT
    LOWER('Hello World');

SELECT
    UPPER(title)
FROM
    books;

SELECT
    CONCAT('MY FAVORITE BOOK IS ', UPPER(title))
FROM
    books;

SELECT
    CONCAT('MY FAVORITE BOOK IS ', LOWER(title))
FROM
    books;



SELECT
    LEFT('omghahalol!', 3);

SELECT
    RIGHT('omghahalol!', 4);

SELECT
    TRIM('  pickle  ');

SELECT
    REVERSE(
        UPPER('Why does my cat look at me with such hatred?')
    );

SELECT
    REPLACE(title, ' ', '-&gt;') AS title
FROM
    books;

SELECT
    author_lname AS forwards,
    REVERSE(author_lname) AS backwards
FROM
    books;

SELECT
    UPPER(CONCAT(author_fname, ' ', author_lname)) AS 'full name in caps'
FROM
    books;

SELECT
    CONCAT(title, ' was released in ', released_year) AS blurb
FROM
    books;

SELECT
    title,
    len(title) AS character_count
FROM
    books;

SELECT
    CONCAT(SUBSTRING(title, 1, 10), '...') AS short_title,
    CONCAT(author_lname, ',', author_fname) AS author,
    CONCAT(stock_quantity, ' in stock') AS quantity
FROM
    books;


SELECT
    author_lname
FROM
    books;

SELECT
    DISTINCT author_lname
FROM
    books;

SELECT
    author_fname,
    author_lname
FROM
    books;

SELECT
    DISTINCT CONCAT(author_fname, ' ', author_lname) AS FullName
FROM
    books;

SELECT
    *
FROM
    books
ORDER BY
    author_lname;

SELECT
    *
FROM
    books
ORDER BY
    author_lname DESC;

SELECT
    *
FROM
    books
ORDER BY
    released_year;

SELECT
    book_id,
    author_fname,
    author_lname,
    pages
FROM
    books
ORDER BY
    2 desc;

SELECT
    book_id,
    author_fname,
    author_lname,
    pages
FROM
    books
ORDER BY
    author_lname,
    author_fname;

SELECT top 3
    title
FROM
    books;


SELECT top 5
    title,
    released_year
FROM
    books
ORDER BY
    released_year DESC;

SELECT
    title,
    author_fname,
    author_lname,
    pages
FROM
    books
WHERE
    author_fname LIKE '%da%';

SELECT
    title,
    author_fname,
    author_lname,
    pages
FROM
    books
WHERE
    title LIKE '%:%';

SELECT
    *
FROM
    books
WHERE
    author_fname LIKE '____';

SELECT
    *
FROM
    books
WHERE
    author_fname LIKE '_a_';

    select * from books;

  

-- To select books with '%' in their title:
SELECT
    *
FROM
    books
WHERE
    title LIKE '%\%%' ESCAPE '\';

-- To select books with an underscore '_' in title:
SELECT
    *
FROM
    books
WHERE
    title LIKE '%:%';

SELECT
    title
FROM
    books
WHERE
    title LIKE '%stories%';

--Logical-Comparison Operator

SELECT
    *
FROM
    books
WHERE
    released_year != 2017;

SELECT
    *
FROM
    books
WHERE
    title NOT LIKE '%e%';

SELECT
    *
FROM
    books
WHERE
    released_year > 2005;

SELECT
    *
FROM
    books
WHERE
    pages > 500;

SELECT
    *
FROM
    books
WHERE
    pages < 200;

SELECT
    *
FROM
    books
WHERE
    released_year < 2000;

SELECT
    *
FROM
    books
WHERE
    released_year <= 1985;

SELECT
    title,
    author_lname,
    released_year
FROM
    books
WHERE
    released_year > 2010
    AND author_lname = 'Eggers';

SELECT
    title,
    author_lname,
    released_year
FROM
    books
WHERE
    released_year > 2010
    AND author_lname = 'Eggers'
    AND title LIKE '%novel%';

SELECT
    title,
    pages
FROM
    books
WHERE
    len(title) > 30
    AND pages > 500;

SELECT
    title,
    author_lname
FROM
    books
WHERE
    author_lname = 'Eggers'
    AND released_year > 2010;

SELECT
    title,
    author_lname,
    released_year
FROM
    books
WHERE
    author_lname = 'Eggers'
    OR released_year > 2010;

SELECT
    title,
    pages
FROM
    books
WHERE
    pages < 200
    OR title LIKE '%stories%';

SELECT
    title,
    released_year
FROM
    books
WHERE
    released_year <= 2015
    AND released_year >= 2004;

SELECT
    title,
    released_year
FROM
    books
WHERE
    released_year BETWEEN 2004
    AND 2014;


SELECT
    title,
    author_lname
FROM
    books
WHERE
    author_lname = 'Carver'
    OR author_lname = 'Lahiri'
    OR author_lname = 'Smith';

SELECT
    title,
    author_lname
FROM
    books
WHERE
    author_lname IN ('Carver', 'Lahiri', 'Smith');

SELECT
    title,
    author_lname
FROM
    books
WHERE
    author_lname NOT IN ('Carver', 'Lahiri', 'Smith');

SELECT
    title,
    released_year
FROM
    books
WHERE
    released_year >= 2000
    AND released_year % 2 = 1;

SELECT
    title,
    released_year,
    CASE
        WHEN released_year >= 2000 THEN 'modern literature'
        ELSE '20th century literature'
    END AS genre
FROM
    books;

SELECT
    title,
    stock_quantity,
    CASE
        WHEN stock_quantity BETWEEN 0
        AND 40 THEN '*'
        WHEN stock_quantity BETWEEN 41
        AND 70 THEN '**'
        WHEN stock_quantity BETWEEN 71
        AND 100 THEN '***'
        WHEN stock_quantity BETWEEN 101
        AND 140 THEN '****'
        ELSE '*****'
    END AS stock
FROM
    books;

SELECT
    title,
    stock_quantity,
    CASE
        WHEN stock_quantity <= 40 THEN '*'
        WHEN stock_quantity <= 70 THEN '**'
        WHEN stock_quantity <= 100 THEN '***'
        WHEN stock_quantity <= 140 THEN '****'
        ELSE '*****'
    END AS stock
FROM
    books;

SELECT
    *
FROM
    books
WHERE
    released_year < 1980;

SELECT
    *
FROM
    books
WHERE
    author_lname = 'Eggers'
    OR author_lname = 'Chabon';

SELECT
    *
FROM
    books
WHERE
    author_lname = 'Lahiri'
    AND released_year > 2000;

SELECT
    *
FROM
    books
WHERE
    pages >= 100
    AND pages <= 200;

SELECT
    *
FROM
    books
WHERE
    pages BETWEEN 100
    and 200;

SELECT
    title,
    author_lname
FROM
    books
WHERE
    author_lname LIKE 'C%'
    OR author_lname LIKE 'S%';

SELECT
    title,
    author_lname
FROM
    books
WHERE
    SUBSTRING(author_lname, 1, 1) in ('C', 'S');


SELECT
    author_fname,
    author_lname,
    CASE
        WHEN COUNT(*) = 1 THEN '1 book'
        ELSE CONCAT(COUNT(*), ' books')
    END AS count
FROM
    books
WHERE
    author_lname IS NOT NULL
GROUP BY
    author_fname,
    author_lname;



--Aggregate Function

SELECT
    COUNT(*)
FROM
    books;

SELECT
    COUNT(author_lname)
FROM
    books;

SELECT
    COUNT(DISTINCT author_lname)
FROM
    books;

SELECT
    author_lname,
    COUNT(*) as books_written
FROM
    books
GROUP BY
    author_lname;

SELECT
    author_lname,
    COUNT(*) AS books_written
FROM
    books
GROUP BY
    author_lname
ORDER BY
    books_written DESC;

select * from books;



SELECT
    title,
    pages
FROM
    books
WHERE
    pages = (
        SELECT
            MAX(pages)
        FROM
            books
    );

SELECT
    MIN(released_year)
FROM
    books;

SELECT
    title,
    released_year
FROM
    books
WHERE
    released_year = (
        SELECT
            MIN(released_year)
        FROM
            books
    );

SELECT
    author_fname,
    author_lname,
    COUNT(*)
FROM
    books
GROUP BY
    author_lname,
    author_fname;

SELECT
    CONCAT(author_fname, ' ', author_lname) AS author,
    COUNT(*)
FROM
    books
GROUP BY
    CONCAT(author_fname, ' ', author_lname);

SELECT
    author_lname,
    MIN(released_year)
FROM
    books
GROUP BY
    author_lname;

SELECT
    author_lname,
    MAX(released_year),
    MIN(released_year)
FROM
    books
GROUP BY
    author_lname;

SELECT
    author_lname,
    COUNT(*) as books_written,
    MAX(released_year) AS latest_release,
    MIN(released_year) AS earliest_release,
    MAX(pages) AS longest_page_count
FROM
    books
GROUP BY
    author_lname;

SELECT
    author_lname,
    author_fname,
    COUNT(*) as books_written,
    MAX(released_year) AS latest_release,
    MIN(released_year) AS earliest_release
FROM
    books
GROUP BY
    author_lname,
    author_fname;

SELECT
    SUM(pages)
FROM
    books;

SELECT
    author_lname,
    COUNT(*),
    SUM(pages)
FROM
    books
GROUP BY
    author_lname;

SELECT
    AVG(pages)
FROM
    books;

SELECT
    AVG(released_year)
FROM
    books;

SELECT
    released_year,
    AVG(stock_quantity),
    COUNT(*)
FROM
    books
GROUP BY
    released_year;

SELECT
    COUNT(*)
FROM
    books;

SELECT
    released_year,
    COUNT(*)
FROM
    books
GROUP BY
    released_year;

SELECT
    AVG(released_year)
FROM
    books
GROUP BY
    author_lname,
    author_fname;

SELECT
    CONCAT(author_fname, ' ', author_lname) AS author,
    pages
FROM
    books
WHERE
    pages = (
        SELECT
            MAX(pages)
        FROM
            books
    );