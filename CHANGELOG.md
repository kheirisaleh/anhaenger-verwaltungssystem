# Changelog

Alle relevanten Änderungen am Projekt werden hier festgehalten.

## [Unreleased]

### Added (Verwaltungsoberfläche)

- Vollständige Seiten für Dashboard, Anhänger, Schäden, Kunden, Verträge und Einstellungen
- Detailseiten für Anhänger und Kunden, Fotogalerie, Statusverlauf
- Vertragsablauf in der Oberfläche: Übergabe, Rücknahme, Stornierung
- Archivieren und Wiederherstellen von Anhängern und Kunden
- Datensicherung (Export/Import) und CSV-Export
- Beispieldaten beim ersten Start
- Komponenten `AppDateTimeField`, `AppCheckbox`, `AppSearchField`, `AppForm`, `AppMessages`, Diagramme und Kennzahl-Kacheln
- ADR-005 Kennzahlen, Datensicherung und Bedienkonzept
- Bedien-Test aller Bereiche mit Beispieldaten

### Added

- Projektstruktur mit `docs/` und `.github/`
- Projektkontext, Governance und Projektstatus
- Anforderungsdokument und Review der Anforderungen
- ADR-001 Technology Stack, ADR-002 Admin-Umfang und Benutzer, ADR-003 Drift, ADR-004 State Management und Navigation
- Vorlagen für Issues und Pull Requests
- Design System mit HTML-Vorschau und Komponenten `AppButton`, `AppCard`, `AppTextField`, `AppSelectField`, `AppDataTable`, `AppDialog`, `AppIconButton`, `AppStatusBadge`, Lade-, Leer- und Fehlerzustand
- Flutter-Gerüst für Windows und macOS
- Datenbankmodell (`DATABASE_MODEL.md`) und Drift-Datenbank mit acht Tabellen und Startdaten
- Repositories für Benutzer, Anhängertypen, Anhänger, Kunden, Verträge, Schäden und Fotos mit Fachregeln aus ADR-002
- Benutzerauswahl beim Start, Navigation mit Platzhalterseiten
- Tests für Datenbank, Repositories, Formate und Navigation
- GitHub Actions: Analyze, Test und Windows-Build
- `AGENTS.md`, `CLAUDE.md`, `ARCHITECTURE.md`

### Changed

- UI-Texte mit echten Umlauten
- Vertragsstatus um „Geplant“ erweitert

### Fixed

- Datumsformatierung stürzte ohne `initializeDateFormatting` ab
- Alle Seiten zeigten den Leertext der Anhängerliste
- Fehlerzustand zeigte die Fehlermeldung doppelt
