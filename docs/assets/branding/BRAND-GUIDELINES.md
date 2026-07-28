# Neoxix Brand Guidelines

> Official visual identity and documentation standards for all Neoxix-Inc repositories.

**Version:** 1.0.0  
**Status:** Draft  
**Last Updated:** July 2026

---
## 1. Design Principles

The Neoxix visual identity is built around five core principles.

### Professional

Every repository must look like an enterprise-grade project suitable for recruiters, clients, and technical teams.

### Consistent

All repositories under the **Neoxix-Inc** organization must share the same visual language, including colors, icons, badges, layouts, and documentation structure.

### Technical

Documentation should prioritize clarity, reproducibility, diagrams, screenshots, command examples, and technical accuracy.

### Accessible

Content must remain readable on desktop and mobile devices, in both GitHub Light and GitHub Dark themes.

### Bilingual

All public-facing documentation must be written in both **French** and **English** whenever practical.

---
## 2. Official Color Palette

The Neoxix visual identity uses a modern cybersecurity-inspired palette designed for both light and dark themes.

| Color | Hex | Usage |
|-------|------|------|
| Neoxix Blue | `#0F62FE` | Primary brand color |
| SOC Cyan | `#00C2FF` | SOC dashboards, links, highlights |
| Success Green | `#24A148` | Success states, completed labs |
| Warning Orange | `#FF832B` | Warnings, work in progress |
| Critical Red | `#DA1E28` | Alerts, incidents, failed checks |
| Dark Background | `#161616` | Dark mode backgrounds |
| Light Background | `#F4F4F4` | Light mode backgrounds |
| White | `#FFFFFF` | Text on dark backgrounds |
| Gray | `#8D8D8D` | Secondary information |

### Color Usage Rules

- Blue represents networking, cloud infrastructure and enterprise technologies.
- Cyan represents SOC operations and cybersecurity.
- Green indicates successful deployments and completed objectives.
- Orange highlights work in progress or warnings.
- Red is reserved exclusively for critical security events or failures.
- Avoid introducing additional colors unless officially added to this guide.

---

## 3. Logo and Brand Assets

### Primary Logo

The official Neoxix logo is the primary visual identifier for all repositories and documentation.

Rules:

- Always use the original SVG whenever possible.
- Never stretch, distort, rotate, or recolor the logo.
- Maintain sufficient clear space around the logo.
- Use transparent backgrounds whenever possible.

### Repository Banner

Every public repository must include a custom banner located in:

```text
docs/assets/branding/banner.svg
```

The banner should include:

- Repository title
- Project subtitle
- Official Neoxix logo
- Consistent color palette
- Optional animated SVG elements
- Light and Dark theme compatibility

### Technology Logos

Technology logos must be stored locally inside:

```text
docs/assets/logos/
```

They must:

- use SVG whenever available;
- originate from official vendor resources or approved open-source assets;
- never be hot-linked directly from third-party websites inside production documentation.

### Favicon

Future documentation websites must use the official Neoxix favicon.

### Repository Icons

Each repository may define its own visual identity while respecting the Neoxix design language.

Examples:

- 🛡️ SOC Academy
- 🏠 HomeLab
- 🤖 AI Platform
- ☁️ Cloud
- 🌐 Networking
- 📚 Knowledge Base

---