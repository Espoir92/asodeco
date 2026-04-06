<?php

namespace App\Controller\Admin;

use App\Entity\Beneficiaire;
use EasyCorp\Bundle\EasyAdminBundle\Controller\AbstractCrudController;
use EasyCorp\Bundle\EasyAdminBundle\Field\IdField;
use EasyCorp\Bundle\EasyAdminBundle\Field\TextField;

class BeneficiaireCrudController extends AbstractCrudController
{
    public static function getEntityFqcn(): string
    {
        return Beneficiaire::class;
    }

    public function configureFields(string $pageName): iterable
    {
        return [
            IdField::new('id')->hideOnForm(),
            TextField::new('nom', 'Nom'),
            TextField::new('localisation')->hideOnIndex(),
            TextField::new('telephone')->hideOnIndex(),
            TextField::new('email')->hideOnIndex(),
            // Les champs spécifiques aux sous‑classes ne s’affichent pas automatiquement ;
            // pour les faire apparaître, il faudrait un mapping personnalisé.
        ];
    }
}