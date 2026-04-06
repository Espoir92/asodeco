<?php

namespace App\Controller\Admin;

use App\Entity\Appui;
use EasyCorp\Bundle\EasyAdminBundle\Controller\AbstractCrudController;
use EasyCorp\Bundle\EasyAdminBundle\Field\IdField;
use EasyCorp\Bundle\EasyAdminBundle\Field\AssociationField;
use EasyCorp\Bundle\EasyAdminBundle\Field\TextField;
use EasyCorp\Bundle\EasyAdminBundle\Field\MoneyField;
use EasyCorp\Bundle\EasyAdminBundle\Field\TextareaField;
use EasyCorp\Bundle\EasyAdminBundle\Field\DateTimeField;

class AppuiCrudController extends AbstractCrudController
{
    public static function getEntityFqcn(): string
    {
        return Appui::class;
    }

    public function configureFields(string $pageName): iterable
    {
        return [
            IdField::new('id')->hideOnForm(),
            AssociationField::new('project', 'Projet'),
            AssociationField::new('structure', 'Structure'),
            TextField::new('natureAppui', 'Nature de l’appui'),
            MoneyField::new('montant', 'Montant')
                ->setCurrency('USD')
                ->setRequired(false),
            TextareaField::new('description', 'Description')->hideOnIndex(),
            DateTimeField::new('dateAppui', 'Date'),
        ];
    }
}