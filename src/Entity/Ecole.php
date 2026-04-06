<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;


#[ORM\Entity()]
class Ecole extends Beneficiaire
{
    #[ORM\Column(length: 100, nullable: true)]
    private ?string $directeur = null;

    #[ORM\Column(type: 'integer', nullable: true)]
    private ?int $nombreEleves = null;

    #[ORM\Column(length: 100, nullable: true)]
    private ?string $cycle = null;

    // Getters/setters
    public function getDirecteur(): ?string { return $this->directeur; }
    public function setDirecteur(?string $directeur): self { $this->directeur = $directeur; return $this; }
    public function getNombreEleves(): ?int { return $this->nombreEleves; }
    public function setNombreEleves(?int $nombreEleves): self { $this->nombreEleves = $nombreEleves; return $this; }





  

    /**
     * Get the value of cycle
     */
    public function getCycle(): ?string
    {
        return $this->cycle;
    }

    /**
     * Set the value of cycle
     */
    public function setCycle(?string $cycle): self
    {
        $this->cycle = $cycle;

        return $this;
    }
    public function __toString(): string
{
    return $this->getNom() ?? 'Ecole sans nom';
}
}