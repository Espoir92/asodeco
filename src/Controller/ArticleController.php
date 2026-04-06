<?php

namespace App\Controller;

use App\Entity\Article;
use App\Entity\Project;
use App\Form\ArticleType;
use App\Repository\ArticleRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Bridge\Doctrine\Attribute\MapEntity;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;

class ArticleController extends AbstractController
{
    #[Route('/actualites', name: 'app_articles')]
    public function index(ArticleRepository $repo): Response
    {
        return $this->render('article/index.html.twig', [
            'articles' => $repo->findBy([], ['createdAt' => 'DESC']),
        ]);
    }

    #[Route('/actualites/{slug}', name: 'app_article_show')]
    public function show(
        #[MapEntity(mapping: ['slug' => 'slug'])] Article $article
    ): Response {
        return $this->render('article/show.html.twig', [
            'article' => $article,
        ]);
    }

       #[Route('/en/actualites', name: 'app_articles_en')]
    public function indexEN(ArticleRepository $repo): Response
    {
        return $this->render('article/index.html.twig', [
            'articles' => $repo->findBy([], ['createdAt' => 'DESC']),
        ]);
    }

    #[Route('/en/actualites/{slug}', name: 'app_article_show_en')]
    public function showEN(
        #[MapEntity(mapping: ['slug' => 'slug'])] Article $article
    ): Response {
        return $this->render('article/show.html.twig', [
            'article' => $article,
        ]);
    }



    /**
 * Retourne le formulaire d’ajout d’article (HTML) via AJAX.
 */
#[Route('/project/{projectId}/article/form', name: 'app_project_article_form', methods: ['GET'])]
public function getArticleForm(Project $project): Response
{
    if (!$this->isGranted('ROLE_ADMIN')) {
        throw $this->createAccessDeniedException('Seuls les administrateurs peuvent ajouter des articles.');
    }
    $article = new Article();
    $article->setProject($project);
    $form = $this->createForm(ArticleType::class, $article, [
        'action' => $this->generateUrl('app_project_article_create', ['projectId' => $project->getId()]),
    ]);
    return $this->render('project/_article_form.html.twig', [
        'form' => $form->createView(),
        'project' => $project,
    ]);
}

/**
 * Crée un article via AJAX.
 */
#[Route('/project/{projectId}/article', name: 'app_project_article_create', methods: ['POST'])]
public function createArticle(Request $request, Project $project, EntityManagerInterface $em): JsonResponse
{
    if (!$this->isGranted('ROLE_ADMIN')) {
        return $this->json(['success' => false, 'message' => 'Accès refusé'], 403);
    }

    $article = new Article();
    $article->setProject($project);
    $form = $this->createForm(ArticleType::class, $article);
    $form->handleRequest($request);

    if ($form->isSubmitted() && $form->isValid()) {
        $article->setCreatedAt(new \DateTime());
        $em->persist($article);
        $em->flush();
        return $this->json(['success' => true, 'message' => 'Article ajouté avec succès.']);
    }

    $errors = [];
    foreach ($form->getErrors(true) as $error) {
        $errors[] = $error->getMessage();
    }
    return $this->json(['success' => false, 'errors' => $errors], 400);
}
}