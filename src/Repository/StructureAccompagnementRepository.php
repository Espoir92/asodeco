<?php

namespace App\Repository;

use App\Entity\Appui;
use App\Entity\StructureAccompagnement;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<StructureAccompagnement>
 */
class StructureAccompagnementRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, StructureAccompagnement::class);
    }

    /**
     * 1. Retourne toutes les structures triées par nom
     */
    public function findAllOrderedByName(): array
    {
        return $this->createQueryBuilder('s')
            ->orderBy('s.nom', 'ASC')
            ->getQuery()
            ->getResult();
    }

    /**
     * 2. Retourne les structures d'un type donné (bailleur, partenaire technique, etc.)
     */
    public function findByType(string $type): array
    {
        return $this->createQueryBuilder('s')
            ->andWhere('s.type = :type')
            ->setParameter('type', $type)
            ->orderBy('s.nom', 'ASC')
            ->getQuery()
            ->getResult();
    }

    /**
     * 3. Recherche une structure par une chaîne (nom partiel)
     */
    public function searchByName(string $searchTerm): array
    {
        return $this->createQueryBuilder('s')
            ->where('s.nom LIKE :search')
            ->setParameter('search', '%' . $searchTerm . '%')
            ->getQuery()
            ->getResult();
    }

    /**
     * 4. Compte le nombre de structures par type
     */
    public function countByType(): array
    {
        $results = $this->createQueryBuilder('s')
            ->select('s.type, COUNT(s.id) as count')
            ->groupBy('s.type')
            ->getQuery()
            ->getResult();

        $counts = [];
        foreach ($results as $row) {
            $counts[$row['type']] = $row['count'];
        }
        return $counts;
    }

    /**
     * 5. Retourne les structures avec leurs appuis (jointure)
     */
    public function findWithAppuis(): array
    {
        return $this->createQueryBuilder('s')
            ->leftJoin('s.appuis', 'a')
            ->addSelect('a')
            ->getQuery()
            ->getResult();
    }

    /**
     * 6. Retourne les structures ayant soutenu un projet spécifique
     */
    public function findByProject(int $projectId): array
    {
        return $this->createQueryBuilder('s')
            ->innerJoin('s.appuis', 'a')
            ->where('a.project = :projectId')
            ->setParameter('projectId', $projectId)
            ->orderBy('s.nom', 'ASC')
            ->getQuery()
            ->getResult();
    }

    /**
     * 7. Retourne les structures ayant le plus de financements (montant total)
     */
    public function findTopStructuresByFunding(int $limit = 5): array
    {
        return $this->createQueryBuilder('s')
            ->select('s.id, s.nom, SUM(a.montant) as totalFunding')
            ->innerJoin('s.appuis', 'a')
            ->where('a.montant IS NOT NULL')
            ->groupBy('s.id')
            ->orderBy('totalFunding', 'DESC')
            ->setMaxResults($limit)
            ->getQuery()
            ->getResult();
    }
    /**
 * Compte le nombre de structures ayant eu un appui entre deux dates
 */
public function countByDateRange(\DateTime $start, \DateTime $end): int
{
    $qb = $this->getEntityManager()->createQueryBuilder();
    return $qb->select('COUNT(DISTINCT s.id)')
        ->from('App\Entity\StructureAccompagnement', 's')
        ->innerJoin(Appui::class, 'a', 'WITH', 'a.structure = s.id')
        ->where('a.dateAppui BETWEEN :start AND :end')
        ->setParameter('start', $start)
        ->setParameter('end', $end)
        ->getQuery()
        ->getSingleScalarResult();
}

/**
 * Récupère les structures ayant eu un appui entre deux dates
 */
public function findByDateRange(\DateTime $start, \DateTime $end, array $orderBy = [], int $limit = null): array
{
    $qb = $this->createQueryBuilder('s')
        ->innerJoin('s.appuis', 'a')
        ->where('a.dateAppui BETWEEN :start AND :end')
        ->setParameter('start', $start)
        ->setParameter('end', $end)
        ->groupBy('s.id');
    
    if (!empty($orderBy)) {
        foreach ($orderBy as $field => $direction) {
            $qb->orderBy('s.' . $field, $direction);
        }
    }
    
    if ($limit) {
        $qb->setMaxResults($limit);
    }
    
    return $qb->getQuery()->getResult();
}
}