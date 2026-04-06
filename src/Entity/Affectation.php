<?php

namespace App\Entity;

use App\Repository\AffectationRepository;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: AffectationRepository::class)]
class Affectation
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\ManyToOne(targetEntity: Project::class, inversedBy: 'affectations')]
    #[ORM\JoinColumn(nullable: false)]
    private ?Project $project = null;

    #[ORM\ManyToOne(targetEntity: Beneficiaire::class, inversedBy: 'affectations')]
    #[ORM\JoinColumn(nullable: false)]
    private ?Beneficiaire $beneficiaire = null;

    #[ORM\Column(type: 'datetime')]
    private ?\DateTimeInterface $dateAffectation = null;

    #[ORM\Column(length: 100, nullable: true)]
    private ?string $typeAppui = null; // ex: "médical", "scolaire", "nutrition"

    #[ORM\Column(length: 255, nullable: true)]
    private ?string $commentaire = null;

    public function __construct()
    {
        $this->dateAffectation = new \DateTime();
    }

    // Getters/setters
    public function getId(): ?int { return $this->id; }
    public function getProject(): ?Project { return $this->project; }
    public function setProject(?Project $project): self { $this->project = $project; return $this; }
    public function getBeneficiaire(): ?Beneficiaire { return $this->beneficiaire; }
    public function setBeneficiaire(?Beneficiaire $beneficiaire): self { $this->beneficiaire = $beneficiaire; return $this; }
    public function getDateAffectation(): ?\DateTimeInterface { return $this->dateAffectation; }
    public function setDateAffectation(\DateTimeInterface $dateAffectation): self { $this->dateAffectation = $dateAffectation; return $this; }
    public function getTypeAppui(): ?string { return $this->typeAppui; }
    public function setTypeAppui(?string $typeAppui): self { $this->typeAppui = $typeAppui; return $this; }
    public function getCommentaire(): ?string { return $this->commentaire; }
    public function setCommentaire(?string $commentaire): self { $this->commentaire = $commentaire; return $this; }
}