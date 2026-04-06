<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

final class AboutController extends AbstractController
{

//     #[Route('/{_locale}/a-propos', name: 'app_about', requirements: ['_locale' => 'fr'])]
//     #[Route('/{_locale}/about', name: 'app_about_en', requirements: ['_locale' => 'en'])]
//     public function index(Request $request): Response
// {
//     $locale = $request->getLocale();
//     $template = $locale === 'en' ? 'about/index.en.html.twig' : 'about/index.html.twig';
//     return $this->render($template);
// }

#[Route('/a-propos', name: 'app_about')]
    public function index(): Response
    {
        return $this->render('about/index.html.twig');
    }

    #[Route('/about', name: 'app_about_en')]
    public function indexEn(): Response
    {
        return $this->render('about/index.en.html.twig');
    }

}
