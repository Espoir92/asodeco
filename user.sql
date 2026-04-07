-- Assurez-vous d'être sur la bonne base
USE main;

-- Supprimer la table si elle existe (optionnel, seulement si vous voulez la recréer)
-- DROP TABLE IF EXISTS `user`;

-- Créer la table avec le bon moteur (InnoDB) et la bonne collation
CREATE TABLE IF NOT EXISTS `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(180) NOT NULL,  -- Augmenté de 50 à 180 pour sécurité
  `roles` json NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_IDENTIFIER_EMAIL` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- Insérer les utilisateurs (avec gestion des doublons)
INSERT INTO `user` (`id`, `email`, `roles`, `password`) VALUES
(1, 'admin@asodeco.cd', '["ROLE_ADMIN"]', '$2y$13$LMQTJ4TCXbpdhuTzjvqd5eMT0CoPSvbJ77v0XTIjzu5pNvcoQm1Ji'),
(2, 'admin2@asodeco.cd', '["ROLE_ADMIN"]', '$2y$13$bI0Nh1lJtkyhstBzRyuA9.FMkv7GHUPJSnvTh8l3MXFQsl6pNFvJa'),
(3, 'admin3@asodeco.cd', '["ROLE_ADMIN"]', '$2y$13$xX7Hcs.0BQcOv2r06/5ggu0lusCScYRN8Ku27JlWmqYnb8X4.44bi')
ON DUPLICATE KEY UPDATE 
  email = VALUES(email),
  roles = VALUES(roles),
  password = VALUES(password);

-- Vérifier l'insertion
SELECT id, email, JSON_EXTRACT(roles, '$[0]') as role FROM user;