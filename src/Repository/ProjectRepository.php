<?php

namespace App\Repository;

use App\Entity\Affectation;
use App\Entity\Appui;
use App\Entity\Article;
use App\Entity\Project;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<Project>
 */
class ProjectRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Project::class);
    }

    /**
     * Recherche des projets par terme dans plusieurs champs (français et anglais)
     */
    public function findBySearchTerm(string $term): array
    {
        $qb = $this->createQueryBuilder('p')
            ->where('p.title LIKE :term')
            ->orWhere('p.titleEN LIKE :term')
            ->orWhere('p.description LIKE :term')
            ->orWhere('p.descriptionEN LIKE :term')
            ->orWhere('p.objectives LIKE :term')
            ->orWhere('p.objectivesEN LIKE :term')
            ->orWhere('p.results LIKE :term')
            ->orWhere('p.resultsEN LIKE :term')
            ->orWhere('p.partners LIKE :term')
            ->orWhere('p.country LIKE :term')
            ->orWhere('p.province LIKE :term')
            ->orWhere('p.secteur LIKE :term')
            ->orWhere('p.secteurEN LIKE :term')
            ->setParameter('term', '%' . $term . '%')
            ->orderBy('p.title', 'ASC')
            ->setMaxResults(10);

        return $qb->getQuery()->getResult();
    }


    public function findProjectsWithDetails(): array
{
    $projects = $this->findAll();

    if (empty($projects)) {
        return [];
    }

    $ids = array_map(fn($p) => $p->getId(), $projects);

    // Compter les articles
    $articleCounts = $this->getEntityManager()->createQueryBuilder()
        ->select('IDENTITY(a.project) as project_id, COUNT(a.id) as cnt')
        ->from(Article::class, 'a')
        ->where('a.project IN (:ids)')
        ->setParameter('ids', $ids)
        ->groupBy('a.project')
        ->getQuery()
        ->getResult();
    $articleMap = [];
    foreach ($articleCounts as $row) {
        $articleMap[$row['project_id']] = $row['cnt'];
    }

    // Compter les appuis
    $appuiCounts = $this->getEntityManager()->createQueryBuilder()
        ->select('IDENTITY(a.project) as project_id, COUNT(a.id) as cnt')
        ->from(Appui::class, 'a')
        ->where('a.project IN (:ids)')
        ->setParameter('ids', $ids)
        ->groupBy('a.project')
        ->getQuery()
        ->getResult();
    $appuiMap = [];
    foreach ($appuiCounts as $row) {
        $appuiMap[$row['project_id']] = $row['cnt'];
    }

    // Compter les affectations (bénéficiaires)
    $affectCounts = $this->getEntityManager()->createQueryBuilder()
        ->select('IDENTITY(a.project) as project_id, COUNT(a.id) as cnt')
        ->from(Affectation::class, 'a')
        ->where('a.project IN (:ids)')
        ->setParameter('ids', $ids)
        ->groupBy('a.project')
        ->getQuery()
        ->getResult();
    $affectMap = [];
    foreach ($affectCounts as $row) {
        $affectMap[$row['project_id']] = $row['cnt'];
    }

    // Récupérer les noms des structures (distinctes) par projet
    $structures = $this->getEntityManager()->createQueryBuilder()
        ->select('IDENTITY(a.project) as project_id, s.nom as structure_name')
        ->from(Appui::class, 'a')
        ->join('a.structure', 's')
        ->where('a.project IN (:ids)')
        ->setParameter('ids', $ids)
        ->getQuery()
        ->getResult();
    $structureMap = [];
    foreach ($structures as $row) {
        $pid = $row['project_id'];
        if (!isset($structureMap[$pid])) {
            $structureMap[$pid] = [];
        }
        $structureMap[$pid][] = $row['structure_name'];
    }

    // Remplir les propriétés temporaires de chaque projet
    foreach ($projects as $project) {
        $id = $project->getId();
        $project->setArticleCount($articleMap[$id] ?? 0);
        $project->setAppuiCount($appuiMap[$id] ?? 0);
        $project->setAffectationCount($affectMap[$id] ?? 0);
        $project->setStructureNames(array_unique($structureMap[$id] ?? []));
    }

    return $projects;
}

    /**
     * Récupère les projets avec des informations détaillées :
     * - nombre d'articles liés
     * - nombre d'appuis
     * - nombre d'affectations (bénéficiaires)
     * - liste des noms des structures d'accompagnement
     *
     * @param array $criteria  Exemple : ['status' => 'ongoing']
     * @param int|null $limit  Limite le nombre de projets retournés
     * @return Project[]
     */
    public function findProjectsWithDetails2(array $criteria = [], ?int $limit = null): array
    {
        $qb = $this->createQueryBuilder('p');
        if (isset($criteria['status'])) {
            $qb->andWhere('p.status = :status')->setParameter('status', $criteria['status']);
        }
        if ($limit !== null) {
            $qb->setMaxResults($limit);
        }
        $projects = $qb->getQuery()->getResult();

        if (empty($projects)) {
            return [];
        }

        $ids = array_map(fn($p) => $p->getId(), $projects);

        // --- Compter les articles ---
        $articleCounts = $this->getEntityManager()->createQueryBuilder()
            ->select('IDENTITY(a.project) as project_id, COUNT(a.id) as cnt')
            ->from(Article::class, 'a')
            ->where('a.project IN (:ids)')
            ->setParameter('ids', $ids)
            ->groupBy('a.project')
            ->getQuery()
            ->getResult();

        $articleMap = [];
        foreach ($articleCounts as $row) {
            $articleMap[$row['project_id']] = $row['cnt'];
        }

        // --- Compter les appuis ---
        $appuiCounts = $this->getEntityManager()->createQueryBuilder()
            ->select('IDENTITY(a.project) as project_id, COUNT(a.id) as cnt')
            ->from(Appui::class, 'a')
            ->where('a.project IN (:ids)')
            ->setParameter('ids', $ids)
            ->groupBy('a.project')
            ->getQuery()
            ->getResult();

        $appuiMap = [];
        foreach ($appuiCounts as $row) {
            $appuiMap[$row['project_id']] = $row['cnt'];
        }

        // --- Compter les affectations (bénéficiaires) ---
        $affectCounts = $this->getEntityManager()->createQueryBuilder()
            ->select('IDENTITY(a.project) as project_id, COUNT(a.id) as cnt')
            ->from(Affectation::class, 'a')
            ->where('a.project IN (:ids)')
            ->setParameter('ids', $ids)
            ->groupBy('a.project')
            ->getQuery()
            ->getResult();

        $affectMap = [];
        foreach ($affectCounts as $row) {
            $affectMap[$row['project_id']] = $row['cnt'];
        }

        // --- Récupérer les noms des structures (distinctes) par projet ---
        $structures = $this->getEntityManager()->createQueryBuilder()
            ->select('IDENTITY(a.project) as project_id, s.nom as structure_name')
            ->from(Appui::class, 'a')
            ->join('a.structure', 's')
            ->where('a.project IN (:ids)')
            ->setParameter('ids', $ids)
            ->getQuery()
            ->getResult();

        $structureMap = [];
        foreach ($structures as $row) {
            $pid = $row['project_id'];
            if (!isset($structureMap[$pid])) {
                $structureMap[$pid] = [];
            }
            $structureMap[$pid][] = $row['structure_name'];
        }

        // --- Remplir les propriétés temporaires des projets ---
        foreach ($projects as $project) {
            $id = $project->getId();
            $project->setArticleCount($articleMap[$id] ?? 0);
            $project->setAppuiCount($appuiMap[$id] ?? 0);
            $project->setAffectationCount($affectMap[$id] ?? 0);
            $project->setStructureNames(array_unique($structureMap[$id] ?? []));
        }

        return $projects;
    }

    public function countCompletedProjects(): int
{
    return $this->createQueryBuilder('p')
        ->select('COUNT(p.id)')
        ->where('p.status = :status')
        ->setParameter('status', 'completed')
        ->getQuery()
        ->getSingleScalarResult();
}

/**
 * Compte le nombre de projets terminés (status = 'completed')
 */
public function countCompletedProjects2(): int
{
    return $this->createQueryBuilder('p')
        ->select('COUNT(p.id)')
        ->where('p.status = :status')
        ->setParameter('status', 'completed')
        ->getQuery()
        ->getSingleScalarResult();
}
/**
 * Récupère les projets créés entre deux dates
 */
public function findByDateRange2(\DateTime $start, \DateTime $end): array
{
    return $this->createQueryBuilder('p')
        ->where('p.createdAt BETWEEN :start AND :end')
        ->setParameter('start', $start)
        ->setParameter('end', $end)
        ->orderBy('p.createdAt', 'DESC')
        ->getQuery()
        ->getResult();
}

/**
 * Récupère les projets terminés entre deux dates
 */
public function findCompletedByDateRange2(\DateTime $start, \DateTime $end): array
{
    return $this->createQueryBuilder('p')
        ->where('p.status = :status')
        ->andWhere('p.endDate BETWEEN :start AND :end')
        ->setParameter('status', 'completed')
        ->setParameter('start', $start)
        ->setParameter('end', $end)
        ->orderBy('p.endDate', 'DESC')
        ->getQuery()
        ->getResult();
}

/**
 * Récupère les projets créés entre deux dates (utilise created_at)
 */
public function findByDateRange(\DateTime $start, \DateTime $end): array
{
    return $this->createQueryBuilder('p')
        ->where('p.createdAt BETWEEN :start AND :end')
        ->setParameter('start', $start)
        ->setParameter('end', $end)
        ->orderBy('p.createdAt', 'DESC')
        ->getQuery()
        ->getResult();
}

/**
 * Récupère les projets terminés entre deux dates (utilise end_date)
 */
public function findCompletedByDateRange(\DateTime $start, \DateTime $end): array
{
    return $this->createQueryBuilder('p')
        ->where('p.status = :status')
        ->andWhere('p.endDate BETWEEN :start AND :end')
        ->setParameter('status', 'completed')
        ->setParameter('start', $start)
        ->setParameter('end', $end)
        ->orderBy('p.endDate', 'DESC')
        ->getQuery()
        ->getResult();
}
}