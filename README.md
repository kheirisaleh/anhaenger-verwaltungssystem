# Anhängerverwaltung

Offline desktop administration system for trailer rental management, built with Flutter and Dart.

Schulprojekt: Verwaltungsoberfläche für eine Anhängervermietung. Die Anwendung läuft vollständig offline, mit lokaler SQLite-Datenbank, lokalen Fotos und lokalem Backup.

## Status

Phase: **Initial Planning**. Es wird noch keine Feature-Entwicklung betrieben. Zuerst werden die vier Foundation-Aufgaben abgeschlossen:

1. Database Design
2. Scenario-Based Wireframes
3. Design System
4. Development & AI Guidelines

Details: [docs/project/PROJECT_STATUS.md](docs/project/PROJECT_STATUS.md)

## Technologie

- Flutter und Dart
- `fluent_ui` für das Windows-Erscheinungsbild
- SQLite (lokal), Zugriff über eine Repository-Schicht
- Zielplattform: Windows, Entwicklung auf macOS

Begründung: [docs/decisions/ADR-001-technology-stack.md](docs/decisions/ADR-001-technology-stack.md)

## Projektstruktur

```text
.
├── .github/                 Issue- und Pull-Request-Vorlagen
├── docs/
│   ├── requirements/        Anforderungsdokument
│   ├── architecture/        Architektur (ARCHITECTURE.md folgt)
│   ├── database/            Datenbankmodell (DATABASE_MODEL.md folgt)
│   ├── wireframes/          User Flows und Wireframes
│   ├── design-system/       Design System (DESIGN_SYSTEM.md folgt)
│   ├── decisions/           Technische Entscheidungen (ADRs)
│   └── project/             Projektkontext, Governance und Status
├── CHANGELOG.md
└── README.md
```

Der Flutter-Code (`lib/` usw.) wird erst angelegt, wenn die Foundation-Aufgaben abgenommen sind.

## Wichtige Dokumente

- [Project Context and Governance](docs/project/PROJECT_CONTEXT_AND_GOVERNANCE.md): zentrale Referenz für Team und KI-Assistenten
- [Project Status](docs/project/PROJECT_STATUS.md): aktueller Stand und Aufgaben
- [Anforderungsdokument](docs/requirements/Anforderungsdokument_Anhaenger-Verwaltungssystem.pdf)
- [ADR-001 Technology Stack](docs/decisions/ADR-001-technology-stack.md)

## Zusammenarbeit

- Eine Aufgabe, ein Issue, eine verantwortliche Person
- Arbeit auf Branches, Integration über Pull Requests, kein direktes Arbeiten auf `main`
- Branch-Namen in der Foundation-Phase: `docs/database-design`, `docs/wireframes`, `docs/design-system`, `docs/development-guidelines`
- Commit-Nachrichten: `feat:`, `fix:`, `refactor:`, `test:`, `docs:`, `chore:`, `build:`
- Technische Entscheidungen mit Auswirkung auf mehrere Features werden als ADR in `docs/decisions/` dokumentiert
