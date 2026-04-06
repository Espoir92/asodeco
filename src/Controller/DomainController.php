<?php

namespace App\Controller;

use App\Entity\Domain;
use App\Repository\DomainRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Bridge\Doctrine\Attribute\MapEntity; // ⬅️ Ajoutez cet import

final class DomainController extends AbstractController
{
    #[Route('/domaines', name: 'app_domains')]
    public function index(DomainRepository $domainRepository): Response
    {
        $domains = $domainRepository->findAll();
        return $this->render('domain/index.html.twig', [
            'domains' => $domains,
        ]);
    }

    #[Route('/domaines/{slug}', name: 'app_domain_show')]
    public function show(
        #[MapEntity(mapping: ['slug' => 'slug'])] Domain $domain  // ⬅️ Ajoutez MapEntity
    ): Response {
        return $this->render('domain/show.html.twig', [
            'domain' => $domain,
        ]);
    }

    #[Route('/en/our-work', name: 'app_domains_en')]
    public function indexEN(DomainRepository $domainRepository): Response
    {
        $domains = $domainRepository->findAll();
        return $this->render('domain/index.html.twig', [
            'domains' => $domains,
        ]);
    }

    #[Route('/en/domaines/{slug}', name: 'app_domain_show_en')]
    public function showEN(
        #[MapEntity(mapping: ['slug' => 'slug'])] Domain $domain
    ): Response {
        return $this->render('domain/show.html.twig', [
            'domain' => $domain,
        ]);
    }
}