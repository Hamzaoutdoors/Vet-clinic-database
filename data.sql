/* Populate database with sample data. */

    /* animalss data */

INSERT INTO animalss VALUES (
1,
'Agumon',
'2020-02-03',
0,
true,
10.23
)

INSERT INTO animalss VALUES (
2,
'Gabumon',
'2018-11-15',
2,
true,
8
)

INSERT INTO animalss VALUES (
3,
'Pikachu',
'2021-01-07',
1,
false,
15.04
)

INSERT INTO animalss VALUES (
4,
'Devimon',
'2017-05-12',
5,
true,
11
)

INSERT INTO animalss VALUES (
5,
'Charmander',
'2020-02-08',
0,
false,
11
)

INSERT INTO animalss VALUES (
6,
'Plantmon',
'2022-11-15',
2,
true,
5.7
)

INSERT INTO animalss VALUES (
7,
'Squirtle',
'1993-04-02',
3,
false,
12.13
)

INSERT INTO animalss VALUES (
8,
'Angemon',
'2005-06-12',
1,
true,
45
)

INSERT INTO animalss VALUES (
9,
'Boarmon',
'2005-06-07',
7,
true,
20.4
)

INSERT INTO animalss VALUES (
10,
'Blossom',
'1998-10-13',
3,
true,
17
)

    /* Owners data */

INSERT INTO owners (owner_id, full_name, age)
VALUES (DEFAULT, 'Sam Smith', 34);

INSERT INTO owners (owner_id, full_name, age) 
VALUES (DEFAULT, 'Jennifer Orwell', 19);

INSERT INTO owners (owner_id, full_name, age)
VALUES (DEFAULT, 'Bob', 45);

INSERT INTO owners (owner_id, full_name, age)
VALUES (DEFAULT, 'Melody Pond', 77);

INSERT INTO owners (owner_id, full_name, age)
VALUES (DEFAULT, 'Dean Winchester', 14);

INSERT INTO owners (owner_id, full_name, age)
VALUES (DEFAULT, 'Jodie Whittaker', 38);

    /* Species data */

INSERT INTO species (specie_id, name)
VALUES (DEFAULT, 'Pokemon');

INSERT INTO species (specie_id, name)
VALUES (DEFAULT, 'Digimon');

    /* vets data */

INSERT INTO vets 
VALUES (DEFAULT, 'William Tatcher', 45, '2000-04-23');

INSERT INTO vets 
VALUES (DEFAULT, 'Maisy Smith', 26, '2019-01-17');

INSERT INTO vets 
VALUES (DEFAULT, 'Stephanie Mendez', 64, '1981-05-04');

INSERT INTO vets 
VALUES (DEFAULT, 'Jack Harkness', 38, '2008-06-08');

    /* specializations data */

INSERT INTO specializations
VALUES ((SELECT vet_id FROM vets WHERE name = 'William Tatcher'), (SELECT specie_id FROM species WHERE name = 'Pokemon'));

INSERT INTO specializations 
 VALUES ((SELECT vet_id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT specie_id FROM species WHERE name = 'Pokemon'));

 INSERT INTO specializations
 VALUES ((SELECT vet_id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT specie_id FROM species WHERE name = 'Digimon'));

 INSERT INTO specializations
 VALUES ((SELECT vet_id FROM vets WHERE name = 'Jack Harkness'), (SELECT specie_id FROM species WHERE name = 'Digimon'));

     /* visits data */

INSERT into visits
VALUES ((SELECT id FROM animals WHERE name = 'Agumon'), (SELECT vet_id FROM vets WHERE name = 'William Tatcher'), '2020-05-24');

INSERT INTO visits  
VALUES ((SELECT id FROM animals WHERE name = 'Agumon'), (SELECT vet_id FROM vets WHERE name = 'Stephanie Mendez'), '2020-07-22');

INSERT INTO visits  
VALUES ((SELECT id FROM animals WHERE name = 'Gabumon'), (SELECT vet_id FROM vets WHERE name = 'Jack Harkness'), '2021-02-02');

INSERT INTO visits 
VALUES ((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT vet_id FROM vets WHERE name = 'Maisy Smith'), '2020-01-05');

INSERT INTO visits  
VALUES ((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT vet_id FROM vets WHERE name = 'Maisy Smith'), '2020-03-08');

INSERT INTO visits  
VALUES ((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT vet_id FROM vets WHERE name = 'Maisy Smith'), '2020-05-14');

INSERT INTO visits  
VALUES ((SELECT id FROM animals WHERE name = 'Devimon'), (SELECT vet_id FROM vets WHERE name = 'Stephanie Mendez'), '2021-05-04');

INSERT INTO visits  
VALUES ((SELECT id FROM animals WHERE name = 'Charmander'), (SELECT vet_id FROM vets WHERE name = 'Jack Harkness'), '2021-02-24');

INSERT INTO visits  
VALUES ((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT vet_id FROM vets WHERE name = 'Maisy Smith'), '2019-12-21');

 INSERT INTO visits  VALUES ((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT vet_id FROM vets WHERE name = 'William Tatcher'), '2020-08-10');
 INSERT INTO visits  VALUES ((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT vet_id FROM vets WHERE name = 'Maisy Smith'), '2021-04-07');
 INSERT INTO visits  VALUES ((SELECT id FROM animals WHERE name = 'Squirtle'), (SELECT vet_id FROM vets WHERE name = 'Stephanie Mendez'), '2019-09-29');
 INSERT INTO visits  VALUES ((SELECT id FROM animals WHERE name = 'Angemon'), (SELECT vet_id FROM vets WHERE name = 'Jack Harkness'), '2020-10-03');
 INSERT INTO visits  VALUES ((SELECT id FROM animals WHERE name = 'Angemon'), (SELECT vet_id FROM vets WHERE name = 'Jack Harkness'), '2020-11-04');
 INSERT INTO visits  VALUES ((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT vet_id FROM vets WHERE name = 'Maisy Smith'), '2019-01-24');
 INSERT INTO visits  VALUES ((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT vet_id FROM vets WHERE name = 'Maisy Smith'), '2019-05-15');
 INSERT INTO visits  VALUES ((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT vet_id FROM vets WHERE name = 'Maisy Smith'), '2020-02-27');
 INSERT INTO visits  VALUES ((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT vet_id FROM vets WHERE name = 'Maisy Smith'), '2020-08-03');
 INSERT INTO visits  VALUES ((SELECT id FROM animals WHERE name = 'Blossom'), (SELECT vet_id FROM vets WHERE name = 'Stephanie Mendez'), '2020-05-24');
 INSERT INTO visits  VALUES ((SELECT id FROM animals WHERE name = 'Blossom'), (SELECT vet_id FROM vets WHERE name = 'William Tatcher'), '2021-01-11');
