<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity()]
class Communaute extends Beneficiaire
{
    #[ORM\Column(type: 'integer', nullable: true)]
    private ?int $population = null;

    #[ORM\Column(length: 255, nullable: true)]
    private ?string $chef = null;

    #[ORM\Column(length: 100, nullable: true)]
    private ?string $zone = null; // ex: "Chefferie", "Groupement", "Village"

    // Getters / Setters

    public function getPopulation(): ?int
    {
        return $this->population;
    }

    public function setPopulation(?int $population): self
    {
        $this->population = $population;
        return $this;
    }

    public function getChef(): ?string
    {
        return $this->chef;
    }

    public function setChef(?string $chef): self
    {
        $this->chef = $chef;
        return $this;
    }

    public function getZone(): ?string
    {
        return $this->zone;
    }

    public function setZone(?string $zone): self
    {
        $this->zone = $zone;
        return $this;
    }
    public function __toString(): string
{
    return $this->getNom() ?? 'Communaute sans nom';
}
}