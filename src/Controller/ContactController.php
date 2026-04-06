<?php

namespace App\Controller;

use App\Entity\Contact;
use App\Form\ContactType;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
// use Symfony\Component\Routing\Annotation\Route;

use Symfony\Component\Mailer\MailerInterface;
use Symfony\Component\Mime\Email;
// use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Routing\Attribute\Route;

class ContactController extends AbstractController
{

    #[Route('/contact', name: 'app_contact')]
    public function index(Request $request, EntityManagerInterface $em, MailerInterface $mailer = null): Response
    {
        $contact = new Contact();
        $form = $this->createForm(ContactType::class, $contact);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            // Enregistrement en base
            $contact->setCreatedAt(new \DateTimeImmutable());
            $em->persist($contact);
            $em->flush();

            // Envoi d'un email de notification (optionnel)
            if ($mailer) {
                $email = (new Email())
                    ->from('noreply@asodeco.cd')
                    ->to('contact@asodeco.cd') // Adresse de l'ONG
                    ->subject('Nouveau message de contact')
                    ->html($this->renderView('emails/contact_notification.html.twig', [
                        'contact' => $contact,
                    ]));
                $mailer->send($email);
            }

            $this->addFlash('success', 'Votre message a été envoyé avec succès. Nous vous répondrons dans les meilleurs délais.');

            return $this->redirectToRoute('app_contact');
        }

        return $this->render('contact/index2.html.twig', [
            'form' => $form->createView(),
        ]);
    }

    #[Route('/en/contact', name: 'app_contact_en')]
    public function indexEN(Request $request, EntityManagerInterface $em, MailerInterface $mailer = null): Response
    {
        $contact = new Contact();
        $form = $this->createForm(ContactType::class, $contact);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            // Enregistrement en base
            $contact->setCreatedAt(new \DateTimeImmutable());
            $em->persist($contact);
            $em->flush();

            // Envoi d'un email de notification (optionnel)
            if ($mailer) {
                $email = (new Email())
                    ->from('noreply@asodeco.cd')
                    ->to('contact@asodeco.cd') // Adresse de l'ONG
                    ->subject('Nouveau message de contact')
                    ->html($this->renderView('emails/contact_notification.html.twig', [
                        'contact' => $contact,
                    ]));
                $mailer->send($email);
            }

            $this->addFlash('success', 'Votre message a été envoyé avec succès. Nous vous répondrons dans les meilleurs délais.');

            return $this->redirectToRoute('app_contact');
        }

        return $this->render('contact/index2.html.twig', [
            'form' => $form->createView(),
        ]);
    }
    // #[Route('/contact', name: 'app_contact')]
    // public function index(Request $request, EntityManagerInterface $em): Response
    // {
    //     $contact = new Contact();
    //     $form = $this->createForm(ContactType::class, $contact);
    //     $form->handleRequest($request);

    //     if ($form->isSubmitted() && $form->isValid()) {
    //         $contact->setCreatedAt(new \DateTimeImmutable());
    //         $em->persist($contact);
    //         $em->flush();

    //         $this->addFlash('success', 'Votre message a été envoyé avec succès.');
    //         return $this->redirectToRoute('app_contact');
    //     }

    //     return $this->render('contact/index.html.twig', [
    //         'form' => $form->createView(),
    //     ]);
    // }
}