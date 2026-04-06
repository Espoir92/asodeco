<?php

namespace App\Controller\Admin;

use App\Entity\Project;
use App\Entity\Article;
use App\Entity\Domain;
use App\Entity\Contact;
use EasyCorp\Bundle\EasyAdminBundle\Config\Dashboard;
use EasyCorp\Bundle\EasyAdminBundle\Config\MenuItem;
use EasyCorp\Bundle\EasyAdminBundle\Config\UserMenu;
use EasyCorp\Bundle\EasyAdminBundle\Controller\AbstractDashboardController;
use EasyCorp\Bundle\EasyAdminBundle\Attribute\AdminDashboard;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Security\Core\User\UserInterface;

// Imports des CRUD pour les nouvelles entités
use App\Controller\Admin\StructureAccompagnementCrudController;
use App\Controller\Admin\AppuiCrudController;
use App\Controller\Admin\BeneficiaireCrudController;
use App\Controller\Admin\AffectationCrudController;

#[AdminDashboard(routePath: '/admin', routeName: 'admin')]
class DashboardController extends AbstractDashboardController
{
    public function index(): Response
    {
        return $this->render('admin/dashboard.html.twig');
    }

    public function configureDashboard(): Dashboard
    {
        return Dashboard::new()
            ->setTitle('ASODECO Admin');
    }

    public function configureMenuItems(): iterable
    {
        yield MenuItem::linkToDashboard('Dashboard', 'fa fa-home');

        yield MenuItem::linkTo(Project::class, 'Projets', 'fas fa-tasks')
            ->setAction('index');
        yield MenuItem::linkTo(Article::class, 'Actualités', 'fas fa-newspaper')
            ->setAction('index');
        yield MenuItem::linkTo(Domain::class, 'Domaines', 'fas fa-list')
            ->setAction('index');
        yield MenuItem::linkTo(Contact::class, 'Messages', 'fas fa-envelope')
            ->setAction('index');
        
        // Nouveaux CRUD
        yield MenuItem::linkTo(StructureAccompagnementCrudController::class, 'Structures', 'fas fa-building');
        yield MenuItem::linkTo(AppuiCrudController::class, 'Appuis', 'fas fa-hand-holding-usd');
        yield MenuItem::linkTo(BeneficiaireCrudController::class, 'Bénéficiaires', 'fas fa-users');
        yield MenuItem::linkTo(AffectationCrudController::class, 'Affectations', 'fas fa-link');
        yield MenuItem::linkTo(UserCrudController::class,'Utilisateurs', 'fas fa-users');

    //     yield MenuItem::linkTo(ProjectCrudController::class, 'Projets', 'fas fa-tasks');
    // yield MenuItem::linkTo(ArticleCrudController::class, 'Actualités', 'fas fa-newspaper');
    // yield MenuItem::linkTo(DomainCrudController::class, 'Domaines', 'fas fa-list');
    // yield MenuItem::linkTo(ContactCrudController::class, 'Messages', 'fas fa-envelope');

    }

    /**
     * Configure le menu utilisateur (en haut à droite)
     * Cette version crée le menu de zéro pour garantir son affichage
     */
    public function configureUserMenu(UserInterface $user): UserMenu
    {
        return UserMenu::new()
            ->setName($user->getUserIdentifier())
            ->displayUserName(true)
            ->displayUserAvatar(true)
            ->setAvatarUrl(null)
            ->addMenuItems([
                MenuItem::linkToRoute('Changer mon mot de passe', 'fa fa-key', 'app_change_password'),
                MenuItem::linkToLogout('Déconnexion', 'fa fa-sign-out'),
            ]);
    }
}