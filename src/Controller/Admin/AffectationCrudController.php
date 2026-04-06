<?php

namespace App\Controller\Admin;

use App\Entity\Affectation;
use EasyCorp\Bundle\EasyAdminBundle\Controller\AbstractCrudController;
use EasyCorp\Bundle\EasyAdminBundle\Field\AssociationField;
use EasyCorp\Bundle\EasyAdminBundle\Field\DateTimeField;
use EasyCorp\Bundle\EasyAdminBundle\Field\TextField;

class AffectationCrudController extends AbstractCrudController
{
    public static function getEntityFqcn(): string
    {
        return Affectation::class;
    }

    public function configureFields(string $pageName): iterable
    {
        return [
            AssociationField::new('project', 'Projet'),
            AssociationField::new('beneficiaire', 'Bénéficiaire'),
            DateTimeField::new('dateAffectation', 'Date d’affectation'),
            TextField::new('typeAppui', 'Type d’appui'),
            TextField::new('commentaire', 'Commentaire')->hideOnIndex(),
        ];
    }
}