# Workflow de contribution

Ce dépôt étant un portfolio individuel, ce workflow reste volontairement simple. Il documente la procédure à suivre pour ajouter ou modifier un laboratoire.

## 1. Créer un laboratoire

1. Copier [templates/LAB-README-TEMPLATE.md](../templates/LAB-README-TEMPLATE.md) dans le domaine concerné, sous `NN-Domaine/01-Labs/LAB-NN-Nom-Descriptif/README.md`.
2. Compléter les templates complémentaires nécessaires (objectifs, topologie, procédures, preuves, troubleshooting, lessons learned) depuis [templates/README.md](../templates/README.md).
3. Marquer toute section non encore exécutée avec `TODO — À compléter pendant le laboratoire` (voir [CLAUDE.md](../CLAUDE.md), règle 1 et 2).

## 2. Exécuter et documenter

- Exécuter réellement le laboratoire dans l'environnement prévu.
- Ne renseigner que des résultats réellement observés (aucune capture, log ou conclusion inventée).
- Ajouter les preuves (captures, exports, PCAP) dans les sous-dossiers dédiés du domaine.

## 3. Mettre à jour les index

- Ajouter la ligne correspondante dans le tableau d'index du `README.md` du domaine.
- Mettre à jour [docs/LAB-INDEX.md](./LAB-INDEX.md).
- Ajouter une entrée dans [CHANGELOG.md](../CHANGELOG.md) sous `[Unreleased]`.

## 4. Revue avant publication

Avant de proposer une publication (commit/push), vérifier :

- [ ] aucune donnée personnelle, secret, clé ou identifiant réel n'est présent ;
- [ ] aucune capture réseau de production n'est incluse ;
- [ ] les sections `TODO` restantes sont assumées et visibles, pas masquées ;
- [ ] les liens Markdown relatifs fonctionnent (`scripts/Test-NeoxixSocAcademyStructure.ps1`) ;
- [ ] le statut du laboratoire dans les index reflète son état réel.

Voir aussi [templates/PUBLICATION](../templates/README.md) et les règles permanentes de [CLAUDE.md](../CLAUDE.md).

## 5. Commit, push, merge

Ces actions ne sont jamais automatiques : elles nécessitent une autorisation explicite de l'auteur pour chaque exécution (voir [CLAUDE.md](../CLAUDE.md), règle 3).
