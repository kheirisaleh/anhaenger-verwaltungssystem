# AGENTS.md

Arbeitsregeln für KI-Assistenten (Claude Code, Codex, Cursor, Copilot usw.) in diesem Repository.
Diese Datei ist kurz gehalten und verweist auf die verbindlichen Dokumente. Bei Widerspruch gelten die verlinkten Dokumente.

## Projekt in einem Satz

Offline-Desktop-Verwaltungsoberfläche für eine Anhängervermietung (Schulprojekt). Flutter/Dart, `fluent_ui`, SQLite über Drift, Zielplattform Windows, Entwicklung auf macOS. UI-Sprache Deutsch.

## Vor jeder Aufgabe lesen

| Aufgabe betrifft | Dokument |
|---|---|
| immer | `docs/architecture/ARCHITECTURE.md` |
| Ordner, Dateinamen, Imports | `docs/architecture/PROJECT_STRUCTURE.md` |
| jede UI | `docs/design-system/DESIGN_SYSTEM.md` |
| Datenbank, Repositories | `docs/database/DATABASE_MODEL.md`, ADR-002, ADR-003 |
| Controller, Navigation | ADR-004 |
| fachliche Anforderungen | `docs/requirements/` (PDF und `REQUIREMENTS_REVIEW.md`) |
| Teamprozess | `docs/project/PROJECT_CONTEXT_AND_GOVERNANCE.md` |

## Befehle

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # nach jeder Änderung an tables.dart
dart format lib test
flutter analyze            # muss ohne Meldungen laufen
flutter test
flutter run -d macos       # bzw. -d windows
```

`*.g.dart` wird generiert und eingecheckt. Nie von Hand bearbeiten. Fehlermeldungen wie „`_$AppDatabase` not found“ bedeuten: `build_runner` ausführen. Die CI hält generierten Code, Formatierung und `pubspec.lock` auf `main` automatisch aktuell.

## Harte Regeln

1. **Offline.** Keine Netzwerkaufrufe, keine Cloud-Dienste, keine externen Bild-URLs.
2. **Schichten.** `presentation -> application -> Repository-Schnittstelle -> Drift-Implementierung -> SQLite`. Widgets und Controller kennen nur Schnittstellen aus `lib/data/repositories/`, nie `Drift*Repository`, `AppDatabase` oder `*Row`-Klassen. Ein Feature importiert kein anderes Feature.
3. **Fachregeln** stehen in den Repository-Implementierungen und werden als `RepositoryException` gemeldet. Nicht in Widgets duplizieren. Neue Fachregel = neuer Test in `test/data/`.
4. **Dialoge und Seiten** mit `showScopedDialog` / `pushScopedPage` aus `lib/shared/scoped_navigation.dart` öffnen, sonst fehlt `AppScope` (Absturz). Rückmeldungen mit `AppMessages`, Aktionen mit `runAction`.
5. **State.** `ChangeNotifier`-Controller in `features/<x>/application/`, Repositories über den Konstruktor, in der Seite aus `AppScope.of(context)`. Kein Riverpod, provider, BLoC, go_router (ADR-004).
6. **Design System.** Keine rohen Farben, Abstände, Radien oder `TextStyle`s. Nur `AppColors`, `AppSpacing`, `AppSizes`, `AppRadius`, `AppText`, `AppIcons`. Keine `fluent_ui`-Basis-Widgets (`Button`, `TextBox`, `ComboBox`, `ContentDialog`) im Feature-Code, sondern `App*`-Komponenten aus `lib/core/design/widgets/`.
7. **Texte.** Alle UI-Texte in `lib/core/constants/app_strings.dart`, mit echten Umlauten. Keine hartcodierten Strings in Widgets.
8. **Daten.** Geld als `int` in Cent, Anzeige mit `AppFormats.currencyFromCents`. Datum mit `AppFormats.date`. Aktionen mit Protokoll brauchen die `userId` aus `AppScope.of(context).currentUser`.
9. **Code-Stil.** Bezeichner Englisch. Keine Kommentare, keine Emojis im Code. Explizite Typen wie im bestehenden Code. Lint-Regeln aus `analysis_options.yaml`.
10. **Kleine Änderungen.** Nur Dateien ändern, die die Aufgabe betrifft.

## STOP: erst fragen, nicht selbst entscheiden

- neue Dependency in `pubspec.yaml`
- Änderungen an `tables.dart` (Schema), `schemaVersion`, Migrationen
- Änderungen an Design-Tokens oder neue Komponentenarten
- Änderungen an Kennzahl-Definitionen oder Backup-Format (ADR-005)
- Änderungen an ADRs, Branch-Strategie, CI

Vorgehen: Vorschlag mit Begründung formulieren und nach Zustimmung als ADR in `docs/decisions/ADR-NNN-<thema>.md` dokumentieren.

## Git

- Branches: `feature/<thema>`, `fix/<kurzbeschreibung>`, `docs/<thema>`, `chore/<thema>`.
- Commits im Conventional-Commit-Stil: `feat:`, `fix:`, `refactor:`, `test:`, `docs:`, `chore:`, `build:`. Englisch, Imperativ, klein geschrieben.
- Ein Thema pro Pull Request. PR-Vorlage `.github/PULL_REQUEST_TEMPLATE.md` vollständig ausfüllen.
- Nicht pushen, keine PRs erstellen und nichts mergen ohne ausdrückliche Anweisung.

## Definition of Done

`flutter analyze` ohne Meldungen, `flutter test` grün, CI grün, Design-System-Checkliste (`DESIGN_SYSTEM.md` §10) erfüllt, betroffene Doku und `CHANGELOG.md` aktualisiert.
