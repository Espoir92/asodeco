<?php

namespace App\Controller;

use Dompdf\Dompdf;
use Dompdf\Options;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class PresentationController extends AbstractController
{

     #[Route('/presentation', name: 'app_presentation_page')]
    public function page(): Response
    {
        return $this->render('presentation/page.html.twig', [
            'isEnglish' => false,
        ]);
    }

    #[Route('/en/presentation', name: 'app_presentation_page_en')]
    public function pageEn(): Response
    {
        return $this->render('presentation/page.html.twig', [
            'isEnglish' => true,
        ]);
    }

    #[Route('/presentation/pdf', name: 'app_presentation_pdf')]
    public function generatePdf(Request $request): Response
    {
        $isEnglish = $request->query->get('lang') === 'en';
        
        $html = $this->renderView('presentation/pdf.html.twig', [
            'isEnglish' => $isEnglish,
            'generatedAt' => new \DateTime(),
        ]);

        $pdfOptions = new Options();
        $pdfOptions->set('defaultFont', 'Arial');
        $pdfOptions->set('isRemoteEnabled', true);
        $pdfOptions->set('isHtml5ParserEnabled', true);

        $dompdf = new Dompdf($pdfOptions);
        $dompdf->loadHtml($html);
        $dompdf->setPaper('A4', 'portrait');
        $dompdf->render();

        return new Response($dompdf->output(), 200, [
            'Content-Type' => 'application/pdf',
            'Content-Disposition' => 'attachment; filename="asodeco-presentation-' . ($isEnglish ? 'en' : 'fr') . '.pdf"'
        ]);
    }
}
    // #[Route('/dossier-presentation', name: 'app_presentation')]
    // public function generatePresentation(): Response
    // {
    //     $html = $this->renderView('presentation/dossier.html.twig', [
    //         'generatedAt' => new \DateTime(),
    //         'isEnglish' => false,  // Ajoutez cette ligne
    //     ]);

    //     return $this->generatePdf($html, 'dossier-presentation-asodeco.pdf');
    // }

    // #[Route('/en/presentation', name: 'app_presentation_en')]
    // public function generatePresentationEn(): Response
    // {
    //     $html = $this->renderView('presentation/dossier.html.twig', [
    //         'generatedAt' => new \DateTime(),
    //         'isEnglish' => true,   // Ajoutez cette ligne
    //     ]);

    //     return $this->generatePdf($html, 'asodeco-presentation.pdf');
    // }

    // private function generatePdf(string $html, string $filename): Response
    // {
    //     $pdfOptions = new Options();
    //     $pdfOptions->set('defaultFont', 'Arial');
    //     $pdfOptions->set('isRemoteEnabled', true);

    //     $dompdf = new Dompdf($pdfOptions);
    //     $dompdf->loadHtml($html);
    //     $dompdf->setPaper('A4', 'portrait');
    //     $dompdf->render();

    //     return new Response($dompdf->output(), 200, [
    //         'Content-Type' => 'application/pdf',
    //         'Content-Disposition' => 'inline; filename="' . $filename . '"'
    //     ]);
    // }
// }