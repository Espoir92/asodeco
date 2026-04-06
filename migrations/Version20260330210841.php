<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20260330210841 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE TABLE affectation (id INT AUTO_INCREMENT NOT NULL, date_affectation DATETIME NOT NULL, type_appui VARCHAR(100) DEFAULT NULL, commentaire VARCHAR(255) DEFAULT NULL, project_id INT NOT NULL, beneficiaire_id INT NOT NULL, INDEX IDX_F4DD61D3166D1F9C (project_id), INDEX IDX_F4DD61D35AF81F68 (beneficiaire_id), PRIMARY KEY (id)) DEFAULT CHARACTER SET utf8mb4 ROW_FORMAT = dynamic');
        $this->addSql('CREATE TABLE appui (id INT AUTO_INCREMENT NOT NULL, nature_appui VARCHAR(100) DEFAULT NULL, montant NUMERIC(15, 2) DEFAULT NULL, description LONGTEXT DEFAULT NULL, date_appui DATETIME NOT NULL, project_id INT NOT NULL, structure_id INT NOT NULL, INDEX IDX_3B983563166D1F9C (project_id), INDEX IDX_3B9835632534008B (structure_id), PRIMARY KEY (id)) DEFAULT CHARACTER SET utf8mb4 ROW_FORMAT = dynamic');
        $this->addSql('CREATE TABLE beneficiaire (id INT AUTO_INCREMENT NOT NULL, nom VARCHAR(255) NOT NULL, localisation VARCHAR(255) DEFAULT NULL, telephone VARCHAR(20) DEFAULT NULL, email VARCHAR(100) DEFAULT NULL, type VARCHAR(255) NOT NULL, prenom VARCHAR(100) DEFAULT NULL, post_nom VARCHAR(100) DEFAULT NULL, date_naissance DATE DEFAULT NULL, population INT DEFAULT NULL, chef VARCHAR(255) DEFAULT NULL, zone VARCHAR(100) DEFAULT NULL, directeur VARCHAR(100) DEFAULT NULL, nombre_eleves INT DEFAULT NULL, type_institution VARCHAR(100) DEFAULT NULL, responsable VARCHAR(255) DEFAULT NULL, domaine_activite VARCHAR(255) DEFAULT NULL, nombre_lits INT DEFAULT NULL, specialites LONGTEXT DEFAULT NULL, medecin_chef VARCHAR(255) DEFAULT NULL, directeur_medical VARCHAR(255) DEFAULT NULL, type_hopital VARCHAR(255) DEFAULT NULL, PRIMARY KEY (id)) DEFAULT CHARACTER SET utf8mb4 ROW_FORMAT = dynamic');
        $this->addSql('CREATE TABLE structure_accompagnement (id INT AUTO_INCREMENT NOT NULL, nom VARCHAR(255) NOT NULL, type VARCHAR(100) DEFAULT NULL, site_web VARCHAR(255) DEFAULT NULL, logo VARCHAR(255) NOT NULL, PRIMARY KEY (id)) DEFAULT CHARACTER SET utf8mb4 ROW_FORMAT = dynamic');
        $this->addSql('ALTER TABLE affectation ADD CONSTRAINT FK_F4DD61D3166D1F9C FOREIGN KEY (project_id) REFERENCES project (id)');
        $this->addSql('ALTER TABLE affectation ADD CONSTRAINT FK_F4DD61D35AF81F68 FOREIGN KEY (beneficiaire_id) REFERENCES beneficiaire (id)');
        $this->addSql('ALTER TABLE appui ADD CONSTRAINT FK_3B983563166D1F9C FOREIGN KEY (project_id) REFERENCES project (id)');
        $this->addSql('ALTER TABLE appui ADD CONSTRAINT FK_3B9835632534008B FOREIGN KEY (structure_id) REFERENCES structure_accompagnement (id)');
        $this->addSql('ALTER TABLE article ADD CONSTRAINT FK_23A0E66166D1F9C FOREIGN KEY (project_id) REFERENCES project (id)');
        $this->addSql('ALTER TABLE project DROP partners, DROP financed_by');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE affectation DROP FOREIGN KEY FK_F4DD61D3166D1F9C');
        $this->addSql('ALTER TABLE affectation DROP FOREIGN KEY FK_F4DD61D35AF81F68');
        $this->addSql('ALTER TABLE appui DROP FOREIGN KEY FK_3B983563166D1F9C');
        $this->addSql('ALTER TABLE appui DROP FOREIGN KEY FK_3B9835632534008B');
        $this->addSql('DROP TABLE affectation');
        $this->addSql('DROP TABLE appui');
        $this->addSql('DROP TABLE beneficiaire');
        $this->addSql('DROP TABLE structure_accompagnement');
        $this->addSql('ALTER TABLE article DROP FOREIGN KEY FK_23A0E66166D1F9C');
        $this->addSql('ALTER TABLE project ADD partners VARCHAR(255) DEFAULT NULL, ADD financed_by VARCHAR(150) NOT NULL');
    }
}
