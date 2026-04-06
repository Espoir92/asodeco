<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity()]
class Clinique extends Beneficiaire
{
    #[ORM\Column(type: 'integer', nullable: true)]
    private ?int $nombreLits = null;

    #[ORM\Column(type: 'text', nullable: true)]
    private ?string $specialites = null; // peut être une liste séparée par des virgules

    #[ORM\Column(length: 255, nullable: true)]
    private ?string $medecinChef = null;

    public function getNombreLits(): ?int
    {
        return $this->nombreLits;
    }

    public function setNombreLits(?int $nombreLits): self
    {
        $this->nombreLits = $nombreLits;
        return $this;
    }

    public function getSpecialites(): ?string
    {
        return $this->specialites;
    }

    public function setSpecialites(?string $specialites): self
    {
        $this->specialites = $specialites;
        return $this;
    }

    public function getMedecinChef(): ?string
    {
        return $this->medecinChef;
    }

    public function setMedecinChef(?string $medecinChef): self
    {
        $this->medecinChef = $medecinChef;
        return $this;
    }
    public function __toString(): string
{
    return $this->getNom() ?? 'Clinique sans nom';
}
}