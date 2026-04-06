<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class ErrorController extends AbstractController
{
    #[Route('/{any}', name: 'app_error_redirect', requirements: ['any' => '.*'], priority: -100)]
    public function redirectToHome(Request $request): Response
    {
        $pathInfo = $request->getPathInfo();
        
        // Liste des routes valides (ne pas rediriger)
        $validRoutes = [
            '/', '/en', '/fr',
            '/a-propos', '/about',
            '/contact', '/en/contact',
            '/domaines', '/en/our-work',
            '/projets', '/en/projects',
            '/actualites', '/en/news',
            '/devenir-partenaire', '/en/become-partner',
            '/presentation', '/en/presentation',
            '/don', '/en/donate',
            '/login', '/logout',
            '/admin', '/admin/',
        ];
        
        // Vérifier si c'est une route valide
        foreach ($validRoutes as $route) {
            if ($pathInfo === $route || str_starts_with($pathInfo, $route . '/')) {
                // Laisser Symfony gérer normalement
                throw $this->createNotFoundException();
            }
        }
        
        // Rediriger vers l'accueil selon la langue
        $isEnglish = str_starts_with($pathInfo, '/en');
        return $this->redirectToRoute($isEnglish ? 'app_home_en' : 'app_home');
    }
}