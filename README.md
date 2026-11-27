<!-- BEGIN NEOXIX REPOSITORY PRESENTATION -->
<p align="left">
  <img src="README-banner.svg" alt="NEOXIX SOC Academy — Observer les signaux. Comprendre les incidents. Progresser." width="1200" />
</p>

<p align="left"><strong>Parcours pratique et documentation de laboratoires en cybersécurité défensive.</strong></p>

<p align="left"><img alt="Statut : In development" src="https://img.shields.io/static/v1?label=Statut&amp;message=In%20development&amp;color=A7412D&amp;style=flat-square" /></p>

<p align="left"><a href="01-Wireshark">Wireshark</a> &nbsp; / &nbsp; <a href="02-Wazuh">Wazuh</a> &nbsp; / &nbsp; <a href="ROADMAP.md">Feuille de route</a></p>
<!-- END NEOXIX REPOSITORY PRESENTATION -->

---

<div align="center">

# 🛡️ Neoxix SOC Academy

<img src="https://readme-typing-svg.demolab.com?font=Fira+Code&weight=600&size=24&pause=1000&color=2F81F7&center=true&vCenter=true&width=850&lines=Security+Operations+Center+Training;Blue+Team+%7C+SIEM+%7C+Threat+Hunting;Network+Analysis+%7C+Incident+Response;Formation+SOC+%7C+Cybers%C3%A9curit%C3%A9+d%C3%A9fensive" alt="Bannière animée Neoxix SOC Academy" />

<br>

[![GitHub organization](https://img.shields.io/badge/GitHub-Neoxix--Inc-181717?logo=github)](https://github.com/Neoxix-Inc)
![Project status](https://img.shields.io/badge/Status-In%20Development-orange)
![Focus](https://img.shields.io/badge/Focus-Blue%20Team-0078D4)
![License](https://img.shields.io/badge/License-MIT-green)
![Language](https://img.shields.io/badge/Documentation-FR%20%7C%20EN-blue)

**Français · English**

[🇫🇷 Version française](#-version-française) • [🇬🇧 English version](#-english-version)

</div>

---

# 🇫🇷 Version française

## Présentation

**Neoxix SOC Academy** est un portfolio technique professionnel consacré à l’administration réseau, à l’administration système, à la cybersécurité défensive et aux opérations d’un centre opérationnel de sécurité — **SOC**.

Le dépôt documente une progression pratique à travers des laboratoires réalistes, des analyses techniques, des fichiers PCAP, des scripts, des diagrammes, des rapports d’incident et des preuves de compétences.

## Objectifs professionnels

Ce projet vise à démontrer des compétences concrètes pour des postes tels que :

* analyste SOC ;
* analyste en cybersécurité ;
* administrateur réseau ;
* administrateur système ;
* technicien en sécurité informatique ;
* analyste Blue Team ;
* analyste en réponse aux incidents.

L’objectif principal est de construire un portfolio vérifiable pouvant être présenté directement à des recruteurs avant **décembre 2026**.

## Technologies et disciplines

| Domaine                | Technologies et compétences                               |
| ---------------------- | --------------------------------------------------------- |
| Analyse réseau         | Wireshark, PCAP, TCP/IP, DNS, HTTP, TLS, ICMP, ARP        |
| SIEM                   | Wazuh, Splunk                                             |
| Sécurité des endpoints | CrowdStrike, Sysmon, Microsoft Defender                   |
| Détection des menaces  | IOC, règles de détection, corrélation d’événements        |
| Threat Hunting         | Hypothèses de chasse, recherche d’anomalies, MITRE ATT&CK |
| Réponse aux incidents  | Identification, confinement, éradication, récupération    |
| Blue Team              | Surveillance, analyse, défense et documentation           |
| Automatisation         | PowerShell, scripts, GitHub Actions                       |
| Réseau                 | Cisco CCNA 200-301                                        |
| Sécurité réseau        | Fortinet NSE 4                                            |

## Technologies utilisées · Technologies used

<div align="center">

<img src="https://cdn.simpleicons.org/wireshark/1679A7" alt="Wireshark" width="55" height="55" title="Wireshark"/>
&nbsp;&nbsp;
<img src="./docs/assets/logos/security/wazuh.svg" alt="Wazuh" width="55" height="55" title="Wazuh"/>
&nbsp;&nbsp;
<img src="https://cdn.simpleicons.org/splunk/000000" alt="Splunk" width="55" height="55" title="Splunk"/>
&nbsp;&nbsp;
<img src="https://cdn.simpleicons.org/crowdstrike/FC0000" alt="CrowdStrike" width="55" height="55" title="CrowdStrike"/>
&nbsp;&nbsp;
<img src="https://cdn.simpleicons.org/windows/0078D4" alt="Windows" width="55" height="55" title="Windows"/>
&nbsp;&nbsp;
<img src="./docs/assets/logos/tools/powershell.svg" alt="PowerShell" width="55" height="55" title="PowerShell"/>
&nbsp;&nbsp;
<img src="https://cdn.simpleicons.org/cisco/1BA0D7" alt="Cisco" width="55" height="55" title="Cisco"/>
&nbsp;&nbsp;
<img src="https://cdn.simpleicons.org/fortinet/EE3124" alt="Fortinet" width="55" height="55" title="Fortinet"/>
&nbsp;&nbsp;
<img src="https://cdn.simpleicons.org/github/181717" alt="GitHub" width="55" height="55" title="GitHub"/>
&nbsp;&nbsp;
<img src="https://cdn.simpleicons.org/git/F05032" alt="Git" width="55" height="55" title="Git"/>
&nbsp;&nbsp;
<img src="https://cdn.simpleicons.org/visualstudiocode/007ACC" alt="Visual Studio Code" width="55" height="55" title="Visual Studio Code"/>
&nbsp;&nbsp;
<img src="https://cdn.simpleicons.org/linux/FCC624" alt="Linux" width="55" height="55" title="Linux"/>

<br><br>

**Wireshark · Wazuh · Splunk · CrowdStrike · Windows · PowerShell · Cisco · Fortinet · GitHub · Git · Visual Studio Code · Linux**

</div>

## Structure du dépôt

```text
neoxix-soc-academy
├── .github
├── 00-Environment
├── 01-Wireshark
├── 02-Wazuh
├── 03-Splunk
├── 04-CrowdStrike
├── 05-Incident-Response
├── 06-Threat-Hunting
├── 07-Final-Projects
├── 08-Portfolio
├── 09-CCNA
├── 10-Fortinet-NSE4
├── docs
├── diagrams
├── scripts
├── templates
├── CHANGELOG.md
├── LICENSE
├── README.md
└── ROADMAP.md
```

## Méthodologie des laboratoires

Chaque laboratoire doit inclure :

* les objectifs techniques ;
* les compétences évaluées ;
* les prérequis ;
* la topologie réseau ;
* la procédure d’exécution ;
* les commandes utilisées ;
* les filtres Wireshark ou requêtes SIEM ;
* l’analyse des résultats ;
* les preuves et captures d’écran ;
* les indicateurs de compromission ;
* les difficultés rencontrées ;
* les leçons apprises ;
* les recommandations de sécurité.

## Premier module — Wireshark

Le premier module porte sur l’analyse réseau avec Wireshark.

### Premier laboratoire

```text
LAB-01-Network-Traffic-Baseline
```

Ce laboratoire permettra :

* de capturer du trafic réseau normal ;
* d’identifier les protocoles principaux ;
* d’analyser les communications entre les hôtes ;
* de créer une référence de trafic légitime ;
* de préparer la détection de comportements suspects.

## Progression du projet

| Phase | Module                | État              |
| ----: | --------------------- | ----------------- |
|     1 | Architecture du dépôt | 🟡 En cours       |
|     2 | Wireshark             | 🟡 En préparation |
|     3 | Wazuh                 | ⚪ Planifié        |
|     4 | Splunk                | ⚪ Planifié        |
|     5 | CrowdStrike           | ⚪ Planifié        |
|     6 | Incident Response     | ⚪ Planifié        |
|     7 | Threat Hunting        | ⚪ Planifié        |
|     8 | Projets SOC finaux    | ⚪ Planifié        |
|     9 | CCNA                  | ⚪ Planifié        |
|    10 | Fortinet NSE4         | ⚪ Planifié        |

Consultez le fichier [ROADMAP.md](ROADMAP.md) pour suivre l’évolution détaillée du projet.

## Sécurité et confidentialité

Ce dépôt ne doit jamais contenir :

* de mots de passe ;
* de jetons d’accès ;
* de clés privées ;
* de secrets d’API ;
* de certificats confidentiels ;
* de captures réseau provenant d’un environnement de production ;
* de données personnelles sensibles ;
* d’informations internes appartenant à une organisation.

Toutes les données publiées doivent provenir d’environnements de laboratoire contrôlés et autorisés.

---

# 🇬🇧 English version

## Overview

**Neoxix SOC Academy** is a professional technical portfolio focused on network administration, system administration, defensive cybersecurity and Security Operations Center activities.

The repository documents practical progression through realistic laboratories, technical analyses, PCAP files, scripts, diagrams, incident reports and verifiable evidence of technical skills.

## Professional objectives

This project is designed to demonstrate practical competencies for roles such as:

* SOC analyst;
* cybersecurity analyst;
* network administrator;
* system administrator;
* information security technician;
* Blue Team analyst;
* incident response analyst.

The main objective is to build a verifiable technical portfolio that can be presented directly to recruiters before **December 2026**.

## Technologies and disciplines

| Domain            | Technologies and skills                             |
| ----------------- | --------------------------------------------------- |
| Network analysis  | Wireshark, PCAP, TCP/IP, DNS, HTTP, TLS, ICMP, ARP  |
| SIEM              | Wazuh, Splunk                                       |
| Endpoint security | CrowdStrike, Sysmon, Microsoft Defender             |
| Threat detection  | IOC, detection rules, event correlation             |
| Threat hunting    | Hunting hypotheses, anomaly detection, MITRE ATT&CK |
| Incident response | Identification, containment, eradication, recovery  |
| Blue Team         | Monitoring, investigation, defense and reporting    |
| Automation        | PowerShell, scripting, GitHub Actions               |
| Networking        | Cisco CCNA 200-301                                  |
| Network security  | Fortinet NSE 4                                      |

## Repository structure

```text
neoxix-soc-academy
├── .github
├── 00-Environment
├── 01-Wireshark
├── 02-Wazuh
├── 03-Splunk
├── 04-CrowdStrike
├── 05-Incident-Response
├── 06-Threat-Hunting
├── 07-Final-Projects
├── 08-Portfolio
├── 09-CCNA
├── 10-Fortinet-NSE4
├── docs
├── diagrams
├── scripts
├── templates
├── CHANGELOG.md
├── LICENSE
├── README.md
└── ROADMAP.md
```

## Laboratory methodology

Each laboratory must include:

* technical objectives;
* evaluated skills;
* prerequisites;
* network topology;
* implementation procedure;
* commands used;
* Wireshark filters or SIEM queries;
* result analysis;
* screenshots and technical evidence;
* indicators of compromise;
* encountered difficulties;
* lessons learned;
* security recommendations.

## First module — Wireshark

The first module focuses on network traffic analysis using Wireshark.

### First laboratory

```text
LAB-01-Network-Traffic-Baseline
```

This laboratory will be used to:

* capture normal network traffic;
* identify common protocols;
* analyze host communications;
* establish a legitimate traffic baseline;
* prepare for suspicious behavior detection.

## Project progress

| Phase | Module                  | Status            |
| ----: | ----------------------- | ----------------- |
|     1 | Repository architecture | 🟡 In progress    |
|     2 | Wireshark               | 🟡 In preparation |
|     3 | Wazuh                   | ⚪ Planned         |
|     4 | Splunk                  | ⚪ Planned         |
|     5 | CrowdStrike             | ⚪ Planned         |
|     6 | Incident Response       | ⚪ Planned         |
|     7 | Threat Hunting          | ⚪ Planned         |
|     8 | Final SOC projects      | ⚪ Planned         |
|     9 | CCNA                    | ⚪ Planned         |
|    10 | Fortinet NSE4           | ⚪ Planned         |

See [ROADMAP.md](ROADMAP.md) for the detailed project roadmap.

## Security and privacy

This repository must never contain:

* passwords;
* access tokens;
* private keys;
* API secrets;
* confidential certificates;
* production network captures;
* sensitive personal information;
* confidential organizational data.

All published data must originate from controlled and authorized laboratory environments.

---

## Documentation

* [Project roadmap](ROADMAP.md)
* [Project changelog](CHANGELOG.md)
* [MIT License](LICENSE)
* [Documentation index](docs/README.md)
* [Reusable templates](templates/README.md)
* [Repository rules for AI assistants](CLAUDE.md)
* [Wireshark module](01-Wireshark/README.md)
* [First Wireshark laboratory](01-Wireshark/01-Labs/LAB-01-Network-Traffic-Baseline/README.md)

## Author

**Kodjo Mathias Akah**
Founder — **Neoxix Inc.**

GitHub organization: [Neoxix-Inc](https://github.com/Neoxix-Inc)

---

<div align="center">

### Building practical cybersecurity skills, one laboratory at a time.

### Développer des compétences pratiques en cybersécurité, un laboratoire à la fois.

![Cybersecurity](https://img.shields.io/badge/Cybersecurity-Defensive-blue)
![SOC](https://img.shields.io/badge/SOC-Academy-purple)
![Blue Team](https://img.shields.io/badge/Blue%20Team-Labs-0078D4)

</div>
