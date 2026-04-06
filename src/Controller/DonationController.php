<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class DonationController extends AbstractController
{
    #[Route('/don', name: 'app_donate')]
    public function index(): Response
    {
        return $this->render('donation/index.html.twig');
    }

    #[Route('/en/donate', name: 'app_donate_en')]
    public function indexEn(): Response
    {
        return $this->render('donation/index.en.html.twig');
    }
}