-- phpMyAdmin SQL Dump
-- Hôte : 127.0.0.1:3306
-- Version du serveur : 8.2.0
-- PHP : 8.3.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

-- Base de données : asodeco (Upsun)
CREATE DATABASE IF NOT EXISTS main CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE main;

-- --------------------------------------------------------
-- Table `user`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(180) NOT NULL,
  `roles` json NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_IDENTIFIER_EMAIL` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT IGNORE INTO `user` (`id`, `email`, `roles`, `password`) VALUES
(1, 'admin@asodeco.cd', '["ROLE_ADMIN"]', '$2y$13$LMQTJ4TCXbpdhuTzjvqd5eMT0CoPSvbJ77v0XTIjzu5pNvcoQm1Ji'),
(2, 'admin2@asodeco.cd', '["ROLE_ADMIN"]', '$2y$13$bI0Nh1lJtkyhstBzRyuA9.FMkv7GHUPJSnvTh8l3MXFQsl6pNFvJa'),
(3, 'admin3@asodeco.cd', '["ROLE_ADMIN"]', '$2y$13$xX7Hcs.0BQcOv2r06/5ggu0lusCScYRN8Ku27JlWmqYnb8X4.44bi');

-- --------------------------------------------------------
-- Table `domain` (sans balises HTML)
-- --------------------------------------------------------

DROP TABLE IF EXISTS `domain`;
CREATE TABLE IF NOT EXISTS `domain` (
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

INSERT INTO `domain` (`id`, `name`, `slug`, `description`, `updated_at`, `image_filename`, `name_en`, `description_en`) VALUES
(1, 'Éducation', 'education', 'L\'accès à une éducation de qualité est un droit fondamental et un levier essentiel pour le développement. ASODECO œuvre pour la construction et la réhabilitation d\'écoles, la fourniture de matériel scolaire et la formation des enseignants. Nous soutenons également des programmes d\'alphabétisation pour adultes et des cantines scolaires afin de lutter contre le décrochage. Nos actions incluent la sensibilisation des familles à l\'importance de la scolarisation des filles, l\'organisation de classes passerelles pour les enfants déscolarisés et le plaidoyer pour des politiques éducatives inclusives. Grâce à nos partenaires, nous équipons les bibliothèques et offrons des bourses d\'études aux élèves méritants issus de milieux défavorisés. À long terme, nous visons à améliorer les taux de scolarisation et la qualité de l\'enseignement dans les zones rurales, en formant des comités de gestion scolaire et en promouvant des méthodes pédagogiques participatives.', '2026-03-28 11:22:22', 'education-2026-69c7b9eee0e27756315452.png', 'Education', 'Access to quality education is a fundamental right and a key driver of development. ASODECO works to build and rehabilitate schools, provide school supplies, and train teachers. We also support adult literacy programs and school canteens to prevent dropout. Our actions include raising awareness among families about the importance of girls\' education, organizing bridging classes for out-of-school children, and advocating for inclusive education policies. Through our partners, we equip libraries and offer scholarships to deserving students from disadvantaged backgrounds. In the long term, we aim to improve school enrollment rates and teaching quality in rural areas by training school management committees and promoting participatory teaching methods.'),

(2, 'Santé', 'sante', 'La santé communautaire est au cœur de notre mission. Nous appuyons les centres de santé ruraux par des équipements médicaux, des formations pour le personnel soignant et des campagnes de vaccination. Nos équipes mènent des actions de sensibilisation sur les maladies endémiques (paludisme, tuberculose) et sur la santé materno-infantile. Nous organisons des consultations mobiles pour atteindre les populations isolées, distribuons des moustiquaires imprégnées et favorisons l\'accès à l\'eau potable dans les structures de santé. La lutte contre la malnutrition passe par des ateliers nutritionnels et la création de jardins potagers thérapeutiques. Notre objectif est de réduire la mortalité infantile et maternelle, d\'améliorer l\'offre de soins de premier recours et de renforcer la résilience des communautés face aux épidémies. Nous travaillons en étroite collaboration avec les autorités sanitaires locales.', '2026-03-28 11:26:19', 'sante-69c7badbb9298916124159.jpg', 'Health', 'Community health is at the heart of our mission. We support rural health centers with medical equipment, training for healthcare staff, and vaccination campaigns. Our teams conduct awareness activities on endemic diseases (malaria, tuberculosis) and maternal and child health. We organize mobile consultations to reach isolated populations, distribute insecticide-treated mosquito nets, and promote access to clean water in health facilities. The fight against malnutrition involves nutritional workshops and the creation of therapeutic kitchen gardens. Our goal is to reduce infant and maternal mortality, improve primary healthcare services, and strengthen community resilience against epidemics. We work closely with local health authorities.'),

(3, 'Hygiène, eau et assainissement', 'hygiene-eau-assainissement', 'L\'accès à l\'eau potable et à des infrastructures d\'assainissement décentes est une priorité. Nous forons des puits, réhabilitons des sources d\'eau et construisons des latrines dans les écoles et les villages. Des comités de gestion de l\'eau sont formés pour assurer la durabilité des ouvrages. Nos équipes animent des séances d\'hygiène collective : lavage des mains, gestion des déchets, entretien des points d\'eau. Nous distribuons également des kits d\'hygiène aux familles les plus vulnérables et sensibilisons à la prévention des maladies hydriques (choléra, diarrhées). À travers ces actions, nous contribuons à réduire les maladies liées à l\'eau, à améliorer la scolarité des filles (grâce aux latrines séparées) et à renforcer la dignité des communautés. Notre approche est participative et respectueuse des savoirs locaux.', '2026-03-28 11:30:16', 'eau-hygiene-ass-69c7bbc8638d7350072644.png', 'Water, Hygiene and Sanitation', 'Access to clean water and decent sanitation infrastructure is a priority. We drill wells, rehabilitate water sources, and build latrines in schools and villages. Water management committees are trained to ensure the sustainability of the structures. Our teams conduct group hygiene sessions: hand washing, waste management, and maintenance of water points. We also distribute hygiene kits to the most vulnerable families and raise awareness about the prevention of water-borne diseases (cholera, diarrhea). Through these actions, we help reduce water-related diseases, improve girls\' school attendance (thanks to separate latrines), and strengthen the dignity of communities. Our approach is participatory and respectful of local knowledge.'),

(4, 'Inclusion sociale', 'inclusion-sociale', 'L\'inclusion sociale vise à garantir que les groupes vulnérables – femmes, enfants, personnes handicapées, minorités – participent pleinement à la vie de la communauté. Nous menons des ateliers de sensibilisation aux droits humains, appuyons des groupements d\'entraide et facilitons l\'accès aux services de base. Nous accompagnons les femmes dans des activités génératrices de revenus, luttons contre les violences basées sur le genre et promouvons la scolarisation des enfants handicapés. Des plaidoyers sont organisés auprès des autorités locales pour l\'adoption de politiques inclusives. Notre vision est de bâtir une société plus juste où chacun, sans discrimination, peut exercer ses droits et contribuer au développement collectif. Nous travaillons en réseau avec d\'autres organisations de la société civile.', '2026-03-28 12:34:35', 'asedeco-inclusion-sociale-69c7cadb427ab797928562.png', 'Social Inclusion', 'Social inclusion aims to ensure that vulnerable groups – women, children, people with disabilities, minorities – participate fully in community life. We conduct human rights awareness workshops, support self-help groups, and facilitate access to basic services. We support women in income-generating activities, fight gender-based violence, and promote the education of children with disabilities. Advocacy efforts are organized with local authorities for the adoption of inclusive policies. Our vision is to build a fairer society where everyone, without discrimination, can exercise their rights and contribute to collective development. We work in networks with other civil society organizations.'),

(5, 'Développement rural', 'developpement-rural', 'Le développement rural passe par l\'amélioration des infrastructures et des services de base. Nous construisons des pistes rurales, des marchés et des petits ouvrages hydrauliques. Nous appuyons également les organisations paysannes pour renforcer leur capacité de production et de commercialisation. Nos projets incluent l\'électrification rurale par énergie solaire, la mise en place de systèmes d\'irrigation et la formation en techniques agricoles durables. Nous facilitons l\'accès aux intrants et aux services financiers pour les petits producteurs. Notre objectif est de réduire l\'isolement des communautés rurales, d\'augmenter les revenus agricoles et de freiner l\'exode rural. Nous privilégions une approche participative et durable.', '2026-03-28 12:12:47', 'dev-rurale-69c7c5bfeb866089650718.png', 'Rural Development', 'Rural development involves improving infrastructure and basic services. We build rural roads, markets, and small hydraulic structures. We also support farmers\' organizations to strengthen their production and marketing capacity. Our projects include rural electrification with solar energy, establishment of irrigation systems, and training in sustainable agricultural techniques. We facilitate access to inputs and financial services for smallholder farmers. Our goal is to reduce the isolation of rural communities, increase agricultural incomes, and curb rural-to-urban migration. We prioritize a participatory and sustainable approach.'),

(6, 'Renforcement des capacités', 'renforcement-capacites', 'Le renforcement des capacités est un axe transversal de notre action. Nous formons les organisations locales à la gestion de projets, à la collecte de fonds et au plaidoyer. Des sessions de formation sont également dispensées aux agents communautaires sur des thèmes variés (santé, environnement, droits humains). Nous mettons en place des programmes de mentorat pour les jeunes leaders et appuyons la structuration d\'associations locales. Nos outils pédagogiques (guides, modules) sont adaptés aux contextes ruraux et disponibles en français et en langues locales. En renforçant les compétences des acteurs locaux, nous favorisons l\'appropriation des projets et leur durabilité. Notre ambition est de créer un vivier d\'expertises locales capables de répondre durablement aux besoins des communautés.', '2026-03-28 12:21:22', 'renforcement-de-capacite-2-69c7c7c281378390515991.png', 'Capacity Building', 'Capacity building is a cross-cutting focus of our action. We train local organizations in project management, fundraising, and advocacy. Training sessions are also provided to community agents on various themes (health, environment, human rights). We set up mentoring programs for young leaders and support the structuring of local associations. Our educational tools (guides, modules) are adapted to rural contexts and available in French and local languages. By strengthening the skills of local actors, we promote ownership of projects and their sustainability. Our ambition is to create a pool of local expertise capable of sustainably meeting community needs.'),

(7, 'Agriculture et sécurité alimentaire', 'agriculture-securite-alimentaire', 'L\'agriculture durable est au cœur de la sécurité alimentaire. Nous soutenons les producteurs par des formations en agroécologie, la distribution de semences améliorées et l\'appui à la diversification des cultures. Des champs écoles sont mis en place pour tester et diffuser les bonnes pratiques. Nous facilitons l\'accès aux marchés, aidons à la création de coopératives et promouvons la transformation locale des produits agricoles. Des banques de céréales communautaires permettent de lutter contre la soudure alimentaire. Notre objectif est d\'accroître la production vivrière, de diversifier les sources de revenus et de renforcer la résilience des ménages face aux crises alimentaires. Nous travaillons avec les services techniques agricoles et les organisations paysannes.', '2026-03-28 12:31:36', 'agriculture-69c7ca285635d660816833.png', 'Agriculture and Food Security', 'Sustainable agriculture is at the heart of food security. We support producers through training in agroecology, distribution of improved seeds, and support for crop diversification. Farmer field schools are established to test and disseminate good practices. We facilitate access to markets, help create cooperatives, and promote local processing of agricultural products. Community grain banks help combat food shortages. Our goal is to increase food production, diversify income sources, and strengthen household resilience to food crises. We work with agricultural technical services and farmers\' organizations.'),

(8, 'Environnement et climat', 'environnement-climat', 'La protection de l\'environnement est indissociable du développement. Nous menons des campagnes de reboisement, de protection des sources et de gestion des déchets. Des formations sont dispensées sur l\'agroforesterie, la restauration des sols et l\'adaptation au changement climatique. Nous appuyons la mise en place de micro-projets d\'énergie propre (foyers améliorés, biogaz) et sensibilisons les communautés aux risques climatiques. Des comités locaux de gestion environnementale sont créés pour assurer la pérennité des actions. Notre vision est de contribuer à un développement respectueux de l\'environnement, de restaurer les écosystèmes dégradés et de renforcer la capacité des communautés à faire face aux aléas climatiques.', '2026-03-28 12:31:06', 'climat-69c7ca0a94bbb874801727.png', 'Environment and Climate', 'Environmental protection is inseparable from development. We carry out reforestation campaigns, source protection, and waste management. Training is provided on agroforestry, soil restoration, and adaptation to climate change. We support the implementation of clean energy micro-projects (improved cookstoves, biogas) and raise community awareness of climate risks. Local environmental management committees are created to ensure the sustainability of actions. Our vision is to contribute to environmentally friendly development, restore degraded ecosystems, and strengthen communities\' capacity to cope with climate hazards.'),

(9, 'Travaux publics', 'travaux-publics', 'Les travaux publics sont essentiels pour désenclaver les zones rurales et améliorer les conditions de vie. Nous réalisons des travaux de réhabilitation de routes, de ponts et de caniveaux. Des chantiers d\'intérêt communautaire (lutte anti-érosive, aménagement des berges) sont organisés avec la main-d\'œuvre locale. Nous formons des comités de suivi pour l\'entretien des infrastructures et promouvons l\'utilisation de techniques à faible impact environnemental. Des programmes de rémunération en espèces ou en nature (cash-for-work) permettent de soutenir les ménages les plus vulnérables. Ces actions contribuent à la réduction des risques de catastrophes, à l\'amélioration de la mobilité et à la création d\'emplois temporaires. Nous travaillons en étroite collaboration avec les services techniques de l\'État.', '2026-03-28 12:28:34', 'travaux-publics-69c7c97234e6b204109199.png', 'Public Works', 'Public works are essential to open up rural areas and improve living conditions. We carry out rehabilitation of roads, bridges, and drainage channels. Community-based work sites (anti-erosion, riverbank development) are organized with local labor. We train monitoring committees for infrastructure maintenance and promote the use of low-environmental-impact techniques. Cash-for-work or food-for-work programs support the most vulnerable households. These actions contribute to disaster risk reduction, improved mobility, and the creation of temporary jobs. We work closely with state technical services.');

-- --------------------------------------------------------
-- Table `project` (version simplifiée sans HTML)
-- --------------------------------------------------------

DROP TABLE IF EXISTS `project`;
CREATE TABLE IF NOT EXISTS `project` (
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

INSERT INTO `project` (`id`, `title`, `slug`, `description`, `objectives`, `results`, `status`, `start_date`, `end_date`, `image_filename`, `created_at`, `updated_at`, `country`, `province`, `secteur`, `budget`, `code`, `abbreviated_name`, `abbreviated_name_en`, `title_en`, `description_en`, `objectives_en`, `results_en`, `secteur_en`) VALUES
(1, 'Appui aux centres de santé de Kabare', 'appui-sante-kabare', 'Le projet vise à renforcer l\'offre de soins dans la zone de santé de Kabare, en équipant trois centres de santé et en formant le personnel. Des campagnes de vaccination et de sensibilisation seront organisées.', 'Réduire la mortalité infantile de 20% ; augmenter le taux de vaccination de 50%.', '3 centres équipés, 50 agents formés, 5000 enfants vaccinés.', 'ongoing', '2024-01-15 00:00:00', '2025-12-31 00:00:00', 'suivi-plantes-69cfc7a8a61c3502651948.jpg', '2026-03-28 19:56:51', '2026-04-03 13:59:04', 'RDC', 'Sud-Kivu', 'Santé', '150000 USD', 'SANT-001', 'Appui santé', 'Health Support', 'Support to Kabare Health Centers', 'The project aims to strengthen healthcare services in the Kabare health zone by equipping three health centers and training staff. Vaccination and awareness campaigns will be organized.', 'Reduce infant mortality by 20%; increase vaccination coverage by 50%.', '3 centers equipped, 50 staff trained, 5,000 children vaccinated.', 'Health'),

(2, 'Éducation pour tous à Bukavu', 'education-bukavu', 'Construction de 2 écoles primaires et distribution de matériel scolaire à 2000 enfants. Formation de 40 enseignants aux méthodes participatives.', 'Réduire le taux d\'abandon scolaire ; améliorer la qualité de l\'enseignement.', '2 écoles construites, 2000 kits scolaires distribués, 40 enseignants formés.', 'ongoing', '2024-03-01 00:00:00', '2025-06-30 00:00:00', NULL, '2026-03-28 19:56:51', NULL, 'RDC', 'Sud-Kivu', 'Éducation', '200000 USD', 'EDU-001', 'Éducation pour tous', 'Education for All', 'Education for All in Bukavu', 'Construction of 2 primary schools and distribution of school supplies to 2,000 children. Training of 40 teachers in participatory methods.', 'Reduce school dropout rate; improve teaching quality.', '2 schools built, 2,000 school kits distributed, 40 teachers trained.', 'Education'),

(3, 'Eau potable pour les villages de Kalehe', 'eau-kalehe', 'Forage de 10 puits et construction de latrines dans 5 villages. Formation de comités de gestion de l\'eau.', 'Accès à l\'eau potable pour 5000 personnes.', '10 puits forés, 5 latrines construites, 10 comités formés.', 'ongoing', '2024-05-01 00:00:00', '2025-11-30 00:00:00', NULL, '2026-03-28 19:56:51', NULL, 'RDC', 'Sud-Kivu', 'Eau et assainissement', '120000 USD', 'EAU-001', 'Eau potable', 'Clean Water', 'Clean Water for Kalehe Villages', 'Drilling of 10 wells and construction of latrines in 5 villages. Training of water management committees.', 'Access to clean water for 5,000 people.', '10 wells drilled, 5 latrines built, 10 committees trained.', 'Water and Sanitation');

-- Vérification finale
SELECT 'Utilisateurs insérés :' as Info, COUNT(*) as Nombre FROM user
UNION ALL
SELECT 'Domaines insérés :', COUNT(*) FROM domain
UNION ALL
SELECT 'Projets insérés :', COUNT(*) FROM project;

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;