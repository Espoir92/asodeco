<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity()]
class Hopital extends Beneficiaire
{
    #[ORM\Column(type: 'integer', nullable: true)]
    private ?int $nombreLits = null;

    #[ORM\Column(type: 'text', nullable: true)]
    private ?string $specialites = null; // peut être une liste

    #[ORM\Column(length: 255, nullable: true)]
    private ?string $directeurMedical = null;

    #[ORM\Column(length: 255, nullable: true)]
    private ?string $typeHopital = null; // public, privé, universitaire, etc.

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

    public function getDirectorMedical(): ?string
    {
        return $this->directeurMedical;
    }

    public function setDirectorMedical(?string $directeurMedical): self
    {
        $this->directeurMedical = $directeurMedical;
        return $this;
    }

    public function getTypeHopital(): ?string
    {
        return $this->typeHopital;
    }

    public function setTypeHopital(?string $typeHopital): self
    {
        $this->typeHopital = $typeHopital;
        return $this;
    }
    public function __toString(): string
{
    return $this->getNom() ?? 'Hopital sans nom';
}
}