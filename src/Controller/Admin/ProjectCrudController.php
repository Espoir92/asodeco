<?php

namespace App\Controller\Admin;

use App\Entity\Project;
use EasyCorp\Bundle\EasyAdminBundle\Controller\AbstractCrudController;
use EasyCorp\Bundle\EasyAdminBundle\Field\IdField;
use EasyCorp\Bundle\EasyAdminBundle\Field\TextField;
use EasyCorp\Bundle\EasyAdminBundle\Field\TextareaField;
use EasyCorp\Bundle\EasyAdminBundle\Field\DateTimeField;
use EasyCorp\Bundle\EasyAdminBundle\Field\ChoiceField;
use EasyCorp\Bundle\EasyAdminBundle\Field\ImageField;
use EasyCorp\Bundle\EasyAdminBundle\Field\AssociationField;
use Vich\UploaderBundle\Form\Type\VichImageType;

class ProjectCrudController extends AbstractCrudController
{
    public static function getEntityFqcn(): string
    {
        return Project::class;
    }

    public function configureFields(string $pageName): iterable
    {
        $fields = [
            IdField::new('id')->hideOnForm(),
            TextField::new('title', 'Titre'),
            TextField::new('slug', 'Slug')->hideOnIndex(),
            TextareaField::new('description', 'Description'),
            TextareaField::new('objectives', 'Objectifs')->hideOnIndex(),
            TextareaField::new('results', 'Résultats')->hideOnIndex(),
            // partners supprimé
            ChoiceField::new('status', 'Statut')->setChoices([
                'En cours' => 'ongoing',
                'Terminé' => 'completed',
            ]),
            DateTimeField::new('startDate', 'Date de début'),
            DateTimeField::new('endDate', 'Date de fin'),
            // Upload d’image
            TextField::new('imageFile', 'Image')
                ->setFormType(VichImageType::class)
                ->onlyOnForms(),
            ImageField::new('imageFilename', 'Image')
                ->setBasePath('/uploads/projects')
                ->onlyOnIndex(),
            DateTimeField::new('createdAt', 'Créé le')->hideOnForm(),
            DateTimeField::new('updatedAt', 'Modifié le')->hideOnForm(),

            // Champs supplémentaires
            TextField::new('country', 'Pays'),
            TextField::new('province', 'Province'),
            TextField::new('secteur', 'Secteur (fr)'),
            TextField::new('secteurEN', 'Secteur (en)')->setRequired(false),
            TextField::new('budget', 'Budget'),
            TextField::new('code', 'Code projet'),
            TextField::new('abbreviatedName', 'Nom abrégé (fr)'),
            TextField::new('abbreviatedNameEn', 'Nom abrégé (en)')->setRequired(false),
            TextField::new('titleEN', 'Titre (en)')->setRequired(false),
            TextareaField::new('descriptionEN', 'Description (en)')->setRequired(false),
            TextareaField::new('objectivesEN', 'Objectifs (en)')->setRequired(false)->hideOnIndex(),
            TextareaField::new('resultsEN', 'Résultats (en)')->setRequired(false)->hideOnIndex(),
        ];

        // Ajout des relations en lecture seule (uniquement dans la vue détail)
        if ($pageName === 'detail') {
            $fields[] = AssociationField::new('appuis', 'Appuis')
                ->setFormTypeOption('disabled', true)
                ->setTemplatePath('admin/fields/appuis_list.html.twig');
            $fields[] = AssociationField::new('affectations', 'Bénéficiaires affectés')
                ->setFormTypeOption('disabled', true)
                ->setTemplatePath('admin/fields/affectations_list.html.twig');
        }

        return $fields;
    }
}