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
