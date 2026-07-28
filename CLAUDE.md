# CLAUDE.md

Ce fichier fournit des règles permanentes pour tout assistant IA (Claude Code ou équivalent) travaillant sur le dépôt **neoxix-soc-academy**.

## À propos du dépôt

Neoxix SOC Academy est un portfolio technique de laboratoires de cybersécurité défensive (réseau, SIEM, EDR, threat hunting, réponse aux incidents, CCNA, Fortinet NSE4). Le contenu est destiné à être présenté publiquement à des recruteurs : la rigueur et l'exactitude priment sur le volume.

## Règles permanentes

### 1. Validation des laboratoires avant publication

Un laboratoire technique (dossier sous `NN-Domaine/01-Labs/` ou équivalent) ne doit être considéré comme publiable que lorsque :

- il a été réellement exécuté dans un environnement de laboratoire contrôlé ;
- ses résultats, captures et preuves ont été observés et non simulés ;
- son contenu a été relu et validé par l'auteur humain.

Tant qu'un laboratoire n'a pas été validé, ses sections d'exécution doivent rester marquées **`TODO — À compléter pendant le laboratoire`** plutôt que remplies avec des données plausibles.

### 2. Interdiction des données inventées

Il est interdit de générer ou d'insérer :

- de fausses captures Wireshark, de faux exports de logs ou de faux screenshots ;
- de faux résultats d'analyse, de fausses conclusions techniques ou de fausses métriques ;
- des secrets, mots de passe, clés, jetons ou certificats, réels ou fictifs présentés comme réels ;
- des configurations réseau ou système inventées et présentées comme testées ;
- des données personnelles ou des informations internes appartenant à une organisation tierce.

Toute donnée technique doit provenir d'un environnement de laboratoire réellement exécuté, ou être explicitement marquée comme placeholder/`TODO`.

### 3. Actions Git à autorisation explicite

Un assistant IA ne doit **jamais**, sans autorisation explicite donnée dans le message en cours :

- créer un commit ;
- exécuter un `push` ;
- exécuter un `merge` ou une résolution de conflit qui écrase des changements ;
- supprimer physiquement des fichiers ou dossiers de manière destructive (`rm -rf`, `git clean`, `git reset --hard`, suppression de branche) ;
- réécrire l'historique (`rebase -i`, `commit --amend` sur un commit déjà poussé, `push --force`).

Le staging (`git add`) sans commit est autorisé pour produire des diffs lisibles, à condition de rester réversible et signalé.

### 4. Portée documentaire raisonnable

L'objectif est une fondation documentaire complète mais proportionnée, pas une perfection interminable. Préférer une structure claire et réutilisable (templates, index) à la rédaction anticipée de contenu de laboratoire non exécuté.

### 5. Dossier `neoxix-sdk/`

`neoxix-sdk/` est un dépôt Git local indépendant, non intégré à `neoxix-soc-academy` (ni sous-module, ni contenu versionné). Il est exclu via `.gitignore`. Ne jamais tenter de l'ajouter à l'index de ce dépôt.

### 6. Encodage et hygiène des fichiers

- Markdown, JSON, YAML : UTF-8 sans BOM.
- PowerShell : compatible Windows PowerShell 5.1, encodage cohérent avec les scripts existants.
- Aucun chemin absolu local dans les fichiers publiés.
- Aucune commande shell collée accidentellement dans un fichier Markdown ou YAML.
