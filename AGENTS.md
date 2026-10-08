# AGENTS.md

Arbeitsregeln für KI-Assistenten (Claude Code, Codex, Cursor, Copilot usw.) in diesem Repository.
Diese Datei ist kurz gehalten und verweist auf die verbindlichen Dokumente. Bei Widerspruch gelten die verlinkten Dokumente.

## Projekt in einem Satz

Offline-Desktop-Verwaltungsoberfläche für eine Anhängervermietung (Schulprojekt). Flutter/Dart, `fluent_ui`, lokales SQLite, Zielplattform Windows, Entwicklung auf macOS. UI-Sprache Deutsch.

## Vor jeder Aufgabe lesen

| Aufgabe betrifft | Dokument |
|---|---|
| immer | `docs/project/PROJECT_CONTEXT_AND_GOVERNANCE.md` (insb. §12, §23, §24) |
| aktueller Stand, Phase | `docs/project/PROJECT_STATUS.md` |
| Ordner, Schichten, Imports | `docs/architecture/PROJECT_STRUCTURE.md` |
| jede UI | `docs/design-system/DESIGN_SYSTEM.md` |
| fachliche Anforderungen | `docs/requirements/` (PDF und `REQUIREMENTS_REVIEW.md`) |
| Technologie | `docs/decisions/ADR-*.md` |

## Aktuelle Phase

**Foundation-Phase.** Es wird noch keine Feature-Logik implementiert (`PROJECT_STATUS.md` §13).
Erlaubt sind Dokumentation, Design-System-Komponenten unter `lib/core/design/` und Aufräumarbeiten am Gerüst.
Wenn eine Aufgabe Feature-Code verlangt: kurz darauf hinweisen und nachfragen.

## Befehle

```bash
flutter pub get
flutter analyze            # muss ohne Fehler und Warnungen laufen
dart format .
flutter test
flutter run -d macos       # lokale Entwicklung
flutter build windows      # nur auf Windows bzw. Windows-CI-Runner
```

## Harte Regeln

1. **Offline.** Keine Netzwerkaufrufe, keine Cloud-Dienste, keine externen Bild-URLs. Fotos und Datenbank liegen im lokalen App-Datenordner.
2. **Schichten.** `presentation -> application -> repository -> source -> SQLite`. Widgets greifen nie direkt auf die Datenbank zu. Ein Feature importiert kein anderes Feature. `core/` importiert kein Feature.
3. **Design System.** Keine rohen Farben, Abstände, Radien oder `TextStyle`s. Nur `AppColors`, `AppSpacing`, `AppRadius`, `AppText`, `AppIcons`. Keine `fluent_ui`-Basis-Widgets (`Button`, `TextBox`, `ContentDialog`) im Feature-Code, sondern die `App*`-Komponenten aus `lib/core/design/widgets/`.
4. **Texte.** Alle UI-Texte stehen in `lib/core/constants/app_strings.dart`. Keine hartcodierten Strings in Widgets. Standardtexte aus `DESIGN_SYSTEM.md` §9 wörtlich übernehmen.
5. **Code-Stil.** Bezeichner auf Englisch. Keine Kommentare und keine Emojis im Code (`DESIGN_SYSTEM.md` §0). Lint-Regeln aus `analysis_options.yaml` einhalten (u. a. single quotes, trailing commas, `const`, `final`-Locals).
6. **Formate.** Datum `TT.MM.JJJJ`, Beträge `1.234,50 Euro`, beides über `lib/core/formatting/app_formats.dart`.
7. **Kleine Änderungen.** Nur die Dateien ändern, die die Aufgabe betrifft. Keine Umbauten an fremden Features „nebenbei“.

## STOP: erst fragen, nicht selbst entscheiden

Folgende Punkte sind laut Governance §23 **offen** und dürfen nicht von einer KI-Session festgelegt werden:

- neue Dependency in `pubspec.yaml` (auch Drift, sqflite, Provider, Riverpod, go_router …)
- Drift vs. `sqflite + sqflite_common_ffi`
- State-Management-Lösung und Routing
- Datenbankschema, Migrationen, Backup-Format
- Änderungen an Design-Tokens oder neue Komponentenarten
- Branch-Strategie, CI/CD, Lizenz

Vorgehen: Vorschlag mit Begründung formulieren und, wenn das Team zustimmt, als ADR in `docs/decisions/ADR-NNN-<thema>.md` dokumentieren.

## Git

- Nie direkt auf `main` arbeiten. Branches: `docs/<thema>`, `feature/<thema>`, `fix/<kurzbeschreibung>`, `chore/<thema>`.
- Commits im Conventional-Commit-Stil: `feat:`, `fix:`, `refactor:`, `test:`, `docs:`, `chore:`, `build:`. Englisch, Imperativ, klein geschrieben.
- Ein Thema pro Pull Request. PR-Vorlage `.github/PULL_REQUEST_TEMPLATE.md` vollständig ausfüllen.
- Nicht pushen, keine PRs erstellen und nichts mergen ohne ausdrückliche Anweisung.

## Definition of Done

`flutter analyze` sauber, `flutter test` grün, Design-System-Checkliste (`DESIGN_SYSTEM.md` §10) erfüllt, betroffene Doku und `CHANGELOG.md` aktualisiert.
