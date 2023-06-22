/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

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

SELECT species, AVG(escape_attempts) 
FROM animals
WHERE  date_of_birth >= '1990-01-01' AND date_of_birth <= '2000-12-31'
GROUP BY species

/*--- Multiple table ---*/

SELECT name FROM animals 
JOIN owners ON animals.owner_id = owners.id 
WHERE owners.full_name='Melody Pond';

SELECT animals.name FROM animals 
JOIN species ON animals.species_id = species.id 
WHERE species.name='Pokemon';

SELECT full_name, name 
FROM owners FULL JOIN animals 
ON owners.id = animals.owner_id;

SELECT species.name,COUNT(*) 
FROM animals JOIN species ON animals.species_id=species.id 
GROUP BY species.name;

SELECT animals.name 
FROM animals JOIN owners ON animals.owner_id = owners.id 
JOIN species ON animals.species_id=species.id 
WHERE owners.full_name = 'Jennifer Orwell' 
AND species.name='Digimon';

SELECT name FROM animals 
JOIN owners ON animals.owner_id=owners.id 
WHERE owners.full_name = 'Dean Winchester' 
AND escape_attempts=0;

SELECT full_name, COUNT(animals.name)
FROM owners JOIN animals ON animals.owner_id = owners.id
GROUP BY owners.full_name
ORDER BY COUNT(animals.name) DESC LIMIT 1;