DROP DATABASE IF EXISTS day2;

create database day2;
use day2;

-- Drop the current cats table (if you have one)
DROP TABLE IF EXISTS cats;

-- Create the new cats table:
CREATE TABLE cats (
    cat_id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(100),
    breed VARCHAR(100),
    age INT
);

-- Insert some cats:
INSERT INTO
    cats(name, breed, age)
VALUES
    ('Ringo', 'Tabby', 4),
    ('Cindy', 'Maine Coon', 10),
    ('Dumbledore', 'Maine Coon', 11),
    ('Egg', 'Persian', 4),
    ('Misty', 'Tabby', 13),
    ('George Michael', 'Ragdoll', 9),
    ('Jackson', 'Sphynx', 7);

-- --------------------------------------------------------------------
-- --------------------------------------------------------------------
-- --------------------------------------------------------------------
-- To get all the columns:
SELECT
    *
FROM
    cats;

-- To only get the age column:
SELECT
    age
FROM
    cats;

-- To select multiple specific columns:
SELECT
    name,
    breed
FROM
    cats;

-- --------------------------------------------------------------------
-- --------------------------------------------------------------------
-- --------------------------------------------------------------------
-- Use where to specify a condition:
SELECT
    *
FROM
    cats
WHERE
    age = 4;

SELECT
    *
FROM
    cats
WHERE
    name = 'Egg';

-- --------------------------------------------------------------------
-- --------------------------------------------------------------------
-- --------------------------------------------------------------------
-- CODE: Select Challenges Solution
SELECT
    cat_id
FROM
    cats;

SELECT
    name,
    breed
FROM
    cats;

SELECT
    name,
    age
FROM
    cats
WHERE
    breed = 'Tabby';

SELECT
    cat_id,
    age
FROM
    cats
WHERE
    cat_id = age;

SELECT
    *
FROM
    cats
WHERE
    cat_id = age;

-- --------------------------------------------------------------------
-- --------------------------------------------------------------------
-- --------------------------------------------------------------------
-- Use 'AS' to alias a column in your results (it doesn't actually change the name of the column in the table)
SELECT
    cat_id AS id,
    name
FROM
    cats;

-- --------------------------------------------------------------------
-- --------------------------------------------------------------------
-- --------------------------------------------------------------------
-- CODE: Updating Data Change tabby cats to shorthair:
UPDATE
    cats
SET
    breed = 'Shorthair'
WHERE
    breed = 'Tabby';

-- Another update:
UPDATE
    cats
SET
    age = 14
WHERE
    name = 'Misty';

Select * from cats

-- --------------------------------------------------------------------
-- --------------------------------------------------------------------
-- --------------------------------------------------------------------
-- CODE: Update Challenges Solution
SELECT
    *
FROM
    cats
WHERE
    name = 'Jackson';

UPDATE
    cats
SET
    name = 'Jack'
WHERE
    name = 'Jackson';

SELECT
    *
FROM
    cats
WHERE
    name = 'Jackson';

SELECT
    *
FROM
    cats
WHERE
    name = 'Jack';

SELECT
    *
FROM
    cats
WHERE
    name = 'Ringo';

UPDATE
    cats
SET
    breed = 'British Shorthair'
WHERE
    name = 'Ringo';

SELECT
    *
FROM
    cats
WHERE
    name = 'Ringo';

SELECT
    *
FROM
    cats;

SELECT
    *
FROM
    cats
WHERE
    breed = 'Maine Coon';

UPDATE
    cats
SET
    age = 12
WHERE
    breed = 'Maine Coon';

SELECT
    *
FROM
    cats
WHERE
    breed = 'Maine Coon';

-- --------------------------------------------------------------------
-- --------------------------------------------------------------------
-- --------------------------------------------------------------------
-- Delete all cats with name of 'Egg':
DELETE FROM
    cats
WHERE
    name = 'Egg';

-- Delete all rows in the cats table:
DELETE FROM
    cats;

-- --------------------------------------------------------------------
-- --------------------------------------------------------------------
-- --------------------------------------------------------------------
-- Delete all 4 year old cats:
DELETE FROM
    cats
WHERE
    age = 4;

-- Delete cats where cat_id is the same as their age:
DELETE FROM
    cats
WHERE
    cat_id = age;

-- Delete all cats:
DELETE FROM cats;

Select * from cats