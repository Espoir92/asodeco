<?php

namespace App\Controller\Admin;

use App\Entity\StructureAccompagnement;
use EasyCorp\Bundle\EasyAdminBundle\Controller\AbstractCrudController;
use EasyCorp\Bundle\EasyAdminBundle\Field\IdField;
use EasyCorp\Bundle\EasyAdminBundle\Field\TextField;
use EasyCorp\Bundle\EasyAdminBundle\Field\UrlField;
use EasyCorp\Bundle\EasyAdminBundle\Field\ImageField;
use Vich\UploaderBundle\Form\Type\VichImageType;

class StructureAccompagnementCrudController extends AbstractCrudController
{
    public static function getEntityFqcn(): string
    {
        return StructureAccompagnement::class;
    }

    public function configureFields(string $pageName): iterable
    {
        return [
            IdField::new('id')->hideOnForm(),
            TextField::new('nom', 'Nom'),
            TextField::new('type', 'Type')->setRequired(false),
            UrlField::new('siteWeb', 'Site web')->setRequired(false),
            TextField::new('logoFile', 'Logo')
                ->setFormType(VichImageType::class)
                ->onlyOnForms(),
            ImageField::new('logo', 'Logo')
                ->setBasePath('/uploads/logos')
                ->onlyOnIndex(),
        ];
    }
}