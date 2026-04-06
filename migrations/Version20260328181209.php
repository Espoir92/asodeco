<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20260328181209 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE article ADD project_id INT DEFAULT NULL');
        $this->addSql('ALTER TABLE article ADD CONSTRAINT FK_23A0E66166D1F9C FOREIGN KEY (project_id) REFERENCES project (id)');
        $this->addSql('CREATE INDEX IDX_23A0E66166D1F9C ON article (project_id)');
        $this->addSql('ALTER TABLE project ADD country VARCHAR(100) NOT NULL, ADD province VARCHAR(100) NOT NULL, ADD financed_by VARCHAR(150) NOT NULL, ADD secteur VARCHAR(150) NOT NULL, ADD start_date_at DATETIME NOT NULL, ADD end_date_at DATETIME NOT NULL, ADD budget VARCHAR(150) NOT NULL, ADD code VARCHAR(150) NOT NULL, ADD abbreviated_name VARCHAR(150) NOT NULL, ADD abbreviated_name_en VARCHAR(150) DEFAULT NULL');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE article DROP FOREIGN KEY FK_23A0E66166D1F9C');
        $this->addSql('DROP INDEX IDX_23A0E66166D1F9C ON article');
        $this->addSql('ALTER TABLE article DROP project_id');
        $this->addSql('ALTER TABLE project DROP country, DROP province, DROP financed_by, DROP secteur, DROP start_date_at, DROP end_date_at, DROP budget, DROP code, DROP abbreviated_name, DROP abbreviated_name_en');
    }
}
