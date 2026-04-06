<?php

namespace App\Entity;

use App\Repository\AppuiRepository;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: AppuiRepository::class)]
class Appui
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\ManyToOne(targetEntity: Project::class, inversedBy: 'appuis')]
    #[ORM\JoinColumn(nullable: false)]
    private ?Project $project = null;

    #[ORM\ManyToOne(targetEntity: StructureAccompagnement::class, inversedBy: 'appuis')]
    #[ORM\JoinColumn(nullable: false)]
    private ?StructureAccompagnement $structure = null;

    #[ORM\Column(length: 100, nullable: true)]
    private ?string $natureAppui = null; // financier, matériel, technique

    #[ORM\Column(type: 'decimal', precision: 15, scale: 2, nullable: true)]
    private ?string $montant = null;

    #[ORM\Column(type: 'text', nullable: true)]
    private ?string $description = null;

    #[ORM\Column(type: 'datetime')]
    private ?\DateTimeInterface $dateAppui = null;

    public function __construct()
    {
        $this->dateAppui = new \DateTime();
    }

    // Getters / Setters
    public function getId(): ?int { return $this->id; }
    public function getProject(): ?Project { return $this->project; }
    public function setProject(?Project $project): self { $this->project = $project; return $this; }
    public function getStructure(): ?StructureAccompagnement { return $this->structure; }
    public function setStructure(?StructureAccompagnement $structure): self { $this->structure = $structure; return $this; }
    public function getNatureAppui(): ?string { return $this->natureAppui; }
    public function setNatureAppui(?string $natureAppui): self { $this->natureAppui = $natureAppui; return $this; }
    public function getMontant(): ?string { return $this->montant; }
    public function setMontant(?string $montant): self { $this->montant = $montant; return $this; }
    public function getDescription(): ?string { return $this->description; }
    public function setDescription(?string $description): self { $this->description = $description; return $this; }
    public function getDateAppui(): ?\DateTimeInterface { return $this->dateAppui; }
    public function setDateAppui(\DateTimeInterface $dateAppui): self { $this->dateAppui = $dateAppui; return $this; }
}