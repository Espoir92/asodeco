<?php

namespace App\Controller;

use App\Repository\ProjectRepository;
use App\Repository\ArticleRepository;
use App\Repository\DomainRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
// use Symfony\Component\Routing\Annotation\Route;

use Symfony\Component\Routing\Attribute\Route;

class HomeController extends AbstractController
{
    // #[Route('/', name: 'app_home')]
    // public function index(ProjectRepository $projectRepo, ArticleRepository $articleRepo): Response
    // {
    //     return $this->render('home/index.html.twig', [
    //         'projects' => $projectRepo->findBy(['status' => 'ongoing'], ['createdAt' => 'DESC'], 3),
    //         'articles' => $articleRepo->findBy([], ['createdAt' => 'DESC'], 3),
    //     ]);
    // }

//     #[Route('/', name: 'app_home')]
//     public function index(ProjectRepository $projectRepo, ArticleRepository $articleRepo, DomainRepository $domainRepo): Response
// {
//     return $this->render('home/index.html.twig', [
//         'projects' => $projectRepo->findBy(['status' => 'ongoing'], ['createdAt' => 'DESC'], 3),
//         'articles' => $articleRepo->findBy([], ['createdAt' => 'DESC'], 3),
//         'domains' => $domainRepo->findAll(),
//     ]);
// }

#[Route('/', name: 'app_home')]
    public function index(ProjectRepository $projectRepo, ArticleRepository $articleRepo, DomainRepository $domainRepo): Response
    {
        // Récupérer les projets avec détails, filtrés par statut 'ongoing' et limités à 3
        $projects = $projectRepo->findProjectsWithDetails2(['status' => 'ongoing'], 3);

        $articles = $articleRepo->findBy([], ['createdAt' => 'DESC'], 3);
        $domains = $domainRepo->findAll();

        return $this->render('home/index.html.twig', [
            'projects' => $projects,
            'articles' => $articles,
            'domains' => $domains,
        ]);
    }


// #[Route('/en', name: 'app_home_en')]
// public function indexEn(ProjectRepository $projectRepo, ArticleRepository $articleRepo, DomainRepository $domainRepo): Response
// {
//     return $this->render('home/index.en.html.twig', [
//         'projects' => $projectRepo->findBy(['status' => 'ongoing'], ['createdAt' => 'DESC'], 3),
//         'articles' => $articleRepo->findBy([], ['createdAt' => 'DESC'], 3),
//         'domains' => $domainRepo->findAll(),
//     ]);
// }


    #[Route('/en', name: 'app_home_en')]
    public function indexEn(ProjectRepository $projectRepo, ArticleRepository $articleRepo, DomainRepository $domainRepo): Response
    {
        $projects = $projectRepo->findProjectsWithDetails2(['status' => 'ongoing'], 3);
        $articles = $articleRepo->findBy([], ['createdAt' => 'DESC'], 3);
        $domains = $domainRepo->findAll();

        return $this->render('home/index.en.html.twig', [
            'projects' => $projects,
            'articles' => $articles,
            'domains' => $domains,
        ]);
    }
}