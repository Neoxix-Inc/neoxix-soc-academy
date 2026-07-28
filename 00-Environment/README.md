# 00 — Environment

## Objectif du domaine

Documenter la mise en place et le maintien de l'environnement de laboratoire utilisé par l'ensemble des domaines du dépôt : machines virtuelles, réseau virtuel isolé, outils de base et conventions communes.

## Compétences visées

- Conception d'un laboratoire virtuel isolé (hyperviseur, réseau virtuel, segmentation).
- Installation et configuration de base des systèmes d'exploitation utilisés (Windows, Linux).
- Gestion des snapshots et de la reproductibilité de l'environnement.

## Prérequis

- Notions de virtualisation (VMware Workstation/ESXi, VirtualBox, Hyper-V ou équivalent).
- Notions de réseau de base (adressage IP, VLAN).

## Structure des laboratoires

```text
00-Environment/
└── 01-Labs/
    └── LAB-NN-Nom-Descriptif/
        ├── README.md
        ├── Analysis.md
        ├── Evidence.md
        └── Lessons-Learned.md
```

## Convention de nommage

`LAB-NN-Nom-Descriptif` où `NN` est un numéro séquentiel sur deux chiffres (`01`, `02`, ...) et `Nom-Descriptif` un intitulé court en PascalCase avec tirets.

## Index des laboratoires

| Laboratoire | Objectif | Statut |
| --- | --- | --- |
| — | Aucun laboratoire créé pour le moment | ⚪ Planned |

Légende : ⚪ Planned · 🟡 In Progress · 🟢 Completed

## Templates communs

Voir [templates/](../templates/README.md) pour les gabarits réutilisables (README de laboratoire, objectifs, topologie, procédures, preuves, troubleshooting, lessons learned).
