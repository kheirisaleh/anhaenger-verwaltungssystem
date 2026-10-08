# Projektstruktur

> Verbindliche Ordnerstruktur der Flutter-Anwendung.
> Neue Dateien werden in die passende bestehende Ebene eingeordnet, nicht daneben.
> Schichten und Regeln: `ARCHITECTURE.md`.

## Ordner

```text
lib/
├── main.dart                         Einstiegspunkt
├── core/                             Querschnitt, von allen Features nutzbar
│   ├── constants/app_strings.dart    alle Oberflächentexte
│   ├── database/                     Drift: Tabellen, Datenbank, App-Datenordner
│   ├── design/                       Design System (Tokens)
│   │   └── widgets/                  App*-Komponenten
│   └── formatting/app_formats.dart   Datums- und Betragsformate
├── data/
│   ├── models/                       Modelle, Drafts, Enums
│   ├── repositories/                 Schnittstellen + RepositoryException
│   │   └── drift/                    Implementierungen mit Fachregeln
│   └── sources/                      Dateiablage für Fotos
├── features/
│   ├── dashboard/
│   ├── trailers/
│   ├── damages/
│   ├── customers/
│   ├── contracts/
│   └── settings/
│       ├── application/              Controller
│       └── presentation/             Seiten und feature-eigene Widgets
└── shared/                           App-Start, AppScope, Benutzerauswahl, Navigation

test/
├── helpers/                          In-Memory-Datenbank, Testdaten
├── core/
├── data/                             Repository- und Datenbanktests
└── widget_test.dart
```

## Abhängigkeitsregeln

- `features/` darf `core/`, `data/` und `shared/app_dependencies.dart` nutzen.
- `core/` importiert kein Feature und nichts aus `shared/`.
- Ein Feature importiert kein anderes Feature. Gemeinsame Teile wandern nach `core/` oder `shared/`.
- Nur `shared/app_dependencies.dart` und Tests importieren `data/repositories/drift/`.
- Jede Oberfläche nutzt die Komponenten aus `core/design/widgets/`.

## Dateinamen

| Art | Muster | Beispiel |
|---|---|---|
| Seite | `<name>_page.dart` | `trailer_detail_page.dart` |
| Controller | `<name>_controller.dart` | `trailer_list_controller.dart` |
| Feature-Widget | `<name>.dart` in `presentation/widgets/` | `trailer_status_card.dart` |
| Repository-Schnittstelle | `<name>_repository.dart` | `trailer_repository.dart` |
| Drift-Implementierung | `drift_<name>_repository.dart` | `drift_trailer_repository.dart` |
| Test | `<datei>_test.dart` | `trailer_repository_test.dart` |
