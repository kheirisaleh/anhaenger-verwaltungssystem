# Anhängerverwaltung

Offline desktop administration system for trailer rental management, built with Flutter and Dart.

Schulprojekt: Verwaltungsoberfläche für eine Anhängervermietung. Die Anwendung läuft vollständig offline, mit lokaler SQLite-Datenbank, lokalen Fotos und lokalem Backup.

## Status

Phase: **Alle Verwaltungsfunktionen der Admin-Oberfläche sind benutzbar.**

| Bereich | Funktionen |
|---|---|
| Dashboard | Fuhrpark-Status, Auslastung, Umsatz und Vermietungen mit Vorjahresvergleich, offene Verträge, Ø Mietdauer, beliebteste Typen, Diagramme, CSV-Export |
| Anhänger | Liste mit Suche und Statusfilter, anlegen, bearbeiten, löschen (Archiv), wiederherstellen, Detailseite mit Status, Standort, Fotos, Schäden, Verträgen und Statusverlauf |
| Schäden | Gesamtliste und je Anhänger, Filter nach Art und Zeitraum, erfassen, bearbeiten, löschen, Fotos |
| Kunden | Liste mit Suche, anlegen, bearbeiten, löschen (Archiv), wiederherstellen, Detailseite mit Vertragshistorie |
| Verträge | Liste mit Statusfilter, anlegen, bearbeiten, übergeben, zurücknehmen, stornieren, CSV-Export |
| Einstellungen | Benutzer, Anhängertypen, Datensicherung (Export/Import), Beispieldaten |

Beim ersten Start wird eine leere Datenbank automatisch mit Beispieldaten gefüllt (Anhänger wie „BLITZ-01“, Kunden wie „Rainer Zufall“).

Details: [docs/project/PROJECT_STATUS.md](docs/project/PROJECT_STATUS.md)

## Starten

Voraussetzung: Flutter (Stable, mindestens Dart 3.11, ggf. `flutter upgrade`). Unter Windows zusätzlich Visual Studio mit „Desktopentwicklung mit C++“, unter macOS Xcode (macOS 12 oder neuer).

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run -d windows        # oder: -d macos
```

Der generierte Drift-Code (`*.g.dart`) und `pubspec.lock` liegen im Repository und werden von der CI auf `main` automatisch aktuell gehalten. Nach dem Klonen reichen deshalb `flutter pub get` und `flutter run`. `build_runner` ist nur nötig, wenn `lib/core/database/tables.dart` geändert wurde.

Prüfen vor jedem Pull Request:

```bash
dart format lib test
flutter analyze
flutter test
```


## Fertige Versionen ohne eigenen Build

Jeder Push baut über GitHub Actions eine Windows- und eine macOS-Version. Unter **Actions → CI → letzter Lauf → Artifacts** herunterladen:

- `anhaenger-verwaltung-windows`: entpacken, den ganzen Ordner kopieren, `anhaenger_verwaltungssystem.exe` starten
- `anhaenger-verwaltung-macos`: entpacken, `anhaenger_verwaltungssystem.app` starten (beim ersten Mal Rechtsklick → Öffnen, da nicht signiert)

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
