<?php

namespace App\Entity;

use App\Repository\ProjectRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\DBAL\Types\Types;
use Doctrine\ORM\Mapping as ORM;
use Symfony\Component\HttpFoundation\File\File;
use Vich\UploaderBundle\Mapping\Annotation as Vich;

#[ORM\Entity(repositoryClass: ProjectRepository::class)]
#[Vich\Uploadable]
class Project
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 150)]
    private ?string $title = null;

    #[ORM\Column(length: 190, unique: true)]
    private ?string $slug = null;

    #[ORM\Column(type: Types::TEXT)]
    private ?string $description = null;

    #[ORM\Column(type: Types::TEXT, nullable: true)]
    private ?string $objectives = null;

    #[ORM\Column(type: Types::TEXT, nullable: true)]
    private ?string $results = null;

    // #[ORM\Column(length: 255, nullable: true)]
    // private ?string $partners = null;

    #[ORM\Column(length: 20)]
    private ?string $status = 'ongoing';

    #[ORM\Column(type: Types::DATETIME_IMMUTABLE, nullable: true)]
    private ?\DateTimeInterface $startDate = null;

    #[ORM\Column(type: Types::DATETIME_IMMUTABLE, nullable: true)]
    private ?\DateTimeInterface $endDate = null;

    #[ORM\Column(length: 255, nullable: true)]
    private ?string $imageFilename = null;

    #[Vich\UploadableField(mapping: 'project_image', fileNameProperty: 'imageFilename')]
    private ?File $imageFile = null;

    #[ORM\Column(type: Types::DATETIME_IMMUTABLE)]
    private ?\DateTimeInterface $createdAt = null;

    #[ORM\Column(type: Types::DATETIME_IMMUTABLE, nullable: true)]
    private ?\DateTimeInterface $updatedAt = null;

    #[ORM\Column(length: 100)]
    private ?string $country = null;

    #[ORM\Column(length: 100)]
    private ?string $province = null;

    // #[ORM\Column(length: 150)]
    // private ?string $financedBy = null;

    #[ORM\Column(length: 150)]
    private ?string $secteur = null;

    #[ORM\Column(length: 150)]
    private ?string $secteurEN = null;

    #[ORM\Column(length: 150)]
    private ?string $budget = null;

    #[ORM\Column(length: 150)]
    private ?string $code = null;

    #[ORM\Column(length: 150)]
    private ?string $abbreviatedName = null;

    #[ORM\Column(length: 150, nullable: true)]
    private ?string $abbreviatedNameEn = null;

    #[ORM\Column(length: 150, nullable: true)]
    private ?string $titleEN = null;

    #[ORM\Column(type: Types::TEXT, nullable: true)]
    private ?string $descriptionEN = null;

    #[ORM\Column(type: Types::TEXT, nullable: true)]
    private ?string $objectivesEN = null;

    #[ORM\Column(type: Types::TEXT, nullable: true)]
    private ?string $resultsEN = null;

    #[ORM\OneToMany(targetEntity: Article::class, mappedBy: 'project', cascade: ['persist', 'remove'])]
    private Collection $articles;

    #[ORM\OneToMany(targetEntity: Affectation::class, mappedBy: 'project', cascade: ['persist', 'remove'])]
    private Collection $affectations;

    #[ORM\OneToMany(targetEntity: Appui::class, mappedBy: 'project', cascade: ['persist', 'remove'])]
    private Collection $appuis;


    private $articleCount = 0;
    private $appuiCount = 0;
    private $affectationCount = 0;
    private $structureNames = [];

    public function __construct()
    {
        $this->createdAt = new \DateTimeImmutable();
        $this->articles = new ArrayCollection();
        $this->affectations = new ArrayCollection();
        $this->appuis = new ArrayCollection();
    }

    // --- Getters & Setters ---

    public function getId(): ?int { return $this->id; }

    public function getTitle(): ?string { return $this->title; }
    public function setTitle(string $title): self { $this->title = $title; return $this; }

    public function getSlug(): ?string { return $this->slug; }
    public function setSlug(string $slug): self { $this->slug = $slug; return $this; }

    public function getDescription(): ?string { return $this->description; }
    public function setDescription(string $description): self { $this->description = $description; return $this; }

    public function getObjectives(): ?string { return $this->objectives; }
    public function setObjectives(?string $objectives): self { $this->objectives = $objectives; return $this; }

    public function getResults(): ?string { return $this->results; }
    public function setResults(?string $results): self { $this->results = $results; return $this; }

    // public function getPartners(): ?string { return $this->partners; }
    // public function setPartners(?string $partners): self { $this->partners = $partners; return $this; }

    public function getStatus(): ?string { return $this->status; }
    public function setStatus(string $status): self { $this->status = $status; return $this; }

    public function getStartDate(): ?\DateTimeInterface { return $this->startDate; }
    public function setStartDate(?\DateTimeInterface $startDate): self { $this->startDate = $startDate; return $this; }

    public function getEndDate(): ?\DateTimeInterface { return $this->endDate; }
    public function setEndDate(?\DateTimeInterface $endDate): self { $this->endDate = $endDate; return $this; }

    public function getImageFilename(): ?string { return $this->imageFilename; }
    public function setImageFilename(?string $imageFilename): self { $this->imageFilename = $imageFilename; return $this; }

    public function getImageFile(): ?File { return $this->imageFile; }
    public function setImageFile(?File $imageFile): self
    {
        $this->imageFile = $imageFile;
        if ($imageFile) {
            $this->updatedAt = new \DateTimeImmutable();
        }
        return $this;
    }

    public function getCreatedAt(): ?\DateTimeInterface { return $this->createdAt; }
    public function setCreatedAt(\DateTimeInterface $createdAt): self { $this->createdAt = $createdAt; return $this; }

    public function getUpdatedAt(): ?\DateTimeInterface { return $this->updatedAt; }
    public function setUpdatedAt(?\DateTimeInterface $updatedAt): self { $this->updatedAt = $updatedAt; return $this; }

    public function getCountry(): ?string { return $this->country; }
    public function setCountry(string $country): self { $this->country = $country; return $this; }

    public function getProvince(): ?string { return $this->province; }
    public function setProvince(string $province): self { $this->province = $province; return $this; }

    // public function getFinancedBy(): ?string { return $this->financedBy; }
    // public function setFinancedBy(string $financedBy): self { $this->financedBy = $financedBy; return $this; }

    public function getSecteur(): ?string { return $this->secteur; }
    public function setSecteur(string $secteur): self { $this->secteur = $secteur; return $this; }

    public function getSecteurEN(): ?string { return $this->secteurEN; }
    public function setSecteurEN(string $secteurEN): self { $this->secteurEN = $secteurEN; return $this; }

    public function getBudget(): ?string { return $this->budget; }
    public function setBudget(string $budget): self { $this->budget = $budget; return $this; }

    public function getCode(): ?string { return $this->code; }
    public function setCode(string $code): self { $this->code = $code; return $this; }

    public function getAbbreviatedName(): ?string { return $this->abbreviatedName; }
    public function setAbbreviatedName(string $abbreviatedName): self { $this->abbreviatedName = $abbreviatedName; return $this; }

    public function getAbbreviatedNameEn(): ?string { return $this->abbreviatedNameEn; }
    public function setAbbreviatedNameEn(?string $abbreviatedNameEn): self { $this->abbreviatedNameEn = $abbreviatedNameEn; return $this; }

    public function getTitleEN(): ?string { return $this->titleEN; }
    public function setTitleEN(?string $titleEN): self { $this->titleEN = $titleEN; return $this; }

    public function getDescriptionEN(): ?string { return $this->descriptionEN; }
    public function setDescriptionEN(?string $descriptionEN): self { $this->descriptionEN = $descriptionEN; return $this; }

    public function getObjectivesEN(): ?string { return $this->objectivesEN; }
    public function setObjectivesEN(?string $objectivesEN): self { $this->objectivesEN = $objectivesEN; return $this; }

    public function getResultsEN(): ?string { return $this->resultsEN; }
    public function setResultsEN(?string $resultsEN): self { $this->resultsEN = $resultsEN; return $this; }

    // --- Relations ---

    public function getArticles(): Collection { return $this->articles; }

    public function addArticle(Article $article): self
    {
        if (!$this->articles->contains($article)) {
            $this->articles[] = $article;
            $article->setProject($this);
        }
        return $this;
    }

    public function removeArticle(Article $article): self
    {
        if ($this->articles->removeElement($article)) {
            if ($article->getProject() === $this) {
                $article->setProject(null);
            }
        }
        return $this;
    }

    public function getAffectations(): Collection
    {
        return $this->affectations;
    }

    public function addAffectation(Affectation $affectation): self
    {
        if (!$this->affectations->contains($affectation)) {
            $this->affectations[] = $affectation;
            $affectation->setProject($this);
        }
        return $this;
    }

    public function removeAffectation(Affectation $affectation): self
    {
        if ($this->affectations->removeElement($affectation)) {
            if ($affectation->getProject() === $this) {
                $affectation->setProject(null);
            }
        }
        return $this;
    }

    public function getAppuis(): Collection
    {
        return $this->appuis;
    }

    public function addAppui(Appui $appui): self
    {
        if (!$this->appuis->contains($appui)) {
            $this->appuis[] = $appui;
            $appui->setProject($this);
        }
        return $this;
    }

    public function removeAppui(Appui $appui): self
    {
        if ($this->appuis->removeElement($appui)) {
            if ($appui->getProject() === $this) {
                $appui->setProject(null);
            }
        }
        return $this;
    }

    public function __toString(): string
    {
        return $this->title ?? '';
    }


    public function getArticleCount(): int { return $this->articleCount; }
public function setArticleCount(int $count): self { $this->articleCount = $count; return $this; }

public function getAppuiCount(): int { return $this->appuiCount; }
public function setAppuiCount(int $count): self { $this->appuiCount = $count; return $this; }

public function getAffectationCount(): int { return $this->affectationCount; }
public function setAffectationCount(int $count): self { $this->affectationCount = $count; return $this; }

public function getStructureNames(): array { return $this->structureNames; }
public function setStructureNames(array $names): self { $this->structureNames = $names; return $this; }
}