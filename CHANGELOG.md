# Changelog

Toutes les modifications importantes du projet **Neoxix SOC Academy** seront documentées dans ce fichier.

Le format est basé sur **Keep a Changelog** et le projet suivra progressivement les principes du versionnement sémantique.

## [Unreleased]

### Added

- Création du dépôt `neoxix-soc-academy`
- Initialisation de la branche principale `main`
- Configuration du dépôt distant GitHub
- Création de l'arborescence principale du projet
- Création de la structure du module Wireshark
- Création du laboratoire `LAB-01-Network-Traffic-Baseline`
- Ajout des fichiers standards du laboratoire :
  - `README.md`
  - `Analysis.md`
  - `Evidence.md`
  - `Lessons-Learned.md`
  - `Topology.drawio`
- Ajout du fichier `.gitignore`
- Ajout du fichier `ROADMAP.md`
- Ajout du fichier `CHANGELOG.md`
- Ajout du fichier `CLAUDE.md` (règles permanentes du dépôt pour les assistants IA)
- Ajout des domaines `09-CCNA` et `10-Fortinet-NSE4`
- Ajout d'un `README.md` de navigation dans chacun des domaines `00` à `10`
- Ajout de `README.md` dans les sous-dossiers vides de `01-Wireshark` et dans `diagrams/`
- Ajout de la fondation documentaire : `docs/README.md`, `docs/adr/README.md`, `docs/LAB-INDEX.md`, `docs/CONTRIBUTION-WORKFLOW.md`
- Ajout de 8 templates réutilisables dans `templates/` (README de laboratoire, objectifs et compétences, topologie et inventaire, procédure de configuration, procédure de validation, troubleshooting, preuves, lessons learned)
- Complétion de la structure documentaire initiale de `LAB-01-Network-Traffic-Baseline` (sections marquées `TODO` en attente d'exécution réelle)
- Ajout des scripts `scripts/Initialize-NeoxixSocAcademy.ps1` et `scripts/Test-NeoxixSocAcademyStructure.ps1`
- Ajout des modèles GitHub : `.github/PULL_REQUEST_TEMPLATE.md` et `.github/ISSUE_TEMPLATE/` (lab, bug, documentation, config)
- Remplacement du fichier `.github` (vide) par un dossier `.github/`

### Changed

- Correction du lien brisé vers `wazuh.svg` dans `README.md`
- Mise à jour de l'arborescence documentée dans `README.md` (ajout `09-CCNA`, `10-Fortinet-NSE4`)
- Mise à jour de `ROADMAP.md` : ajout des phases 9 (CCNA) et 10 (Fortinet NSE4), mise à jour des cases de la Phase 1

### Security

- Exclusion des secrets et fichiers d'environnement
- Exclusion des clés privées et certificats
- Exclusion des captures réseau de production
- Exclusion des images de machines virtuelles et archives volumineuses
- Exclusion du dépôt Git imbriqué `neoxix-sdk/` (non versionné dans ce dépôt)
