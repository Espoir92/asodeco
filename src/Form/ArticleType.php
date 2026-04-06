<?php

namespace App\Form;

use App\Entity\Article;
use App\Entity\Project;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\FileType;
use Symfony\Component\Form\Extension\Core\Type\TextareaType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class ArticleType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('title', TextType::class, ['label' => 'Titre'])
            ->add('titleEn', TextType::class, ['label' => 'Titre (anglais)', 'required' => false])
            ->add('content', TextareaType::class, ['label' => 'Contenu', 'attr' => ['rows' => 10]])
            ->add('contentEn', TextareaType::class, ['label' => 'Contenu (anglais)', 'required' => false, 'attr' => ['rows' => 10]])
            ->add('imageFile', FileType::class, ['label' => 'Image', 'required' => false, 'mapped' => false])
            ->add('project', EntityType::class, [
                'class' => Project::class,
                'choice_label' => 'title',
                'required' => false,
                'label' => 'Projet associé',
            ]);
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Article::class,
        ]);
    }
}