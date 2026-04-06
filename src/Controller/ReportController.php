<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

use App\Repository\ProjectRepository;
use App\Repository\AppuiRepository;
use App\Repository\BeneficiaireRepository;
use App\Repository\StructureAccompagnementRepository;
use Dompdf\Dompdf;
use Dompdf\Options;

final class ReportController extends AbstractController
{
    /**
     * Génère le rapport d'activité pour une année donnée.
     * Supporte :
     * - URL : /rapport-activite/2025
     * - GET : /rapport-activite?year=2025
     */
    #[Route('/rapport-activite/{year}', name: 'app_report_activity', defaults: ['year' => null])]
    public function generateReport(
        Request $request,
        $year,
        ProjectRepository $projectRepo,
        AppuiRepository $appuiRepo,
        BeneficiaireRepository $beneficiaireRepo,
        StructureAccompagnementRepository $structureRepo
    ): Response {
        // Priorité : paramètre d'URL, puis paramètre GET, puis année courante
        if (!$year) {
            $year = $request->query->get('year', date('Y'));
        }
        
        // Définir les dates de début et fin de l'année
        $startDate = new \DateTime($year . '-01-01');
        $endDate = new \DateTime($year . '-12-31 23:59:59');

        // Récupérer les projets créés dans l'année
        $projects = $projectRepo->findByDateRange($startDate, $endDate);
        
        // Récupérer les projets terminés dans l'année
        $completedProjectsList = $projectRepo->findCompletedByDateRange($startDate, $endDate);
        
        // Compter les appuis dans l'année
        $totalAppuis = $appuiRepo->countByDateRange($startDate, $endDate);
        
        // Calculer le montant total des appuis dans l'année
        $totalFunding = $appuiRepo->sumMontantsByDateRange($startDate, $endDate);
        
        // Compter les bénéficiaires affectés dans l'année
        $totalBeneficiaires = $beneficiaireRepo->countAffectedByDateRange($startDate, $endDate);
        
        // Compter les structures ayant eu un appui dans l'année
        $totalStructures = $structureRepo->countByDateRange($startDate, $endDate);
        
        // Récupérer les structures actives dans l'année (limitées à 5)
        $recentStructures = $structureRepo->findByDateRange($startDate, $endDate, ['id' => 'DESC'], 5);
        
        $totalProjects = count($projects);
        $completedProjects = count($completedProjectsList);

        // Rendre le template HTML
        $html = $this->renderView('report/activity_report.html.twig', [
            'year' => $year,
            'projects' => $projects,
            'totalProjects' => $totalProjects,
            'completedProjects' => $completedProjects,
            'completedProjectsList' => $completedProjectsList,
            'totalAppuis' => $totalAppuis,
            'totalBeneficiaires' => $totalBeneficiaires,
            'totalStructures' => $totalStructures,
            'totalFunding' => $totalFunding,
            'recentStructures' => $recentStructures,
            'generatedAt' => new \DateTime(),
        ]);

        // Configuration de Dompdf
        $pdfOptions = new Options();
        $pdfOptions->set('defaultFont', 'Arial');
        $pdfOptions->set('isRemoteEnabled', true);

        $dompdf = new Dompdf($pdfOptions);
        $dompdf->loadHtml($html);
        $dompdf->setPaper('A4', 'portrait');
        $dompdf->render();

        // Retourner le PDF
        return new Response($dompdf->output(), 200, [
            'Content-Type' => 'application/pdf',
            'Content-Disposition' => 'inline; filename="rapport-activite-' . $year . '.pdf"'
        ]);
    }
}

// use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
// use Symfony\Component\HttpFoundation\Response;
// use Symfony\Component\Routing\Attribute\Route;


// use App\Repository\ProjectRepository;
// use App\Repository\AppuiRepository;
// use App\Repository\BeneficiaireRepository;
// use App\Repository\StructureAccompagnementRepository;
// use Dompdf\Dompdf;
// use Dompdf\Options;

// // use Symfony\Component\Routing\Annotation\Route;

// final class ReportController extends AbstractController
// {
//     #[Route('/rapport-activite/{year}', name: 'app_report_activity', defaults: ['year' => null])]
//     public function generateReport(
//         $year,
//         ProjectRepository $projectRepo,
//         AppuiRepository $appuiRepo,
//         BeneficiaireRepository $beneficiaireRepo,
//         StructureAccompagnementRepository $structureRepo
//     ): Response {
//         // Si aucune année n'est spécifiée, prendre l'année courante
//         if (!$year) {
//             $year = date('Y');
//         }
        
//         // Définir les dates de début et fin de l'année
//         $startDate = new \DateTime($year . '-01-01');
//         $endDate = new \DateTime($year . '-12-31 23:59:59');

//         // Récupérer les projets créés dans l'année
//         $projects = $projectRepo->findByDateRange($startDate, $endDate);
        
//         // Récupérer les projets terminés dans l'année
//         $completedProjectsList = $projectRepo->findCompletedByDateRange($startDate, $endDate);
        
//         // Compter les appuis dans l'année
//         $totalAppuis = $appuiRepo->countByDateRange($startDate, $endDate);
        
//         // Calculer le montant total des appuis dans l'année
//         $totalFunding = $appuiRepo->sumMontantsByDateRange($startDate, $endDate);
        
//         // Compter les bénéficiaires affectés dans l'année
//         $totalBeneficiaires = $beneficiaireRepo->countAffectedByDateRange($startDate, $endDate);
        
//         // Compter les nouvelles structures créées dans l'année
//         $totalStructures = $structureRepo->countByDateRange($startDate, $endDate);
        
//         // Récupérer les dernières structures de l'année
//         $recentStructures = $structureRepo->findByDateRange($startDate, $endDate, ['id' => 'DESC'], 5);
        
//         $totalProjects = count($projects);
//         $completedProjects = count($completedProjectsList);

//         // Rendre le template HTML
//         $html = $this->renderView('report/activity_report.html.twig', [
//             'year' => $year,
//             'projects' => $projects,
//             'totalProjects' => $totalProjects,
//             'completedProjects' => $completedProjects,
//             'completedProjectsList' => $completedProjectsList,
//             'totalAppuis' => $totalAppuis,
//             'totalBeneficiaires' => $totalBeneficiaires,
//             'totalStructures' => $totalStructures,
//             'totalFunding' => $totalFunding,
//             'recentStructures' => $recentStructures,
//             'generatedAt' => new \DateTime(),
//         ]);

//         // Configuration de Dompdf
//         $pdfOptions = new Options();
//         $pdfOptions->set('defaultFont', 'Arial');
//         $pdfOptions->set('isRemoteEnabled', true);

//         $dompdf = new Dompdf($pdfOptions);
//         $dompdf->loadHtml($html);
//         $dompdf->setPaper('A4', 'portrait');
//         $dompdf->render();

//         // Retourner le PDF
//         return new Response($dompdf->output(), 200, [
//             'Content-Type' => 'application/pdf',
//             'Content-Disposition' => 'inline; filename="rapport-activite-' . $year . '.pdf"'
//         ]);
    // }
    // #[Route('/report', name: 'app_report')]
    // public function index(): Response
    // {
    //     return $this->render('report/index.html.twig', [
    //         'controller_name' => 'ReportController',
    //     ]);
    // }

    // #[Route('/rapport-activite', name: 'app_report_activity')]
    // public function generateReport(
    //     ProjectRepository $projectRepo,
    //     AppuiRepository $appuiRepo,
    //     BeneficiaireRepository $beneficiaireRepo,
    //     StructureAccompagnementRepository $structureRepo
    // ): Response {
    //     // Récupérer les données
    //     $projects = $projectRepo->findBy([], ['createdAt' => 'DESC']);
    //     $totalProjects = count($projects);
    //     $completedProjects = $projectRepo->countCompletedProjects();
    //     $totalAppuis = $appuiRepo->count([]);
    //     $totalBeneficiaires = $beneficiaireRepo->count([]);
    //     $totalStructures = $structureRepo->count([]);
        
    //     // Calculer le montant total des appuis
    //     $totalFunding = $appuiRepo->sumAllMontants();

    //     // Récupérer les projets terminés
    //     $completedProjectsList = $projectRepo->findBy(['status' => 'completed'], ['endDate' => 'DESC']);
        
    //     // Récupérer les 5 dernières structures
    //     $recentStructures = $structureRepo->findBy([], ['id' => 'DESC'], 5);

    //     // Rendre le template HTML
    //     $html = $this->renderView('report/activity_report.html.twig', [
    //         'projects' => $projects,
    //         'totalProjects' => $totalProjects,
    //         'completedProjects' => $completedProjects,
    //         'completedProjectsList' => $completedProjectsList,
    //         'totalAppuis' => $totalAppuis,
    //         'totalBeneficiaires' => $totalBeneficiaires,
    //         'totalStructures' => $totalStructures,
    //         'totalFunding' => $totalFunding,
    //         'recentStructures' => $recentStructures,
    //         'generatedAt' => new \DateTime(),
    //     ]);

    //     // Configuration de Dompdf
    //     $pdfOptions = new Options();
    //     $pdfOptions->set('defaultFont', 'Arial');
    //     $pdfOptions->set('isRemoteEnabled', true); // Permet d'inclure des images distantes

    //     $dompdf = new Dompdf($pdfOptions);
    //     $dompdf->loadHtml($html);
    //     $dompdf->setPaper('A4', 'portrait');
    //     $dompdf->render();

    //     // Retourner le PDF en inline (ou en téléchargement)
    //     return new Response($dompdf->output(), 200, [
    //         'Content-Type' => 'application/pdf',
    //         'Content-Disposition' => 'inline; filename="rapport-activite-2025.pdf"'
    //     ]);
    // }

// }
