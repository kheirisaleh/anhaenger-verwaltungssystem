# Anhängerverwaltung

Offline desktop administration system for trailer rental management, built with Flutter and Dart.

Schulprojekt: Verwaltungsoberfläche für eine Anhängervermietung. Die Anwendung läuft vollständig offline, mit lokaler SQLite-Datenbank, lokalen Fotos und lokalem Backup.

## Status

Phase: **Foundation abgeschlossen, bereit für Feature-Entwicklung.**

Vorhanden: Datenbank mit allen Tabellen, Repositories mit den Fachregeln (Statusprotokoll, Übergabe/Rückgabe, Überschneidungsprüfung), Design-System-Komponenten, Benutzerauswahl, Navigation, Tests und CI. Die Seiten der Features sind noch Platzhalter.

Details: [docs/project/PROJECT_STATUS.md](docs/project/PROJECT_STATUS.md)

## Starten

Voraussetzung: Flutter (Stable, mindestens Dart 3.11). Unter Windows zusätzlich Visual Studio mit „Desktopentwicklung mit C++“, unter macOS Xcode.

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run -d windows        # oder: -d macos
```

`build_runner` erzeugt den Drift-Code (`*.g.dart`). Diese Dateien sind nicht im Repository und müssen nach dem Klonen und nach jeder Änderung an `lib/core/database/tables.dart` neu erzeugt werden.

Prüfen vor jedem Pull Request:

```bash
dart format lib test
flutter analyze
flutter test
```

Beim ersten Start wird die Datenbank mit dem Benutzer „Administrator“ und fünf Anhängertypen angelegt.

## Fertige Windows-Version ohne eigenen Build

Jeder Push baut über GitHub Actions eine Windows-Version. Unter **Actions → CI → letzter Lauf → Artifacts → `anhaenger-verwaltung-windows`** herunterladen, entpacken und `anhaenger_verwaltungssystem.exe` starten.

## Technologie

- Flutter und Dart, `fluent_ui` für das Windows-Erscheinungsbild ([ADR-001](docs/decisions/ADR-001-technology-stack.md))
- SQLite über Drift ([ADR-003](docs/decisions/ADR-003-database-access-drift.md))
- State Management mit Flutter-Bordmitteln, keine Router-Bibliothek ([ADR-004](docs/decisions/ADR-004-state-management-and-navigation.md))

## Wichtige Dokumente

| Dokument | Inhalt |
|---|---|
| [AGENTS.md](AGENTS.md) | Regeln für KI-Assistenten (auch für Menschen lesenswert) |
| [ARCHITECTURE.md](docs/architecture/ARCHITECTURE.md) | Schichten, Datenfluss, wo welche Regel hingehört |
| [PROJECT_STRUCTURE.md](docs/architecture/PROJECT_STRUCTURE.md) | Ordner und Dateinamen |
| [DATABASE_MODEL.md](docs/database/DATABASE_MODEL.md) | Tabellen, Constraints, Löschregeln |
| [DESIGN_SYSTEM.md](docs/design-system/DESIGN_SYSTEM.md) | Farben, Komponenten, Standardtexte |
| [ADR-002](docs/decisions/ADR-002-admin-scope-and-users.md) | Umfang, Benutzermodell, Vertragsablauf |
| [REQUIREMENTS_REVIEW.md](docs/requirements/REQUIREMENTS_REVIEW.md) | Lücken im Anforderungsdokument, offene Punkte |
| [PROJECT_CONTEXT_AND_GOVERNANCE.md](docs/project/PROJECT_CONTEXT_AND_GOVERNANCE.md) | Projektkontext und Zusammenarbeit |

## Zusammenarbeit

- Eine Aufgabe, ein Issue, eine verantwortliche Person
- Arbeit auf Branches, Integration über Pull Requests
- Branch-Namen: `feature/<thema>`, `fix/<thema>`, `docs/<thema>`, `chore/<thema>`
- Commit-Nachrichten: `feat:`, `fix:`, `refactor:`, `test:`, `docs:`, `chore:`, `build:`
- Technische Entscheidungen mit Auswirkung auf mehrere Features werden als ADR in `docs/decisions/` dokumentiert
