<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20260328183339 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE article ADD CONSTRAINT FK_23A0E66166D1F9C FOREIGN KEY (project_id) REFERENCES project (id)');
        $this->addSql('ALTER TABLE project ADD title_en VARCHAR(150) DEFAULT NULL, ADD description_en LONGTEXT DEFAULT NULL, ADD objectives_en LONGTEXT DEFAULT NULL, ADD results_en LONGTEXT DEFAULT NULL, DROP start_date_at, DROP end_date_at');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE article DROP FOREIGN KEY FK_23A0E66166D1F9C');
        $this->addSql('ALTER TABLE project ADD start_date_at DATETIME NOT NULL, ADD end_date_at DATETIME NOT NULL, DROP title_en, DROP description_en, DROP objectives_en, DROP results_en');
    }
}
