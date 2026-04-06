<?php

namespace App\Repository;

use App\Entity\Affectation;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<Affectation>
 */
class AffectationRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Affectation::class);
    }

    /**
     * 1. Trouve toutes les affectations d'un projet
     */
    public function findByProject(int $projectId): array
    {
        return $this->createQueryBuilder('a')
            ->where('a.project = :projectId')
            ->setParameter('projectId', $projectId)
            ->orderBy('a.dateAffectation', 'DESC')
            ->getQuery()
            ->getResult();
    }

    /**
     * 2. Trouve toutes les affectations d'un bénéficiaire
     */
    public function findByBeneficiaire(int $beneficiaireId): array
    {
        return $this->createQueryBuilder('a')
            ->where('a.beneficiaire = :beneficiaireId')
            ->setParameter('beneficiaireId', $beneficiaireId)
            ->orderBy('a.dateAffectation', 'DESC')
            ->getQuery()
            ->getResult();
    }

    /**
     * 3. Trouve les affectations par type d'appui (ex: médical, scolaire)
     */
    public function findByTypeAppui(string $typeAppui): array
    {
        return $this->createQueryBuilder('a')
            ->where('a.typeAppui = :typeAppui')
            ->setParameter('typeAppui', $typeAppui)
            ->orderBy('a.dateAffectation', 'DESC')
            ->getQuery()
            ->getResult();
    }

    /**
     * 4. Compte le nombre de bénéficiaires distincts pour un projet
     */
    public function countDistinctBeneficiairesByProject(int $projectId): int
    {
        return $this->createQueryBuilder('a')
            ->select('COUNT(DISTINCT a.beneficiaire)')
            ->where('a.project = :projectId')
            ->getQuery()
            ->getSingleScalarResult();
    }

    /**
     * 5. Récupère les affectations sur une période
     */
    public function findByDateRange(\DateTimeInterface $start, \DateTimeInterface $end): array
    {
        return $this->createQueryBuilder('a')
            ->where('a.dateAffectation BETWEEN :start AND :end')
            ->setParameter('start', $start)
            ->setParameter('end', $end)
            ->orderBy('a.dateAffectation', 'DESC')
            ->getQuery()
            ->getResult();
    }

    /**
     * 6. Récupère les affectations d'un type de bénéficiaire (via le discriminator)
     */
    public function findByBeneficiaireType(string $beneficiaireType): array
    {
        return $this->createQueryBuilder('a')
            ->innerJoin('a.beneficiaire', 'b')
            ->where('b.type = :type')
            ->setParameter('type', $beneficiaireType)
            ->orderBy('a.dateAffectation', 'DESC')
            ->getQuery()
            ->getResult();
    }

    /**
     * 7. Récupère les dernières affectations (limite)
     */
    public function findLatestAffectations(int $limit = 10): array
    {
        return $this->createQueryBuilder('a')
            ->orderBy('a.dateAffectation', 'DESC')
            ->setMaxResults($limit)
            ->getQuery()
            ->getResult();
    }
}