# WiseProd

Outil d'aide à la vente pour conseillers retail high-tech, avec étude de besoins guidée, argumentaires générés par IA et parcours de vente complet jusqu'au ticket de caisse.

Projet personnel inspiré de mon expérience de conseiller de vente chez Fnac — non affilié, non officiel.

🔗 **Démo en ligne :** [wiseprod.tremic.fr](https://wiseprod.tremic.fr)

---

## Le problème

Un vendeur qui conseille un client doit à la fois cerner son besoin, connaître le catalogue produit, savoir quels services associer (assurance, garanties...), et formuler un discours de vente convaincant — souvent en quelques minutes, sans avoir le temps de tout préparer.

## La solution

WiseProd guide le vendeur du premier contact client jusqu'au paiement :

1. **Étude de besoins** — questionnaire à tuiles (type d'appareil, usage, budget, priorité), avec un chemin court pour un client qui sait déjà ce qu'il veut, et un chemin d'aide au choix pour celui qui cherche une solution à un besoin
2. **Recommandation produit** — matching automatique selon les critères renseignés
3. **Argumentaire de vente généré par IA** — contextualisé au produit et au profil client, avec proposition de services additionnels cumulables
4. **Panier** — ajout de produits et services sélectionnés
5. **Fiche client** — création, recherche (téléphone, email, matricule), édition
6. **Ticket de caisse** — génération d'un document imprimable avec calcul HT/TTC, numéro de ticket unique et détail des articles par référence (SKU)

## Fonctionnalités par rôle

| Fonctionnalité | Vendeur | Admin |
|---|---|---|
| Étude de besoins et recommandation | ✅ | ✅ |
| Génération d'argumentaire IA | ✅ | ✅ |
| Panier et ticket de caisse | ✅ | ✅ |
| Création / édition fiche client | ✅ | ✅ |
| Suppression fiche client | ❌ | ✅ |
| Création / édition / suppression produit | ❌ | ✅ |

## Stack technique

- **Backend** : Ruby on Rails 8, SQLite
- **Authentification** : Devise
- **Autorisations** : Pundit
- **IA** : ruby_llm + OpenAI API
- **Déploiement** : Docker, Kamal
- **Frontend** : Stimulus, CSS custom (identité visuelle propre, sans framework CSS générique)

## Démo

Un compte démo est disponible pour tester l'application sans créer de compte.


## Installation locale

```bash
git clone git@github.com:mtremauville/Wiseprod.git
cd Wiseprod
bundle install
cp .env.example .env
# Renseigner OPENAI_API_KEY dans .env
rails db:migrate
rails db:seed
rails server



	•	Modélisation d'un parcours métier complet (besoin → produit → vente → paiement), pas seulement du CRUD isolé
	•	Intégration d'IA générative contextualisée à des données métier réelles
	•	Gestion de rôles et permissions avec Pundit
	•	Déploiement Docker/Kamal en production, aux côtés d'autres services sur un même serveur (cohabitation avec Nginx, gestion de ports)
	•	Discipline Git : une fonctionnalité = une branche = une Pull Request documentée

Auteur

Mickael Tremauville — Développeur Frontend Junior en reconversion, ancien conseiller de vente technique 24 ans en tech retail.

	•	Blog : tremic.fr
	•	LinkedIn : linkedin.com/in/mickael-tremauville
	•	GitHub : @mtremauville