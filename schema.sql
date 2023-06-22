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

CREATE TABLE owners (
	id serial PRIMARY KEY,
	full_name char(25),
	age int
);

CREATE TABLE species (
	id serial PRIMARY KEY,
	name char(25)
);

ALTER TABLE animals
DROP species;

ALTER TABLE animals
ADD species_id int
REFERENCES species(id);

ALTER TABLE animals
ADD owner_id int 
REFERENCES owners(id);