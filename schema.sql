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

CREATE TABLE vets(
	id serial PRIMARY KEY,
	age int,
	name char(25),
	date_of_graduation date
);

CREATE TABLE specializations(
	species_id int,
	vets_id int,
	PRIMARY KEY(species_id, vets_id),
	FOREIGN KEY (species_id) REFERENCES species(id),
	FOREIGN KEY (vets_id) REFERENCES vets(id)
);

CREATE TABLE visits (
	animals_id int, 
	vets_id int,
	date_of_visit date,
	PRIMARY KEY(animals_id, vets_id, date_of_visit),
	FOREIGN KEY (animals_id) REFERENCES animals(id), 
	FOREIGN KEY (vets_id) REFERENCES vets(id)
);