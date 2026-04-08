-- Script adapte pour UPSUN
-- Ne pas creer de base de donnees, utiliser celle existante

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

-- --------------------------------------------------------

--
-- Suppression des tables existantes (ordre important pour les cles etrangeres)
--

DROP TABLE IF EXISTS `messenger_messages`;
DROP TABLE IF EXISTS `contact`;
DROP TABLE IF EXISTS `affectation`;
DROP TABLE IF EXISTS `appui`;
DROP TABLE IF EXISTS `article`;
DROP TABLE IF EXISTS `beneficiaire`;
DROP TABLE IF EXISTS `domain`;
DROP TABLE IF EXISTS `project`;
DROP TABLE IF EXISTS `structure_accompagnement`;
DROP TABLE IF EXISTS `user`;
DROP TABLE IF EXISTS `doctrine_migration_versions`;

-- --------------------------------------------------------

--
-- Structure de la table `affectation`
--

CREATE TABLE `affectation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date_affectation` datetime NOT NULL,
  `type_appui` varchar(100) DEFAULT NULL,
  `commentaire` varchar(255) DEFAULT NULL,
  `project_id` int NOT NULL,
  `beneficiaire_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_F4DD61D3166D1F9C` (`project_id`),
  KEY `IDX_F4DD61D35AF81F68` (`beneficiaire_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dechargement des donnees de la table `affectation`
--

INSERT INTO `affectation` (`id`, `date_affectation`, `type_appui`, `commentaire`, `project_id`, `beneficiaire_id`) VALUES
(1, '2024-02-20 00:00:00', 'medical', 'Equipement et formation', 1, 15),
(2, '2024-03-15 00:00:00', 'medical', 'Appui en medicaments', 1, 17),
(3, '2024-04-10 00:00:00', 'scolaire', 'Construction d\'une bibliotheque', 2, 7),
(4, '2024-05-20 00:00:00', 'scolaire', 'Distribution de kits scolaires', 2, 6),
(5, '2024-07-01 00:00:00', 'eau', 'Forage de puits et latrines', 3, 9),
(6, '2024-08-15 00:00:00', 'eau', 'Formation comites de gestion', 3, 10),
(7, '2024-03-20 00:00:00', 'social', 'Formation en couture', 4, 0),
(8, '2024-04-25 00:00:00', 'social', 'Appui a la creation d\'entreprise', 4, 0),
(9, '2024-05-25 00:00:00', 'agricole', 'Semences et formation', 5, 13),
(10, '2024-06-30 00:00:00', 'agricole', 'Rehabilitation de pistes', 5, 10),
(11, '2024-03-01 00:00:00', 'formation', 'Ateliers gestion de projet', 6, 12),
(12, '2024-04-15 00:00:00', 'recherche', 'Formation en plaidoyer', 6, 14),
(13, '2024-07-20 00:00:00', 'agricole', 'Champs-ecoles', 7, 13),
(14, '2024-08-25 00:00:00', 'agricole', 'Distribution semences', 7, 9),
(15, '2024-09-01 00:00:00', 'environnement', 'Reforestation participative', 8, 9),
(16, '2024-10-10 00:00:00', 'environnement', 'Formation en gestion forestiere', 8, 10),
(17, '2024-09-20 00:00:00', 'travaux', 'Rehabilitation de ponts', 9, 9),
(18, '2024-10-25 00:00:00', 'travaux', 'Debouchage caniveaux', 9, 10),
(19, '2024-10-10 00:00:00', 'medical', 'Formation accoucheuses', 10, 16),
(20, '2024-11-20 00:00:00', 'medical', 'Kits de naissance', 10, 18),
(21, '2022-02-15 00:00:00', 'education', 'Inscription centre d\'alphabetisation', 11, 0),
(22, '2022-03-05 00:00:00', 'education', 'Formation de moniteur', 11, 0),
(23, '2022-04-15 00:00:00', 'agricole', 'Equipement agricole', 12, 13),
(24, '2022-05-10 00:00:00', 'agricole', 'Formation en commercialisation', 12, 7),
(25, '2021-07-20 00:00:00', 'commerce', 'Construction d\'etals', 13, 9),
(26, '2021-08-15 00:00:00', 'commerce', 'Eclairage solaire', 13, 11),
(27, '2020-10-15 00:00:00', 'medical', 'Equipement medical', 14, 17),
(28, '2021-01-20 00:00:00', 'medical', 'Formation du personnel', 14, 15),
(29, '2024-11-15 00:00:00', 'formation', 'Ateliers coding', 15, 12),
(30, '2024-12-10 00:00:00', 'formation', 'Formation bureautique', 15, 0),
(31, '2024-12-10 00:00:00', 'agricole', 'Distribution de chevres', 16, 13),
(32, '2025-01-15 00:00:00', 'agricole', 'Formation en elevage', 16, 9),
(33, '2025-01-20 00:00:00', 'nutrition', 'Depistage malnutrition', 17, 16),
(34, '2025-02-15 00:00:00', 'nutrition', 'Distribution plats nutritifs', 17, 9),
(35, '2025-02-10 00:00:00', 'education', 'Sensibilisation droits de l\'enfant', 18, 6),
(36, '2025-03-20 00:00:00', 'education', 'Formation des enseignants', 18, 7),
(37, '2025-03-15 00:00:00', 'energie', 'Raccordement au reseau', 19, 11),
(38, '2025-04-10 00:00:00', 'energie', 'Formation electriciens', 19, 9),
(39, '2025-04-15 00:00:00', 'environnement', 'Plantation arbres fruitiers', 20, 13),
(40, '2025-05-10 00:00:00', 'environnement', 'Formation agroforesterie', 20, 9);

-- --------------------------------------------------------

--
-- Structure de la table `appui`
--

CREATE TABLE `appui` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nature_appui` varchar(100) DEFAULT NULL,
  `montant` decimal(15,2) DEFAULT NULL,
  `description` longtext,
  `date_appui` datetime NOT NULL,
  `project_id` int NOT NULL,
  `structure_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_3B983563166D1F9C` (`project_id`),
  KEY `IDX_3B9835632534008B` (`structure_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dechargement des donnees de la table `appui`
--

INSERT INTO `appui` (`id`, `nature_appui`, `montant`, `description`, `date_appui`, `project_id`, `structure_id`) VALUES
(1, 'financier', 50000.00, 'Subvention pour equipements medicaux', '2024-02-15 00:00:00', 1, 1),
(2, 'technique', NULL, 'Assistance technique en formation', '2024-03-10 00:00:00', 1, 8),
(3, 'financier', 75000.00, 'Financement construction ecoles', '2024-04-01 00:00:00', 2, 2),
(4, 'materiel', NULL, 'Fourniture de kits scolaires', '2024-05-20 00:00:00', 2, 12),
(5, 'financier', 40000.00, 'Forage et latrines', '2024-06-10 00:00:00', 3, 1),
(6, 'financier', 60000.00, 'Renforcement des comites de gestion', '2024-07-15 00:00:00', 3, 3),
(7, 'financier', 80000.00, 'Formation et groupements d\'epargne', '2024-03-01 00:00:00', 4, 5),
(8, 'financier', 40000.00, 'Appui aux micro-entreprises', '2024-04-15 00:00:00', 4, 20),
(9, 'financier', 100000.00, 'Semences et formation agroecologique', '2024-05-20 00:00:00', 5, 6),
(10, 'materiel', NULL, 'Distribution de vivres', '2024-06-25 00:00:00', 5, 21),
(11, 'financier', 45000.00, 'Ateliers de gestion de projet', '2024-02-28 00:00:00', 6, 9),
(12, 'technique', NULL, 'Formation en plaidoyer', '2024-03-30 00:00:00', 6, 8),
(13, 'financier', 120000.00, 'Distribution semences et champs-ecoles', '2024-07-01 00:00:00', 7, 6),
(14, 'technique', NULL, 'Formation agroecologie', '2024-08-10 00:00:00', 7, 8),
(15, 'financier', 100000.00, 'Reforestation et formation', '2024-08-01 00:00:00', 8, 7),
(16, 'financier', 60000.00, 'Appui a la gestion forestiere', '2024-09-15 00:00:00', 8, 15),
(17, 'financier', 150000.00, 'Travaux de rehabilitation', '2024-09-01 00:00:00', 9, 10),
(18, 'materiel', NULL, 'Cash-for-work', '2024-10-10 00:00:00', 9, 21),
(19, 'financier', 80000.00, 'Formation accoucheuses et kits', '2024-10-01 00:00:00', 10, 23),
(20, 'materiel', NULL, 'Distribution de kits de naissance', '2024-11-15 00:00:00', 10, 1),
(21, 'financier', 30000.00, 'Ouverture des centres', '2022-02-01 00:00:00', 11, 11),
(22, 'financier', 20000.00, 'Formation des moniteurs', '2022-03-10 00:00:00', 11, 18),
(23, 'financier', 50000.00, 'Materiel agricole et formation', '2022-04-01 00:00:00', 12, 16),
(24, 'financier', 30000.00, 'Renforcement des cooperatives', '2022-05-20 00:00:00', 12, 17),
(25, 'financier', 80000.00, 'Construction d\'etals', '2021-07-15 00:00:00', 13, 3),
(26, 'financier', 20000.00, 'Eclairage solaire', '2021-08-10 00:00:00', 13, 4),
(27, 'financier', 100000.00, 'Construction et equipement', '2020-10-01 00:00:00', 14, 14),
(28, 'technique', NULL, 'Supervision des travaux', '2021-01-15 00:00:00', 14, 24),
(29, 'financier', 60000.00, 'Ateliers coding et bureautique', '2024-11-01 00:00:00', 15, 8),
(30, 'technique', NULL, 'Programmes entrepreneuriat', '2024-12-01 00:00:00', 15, 11),
(31, 'financier', 50000.00, 'Distribution de chevres', '2024-12-01 00:00:00', 16, 6),
(32, 'financier', 20000.00, 'Formation en elevage', '2025-01-10 00:00:00', 16, 18),
(33, 'financier', 60000.00, 'Plats nutritifs et formation', '2025-01-15 00:00:00', 17, 13),
(34, 'materiel', NULL, 'Kits nutritionnels', '2025-02-10 00:00:00', 17, 1),
(35, 'financier', 40000.00, 'Sensibilisation dans les ecoles', '2025-02-01 00:00:00', 18, 12),
(36, 'technique', NULL, 'Formation des enseignants', '2025-03-15 00:00:00', 18, 1),
(37, 'financier', 100000.00, 'Renovation du reseau', '2025-03-01 00:00:00', 19, 3),
(38, 'financier', 40000.00, 'Formation des electriciens', '2025-04-01 00:00:00', 19, 4),
(39, 'financier', 80000.00, 'Plantation et formation', '2025-04-01 00:00:00', 20, 7),
(40, 'financier', 50000.00, 'Appui technique', '2025-05-01 00:00:00', 20, 25);

-- --------------------------------------------------------

--
-- Structure de la table `article`
--

CREATE TABLE `article` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(150) NOT NULL,
  `slug` varchar(190) NOT NULL,
  `content` longtext NOT NULL,
  `image_filename` varchar(150) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `title_en` varchar(100) DEFAULT NULL,
  `content_en` longtext,
  `project_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_23A0E66989D9B62` (`slug`),
  KEY `IDX_23A0E66166D1F9C` (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dechargement des donnees de la table `article`
--

INSERT INTO `article` (`id`, `title`, `slug`, `content`, `image_filename`, `created_at`, `updated_at`, `title_en`, `content_en`, `project_id`) VALUES
(1, 'Lancement du projet sante a Kabare', 'lancement-sante-kabare', '<p>Le projet a officiellement debute avec une ceremonie en presence des autorites locales. Les travaux de rehabilitation des centres de sante commencent la semaine prochaine.</p>', NULL, '2024-02-01 00:00:00', '2024-02-01 00:00:00', 'Launch of health project in Kabare', '<p>The project officially started with a ceremony attended by local authorities. Rehabilitation works will begin next week.</p>', 1),
(2, 'Premiere campagne de vaccination reussie', 'campagne-vaccination-kabare', '<p>500 enfants ont ete vaccines contre la rougeole et la polio lors de la premiere campagne. La participation des meres a ete remarquable.</p>', NULL, '2024-04-10 00:00:00', '2024-04-10 00:00:00', 'First vaccination campaign successful', '<p>500 children were vaccinated against measles and polio in the first campaign. Mothers\' participation was remarkable.</p>', 1),
(3, 'Formation des agents de sante', 'formation-agents-kabare', '<p>Une formation de 30 agents de sante sur les nouvelles directives de soins primaires a eu lieu a Bukavu.</p>', NULL, '2024-06-15 00:00:00', '2024-06-15 00:00:00', 'Health workers training', '<p>A training session for 30 health workers on new primary care guidelines took place in Bukavu.</p>', 1),
(4, 'Inauguration de deux nouvelles ecoles', 'inauguration-ecoles-bukavu', '<p>Deux ecoles primaires ont ete inaugurees dans les quartiers de Kadutu et Panzi. 800 eleves vont beneficier de nouvelles infrastructures.</p>', NULL, '2024-05-20 00:00:00', '2024-05-20 00:00:00', 'Two new schools inaugurated', '<p>Two primary schools were inaugurated in Kadutu and Panzi districts. 800 students will benefit from the new facilities.</p>', 2),
(5, 'Distribution de kits scolaires', 'distribution-kits-bukavu', '<p>2000 kits contenant cahiers, stylos et cartables ont ete distribues aux enfants des ecoles soutenues par le projet.</p>', NULL, '2024-09-10 00:00:00', '2024-09-10 00:00:00', 'School kits distribution', '<p>2000 kits containing notebooks, pens and schoolbags were distributed to children in supported schools.</p>', 2),
(6, 'Formation des enseignants', 'formation-enseignants-bukavu', '<p>40 enseignants ont participe a une formation sur les methodes pedagogiques actives.</p>', NULL, '2024-11-05 00:00:00', '2024-11-05 00:00:00', 'Teacher training', '<p>40 teachers participated in a training on active pedagogical methods.</p>', 2),
(7, 'Forage des premiers puits', 'forage-puits-kalehe', '<p>Les travaux de forage ont commence et 3 puits sont deja operationnels. Les comites de gestion sont en place.</p>', NULL, '2024-06-20 00:00:00', '2024-06-20 00:00:00', 'First wells drilled', '<p>Drilling works have started and 3 wells are already operational. Management committees are in place.</p>', 3),
(8, 'Construction des latrines', 'latrines-kalehe', '<p>5 latrines scolaires ont ete construites dans les villages cibles, ameliorant ainsi l\'hygiene.</p>', NULL, '2024-08-25 00:00:00', '2024-08-25 00:00:00', 'Latrines construction', '<p>5 school latrines were built in targeted villages, improving hygiene.</p>', 3),
(9, 'Formation des comites de gestion', 'formation-comites-kalehe', '<p>10 comites de gestion de l\'eau ont recu une formation sur l\'entretien et la tarification.</p>', NULL, '2024-10-15 00:00:00', '2024-10-15 00:00:00', 'Water committees training', '<p>10 water management committees were trained on maintenance and pricing.</p>', 3),
(10, 'Ateliers de couture a Uvira', 'ateliers-couture-uvira', '<p>Les premieres sessions de formation en couture ont reuni 50 femmes. Elles apprennent a confectionner des tenues et a commercialiser leurs produits.</p>', NULL, '2024-03-15 00:00:00', '2024-03-15 00:00:00', 'Sewing workshops in Uvira', '<p>The first sewing training sessions gathered 50 women. They learn to make clothes and market their products.</p>', 4),
(11, 'Creation de groupements d\'epargne', 'groupements-epargne-uvira', '<p>20 groupements d\'epargne ont ete crees, permettant aux femmes de se constituer une epargne solidaire.</p>', NULL, '2024-07-01 00:00:00', '2024-07-01 00:00:00', 'Savings groups created', '<p>20 savings groups were created, allowing women to build solidarity savings.</p>', 4),
(12, 'Foire d\'exposition des produits', 'foire-produits-uvira', '<p>Les femmes formees ont organise une foire d\'exposition de leurs produits. Plusieurs acheteurs se sont interesses.</p>', NULL, '2024-12-10 00:00:00', '2024-12-10 00:00:00', 'Products exhibition fair', '<p>The trained women organized a products exhibition fair. Several buyers showed interest.</p>', 4),
(13, 'Rehabilitation de pistes rurales', 'pistes-walungu', '<p>Les travaux de rehabilitation de 15 km de pistes ont debute. Des entrepreneurs locaux ont ete mobilises.</p>', NULL, '2024-05-05 00:00:00', '2024-05-05 00:00:00', 'Rural roads rehabilitation', '<p>Rehabilitation works on 15 km of rural roads have started. Local contractors were mobilized.</p>', 5),
(14, 'Distribution de semences', 'semences-walungu', '<p>500 agriculteurs ont recu des semences ameliorees de mais et de haricots. Des demonstrations de techniques culturales ont ete organisees.</p>', NULL, '2024-07-20 00:00:00', '2024-07-20 00:00:00', 'Seed distribution', '<p>500 farmers received improved maize and bean seeds. Demonstrations of cultivation techniques were organized.</p>', 5),
(15, 'Evaluation des rendements', 'rendements-walungu', '<p>Les premieres recoltes montrent une augmentation de 25% des rendements grace aux semences ameliorees et aux formations.</p>', NULL, '2025-01-15 00:00:00', '2025-01-15 00:00:00', 'Yield assessment', '<p>First harvests show a 25% increase in yields thanks to improved seeds and training.</p>', 5),
(16, 'Atelier de gestion de projet', 'atelier-gestion-projet', '<p>Un atelier de 3 jours a reuni 25 organisations pour renforcer leurs competences en gestion de projet.</p>', NULL, '2024-02-20 00:00:00', '2024-02-20 00:00:00', 'Project management workshop', '<p>A 3-day workshop gathered 25 organizations to strengthen their project management skills.</p>', 6),
(17, 'Formation en collecte de fonds', 'formation-collecte-fonds', '<p>Les participants ont appris les techniques de redaction de propositions et de recherche de financements.</p>', NULL, '2024-05-10 00:00:00', '2024-05-10 00:00:00', 'Fundraising training', '<p>Participants learned proposal writing and funding search techniques.</p>', 6),
(18, 'Plaidoyer pour les droits des femmes', 'plaidoyer-droits-femmes', '<p>5 organisations ont elabore une strategie commune de plaidoyer pour l\'adoption d\'une loi contre les violences basees sur le genre.</p>', NULL, '2024-09-25 00:00:00', '2024-09-25 00:00:00', 'Women\'s rights advocacy', '<p>5 organizations developed a joint advocacy strategy for the adoption of a law against gender-based violence.</p>', 6),
(19, 'Champs-ecoles pour les paysans', 'champs-ecoles-mwenga', '<p>Des champs-ecoles ont ete mis en place pour permettre aux agriculteurs d\'experimenter de nouvelles techniques.</p>', NULL, '2024-07-15 00:00:00', '2024-07-15 00:00:00', 'Farmer field schools', '<p>Farmer field schools were set up to allow farmers to experiment with new techniques.</p>', 7),
(20, 'Distribution de semences et outils', 'semences-outils-mwenga', '<p>800 agriculteurs ont recu des semences ameliorees et des outils aratoires.</p>', NULL, '2024-09-10 00:00:00', '2024-09-10 00:00:00', 'Seeds and tools distribution', '<p>800 farmers received improved seeds and farming tools.</p>', 7),
(21, 'Creation de banques de cereales', 'banques-cereales-mwenga', '<p>Deux banques de cereales ont ete creees pour lutter contre la soudure alimentaire.</p>', NULL, '2025-01-30 00:00:00', '2025-01-30 00:00:00', 'Cereal banks creation', '<p>Two cereal banks were created to fight food shortages.</p>', 7),
(22, 'Plantation de 50 000 arbres', 'plantation-arbres-kahuzi', '<p>La premiere phase de reboisement a permis de planter 20 000 arbres sur les collines de Kahuzi.</p>', NULL, '2024-08-20 00:00:00', '2024-08-20 00:00:00', 'Planting 50,000 trees', '<p>The first phase of reforestation allowed planting 20,000 trees on the Kahuzi hills.</p>', 8),
(23, 'Formation des comites forestiers', 'comites-forestiers-kahuzi', '<p>10 comites locaux ont ete formes a la gestion durable des forets.</p>', NULL, '2024-10-05 00:00:00', '2024-10-05 00:00:00', 'Forest committees training', '<p>10 local committees were trained on sustainable forest management.</p>', 8),
(24, 'Sensibilisation au changement climatique', 'climat-kahuzi', '<p>Des seances de sensibilisation ont touche 2000 personnes sur les enjeux climatiques.</p>', NULL, '2025-01-20 00:00:00', '2025-01-20 00:00:00', 'Climate change awareness', '<p>Awareness sessions reached 2000 people on climate issues.</p>', 8),
(25, 'Rehabilitation de ponts', 'ponts-fizi', '<p>5 ponts endommages par les pluies ont ete rehabilites, retablissant le passage pour 10 villages.</p>', NULL, '2024-09-15 00:00:00', '2024-09-15 00:00:00', 'Bridges rehabilitation', '<p>5 bridges damaged by rains were rehabilitated, restoring passage for 10 villages.</p>', 9),
(26, 'Debouchage des caniveaux', 'caniveaux-fizi', '<p>8 km de caniveaux ont ete debouches, reduisant les risques d\'inondation en saison des pluies.</p>', NULL, '2024-11-20 00:00:00', '2024-11-20 00:00:00', 'Gutters clearing', '<p>8 km of gutters were cleared, reducing flood risks during the rainy season.</p>', 9),
(27, 'Emplois temporaires pour 200 personnes', 'emplois-fizi', '<p>200 personnes ont beneficie d\'emplois temporaires dans le cadre des travaux publics.</p>', NULL, '2025-02-10 00:00:00', '2025-02-10 00:00:00', 'Temporary jobs for 200 people', '<p>200 people benefited from temporary jobs as part of the public works.</p>', 9),
(28, 'Formation des accoucheuses', 'accoucheuses-shabunda', '<p>50 accoucheuses traditionnelles ont ete formees aux soins obstetricaux d\'urgence.</p>', NULL, '2024-10-01 00:00:00', '2024-10-01 00:00:00', 'Traditional birth attendants training', '<p>50 traditional birth attendants were trained in emergency obstetric care.</p>', 10),
(29, 'Equipement de maternites', 'maternites-shabunda', '<p>Deux maternites ont recu du materiel medical et des kits de naissance.</p>', NULL, '2024-12-05 00:00:00', '2024-12-05 00:00:00', 'Maternity units equipment', '<p>Two maternity units received medical equipment and birth kits.</p>', 10),
(30, 'Campagne de sensibilisation', 'sensibilisation-shabunda', '<p>Une campagne de sensibilisation a touche 5000 femmes sur l\'importance des consultations prenatales.</p>', NULL, '2025-02-20 00:00:00', '2025-02-20 00:00:00', 'Awareness campaign', '<p>An awareness campaign reached 5000 women on the importance of prenatal care.</p>', 10),
(31, 'Ouverture des centres d\'alphabetisation', 'centres-alphabetisation-idjwi', '<p>20 centres ont ete ouverts et 600 adultes se sont inscrits.</p>', NULL, '2022-02-01 00:00:00', '2022-02-01 00:00:00', 'Literacy centers opening', '<p>20 centers were opened and 600 adults enrolled.</p>', 11),
(32, 'Formation des moniteurs', 'moniteurs-idjwi', '<p>40 moniteurs ont ete formes aux methodes d\'alphabetisation fonctionnelle.</p>', NULL, '2022-04-10 00:00:00', '2022-04-10 00:00:00', 'Trainers training', '<p>40 trainers were trained in functional literacy methods.</p>', 11),
(33, 'Cremonie de cloture', 'cloture-idjwi', '<p>600 adultes ont recu leur certificat d\'alphabetisation lors d\'une ceremonie en presence des autorites.</p>', NULL, '2023-11-15 00:00:00', '2023-11-15 00:00:00', 'Closing ceremony', '<p>600 adults received their literacy certificate at a ceremony attended by authorities.</p>', 11),
(34, 'Creation de 10 cooperatives', 'cooperatives-creees', '<p>Dix cooperatives ont ete legalement creees et enregistrees.</p>', NULL, '2022-04-01 00:00:00', '2022-04-01 00:00:00', '10 cooperatives created', '<p>Ten cooperatives were legally created and registered.</p>', 12),
(35, 'Formation en gouvernance', 'gouvernance-cooperatives', '<p>Les membres des cooperatives ont ete formes a la gestion financiere et aux prises de decision democratiques.</p>', NULL, '2022-06-15 00:00:00', '2022-06-15 00:00:00', 'Governance training', '<p>Cooperative members were trained in financial management and democratic decision-making.</p>', 12),
(36, 'Commercialisation collective', 'commercialisation-cooperatives', '<p>Les cooperatives ont vendu leurs produits en commun, obtenant de meilleurs prix.</p>', NULL, '2023-10-20 00:00:00', '2023-10-20 00:00:00', 'Collective marketing', '<p>The cooperatives sold their products collectively, obtaining better prices.</p>', 12),
(37, 'Construction des etals', 'etals-baraka', '<p>50 etals ont ete construits, offrant des conditions de vente ameliorees.</p>', NULL, '2021-07-01 00:00:00', '2021-07-01 00:00:00', 'Stalls construction', '<p>50 stalls were built, providing improved sales conditions.</p>', 13),
(38, 'Installation de l\'eclairage solaire', 'eclairage-baraka', '<p>Le marche est desormais equipe de lampadaires solaires, permettant une activite nocturne.</p>', NULL, '2022-03-15 00:00:00', '2022-03-15 00:00:00', 'Solar lighting installation', '<p>The market is now equipped with solar streetlights, allowing night activity.</p>', 13),
(39, 'Formation des commercants', 'formation-commercants-baraka', '<p>200 commercants ont recu une formation sur les normes d\'hygiene et la gestion des stocks.</p>', NULL, '2022-08-10 00:00:00', '2022-08-10 00:00:00', 'Traders training', '<p>200 traders received training on hygiene standards and stock management.</p>', 13),
(40, 'Debut des travaux', 'travaux-centre-lulingu', '<p>La construction du centre de sante a debute en septembre 2020.</p>', NULL, '2020-09-01 00:00:00', '2020-09-01 00:00:00', 'Construction start', '<p>The construction of the health center began in September 2020.</p>', 14),
(41, 'Inauguration du centre', 'inauguration-centre-lulingu', '<p>Le centre de sante a ete inaugure en mars 2022. Il dessert desormais 15 000 habitants.</p>', NULL, '2022-03-31 00:00:00', '2022-03-31 00:00:00', 'Center inauguration', '<p>The health center was inaugurated in March 2022. It now serves 15,000 people.</p>', 14),
(42, 'Equipement en materiel medical', 'equipement-centre-lulingu', '<p>Le centre a recu des equipements de base (lits, tables d\'accouchement, medicaments).</p>', NULL, '2022-04-15 00:00:00', '2022-04-15 00:00:00', 'Medical equipment', '<p>The center received basic equipment (beds, delivery tables, medicines).</p>', 14),
(43, 'Ateliers de coding', 'coding-jeunes', '<p>100 jeunes ont participe aux ateliers de programmation web.</p>', NULL, '2024-10-15 00:00:00', '2024-10-15 00:00:00', 'Coding workshops', '<p>100 young people participated in web programming workshops.</p>', 15),
(44, 'Formation en bureautique', 'bureautique-jeunes', '<p>50 jeunes ont ete formes en bureautique avancee (Word, Excel, PowerPoint).</p>', NULL, '2024-12-05 00:00:00', '2024-12-05 00:00:00', 'Office skills training', '<p>50 young people were trained in advanced office skills (Word, Excel, PowerPoint).</p>', 15),
(45, 'Creation d\'entreprises', 'entreprises-jeunes', '<p>10 jeunes ont cree leur propre micro-entreprise grace aux competences acquises.</p>', NULL, '2025-02-20 00:00:00', '2025-02-20 00:00:00', 'Business creation', '<p>10 young people created their own micro-enterprises thanks to the skills acquired.</p>', 15),
(46, 'Distribution des chevres', 'chevre-kabare', '<p>500 chevres ont ete distribuees aux menages vulnerables.</p>', NULL, '2024-11-20 00:00:00', '2024-11-20 00:00:00', 'Goat distribution', '<p>500 goats were distributed to vulnerable households.</p>', 16),
(47, 'Formation en elevage', 'formation-elevage-kabare', '<p>Les beneficiaires ont ete formes aux soins veterinaires de base et a la gestion des animaux.</p>', NULL, '2025-01-10 00:00:00', '2025-01-10 00:00:00', 'Livestock training', '<p>Beneficiaries were trained in basic veterinary care and animal management.</p>', 16),
(48, 'Naissances et production', 'naissances-chevre-kabare', '<p>Les premieres naissances de chevreaux ont ete enregistrees, signe de l\'adaptation du projet.</p>', NULL, '2025-03-15 00:00:00', '2025-03-15 00:00:00', 'Births and production', '<p>The first kids were born, a sign of the project\'s adaptation.</p>', 16),
(49, 'Depistage de la malnutrition', 'depistage-mwenga', '<p>500 enfants ont ete depistes dans les centres de sante. 200 cas de malnutrition aigue ont ete identifies.</p>', NULL, '2025-01-05 00:00:00', '2025-01-05 00:00:00', 'Malnutrition screening', '<p>500 children were screened in health centers. 200 cases of acute malnutrition were identified.</p>', 17),
(50, 'Distribution de plats nutritifs', 'plats-nutritifs-mwenga', '<p>Des plats enrichis ont ete distribues aux enfants malnutris.</p>', NULL, '2025-02-10 00:00:00', '2025-02-10 00:00:00', 'Nutritious meals distribution', '<p>Enriched meals were distributed to malnourished children.</p>', 17),
(51, 'Formation des meres', 'formation-meres-mwenga', '<p>300 meres ont ete formees a la preparation de repas equilibres a partir de produits locaux.</p>', NULL, '2025-03-01 00:00:00', '2025-03-01 00:00:00', 'Mothers training', '<p>300 mothers were trained in preparing balanced meals from local products.</p>', 17),
(52, 'Sensibilisation dans les ecoles', 'sensibilisation-ecoles', '<p>50 ecoles ont beneficie de sessions de sensibilisation sur les droits de l\'enfant.</p>', NULL, '2025-02-01 00:00:00', '2025-02-01 00:00:00', 'Awareness in schools', '<p>50 schools benefited from awareness sessions on children\'s rights.</p>', 18),
(53, 'Formation des enseignants', 'formation-enseignants-droits', '<p>100 enseignants ont ete formes pour detecter les cas de violence et y repondre.</p>', NULL, '2025-03-10 00:00:00', '2025-03-10 00:00:00', 'Teachers training', '<p>100 teachers were trained to detect and respond to violence cases.</p>', 18),
(54, 'Plaidoyer pour l\'enregistrement des naissances', 'plaidoyer-naissance', '<p>Une campagne de plaidoyer a conduit a l\'enregistrement de 2000 naissances dans les zones reculees.</p>', NULL, '2025-03-20 00:00:00', '2025-03-20 00:00:00', 'Birth registration advocacy', '<p>An advocacy campaign led to the registration of 2000 births in remote areas.</p>', 18),
(55, 'Raccordement des quartiers', 'raccordement-uvira', '<p>Trois quartiers ont ete raccordes au reseau electrique renove.</p>', NULL, '2025-03-05 00:00:00', '2025-03-05 00:00:00', 'Neighborhoods connection', '<p>Three neighborhoods were connected to the renovated electricity network.</p>', 19),
(56, 'Formation des electriciens', 'electriciens-uvira', '<p>10 electriciens locaux ont ete formes a la maintenance du reseau.</p>', NULL, '2025-02-25 00:00:00', '2025-02-25 00:00:00', 'Electricians training', '<p>10 local electricians were trained in network maintenance.</p>', 19),
(57, 'Cremonie de mise en service', 'mise-service-uvira', '<p>Une ceremonie a marque la mise en service officielle du reseau.</p>', NULL, '2025-03-15 00:00:00', '2025-03-15 00:00:00', 'Commissioning ceremony', '<p>A ceremony marked the official commissioning of the network.</p>', 19),
(58, 'Plantation d\'arbres fruitiers', 'arbres-fruitiers', '<p>5000 arbres fruitiers (manguiers, avocatiers) ont ete plantes sur les exploitations des agriculteurs.</p>', 'plantations-69cd85fb52a4d487127141.jpg', '2025-04-01 00:00:00', '2026-04-01 20:54:19', 'Fruit trees planting', '<p>5000 fruit trees (mango, avocado) were planted on farmers\' lands.</p>', 20),
(59, 'Formation en agroforesterie', 'formation-agroforesterie', '<p>100 agriculteurs ont ete formes a l\'association des arbres et des cultures vivrieres.</p>', 'agroforesterie-69cd856cb9e3d528613006.jpg', '2025-04-10 00:00:00', '2026-04-01 20:51:56', 'Agroforestry training', '<p>100 farmers were trained in the association of trees and food crops.</p>', 20),
(60, 'Suivi des plantations', 'suivi-plantations', '<p>Les premieres pousses sont visibles, les agriculteurs s\'engagent a entretenir les arbres.</p>', 'suivi-plantes-69cd84d730d66694581396.jpg', '2025-05-01 00:00:00', '2026-04-01 20:49:27', 'Plantation monitoring', '<p>First shoots are visible, farmers are committed to maintaining the trees.</p>', 20);

-- --------------------------------------------------------

--
-- Structure de la table `beneficiaire`
--

CREATE TABLE `beneficiaire` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) NOT NULL,
  `localisation` varchar(255) DEFAULT NULL,
  `telephone` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `prenom` varchar(100) DEFAULT NULL,
  `post_nom` varchar(100) DEFAULT NULL,
  `date_naissance` date DEFAULT NULL,
  `population` int DEFAULT NULL,
  `chef` varchar(255) DEFAULT NULL,
  `zone` varchar(100) DEFAULT NULL,
  `directeur` varchar(100) DEFAULT NULL,
  `nombre_eleves` int DEFAULT NULL,
  `type_institution` varchar(100) DEFAULT NULL,
  `responsable` varchar(255) DEFAULT NULL,
  `domaine_activite` varchar(255) DEFAULT NULL,
  `nombre_lits` int DEFAULT NULL,
  `specialites` longtext,
  `medecin_chef` varchar(255) DEFAULT NULL,
  `directeur_medical` varchar(255) DEFAULT NULL,
  `type_hopital` varchar(255) DEFAULT NULL,
  `cycle` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dechargement des donnees de la table `beneficiaire`
--

INSERT INTO `beneficiaire` (`id`, `nom`, `localisation`, `telephone`, `email`, `type`, `prenom`, `post_nom`, `date_naissance`, `population`, `chef`, `zone`, `directeur`, `nombre_eleves`, `type_institution`, `responsable`, `domaine_activite`, `nombre_lits`, `specialites`, `medecin_chef`, `directeur_medical`, `type_hopital`, `cycle`) VALUES
(1, 'Mukwege', 'Bukavu', '+243 123 456 789', 'denis@example.com', 'personne', 'Denis', NULL, '1955-03-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2, 'Kapinga', 'Kinshasa', '+243 811 234 567', 'marie@example.com', 'personne', 'Marie', NULL, '1980-06-15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(3, 'Landaha', 'Lubumbashi', '+243 822 345 678', 'jean@example.com', 'personne', 'Jean Claude', NULL, '1975-11-20', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(4, 'Miteu', 'Goma', '+243 833 456 789', 'richard@example.com', 'personne', 'Richard', NULL, '1990-02-10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(5, 'Sekele', 'Kinshasa', '+243 844 567 890', 'eugene@example.com', 'personne', 'Eugene', NULL, '1965-08-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(6, 'Ecole Primaire de Kabare', 'Kabare', '+243 123 456 789', 'kabare@ecole.cd', 'ecole', NULL, NULL, NULL, NULL, NULL, NULL, 'Mme Nzir', 450, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'primaire'),
(7, 'Institut Bukavu', 'Bukavu', '+243 123 456 780', 'bukavu@ecole.cd', 'ecole', NULL, NULL, NULL, NULL, NULL, NULL, 'M. Balekage', 800, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'secondaire'),
(8, 'Complexe Scolaire Mwenga', 'Mwenga', '+243 123 456 781', 'mwenga@ecole.cd', 'ecole', NULL, NULL, NULL, NULL, NULL, NULL, 'Mme Kavira', 350, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'primaire'),
(9, 'Village de Kalehe', 'Kalehe', '+243 123 456 782', 'kalehe@comm.cd', 'communaute', NULL, NULL, NULL, 5000, 'Chef Mambo', 'Chefferie', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10, 'Groupement de Walungu', 'Walungu', '+243 123 456 783', 'walungu@comm.cd', 'communaute', NULL, NULL, NULL, 12000, 'Mwami Bora', 'Groupement', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11, 'Quartier de Panzi', 'Bukavu', '+243 123 456 784', 'panzi@comm.cd', 'communaute', NULL, NULL, NULL, 8000, 'Chef Nyarugabo', 'Quartier', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(12, 'Universite Catholique de Bukavu', 'Bukavu', '+243 123 456 785', 'ucb@inst.cd', 'institution', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'universitaire', 'Recteur', 'enseignement', NULL, NULL, NULL, NULL, NULL, NULL),
(13, 'Cooperative Agricole de Kabare', 'Kabare', '+243 123 456 786', 'coop@inst.cd', 'institution', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'cooperative', 'Mme Kanyere', 'agriculture', NULL, NULL, NULL, NULL, NULL, NULL),
(14, 'Centre de Recherche en Environnement', 'Lubumbashi', '+243 123 456 787', 'cre@inst.cd', 'institution', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'recherche', 'Dr. Ilunga', 'recherche', NULL, NULL, NULL, NULL, NULL, NULL),
(15, 'Clinique de Kabare', 'Kabare', '+243 123 456 788', 'clinique@kabare.cd', 'clinique', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 20, 'medecine generale, pediatrie', 'Dr. Amani', NULL, NULL, NULL),
(16, 'Clinique Maternite de Walungu', 'Walungu', '+243 123 456 789', 'maternite@walungu.cd', 'clinique', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 15, 'maternite, neonatologie', 'Dr. Mapendo', NULL, NULL, NULL),
(17, 'Hopital General de Bukavu', 'Bukavu', '+243 123 456 790', 'hg@bukavu.cd', 'hopital', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 250, 'chirurgie, medecine, pediatrie', NULL, 'Dr. Kasereka', 'public', NULL),
(18, 'Hopital de Reference de Shabunda', 'Shabunda', '+243 123 456 791', 'hr@shabunda.cd', 'hopital', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 120, 'medecine generale, chirurgie', NULL, 'Dr. Kambale', 'public', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `contact`
--

CREATE TABLE `contact` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `message` longtext NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dechargement des donnees de la table `contact`
--

INSERT INTO `contact` (`id`, `name`, `email`, `phone`, `message`, `created_at`) VALUES
(1, 'Prof TENGENEZA', 'teng10@gml.com', '+243810419462', 'azdhkldh klzjelkjzalj lzjeklazjelekjakzjekzn  zaekljaz zenke zkeze zame', '2026-03-25 23:53:21'),
(2, 'Prof TENGENEZA', 'teng10@gml.com', '+243810419462', 'qnlsln nzdld lkzdkln ;dkldnzl', '2026-03-25 23:54:17');

-- --------------------------------------------------------

--
-- Structure de la table `doctrine_migration_versions`
--

CREATE TABLE `doctrine_migration_versions` (
  `version` varchar(191) NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dechargement des donnees de la table `doctrine_migration_versions`
--

INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
('DoctrineMigrations\\Version20260325031338', '2026-03-25 03:22:02', 151),
('DoctrineMigrations\\Version20260327235857', '2026-03-28 00:01:50', 157),
('DoctrineMigrations\\Version20260328004308', '2026-03-28 00:44:45', 56),
('DoctrineMigrations\\Version20260328110058', '2026-03-28 11:02:37', 85),
('DoctrineMigrations\\Version20260328165439', '2026-03-28 16:54:55', 138),
('DoctrineMigrations\\Version20260328181209', '2026-03-28 18:12:15', 159),
('DoctrineMigrations\\Version20260328183339', '2026-03-28 18:33:46', 152),
('DoctrineMigrations\\Version20260328223808', '2026-03-28 22:38:35', 314),
('DoctrineMigrations\\Version20260330210841', '2026-03-30 21:09:08', 446),
('DoctrineMigrations\\Version20260330213155', '2026-03-30 21:32:13', 263),
('DoctrineMigrations\\Version20260330220957', '2026-03-30 22:11:35', 263),
('DoctrineMigrations\\Version20260330235921', '2026-04-01 01:03:48', 488),
('DoctrineMigrations\\Version20260401010336', '2026-04-01 01:03:49', 214),
('DoctrineMigrations\\Version20260401204850', '2026-04-01 20:49:11', 363),
('DoctrineMigrations\\Version20260403135621', '2026-04-03 13:58:26', 862),
('DoctrineMigrations\\Version20260404012121', '2026-04-04 01:21:37', 338),
('DoctrineMigrations\\Version20260404014754', '2026-04-04 01:47:59', 249);

-- --------------------------------------------------------

--
-- Structure de la table `domain`
--

CREATE TABLE `domain` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `slug` varchar(190) NOT NULL,
  `description` longtext,
  `updated_at` datetime DEFAULT NULL,
  `image_filename` varchar(255) DEFAULT NULL,
  `name_en` varchar(100) DEFAULT NULL,
  `description_en` longtext,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_A7A91E0B989D9B62` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dechargement des donnees de la table `domain`
--

INSERT INTO `domain` (`id`, `name`, `slug`, `description`, `updated_at`, `image_filename`, `name_en`, `description_en`) VALUES
(1, 'Education', 'education', '<p>L\'acces a une education de qualite est un droit fondamental et un levier essentiel pour le developpement. ASODECO oeuvre pour la construction et la rehabilitation d\'ecoles, la fourniture de materiel scolaire et la formation des enseignants. Nous soutenons egalement des programmes d\'alphabetisation pour adultes et des cantines scolaires afin de lutter contre le decrochage.</p>\r\n<p>Nos actions incluent la sensibilisation des familles a l\'importance de la scolarisation des filles, l\'organisation de classes passerelles pour les enfants descolarises et le plaidoyer pour des politiques educatives inclusives. Grace a nos partenaires, nous equipons les bibliotheques et offrons des bourses d\'etudes aux eleves meritants issus de milieux defavorises.</p>\r\n<p>A long terme, nous visons a ameliorer les taux de scolarisation et la qualite de l\'enseignement dans les zones rurales, en formant des comites de gestion scolaire et en promouvant des methodes pedagogiques participatives.</p>', '2026-03-28 11:22:22', 'education-2026-69c7b9eee0e27756315452.png', 'Education', '<p>Access to quality education is a fundamental right and a key driver of development. ASODECO works to build and rehabilitate schools, provide school supplies, and train teachers. We also support adult literacy programs and school canteens to prevent dropout.</p>\r\n<p>Our actions include raising awareness among families about the importance of girls\' education, organizing bridging classes for out-of-school children, and advocating for inclusive education policies. Through our partners, we equip libraries and offer scholarships to deserving students from disadvantaged backgrounds.</p>\r\n<p>In the long term, we aim to improve school enrollment rates and teaching quality in rural areas by training school management committees and promoting participatory teaching methods.</p>'),
(2, 'Sante', 'sante', '<p>La sante communautaire est au coeur de notre mission. Nous appuyons les centres de sante ruraux par des equipements medicaux, des formations pour le personnel soignant et des campagnes de vaccination. Nos equipes menent des actions de sensibilisation sur les maladies endemiques (paludisme, tuberculose) et sur la sante materno-infantile.</p>\r\n<p>Nous organisons des consultations mobiles pour atteindre les populations isolees, distribuons des moustiquaires impregnees et favorisons l\'acces a l\'eau potable dans les structures de sante. La lutte contre la malnutrition passe par des ateliers nutritionnels et la creation de jardins potagers therapeutiques.</p>\r\n<p>Notre objectif est de reduire la mortalite infantile et maternelle, d\'ameliorer l\'offre de soins de premier recours et de renforcer la resilience des communautes face aux epidemies. Nous travaillons en etroite collaboration avec les autorites sanitaires locales.</p>', '2026-03-28 11:26:19', 'sante-69c7badbb9298916124159.jpg', 'Health', '<p>Community health is at the heart of our mission. We support rural health centers with medical equipment, training for healthcare staff, and vaccination campaigns. Our teams conduct awareness activities on endemic diseases (malaria, tuberculosis) and maternal and child health.</p>\r\n<p>We organize mobile consultations to reach isolated populations, distribute insecticide-treated mosquito nets, and promote access to clean water in health facilities. The fight against malnutrition involves nutritional workshops and the creation of therapeutic kitchen gardens.</p>\r\n<p>Our goal is to reduce infant and maternal mortality, improve primary healthcare services, and strengthen community resilience against epidemics. We work closely with local health authorities.</p>'),
(3, 'Hygiene, eau et assainissement', 'hygiene-eau-assainissement', '<p>L\'acces a l\'eau potable et a des infrastructures d\'assainissement decentes est une priorite. Nous forons des puits, rehabilitons des sources d\'eau et construisons des latrines dans les ecoles et les villages. Des comites de gestion de l\'eau sont formes pour assurer la durabilite des ouvrages.</p>\r\n<p>Nos equipes animent des seances d\'hygiene collective : lavage des mains, gestion des dechets, entretien des points d\'eau. Nous distribuons egalement des kits d\'hygiene aux familles les plus vulnerables et sensibilisons a la prevention des maladies hydriques (cholera, diarrhees).</p>\r\n<p>A travers ces actions, nous contribuons a reduire les maladies liees a l\'eau, a ameliorer la scolarite des filles (grace aux latrines separees) et a renforcer la dignite des communautes. Notre approche est participative et respectueuse des savoirs locaux.</p>', '2026-03-28 11:30:16', 'eau-hygiene-ass-69c7bbc8638d7350072644.png', 'Water, Hygiene and Sanitation', '<p>Access to clean water and decent sanitation infrastructure is a priority. We drill wells, rehabilitate water sources, and build latrines in schools and villages. Water management committees are trained to ensure the sustainability of the structures.</p>\r\n<p>Our teams conduct group hygiene sessions: hand washing, waste management, and maintenance of water points. We also distribute hygiene kits to the most vulnerable families and raise awareness about the prevention of water-borne diseases (cholera, diarrhea).</p>\r\n<p>Through these actions, we help reduce water-related diseases, improve girls\' school attendance (thanks to separate latrines), and strengthen the dignity of communities. Our approach is participatory and respectful of local knowledge.</p>'),
(4, 'Inclusion sociale', 'inclusion-sociale', '<p>L\'inclusion sociale vise a garantir que les groupes vulnerables – femmes, enfants, personnes handicapees, minorites – participent pleinement a la vie de la communaute. Nous menons des ateliers de sensibilisation aux droits humains, appuyons des groupements d\'entraide et facilitons l\'acces aux services de base.</p>\r\n<p>Nous accompagnons les femmes dans des activites generatrices de revenus, luttons contre les violences basees sur le genre et promouvons la scolarisation des enfants handicapes. Des plaidoyers sont organises aupres des autorites locales pour l\'adoption de politiques inclusives.</p>\r\n<p>Notre vision est de batir une societe plus juste ou chacun, sans discrimination, peut exercer ses droits et contribuer au developpement collectif. Nous travaillons en reseau avec d\'autres organisations de la societe civile.</p>', '2026-03-28 12:34:35', 'asedeco-inclusion-sociale-69c7cadb427ab797928562.png', 'Social Inclusion', '<p>Social inclusion aims to ensure that vulnerable groups – women, children, people with disabilities, minorities – participate fully in community life. We conduct human rights awareness workshops, support self-help groups, and facilitate access to basic services.</p>\r\n<p>We support women in income-generating activities, fight gender-based violence, and promote the education of children with disabilities. Advocacy efforts are organized with local authorities for the adoption of inclusive policies.</p>\r\n<p>Our vision is to build a fairer society where everyone, without discrimination, can exercise their rights and contribute to collective development. We work in networks with other civil society organizations.</p>'),
(5, 'Developpement rural', 'developpement-rural', '<p>Le developpement rural passe par l\'amelioration des infrastructures et des services de base. Nous construisons des pistes rurales, des marches et des petits ouvrages hydrauliques. Nous appuyons egalement les organisations paysannes pour renforcer leur capacite de production et de commercialisation.</p>\n<p>Nos projets incluent l\'electrification rurale par energie solaire, la mise en place de systemes d\'irrigation et la formation en techniques agricoles durables. Nous facilitons l\'acces aux intrants et aux services financiers pour les petits producteurs.</p>\n<p>Notre objectif est de reduire l\'isolement des communautes rurales, d\'augmenter les revenus agricoles et de freiner l\'exode rural. Nous privilegions une approche participative et durable.</p>', '2026-03-28 12:12:47', 'dev-rurale-69c7c5bfeb866089650718.png', 'Rural Development', '<p>Rural development involves improving infrastructure and basic services. We build rural roads, markets, and small hydraulic structures. We also support farmers\' organizations to strengthen their production and marketing capacity.</p>\r\n<p>Our projects include rural electrification with solar energy, establishment of irrigation systems, and training in sustainable agricultural techniques. We facilitate access to inputs and financial services for smallholder farmers.</p>\r\n<p>Our goal is to reduce the isolation of rural communities, increase agricultural incomes, and curb rural-to-urban migration. We prioritize a participatory and sustainable approach.</p>'),
(6, 'Renforcement des capacites', 'renforcement-capacites', '<p>Le renforcement des capacites est un axe transversal de notre action. Nous formons les organisations locales a la gestion de projets, a la collecte de fonds et au plaidoyer. Des sessions de formation sont egalement dispensees aux agents communautaires sur des themes varies (sante, environnement, droits humains).</p>\r\n<p>Nous mettons en place des programmes de mentorat pour les jeunes leaders et appuyons la structuration d\'associations locales. Nos outils pedagogiques (guides, modules) sont adaptes aux contextes ruraux et disponibles en francais et en langues locales.</p>\r\n<p>En renforcant les competences des acteurs locaux, nous favorisons l\'appropriation des projets et leur durabilite. Notre ambition est de creer un vivier d\'expertises locales capables de repondre durablement aux besoins des communautes.</p>', '2026-03-28 12:21:22', 'renforcement-de-capacite-2-69c7c7c281378390515991.png', 'Capacity Building', '<p>Capacity building is a cross-cutting focus of our action. We train local organizations in project management, fundraising, and advocacy. Training sessions are also provided to community agents on various themes (health, environment, human rights).</p>\r\n<p>We set up mentoring programs for young leaders and support the structuring of local associations. Our educational tools (guides, modules) are adapted to rural contexts and available in French and local languages.</p>\r\n<p>By strengthening the skills of local actors, we promote ownership of projects and their sustainability. Our ambition is to create a pool of local expertise capable of sustainably meeting community needs.</p>'),
(7, 'Agriculture et securite alimentaire', 'agriculture-securite-alimentaire', '<p>L\'agriculture durable est au coeur de la securite alimentaire. Nous soutenons les producteurs par des formations en agroecologie, la distribution de semences ameliorees et l\'appui a la diversification des cultures. Des champs ecoles sont mis en place pour tester et diffuser les bonnes pratiques.</p>\r\n<p>Nous facilitons l\'acces aux marches, aidons a la creation de cooperatives et promouvons la transformation locale des produits agricoles. Des banques de cereales communautaires permettent de lutter contre la soudure alimentaire.</p>\r\n<p>Notre objectif est d\'accroitre la production vivriere, de diversifier les sources de revenus et de renforcer la resilience des menages face aux crises alimentaires. Nous travaillons avec les services techniques agricoles et les organisations paysannes.</p>', '2026-03-28 12:31:36', 'agriculture-69c7ca285635d660816833.png', 'Agriculture and Food Security', '<p>Sustainable agriculture is at the heart of food security. We support producers through training in agroecology, distribution of improved seeds, and support for crop diversification. Farmer field schools are established to test and disseminate good practices.</p>\r\n<p>We facilitate access to markets, help create cooperatives, and promote local processing of agricultural products. Community grain banks help combat food shortages.</p>\r\n<p>Our goal is to increase food production, diversify income sources, and strengthen household resilience to food crises. We work with agricultural technical services and farmers\' organizations.</p>'),
(8, 'Environnement et climat', 'environnement-climat', '<p>La protection de l\'environnement est indissociable du developpement. Nous menons des campagnes de reboisement, de protection des sources et de gestion des dechets. Des formations sont dispensees sur l\'agroforesterie, la restauration des sols et l\'adaptation au changement climatique.</p>\r\n<p>Nous appuyons la mise en place de micro-projets d\'energie propre (foyers ameliores, biogaz) et sensibilisons les communautes aux risques climatiques. Des comites locaux de gestion environnementale sont crees pour assurer la perennite des actions.</p>\r\n<p>Notre vision est de contribuer a un developpement respectueux de l\'environnement, de restaurer les ecosystemes degrades et de renforcer la capacite des communautes a faire face aux aleas climatiques.</p>', '2026-03-28 12:31:06', 'climat-69c7ca0a94bbb874801727.png', 'Environment and Climate', '<p>Environmental protection is inseparable from development. We carry out reforestation campaigns, source protection, and waste management. Training is provided on agroforestry, soil restoration, and adaptation to climate change.</p>\r\n<p>We support the implementation of clean energy micro-projects (improved cookstoves, biogas) and raise community awareness of climate risks. Local environmental management committees are created to ensure the sustainability of actions.</p>\r\n<p>Our vision is to contribute to environmentally friendly development, restore degraded ecosystems, and strengthen communities\' capacity to cope with climate hazards.</p>'),
(9, 'Travaux publics', 'travaux-publics', '<p>Les travaux publics sont essentiels pour desenclaver les zones rurales et ameliorer les conditions de vie. Nous realisons des travaux de rehabilitation de routes, de ponts et de caniveaux. Des chantiers d\'interet communautaire (lutte anti-erosive, amenagement des berges) sont organises avec la main-d\'oeuvre locale.</p>\r\n<p>Nous formons des comites de suivi pour l\'entretien des infrastructures et promouvons l\'utilisation de techniques a faible impact environnemental. Des programmes de remuneration en especes ou en nature (cash-for-work) permettent de soutenir les menages les plus vulnerables.</p>\r\n<p>Ces actions contribuent a la reduction des risques de catastrophes, a l\'amelioration de la mobilite et a la creation d\'emplois temporaires. Nous travaillons en etroite collaboration avec les services techniques de l\'Etat.</p>', '2026-03-28 12:28:34', 'travaux-publics-69c7c97234e6b204109199.png', 'Public Works', '<p>Public works are essential to open up rural areas and improve living conditions. We carry out rehabilitation of roads, bridges, and drainage channels. Community-based work sites (anti-erosion, riverbank development) are organized with local labor.</p>\r\n<p>We train monitoring committees for infrastructure maintenance and promote the use of low-environmental-impact techniques. Cash-for-work or food-for-work programs support the most vulnerable households.</p>\r\n<p>These actions contribute to disaster risk reduction, improved mobility, and the creation of temporary jobs. We work closely with state technical services.</p>');

-- --------------------------------------------------------

--
-- Structure de la table `messenger_messages`
--

CREATE TABLE `messenger_messages` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `body` longtext NOT NULL,
  `headers` longtext NOT NULL,
  `queue_name` varchar(190) NOT NULL,
  `created_at` datetime NOT NULL,
  `available_at` datetime NOT NULL,
  `delivered_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_75EA56E0FB7336F0E3BD61CE16BA31DBBF396750` (`queue_name`,`available_at`,`delivered_at`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `project`
--

CREATE TABLE `project` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(150) NOT NULL,
  `slug` varchar(190) NOT NULL,
  `description` longtext NOT NULL,
  `objectives` longtext,
  `results` longtext,
  `status` varchar(20) NOT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `image_filename` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `country` varchar(100) NOT NULL,
  `province` varchar(100) NOT NULL,
  `secteur` varchar(150) NOT NULL,
  `budget` varchar(150) NOT NULL,
  `code` varchar(150) NOT NULL,
  `abbreviated_name` varchar(150) NOT NULL,
  `abbreviated_name_en` varchar(150) DEFAULT NULL,
  `title_en` varchar(150) DEFAULT NULL,
  `description_en` longtext,
  `objectives_en` longtext,
  `results_en` longtext,
  `secteur_en` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_2FB3D0EE989D9B62` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dechargement des donnees de la table `project`
--

INSERT INTO `project` (`id`, `title`, `slug`, `description`, `objectives`, `results`, `status`, `start_date`, `end_date`, `image_filename`, `created_at`, `updated_at`, `country`, `province`, `secteur`, `budget`, `code`, `abbreviated_name`, `abbreviated_name_en`, `title_en`, `description_en`, `objectives_en`, `results_en`, `secteur_en`) VALUES
(1, 'Appui aux centres de sante de Kabare', 'appui-sante-kabare', '<p>Le projet vise a renforcer l\'offre de soins dans la zone de sante de Kabare, en equipant trois centres de sante et en formant le personnel.</p><p>Des campagnes de vaccination et de sensibilisation seront organisees.</p>', '<p>Reduire la mortalite infantile de 20% ; augmenter le taux de vaccination de 50%.</p>', '<p>3 centres equipes, 50 agents formes, 5000 enfants vaccines.</p>', 'ongoing', '2024-01-15 00:00:00', '2025-12-31 00:00:00', 'suivi-plantes-69cfc7a8a61c3502651948.jpg', '2026-03-28 19:56:51', '2026-04-03 13:59:04', 'RDC', 'Sud-Kivu', 'Sante', '150000 USD', 'SANT-001', 'Appui sante', 'Health Support', 'Support to Kabare Health Centers', '<p>The project aims to strengthen healthcare services in the Kabare health zone by equipping three health centers and training staff.</p><p>Vaccination and awareness campaigns will be organized.</p>', '<p>Reduce infant mortality by 20%; increase vaccination coverage by 50%.</p>', '<p>3 centers equipped, 50 staff trained, 5,000 children vaccinated.</p>', 'Health'),
(2, 'Education pour tous a Bukavu', 'education-bukavu', '<p>Construction de 2 ecoles primaires et distribution de materiel scolaire a 2000 enfants.</p><p>Formation de 40 enseignants aux methodes participatives.</p>', '<p>Reduire le taux d\'abandon scolaire ; ameliorer la qualite de l\'enseignement.</p>', '<p>2 ecoles construites, 2000 kits scolaires distribues, 40 enseignants formes.</p>', 'ongoing', '2024-03-01 00:00:00', '2025-06-30 00:00:00', NULL, '2026-03-28 19:56:51', NULL, 'RDC', 'Sud-Kivu', 'Education', '200000 USD', 'EDU-001', 'Education pour tous', 'Education for All', 'Education for All in Bukavu', '<p>Construction of 2 primary schools and distribution of school supplies to 2,000 children.</p><p>Training of 40 teachers in participatory methods.</p>', '<p>Reduce school dropout rate; improve teaching quality.</p>', '<p>2 schools built, 2,000 school kits distributed, 40 teachers trained.</p>', 'Education'),
(3, 'Eau potable pour les villages de Kalehe', 'eau-kalehe', '<p>Forage de 10 puits et construction de latrines dans 5 villages.</p><p>Formation de comites de gestion de l\'eau.</p>', '<p>Acces a l\'eau potable pour 5000 personnes.</p>', '<p>10 puits fores, 5 latrines construites, 10 comites formes.</p>', 'ongoing', '2024-05-01 00:00:00', '2025-11-30 00:00:00', NULL, '2026-03-28 19:56:51', NULL, 'RDC', 'Sud-Kivu', 'Eau et assainissement', '120000 USD', 'EAU-001', 'Eau potable', 'Clean Water', 'Clean Water for Kalehe Villages', '<p>Drilling of 10 wells and construction of latrines in 5 villages.</p><p>Training of water management committees.</p>', '<p>Access to clean water for 5,000 people.</p>', '<p>10 wells drilled, 5 latrines built, 10 committees trained.</p>', 'Water and Sanitation'),
(4, 'Autonomisation des femmes a Uvira', 'femmes-uvira', '<p>Formation de 300 femmes en couture et petit commerce, creation de groupements d\'epargne.</p>', '<p>Reduire la pauvrete des menages diriges par des femmes.</p>', '<p>300 femmes formees, 20 groupements crees, 100 micro-entreprises soutenues.</p>', 'ongoing', '2024-02-10 00:00:00', '2025-04-30 00:00:00', NULL, '2026-03-28 19:56:51', NULL, 'RDC', 'Sud-Kivu', 'Inclusion sociale', '180000 USD', 'INC-001', 'Femmes actives', 'Women Empowerment', 'Women Empowerment in Uvira', '<p>Training of 300 women in sewing and small trade, creation of savings groups.</p>', '<p>Reduce poverty in female-headed households.</p>', '<p>300 women trained, 20 groups created, 100 micro-enterprises supported.</p>', 'Social Inclusion'),
(5, 'Developpement rural a Walungu', 'rural-walungu', '<p>Rehabilitation de 15 km de pistes rurales, appui a 500 agriculteurs en semences et formation agroecologique.</p>', '<p>Ameliorer l\'acces aux marches et la productivite agricole.</p>', '<p>15 km de pistes rehabilitees, 500 agriculteurs formes, augmentation de 30% des rendements.</p>', 'ongoing', '2024-04-15 00:00:00', '2025-09-30 00:00:00', NULL, '2026-03-28 19:56:51', NULL, 'RDC', 'Sud-Kivu', 'Developpement rural', '250000 USD', 'RUR-001', 'Developpement rural', 'Rural Development', 'Rural Development in Walungu', '<p>Rehabilitation of 15 km of rural roads, support to 500 farmers with seeds and agroecological training.</p>', '<p>Improve market access and agricultural productivity.</p>', '<p>15 km of roads rehabilitated, 500 farmers trained, 30% increase in yields.</p>', 'Rural Development'),
(6, 'Renforcement des capacites des OSC', 'renforcement-osc', '<p>Ateliers de formation en gestion de projet, collecte de fonds, plaidoyer pour 50 organisations locales.</p>', '<p>Renforcer la societe civile pour un developpement durable.</p>', '<p>50 OSC formees, 10 plans strategiques elabores, 5 projets collectifs montes.</p>', 'ongoing', '2024-01-20 00:00:00', '2025-03-31 00:00:00', NULL, '2026-03-28 19:56:51', NULL, 'RDC', 'Sud-Kivu', 'Renforcement des capacites', '90000 USD', 'CAP-001', 'Renforcement OSC', 'CSO Capacity', 'CSO Capacity Building', '<p>Training workshops on project management, fundraising, advocacy for 50 local organizations.</p>', '<p>Strengthen civil society for sustainable development.</p>', '<p>50 CSOs trained, 10 strategic plans developed, 5 joint projects set up.</p>', 'Capacity Building'),
(7, 'Agriculture durable a Mwenga', 'agriculture-mwenga', '<p>Distribution de semences ameliorees, formation en agroecologie, mise en place de champs-ecoles pour 800 paysans.</p>', '<p>Augmenter la securite alimentaire et les revenus.</p>', '<p>800 paysans formes, rendement augmente de 25%, 2 banques de cereales creees.</p>', 'ongoing', '2024-06-01 00:00:00', '2025-12-31 00:00:00', NULL, '2026-03-28 19:56:51', NULL, 'RDC', 'Sud-Kivu', 'Agriculture', '300000 USD', 'AGR-001', 'Agriculture durable', 'Sustainable Agriculture', 'Sustainable Agriculture in Mwenga', '<p>Distribution of improved seeds, agroecology training, establishment of farmer field schools for 800 farmers.</p>', '<p>Increase food security and incomes.</p>', '<p>800 farmers trained, yields increased by 25%, 2 cereal banks created.</p>', 'Agriculture'),
(8, 'Protection de l\'environnement a Kahuzi-Biega', 'environnement-kahuzi', '<p>Rehabilitation de 200 ha de foret, plantation de 50 000 arbres, sensibilisation des communautes.</p>', '<p>Lutter contre la deforestation, promouvoir les energies propres.</p>', '<p>200 ha restaures, 50 000 arbres plantes, 10 comites de gestion mis en place.</p>', 'ongoing', '2024-07-01 00:00:00', '2025-08-31 00:00:00', NULL, '2026-03-28 19:56:51', NULL, 'RDC', 'Sud-Kivu', 'Environnement', '220000 USD', 'ENV-001', 'Protection environnement', 'Environmental Protection', 'Environmental Protection in Kahuzi-Biega', '<p>Rehabilitation of 200 ha of forest, planting of 50,000 trees, community awareness.</p>', '<p>Fight deforestation, promote clean energy.</p>', '<p>200 ha restored, 50,000 trees planted, 10 management committees established.</p>', 'Environment'),
(9, 'Urgence et travaux publics a Fizi', 'travaux-fizi', '<p>Rehabilitation de 5 ponts, debouchage de 8 km de caniveaux, creation d\'emplois temporaires pour 200 personnes.</p>', '<p>Ameliorer la mobilite et reduire les risques d\'inondation.</p>', '<p>5 ponts rehabilites, 8 km de caniveaux debouches, 200 emplois crees.</p>', 'ongoing', '2024-08-15 00:00:00', '2025-10-31 00:00:00', NULL, '2026-03-28 19:56:51', NULL, 'RDC', 'Sud-Kivu', 'Travaux publics', '400000 USD', 'TP-001', 'Urgence Fizi', 'Emergency Works', 'Emergency and Public Works in Fizi', '<p>Rehabilitation of 5 bridges, clearing of 8 km of gutters, creation of temporary jobs for 200 people.</p>', '<p>Improve mobility and reduce flood risks.</p>', '<p>5 bridges rehabilitated, 8 km of gutters cleared, 200 jobs created.</p>', 'Public Works'),
(10, 'Sante maternelle a Shabunda', 'sante-maternelle-shabunda', '<p>Formation de 50 accoucheuses traditionnelles, equipement de 2 maternites, distribution de kits de naissance.</p>', '<p>Reduire la mortalite maternelle de 30%.</p>', '<p>50 accoucheuses formees, 2 maternites equipees, 2000 kits distribues.</p>', 'ongoing', '2024-09-01 00:00:00', '2025-05-31 00:00:00', NULL, '2026-03-28 19:56:51', NULL, 'RDC', 'Sud-Kivu', 'Sante', '180000 USD', 'SANT-002', 'Sante maternelle', 'Maternal Health', 'Maternal Health in Shabunda', '<p>Training of 50 traditional birth attendants, equipment for 2 maternity units, distribution of birth kits.</p>', '<p>Reduce maternal mortality by 30%.</p>', '<p>50 TBAs trained, 2 maternity units equipped, 2,000 kits distributed.</p>', 'Health'),
(11, 'Alphabetisation des adultes a Idjwi', 'alphabetisation-idjwi', '<p>Creation de 20 centres d\'alphabetisation, formation de 40 moniteurs, inscription de 600 apprenants.</p>', '<p>Reduire l\'analphabetisme chez les adultes.</p>', '<p>600 apprenants alphabetises, 40 moniteurs formes.</p>', 'completed', '2022-01-10 00:00:00', '2023-12-20 00:00:00', NULL, '2026-03-28 19:56:51', NULL, 'RDC', 'Sud-Kivu', 'Education', '75000 USD', 'EDU-002', 'Alphabetisation', 'Adult Literacy', 'Adult Literacy in Idjwi', '<p>Creation of 20 literacy centers, training of 40 trainers, enrollment of 600 learners.</p>', '<p>Reduce adult illiteracy.</p>', '<p>600 learners literate, 40 trainers trained.</p>', 'Education'),
(12, 'Appui aux cooperatives agricoles', 'cooperatives-agricoles', '<p>Formation de 10 cooperatives en gouvernance et commercialisation, equipement en materiel agricole.</p>', '<p>Renforcer l\'economie agricole locale.</p>', '<p>10 cooperatives structurees, 300 producteurs beneficiaires.</p>', 'completed', '2022-03-01 00:00:00', '2023-12-31 00:00:00', NULL, '2026-03-28 19:56:51', NULL, 'RDC', 'Sud-Kivu', 'Agriculture', '150000 USD', 'AGR-002', 'Cooperatives', 'Cooperatives', 'Support to Agricultural Cooperatives', '<p>Training of 10 cooperatives in governance and marketing, provision of agricultural equipment.</p>', '<p>Strengthen the local agricultural economy.</p>', '<p>10 cooperatives structured, 300 producers benefited.</p>', 'Agriculture'),
(13, 'Rehabilitation du marche de Baraka', 'marche-baraka', '<p>Construction de 50 etals, eclairage solaire, formation des commercants en hygiene.</p>', '<p>Ameliorer les conditions de vente et l\'hygiene.</p>', '<p>50 etals construits, 200 commercants formes.</p>', 'completed', '2021-06-01 00:00:00', '2022-12-31 00:00:00', NULL, '2026-03-28 19:56:51', NULL, 'RDC', 'Sud-Kivu', 'Developpement rural', '100000 USD', 'RUR-002', 'Marche de Baraka', 'Baraka Market', 'Rehabilitation of Baraka Market', '<p>Construction of 50 stalls, solar lighting, training of traders in hygiene.</p>', '<p>Improve sales conditions and hygiene.</p>', '<p>50 stalls built, 200 traders trained.</p>', 'Rural Development'),
(14, 'Construction d\'un centre de sante a Lulingu', 'centre-sante-lulingu', '<p>Construction d\'un centre de sante de 3 batiments, equipement en materiel medical.</p>', '<p>Ameliorer l\'acces aux soins pour 15 000 habitants.</p>', '<p>Centre de sante construit, 15000 personnes beneficiaires.</p>', 'completed', '2020-09-01 00:00:00', '2022-03-31 00:00:00', NULL, '2026-03-28 19:56:51', NULL, 'RDC', 'Sud-Kivu', 'Sante', '250000 USD', 'SANT-003', 'Centre de sante Lulingu', 'Lulingu Health Center', 'Construction of a Health Center in Lulingu', '<p>Construction of a 3-building health center, provision of medical equipment.</p>', '<p>Improve access to care for 15,000 people.</p>', '<p>Health center built, 15,000 beneficiaries.</p>', 'Health'),
(15, 'Formation des jeunes aux metiers du numerique', 'jeunes-numerique', '<p>Ateliers de coding, bureautique, entrepreneuriat pour 200 jeunes.</p>', '<p>Lutter contre le chomage des jeunes.</p>', '<p>200 jeunes formes, 50 emplois crees.</p>', 'ongoing', '2024-10-01 00:00:00', '2025-09-30 00:00:00', NULL, '2026-03-28 19:56:51', NULL, 'RDC', 'Sud-Kivu', 'Renforcement des capacites', '120000 USD', 'CAP-002', 'Numerique jeunes', 'Digital Skills', 'Digital Skills for Youth', '<p>Coding, office automation, entrepreneurship workshops for 200 young people.</p>', '<p>Fight youth unemployment.</p>', '<p>200 youth trained, 50 jobs created.</p>', 'Capacity Building'),
(16, 'Appui a l\'elevage a Kabare', 'elevage-kabare', '<p>Distribution de 500 chevres et formation en techniques d\'elevage.</p>', '<p>Diversifier les revenus des menages ruraux.</p>', '<p>500 familles beneficiaires, production de viande et lait augmentee.</p>', 'ongoing', '2024-11-01 00:00:00', '2025-10-31 00:00:00', NULL, '2026-03-28 19:56:51', NULL, 'RDC', 'Sud-Kivu', 'Agriculture', '80000 USD', 'AGR-003', 'Elevage', 'Livestock', 'Livestock Support in Kabare', '<p>Distribution of 500 goats and training in livestock techniques.</p>', '<p>Diversify income of rural households.</p>', '<p>500 families benefited, meat and milk production increased.</p>', 'Agriculture'),
(17, 'Lutte contre la malnutrition a Mwenga', 'malnutrition-mwenga', '<p>Distribution de plats nutritifs aux enfants de 0-5 ans, formation des meres en nutrition.</p>', '<p>Reduire la malnutrition aigue.</p>', '<p>500 enfants depistes, 200 cas traites, 300 meres formees.</p>', 'ongoing', '2024-12-01 00:00:00', '2025-11-30 00:00:00', NULL, '2026-03-28 19:56:51', NULL, 'RDC', 'Sud-Kivu', 'Sante', '100000 USD', 'SANT-004', 'Nutrition Mwenga', 'Nutrition', 'Malnutrition Control in Mwenga', '<p>Distribution of nutritious meals to children 0-5 years, nutrition training for mothers.</p>', '<p>Reduce acute malnutrition.</p>', '<p>500 children screened, 200 cases treated, 300 mothers trained.</p>', 'Health'),
(18, 'Renforcement des droits des enfants', 'droits-enfants', '<p>Campagnes de sensibilisation dans 50 ecoles, formation des enseignants sur les droits de l\'enfant, plaidoyer pour l\'enregistrement des naissances.</p>', '<p>Proteger les enfants contre les violences et l\'exploitation.</p>', '<p>50 ecoles touchees, 100 enseignants formes, 2000 enfants sensibilises.</p>', 'ongoing', '2025-01-15 00:00:00', '2025-12-31 00:00:00', NULL, '2026-03-28 19:56:51', NULL, 'RDC', 'Sud-Kivu', 'Inclusion sociale', '90000 USD', 'INC-002', 'Droits enfants', 'Children Rights', 'Children Rights Strengthening', '<p>Awareness campaigns in 50 schools, training of teachers on children\'s rights, advocacy for birth registration.</p>', '<p>Protect children from violence and exploitation.</p>', '<p>50 schools reached, 100 teachers trained, 2,000 children sensitized.</p>', 'Social Inclusion'),
(19, 'Rehabilitation de l\'electricite a Uvira', 'electricite-uvira', '<p>Rehabilitation du reseau electrique basse tension dans 3 quartiers, formation d\'electriciens locaux.</p>', '<p>Ameliorer l\'acces a l\'energie.</p>', '<p>3 quartiers raccordes, 10 electriciens formes.</p>', 'ongoing', '2025-02-01 00:00:00', '2025-12-31 00:00:00', NULL, '2026-03-28 19:56:51', NULL, 'RDC', 'Sud-Kivu', 'Travaux publics', '180000 USD', 'TP-002', 'Electricite Uvira', 'Electricity', 'Electricity Rehabilitation in Uvira', '<p>Rehabilitation of the low-voltage electricity network in 3 neighborhoods, training of local electricians.</p>', '<p>Improve access to energy.</p>', '<p>3 neighborhoods connected, 10 electricians trained.</p>', 'Public Works'),
(20, 'Projet pilote d\'agroforesterie', 'agroforesterie', '<p>Plantation de 10 000 arbres fruitiers et forestiers sur 50 ha, formation en agroforesterie.</p>', '<p>Ameliorer les sols et la biodiversite.</p>', '<p>10 000 arbres plantes, 50 ha restaures, 100 agriculteurs formes.</p>', 'ongoing', '2025-03-01 00:00:00', '2026-02-28 00:00:00', NULL, '2026-03-28 19:56:51', NULL, 'RDC', 'Sud-Kivu', 'Environnement', '150000 USD', 'ENV-002', 'Agroforesterie', 'Agroforestry', 'Agroforestry Pilot Project', '<p>Planting of 10,000 fruit and forest trees on 50 ha, agroforestry training.</p>', '<p>Improve soils and biodiversity.</p>', '<p>10,000 trees planted, 50 ha restored, 100 farmers trained.</p>', 'Environment');

-- --------------------------------------------------------

--
-- Structure de la table `structure_accompagnement`
--

CREATE TABLE `structure_accompagnement` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) NOT NULL,
  `type` varchar(100) DEFAULT NULL,
  `site_web` varchar(255) DEFAULT NULL,
  `logo` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dechargement des donnees de la table `structure_accompagnement`
--

INSERT INTO `structure_accompagnement` (`id`, `nom`, `type`, `site_web`, `logo`) VALUES
(1, 'UNICEF', 'bailleur', 'https://www.unicef.org', ''),
(2, 'Union Europeenne', 'bailleur', 'https://europa.eu', ''),
(3, 'Banque Mondiale', 'bailleur', 'https://www.worldbank.org', ''),
(4, 'Gouvernement congolais', 'bailleur', NULL, ''),
(5, 'ONU Femmes', 'bailleur', 'https://www.unwomen.org', ''),
(6, 'FAO', 'bailleur', 'https://www.fao.org', ''),
(7, 'PNUD', 'bailleur', 'https://www.undp.org', ''),
(8, 'GIZ', 'partenaire technique', 'https://www.giz.de', ''),
(9, 'Ambassade des Pays-Bas', 'bailleur', 'https://www.netherlandsandyou.nl', ''),
(10, 'ECHO', 'bailleur', 'https://ec.europa.eu/echo', ''),
(11, 'UNESCO', 'bailleur', 'https://www.unesco.org', ''),
(12, 'Save the Children', 'partenaire technique', 'https://www.savethechildren.org', ''),
(13, 'Action Contre la Faim', 'partenaire technique', 'https://www.actioncontrelafaim.org', ''),
(14, 'Gavi', 'bailleur', 'https://www.gavi.org', ''),
(15, 'GEF', 'bailleur', 'https://www.thegef.org', ''),
(16, 'FIDA', 'bailleur', 'https://www.ifad.org', ''),
(17, 'Suisse', 'bailleur', 'https://www.eda.admin.ch', ''),
(18, 'Belgique', 'bailleur', 'https://diplomatie.belgium.be', ''),
(19, 'Canada', 'bailleur', 'https://www.canada.ca', ''),
(20, 'Gouvernement suedois', 'bailleur', 'https://www.government.se', ''),
(21, 'PAM', 'bailleur', 'https://www.wfp.org', ''),
(22, 'OIM', 'bailleur', 'https://www.iom.int', ''),
(23, 'UNFPA', 'bailleur', 'https://www.unfpa.org', ''),
(24, 'UNOPS', 'bailleur', 'https://www.unops.org', ''),
(25, 'Fonds Vert', 'bailleur', 'https://www.greenclimate.fund', '');

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(50) NOT NULL,
  `roles` json NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_IDENTIFIER_EMAIL` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dechargement des donnees de la table `user`
--

INSERT INTO `user` (`id`, `email`, `roles`, `password`) VALUES
(1, 'admin@asodeco.cd', '[\"ROLE_ADMIN\"]', '$2y$13$LMQTJ4TCXbpdhuTzjvqd5eMT0CoPSvbJ77v0XTIjzu5pNvcoQm1Ji'),
(2, 'admin2@asodeco.cd', '[\"ROLE_ADMIN\"]', '$2y$13$bI0Nh1lJtkyhstBzRyuA9.FMkv7GHUPJSnvTh8l3MXFQsl6pNFvJa'),
(3, 'admin3@asodeco.cd', '[\"ROLE_ADMIN\"]', '$2y$13$xX7Hcs.0BQcOv2r06/5ggu0lusCScYRN8Ku27JlWmqYnb8X4.44bi');

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;