<?php

namespace App\Controller;

use App\Entity\Project;
use App\Repository\ProjectRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Bridge\Doctrine\Attribute\MapEntity;

class ProjectController extends AbstractController
{
    #[Route('/projets', name: 'app_projects')]
    public function index(ProjectRepository $repo): Response
    {
        // return $this->render('project/index.html.twig', [
        //     'projects' => $repo->findBy([], ['createdAt' => 'DESC']),
        // ]);
            
    $projects = $repo->findProjectsWithDetails(); // au lieu de findAll()

        return $this->render('project/index.html.twig', [
        'projects' => $projects,
    ]);
    }

    // La route de recherche DOIT être avant la route {slug}
    #[Route('/projets/search', name: 'app_projects_search')]
    public function search(Request $request, ProjectRepository $projectRepository): JsonResponse
    {
        $query = $request->query->get('q', '');

        if (strlen($query) < 2) {
            return $this->json([]);
        }

        $projects = $projectRepository->findBySearchTerm($query);

        $data = [];
        foreach ($projects as $project) {
            $data[] = [
                'id' => $project->getId(),
                'slug' => $project->getSlug(),
                'title' => $project->getTitle(),
                'titleEN' => $project->getTitleEN(),
            ];
        }

        return $this->json($data);
    }

    #[Route('/projets/{slug}', name: 'app_project_show')]
    public function show(
        #[MapEntity(mapping: ['slug' => 'slug'])] Project $project
    ): Response {
        return $this->render('project/show.html.twig', [
            'project' => $project,
        ]);
    }

    #[Route('/en/projects', name: 'app_projects_en')]
    public function indexEn(ProjectRepository $repo): Response
    {
        $projects = $repo->findProjectsWithDetails();
        return $this->render('project/index.html.twig', [
            'projects' => $repo->findProjectsWithDetails([], ['createdAt' => 'DESC']),
        ]);
    }

    #[Route('/en/projects/{slug}', name: 'app_project_show_en')]
    public function showEn(
        #[MapEntity(mapping: ['slug' => 'slug'])] Project $project
    ): Response {
        return $this->render('project/show.html.twig', [
            'project' => $project,
        ]);
    }
}