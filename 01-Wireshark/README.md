# 01 — Wireshark

## Objectif du domaine

Développer des compétences d'analyse réseau avec Wireshark : capture de trafic, identification des protocoles, établissement d'une référence de trafic légitime et détection de comportements suspects.

## Compétences visées

- Capture et filtrage de trafic réseau (filtres de capture et d'affichage).
- Analyse des protocoles TCP/IP, DNS, HTTP, TLS, ICMP, ARP.
- Établissement d'une baseline de trafic normal.
- Identification d'anomalies et d'indicateurs de compromission dans une capture.

## Prérequis

- Notions de base TCP/IP.
- Domaine [00-Environment](../00-Environment/README.md) opérationnel (labo réseau isolé).

## Structure des laboratoires

```text
01-Wireshark/
├── 01-Labs/
│   └── LAB-NN-Nom-Descriptif/
│       ├── README.md
│       ├── Analysis.md
│       ├── Evidence.md
│       ├── Lessons-Learned.md
│       └── Topology.drawio
├── 02-PCAP-Files/
├── 03-Evidence/
├── 04-Reports/
├── 05-Diagrams/
├── 06-Scripts/
└── 07-Resources/
```

- `02-PCAP-Files/` : fichiers de capture bruts liés aux laboratoires.
- `03-Evidence/` : preuves extraites (exports, captures d'écran).
- `04-Reports/` : rapports d'analyse finalisés.
- `05-Diagrams/` : diagrammes de topologie ou de flux.
- `06-Scripts/` : scripts d'automatisation propres à ce domaine (ex. tshark).
- `07-Resources/` : références et ressources externes utilisées.

## Convention de nommage

`LAB-NN-Nom-Descriptif`, numérotation séquentielle sur deux chiffres.

## Index des laboratoires

| Laboratoire | Objectif | Statut |
| --- | --- | --- |
| [LAB-01-Network-Traffic-Baseline](./01-Labs/LAB-01-Network-Traffic-Baseline/README.md) | Établir une référence de trafic réseau normal | 🟡 In Progress |
| LAB-02 — ARP and ICMP Analysis | Analyse des protocoles ARP et ICMP | ⚪ Planned |
| LAB-03 — DNS Traffic Analysis | Analyse du trafic DNS | ⚪ Planned |
| LAB-04 — TCP Connection Analysis | Analyse des connexions TCP | ⚪ Planned |
| LAB-05 — HTTP and TLS Analysis | Analyse HTTP et TLS | ⚪ Planned |
| LAB-06 — Suspicious Network Traffic | Détection de trafic suspect | ⚪ Planned |
| LAB-07 — Incident Investigation with PCAP | Investigation d'incident à partir d'un PCAP | ⚪ Planned |

Légende : ⚪ Planned · 🟡 In Progress · 🟢 Completed

## Templates communs

Voir [templates/](../templates/README.md) pour les gabarits réutilisables.
