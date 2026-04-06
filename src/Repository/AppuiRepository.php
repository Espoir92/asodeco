<?php

namespace App\Repository;

use App\Entity\Appui;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<Appui>
 */
class AppuiRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Appui::class);
    }

    /**
     * 1. Trouve tous les appuis d'un projet
     */
    public function findByProject(int $projectId): array
    {
        return $this->createQueryBuilder('a')
            ->where('a.project = :projectId')
            ->setParameter('projectId', $projectId)
            ->orderBy('a.dateAppui', 'DESC')
            ->getQuery()
            ->getResult();
    }

    /**
     * 2. Trouve tous les appuis d'une structure
     */
    public function findByStructure(int $structureId): array
    {
        return $this->createQueryBuilder('a')
            ->where('a.structure = :structureId')
            ->setParameter('structureId', $structureId)
            ->orderBy('a.dateAppui', 'DESC')
            ->getQuery()
            ->getResult();
    }

    /**
     * 3. Calcule le montant total des appuis pour un projet
     */
    public function sumMontantByProject(int $projectId): float
    {
        $result = $this->createQueryBuilder('a')
            ->select('SUM(a.montant)')
            ->where('a.project = :projectId')
            ->setParameter('projectId', $projectId)
            ->getQuery()
            ->getSingleScalarResult();
        return (float) $result;
    }

    /**
     * 4. Calcule le montant total des appuis pour une structure
     */
    public function sumMontantByStructure(int $structureId): float
    {
        $result = $this->createQueryBuilder('a')
            ->select('SUM(a.montant)')
            ->where('a.structure = :structureId')
            ->setParameter('structureId', $structureId)
            ->getQuery()
            ->getSingleScalarResult();
        return (float) $result;
    }

    /**
     * 5. Récupère les appuis sur une période donnée
     */
    public function findByDateRange(\DateTimeInterface $start, \DateTimeInterface $end): array
    {
        return $this->createQueryBuilder('a')
            ->where('a.dateAppui BETWEEN :start AND :end')
            ->setParameter('start', $start)
            ->setParameter('end', $end)
            ->orderBy('a.dateAppui', 'DESC')
            ->getQuery()
            ->getResult();
    }

    /**
     * 6. Compte les appuis par nature (financier, matériel, technique)
     */
    public function countByNature(): array
    {
        $results = $this->createQueryBuilder('a')
            ->select('a.natureAppui, COUNT(a.id) as count')
            ->groupBy('a.natureAppui')
            ->getQuery()
            ->getResult();

        $counts = [];
        foreach ($results as $row) {
            $counts[$row['natureAppui']] = $row['count'];
        }
        return $counts;
    }

    /**
     * 7. Récupère les appuis récents (limite)
     */
    public function findRecentAppuis(int $limit = 10): array
    {
        return $this->createQueryBuilder('a')
            ->orderBy('a.dateAppui', 'DESC')
            ->setMaxResults($limit)
            ->getQuery()
            ->getResult();
    }

    public function sumAllMontants(): float
{
    return $this->createQueryBuilder('a')
        ->select('SUM(a.montant)')
        ->getQuery()
        ->getSingleScalarResult() ?? 0.0;
}

/**
 * Compte le nombre d'appuis entre deux dates
 */
public function countByDateRange(\DateTime $start, \DateTime $end): int
{
    return $this->createQueryBuilder('a')
        ->select('COUNT(a.id)')
        ->where('a.dateAppui BETWEEN :start AND :end')
        ->setParameter('start', $start)
        ->setParameter('end', $end)
        ->getQuery()
        ->getSingleScalarResult();
}

/**
 * Calcule le montant total des appuis entre deux dates
 */
public function sumMontantsByDateRange(\DateTime $start, \DateTime $end): float
{
    $result = $this->createQueryBuilder('a')
        ->select('SUM(a.montant)')
        ->where('a.dateAppui BETWEEN :start AND :end')
        ->setParameter('start', $start)
        ->setParameter('end', $end)
        ->getQuery()
        ->getSingleScalarResult();
    
    return $result ?? 0.0;
}
}