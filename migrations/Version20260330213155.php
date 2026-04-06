<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20260330213155 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE affectation ADD CONSTRAINT FK_F4DD61D3166D1F9C FOREIGN KEY (project_id) REFERENCES project (id)');
        $this->addSql('ALTER TABLE affectation ADD CONSTRAINT FK_F4DD61D35AF81F68 FOREIGN KEY (beneficiaire_id) REFERENCES beneficiaire (id)');
        $this->addSql('ALTER TABLE appui ADD CONSTRAINT FK_3B983563166D1F9C FOREIGN KEY (project_id) REFERENCES project (id)');
        $this->addSql('ALTER TABLE appui ADD CONSTRAINT FK_3B9835632534008B FOREIGN KEY (structure_id) REFERENCES structure_accompagnement (id)');
        $this->addSql('ALTER TABLE article ADD CONSTRAINT FK_23A0E66166D1F9C FOREIGN KEY (project_id) REFERENCES project (id)');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE affectation DROP FOREIGN KEY FK_F4DD61D3166D1F9C');
        $this->addSql('ALTER TABLE affectation DROP FOREIGN KEY FK_F4DD61D35AF81F68');
        $this->addSql('ALTER TABLE appui DROP FOREIGN KEY FK_3B983563166D1F9C');
        $this->addSql('ALTER TABLE appui DROP FOREIGN KEY FK_3B9835632534008B');
        $this->addSql('ALTER TABLE article DROP FOREIGN KEY FK_23A0E66166D1F9C');
    }
}
