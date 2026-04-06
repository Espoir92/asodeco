<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;


#[ORM\Entity()]
class Personne extends Beneficiaire
{
    #[ORM\Column(length: 100, nullable: true)]
    private ?string $prenom = null;

    #[ORM\Column(length: 100, nullable: true)]
    private ?string $postNom = null;

    #[ORM\Column(type: 'date', nullable: true)]
    private ?\DateTimeInterface $dateNaissance = null;

    // Getters/setters spécifiques
    public function getPrenom(): ?string { return $this->prenom; }
    public function setPrenom(?string $prenom): self { $this->prenom = $prenom; return $this; }
    public function getDateNaissance(): ?\DateTimeInterface { return $this->dateNaissance; }
    public function setDateNaissance(?\DateTimeInterface $dateNaissance): self { $this->dateNaissance = $dateNaissance; return $this; }


    
    /**
     * Get the value of postNom
     */
    public function getPostNom(): ?string
    {
        return $this->postNom;
    }

    /**
     * Set the value of postNom
     */
    public function setPostNom(?string $postNom): self
    {
        $this->postNom = $postNom;

        return $this;
    }
    public function __toString(): string
{
    return $this->getNom() ?? 'Personne sans nom';
}

}

