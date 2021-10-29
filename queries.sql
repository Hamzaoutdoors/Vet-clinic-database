/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals WHERE name Like '%mon';
SELECT name from animals WHERE EXTRACT(YEAR FROM date_of_birth) BETWEEN 2016 AND 2019;
SELECT name from animals WHERE neutered = true  AND escape_attempts < 3;
SELECT date_of_birth from animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts from animals WHERE weight_kg > 10.5;
SELECT * from animals WHERE neutered = true;
SELECT * from animals WHERE name <>'Gabumon';
SELECT * from animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

BEGIN;
UPDATE animals SET species = 'unspecified';
ROLLBACK;

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
COMMIT;

BEGIN;
DELETE FROM animals; /* with a deep breath :) */
ROLLBACK; 

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT delete_animals;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO SAVEPOINT delete_animals;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

SELECT COUNT(*) FROM animals;

SELECT COUNT(escape_attempts) FROM animals WHERE escape_attempts = 0;

SELECT AVG(weight_kg) FROM animals;

SELECT neutered, SUM(escape_attempts) FROM animals GROUP BY neutered;

SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;

SELECT species, AVG(escape_attempts) 
FROM animals 
WHERE EXTRACT(YEAR FROM date_of_birth) 
BETWEEN 1990 AND 2000 
GROUP BY species;

/* Query multiple tables */

    /* Modify animals table: */

CREATE SEQUENCE animals_id_seq;
ALTER TABLE animals ALTER COLUMN id SET DEFAULT nextval('animals_id_seq');

ALTER TABLE animals DROP COLUMN species;

ALTER TABLE animals ADD species_id INTEGER;
ALTER TABLE animals ADD CONSTRAINT fk_animals_species FOREIGN KEY (species_id) REFERENCES species (specie_id);

ALTER TABLE animals ADD owners_id INTEGER;
ALTER TABLE animals ADD CONSTRAINT fk_animals_owners FOREIGN KEY (owners_id) REFERENCES owners (owner_id);

   /* Modify your inserted animals so it includes the species_id value */

UPDATE animals SET species_id = (SELECT specie_id FROM species WHERE name LIKE 'Digimon') WHERE name LIKE '%mon';
UPDATE animals SET species_id = (SELECT specie_id FROM species WHERE name LIKE 'Pokemon') WHERE name NOT LIKE '%mon';

   /* Modify your inserted animals to include owner information (owner_id):  */

UPDATE animals 
SET owners_id = (SELECT owner_id FROM owners WHERE full_name = 'Sam Smith') 
WHERE name Like '%Agumon%';

UPDATE animals 
SET owners_id = (SELECT owner_id FROM owners WHERE full_name = 'Jennifer Orwell') 
WHERE name IN ('Gabumon', 'Pikachu');

UPDATE animals 
SET owners_id = (SELECT owner_id FROM owners WHERE full_name = 'Bob') 
WHERE name IN ('Devimon', 'Plantmon');

UPDATE animals 
SET owners_id = (SELECT owner_id FROM owners WHERE full_name = 'Melody Pond') 
WHERE name IN ('Charmandar', 'Squirtle', 'Blossom');

UPDATE animals 
SET owners_id = (SELECT owner_id FROM owners WHERE full_name = 'Melody Pond') 
WHERE name IN ('Angemon', 'Boarmon');

   /* Using JOIN to answer question */

/* What animals belong to Melody Pond? */

SELECT o.full_name, a.name 
FROM owners o 
INNER JOIN animals a 
ON o.owner_id = a.owners_id
WHERE o.full_name LIKE 'Melody Pond';

/* List of all animals that are pokemon */

SELECT a.name 
FROM species s 
INNER JOIN animals a
ON s.specie_id = a.species_id
WHERE s.name LIKE 'Pokemon';

/* List all owners and their animals, 
remember to include those that don't own any animal. */

SELECT o.full_name, a.name
FROM owners o
LEFT JOIN animals a
ON o.owner_id = a.owners_id;

/* How many animals are there per species? */

SELECT s.name, COUNT(a.species_id) As num
FROM species s
FULL JOIN animals a
ON s.specie_id = a.species_id
GROUP BY s.name;

/* List all Digimon owned by Jennifer Orwell */

SELECT o.full_name, a.name AS Digimon
FROM owners o
LEFT JOIN animals a
ON o.owner_id = a.owners_id
LEFT JOIN species S
ON S.specie_id = a.species_id
WHERE o.full_name LIKE 'Jennifer Orwell'
AND S.name LIKE 'Digimon'

/* List all animals owned by Dean Winchester that haven't tried to escape. */

SELECT o.full_name, a.name
FROM owners O 
INNER JOIN animals A
ON O.owner_id = A.owners_id
INNER JOIN species S
ON S.specie_id = A.species_id
WHERE full_name LIKE 'Dean Winchester'
AND A.escape_attempts = 0;

/* Who owns the most animals? */

SELECT O.full_name, COUNT(*) 
FROM owners O
JOIN animals A
ON O.owner_id = A.owners_id
GROUP BY O.full_name
HAVING COUNT(*)> 2;

/* Who was the last animal seen by William Tatcher? */

SELECT name AS animalName
FROM animals
WHERE id = (
   SELECT id_animal 
   FROM visits 
   WHERE vet_id = (
      SELECT vet_id 
      FROM vets 
      WHERE name LIKE 'William Tatcher') 
      ORDER BY date_visit DESC 
      LIMIT 1 );

/* How many different animals did Stephanie Mendez see? */

---

SELECT ve.name, COUNT(*) AS Animals
FROM vets ve
INNER JOIN visits vi
ON ve.vet_id = vi.vet_id
GROUP BY ve.name
Having ve.name LIKE 'Stephanie Mendez';

--- List of animals

SELECT DISTINCT animals.name
FROM visits
LEFT JOIN animals ON animals.id = visits.id_animal
LEFT JOIN vets ON vets.vet_id = visits.vet_id
WHERE vets.name = 'Stephanie Mendez';

/* List all vets and their specialties, 
including vets with no specialties */

SELECT v.name as vet_name, sp.name as specie_name
FROM vets v
LEFT JOIN specializations s
ON v.vet_id = s.vet_id
LEFT JOIN species sp
ON s.specie_id = sp.specie_id

/* List all animals that visited Stephanie Mendez 
between April 1st and August 30th, 2020. */

SELECT a.name as animal, vi.date_visit
FROM animals a 
LEFT JOIN visits vi
ON a.id = vi.id_animal
LEFT JOIN vets v 
ON vi.vet_id = v.vet_id
WHERE v.name LIKE 'Stephanie Mendez' 
AND vi.date_visit BETWEEN '2020-04-01' AND '2020-08-30';

/* What animal has the most visits to vets? */

SELECT a.name as animal, COUNT(*)
FROM visits v 
INNER JOIN animals a
ON v.id_animal = a.id
GROUP BY a.name
ORDER BY count DESC
LIMIT 1 

/* Who was Maisy Smith's first visit? */

SELECT animals.name, visits.date_visit
FROM visits
LEFT JOIN animals ON animals.id = visits.id_animal
LEFT JOIN vets ON vets.vet_id = visits.vet_id
WHERE vets.name = 'Maisy Smith'
ORDER BY visits.date_visit ASC
LIMIT 1;

/* Details for most recent visit: animal information, 
vet information, and date of visit. */

SELECT animals.*, vets.*, visits.date_visit
FROM visits
LEFT JOIN animals ON animals.id = visits.id_animal
LEFT JOIN vets ON vets.vet_id = visits.vet_id
ORDER BY visits.date_visit DESC
LIMIT 1;

/* How many visits were with a vet 
that did not specialize in that animal's species? */

SELECT count(*)
FROM visits
LEFT JOIN animals ON animals.id = visits.id_animal
LEFT JOIN vets ON vets.vet_id = visits.vet_id
WHERE animals.species_id NOT IN 
  (
   SELECT specie_id 
   FROM specializations 
   WHERE vet_id = vets.vet_id
   )

/* What specialty should Maisy Smith consider getting? 
Look for the species she gets the most. */

SELECT species.name, count(*)
FROM visits
LEFT JOIN animals ON animals.id = visits.id_animal
LEFT JOIN species ON animals.species_id = species.specie_id
LEFT JOIN vets ON vets.vet_id = visits.vet_id
WHERE vets.name = 'Maisy Smith'
GROUP BY species.name
ORDER BY COUNT DESC
LIMIT 1;

------------------------------------------------------------------