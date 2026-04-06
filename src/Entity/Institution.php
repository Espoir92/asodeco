<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;


#[ORM\Entity()]
class Institution extends Beneficiaire
{
    #[ORM\Column(length: 100, nullable: true)]
    private ?string $typeInstitution = null; // gouvernementale, privée, ONG, etc.

    #[ORM\Column(length: 255, nullable: true)]
    private ?string $responsable = null;

    #[ORM\Column(length: 255, nullable: true)]
    private ?string $domaineActivite = null;

    public function getTypeInstitution(): ?string
    {
        return $this->typeInstitution;
    }

    public function setTypeInstitution(?string $typeInstitution): self
    {
        $this->typeInstitution = $typeInstitution;
        return $this;
    }

    public function getResponsable(): ?string
    {
        return $this->responsable;
    }

    public function setResponsable(?string $responsable): self
    {
        $this->responsable = $responsable;
        return $this;
    }

    public function getDomaineActivite(): ?string
    {
        return $this->domaineActivite;
    }

    public function setDomaineActivite(?string $domaineActivite): self
    {
        $this->domaineActivite = $domaineActivite;
        return $this;
    }
    public function __toString(): string
{
    return $this->getNom() ?? 'Institution sans nom';
}
}