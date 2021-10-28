/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id int NOT NULL  PRIMARY KEY,
	name VARCHAR(100),
	date_of_birth date NOT NULL,
	escape_attempts integer,
	neutered boolean NOT NULL,
	weight_kg numeric NOT NULL,
	species VARCHAR(50)
);

CREATE TABLE owners (
    owner_id SERIAL,
	full_name VARCHAR(100) NOT NULL,
	age INT NOT NULL,
	PRIMARY KEY (id_owner)
);

CREATE TABLE species (
    specie_id SERIAL,
	name VARCHAR(100) NOT NULL,
	PRIMARY KEY (specie_id)
);

