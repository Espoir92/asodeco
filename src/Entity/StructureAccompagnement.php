<?php

namespace App\Entity;

use App\Repository\StructureAccompagnementRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: StructureAccompagnementRepository::class)]
class StructureAccompagnement
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 255)]
    private ?string $nom = null;

    #[ORM\Column(length: 100, nullable: true)]
    private ?string $type = null; // bailleur, partenaire technique, etc.

    #[ORM\Column(length: 255, nullable: true)]
    private ?string $siteWeb = null;

    #[ORM\Column(length: 255)]
    private ?string $logo = null; // stocke le nom du fichier

    #[ORM\OneToMany(targetEntity: Appui::class, mappedBy: 'structure', cascade: ['persist', 'remove'])]
    private Collection $appuis;

    public function __construct()
    {
        $this->appuis = new ArrayCollection();
    }

    public function getId(): ?int { return $this->id; }
    public function getNom(): ?string { return $this->nom; }
    public function setNom(string $nom): self { $this->nom = $nom; return $this; }
    public function getType(): ?string { return $this->type; }
    public function setType(?string $type): self { $this->type = $type; return $this; }
    public function getSiteWeb(): ?string { return $this->siteWeb; }
    public function setSiteWeb(?string $siteWeb): self { $this->siteWeb = $siteWeb; return $this; }
    public function getLogo(): ?string { return $this->logo; }
    public function setLogo(?string $logo): self { $this->logo = $logo; return $this; }

    public function getAppuis(): Collection { return $this->appuis; }

    // Méthodes pour gérer la collection d'appuis (relation bidirectionnelle)
    public function addAppui(Appui $appui): self
    {
        if (!$this->appuis->contains($appui)) {
            $this->appuis[] = $appui;
            $appui->setStructure($this);  // important : setStructure, pas setProject
        }
        return $this;
    }

    public function removeAppui(Appui $appui): self
    {
        if ($this->appuis->removeElement($appui)) {
            if ($appui->getStructure() === $this) {
                $appui->setStructure(null);
            }
        }
        return $this;
    }
}