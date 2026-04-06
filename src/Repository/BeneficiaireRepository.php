<?php

namespace App\Repository;

use App\Entity\Affectation;
use App\Entity\Beneficiaire;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<Beneficiaire>
 */
class BeneficiaireRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Beneficiaire::class);
    }

    /**
     * 1. Trouve les bénéficiaires par type (personne, école, etc.)
     */
    public function findByType(string $type): array
    {
        return $this->createQueryBuilder('b')
            ->andWhere('b.type = :type')
            ->setParameter('type', $type)
            ->orderBy('b.nom', 'ASC')
            ->getQuery()
            ->getResult();
    }

    /**
     * 2. Compte le nombre de bénéficiaires par type
     */
    public function countByType(): array
    {
        $results = $this->createQueryBuilder('b')
            ->select('b.type, COUNT(b.id) as count')
            ->groupBy('b.type')
            ->getQuery()
            ->getResult();

        $counts = [];
        foreach ($results as $row) {
            $counts[$row['type']] = $row['count'];
        }
        return $counts;
    }

    /**
     * 3. Recherche des bénéficiaires par nom (partiel)
     */
    public function searchByNom(string $searchTerm): array
    {
        return $this->createQueryBuilder('b')
            ->where('b.nom LIKE :search')
            ->setParameter('search', '%' . $searchTerm . '%')
            ->orderBy('b.nom', 'ASC')
            ->getQuery()
            ->getResult();
    }

    /**
     * 4. Récupère les bénéficiaires d'une localisation donnée
     */
    public function findByLocalisation(string $localisation): array
    {
        return $this->createQueryBuilder('b')
            ->where('b.localisation LIKE :localisation')
            ->setParameter('localisation', '%' . $localisation . '%')
            ->getQuery()
            ->getResult();
    }

    /**
     * 5. Récupère les bénéficiaires affectés à un projet
     */
    public function findAffectedToProject(int $projectId): array
    {
        return $this->createQueryBuilder('b')
            ->innerJoin('b.affectations', 'a')
            ->where('a.project = :projectId')
            ->setParameter('projectId', $projectId)
            ->orderBy('b.nom', 'ASC')
            ->getQuery()
            ->getResult();
    }

    /**
     * 6. Compte le nombre de bénéficiaires distincts pour un projet
     */
    public function countAffectedToProject(int $projectId): int
    {
        return $this->createQueryBuilder('b')
            ->select('COUNT(DISTINCT b.id)')
            ->innerJoin('b.affectations', 'a')
            ->where('a.project = :projectId')
            ->getQuery()
            ->getSingleScalarResult();
    }

    /**
     * 7. Récupère les bénéficiaires créés récemment
     */
    public function findRecentBeneficiaires(int $limit = 10): array
    {
        // Suppose que vous avez un champ createdAt dans Beneficiaire
        return $this->createQueryBuilder('b')
            ->orderBy('b.createdAt', 'DESC')
            ->setMaxResults($limit)
            ->getQuery()
            ->getResult();
    }

//     /**
//  * Compte le nombre de bénéficiaires affectés entre deux dates
//  */
// public function countAffectedByDateRange(\DateTime $start, \DateTime $end): int
// {
//     $qb = $this->getEntityManager()->createQueryBuilder();
//     return $qb->select('COUNT(DISTINCT b.id)')
//         ->from('App\Entity\Beneficiaire', 'b')
//         ->innerJoin(Affectation::class, 'a', 'WITH', 'a.beneficiaire = b.id')
//         ->where('a.dateAffectation BETWEEN :start AND :end')
//         ->setParameter('start', $start)
//         ->setParameter('end', $end)
//         ->getQuery()
//         ->getSingleScalarResult();
// }

/**
 * Compte le nombre de bénéficiaires affectés entre deux dates
 */
public function countAffectedByDateRange(\DateTime $start, \DateTime $end): int
{
    $qb = $this->getEntityManager()->createQueryBuilder();
    return $qb->select('COUNT(DISTINCT b.id)')
        ->from('App\Entity\Beneficiaire', 'b')
        ->innerJoin(Affectation::class, 'a', 'WITH', 'a.beneficiaire = b.id')
        ->where('a.dateAffectation BETWEEN :start AND :end')
        ->setParameter('start', $start)
        ->setParameter('end', $end)
        ->getQuery()
        ->getSingleScalarResult();
}
}