/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id int NOT NULL  PRIMARY KEY,
	name VARCHAR(100),
	date_of_birth date NOT NULL,
	escape_attempts integer,
	neutered boolean NOT NULL,
	weight_kg numeric NOT NULL
);
