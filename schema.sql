/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
	id serial PRIMARY KEY,
	name char(25),
	date_of_birth date,
	escape_attempts int,
	neutered boolean,
	weight_kg decimal
);

ALTER TABLE animals 
ADD COLUMN species char(25);

/*--- Transactions ---*/

BEGIN;
UPDATE animals
SET species = 'unspecified';

SELECT * FROM animals;
ROLLBACK;

BEGIN;
UPDATE animals 
SET species = 'digimon'
WHERE name LIKE '%mon';

SELECT * FROM animals;

UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;
COMMIT;

BEGIN;
DELETE FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals
WHERE date_of_birth > '2022-01-01';
SAVEPOINT my_savepoint;
UPDATE animals
SET weight_kg = weight_kg * -1;
ROLLBACK TO SAVEPOINT my_savepoint;
UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 1;
COMMIT;
SELECT * FROM animals;

/*--- Queries ---*/

SELECT COUNT(*) 
FROM animals;

SELECT COUNT(*) 
FROM animals
WHERE escape_attempts = 0;

SELECT AVG(weight_kg)
FROM animals;

SELECT neutered, SUM(escape_attempts) 
FROM animals 
GROUP BY neutered;

SELECT species, 
MIN(weight_kg), MAX(weight_kg)
FROM animals
GROUP BY species;

SELECT species,
AVG(escape_attempts)
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '1999-12-31'
GROUP BY species;