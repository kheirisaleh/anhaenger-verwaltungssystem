# Projektstruktur

> Verbindliche Ordnerstruktur der Flutter-Anwendung.
> Neue Dateien werden in die passende bestehende Ebene eingeordnet, nicht daneben.

## Ordner

```text
lib/
├── main.dart                     Einstiegspunkt
├── core/                         Querschnitt, von allen Features nutzbar
│   ├── constants/                AppStrings, feste Oberflaechentexte
│   ├── database/                 lokaler SQLite-Zugang
│   ├── design/                   Design System
│   │   ├── app_colors.dart
│   │   ├── app_typography.dart
│   │   ├── app_spacing.dart
│   │   ├── app_icons.dart
│   │   ├── app_theme.dart
│   │   └── widgets/              AppButton, AppCard, AppTextField, ...
│   └── formatting/               Datums- und Betragsformate
├── data/
│   ├── models/                   Entitaeten und Enums
│   ├── repositories/             Schnittstellen und Implementierungen
│   └── sources/                  konkrete Datenquellen
├── features/                     je Feature Presentation und Application
│   ├── dashboard/
│   ├── trailers/
│   ├── damages/
│   ├── customers/
│   ├── contracts/
│   └── settings/
└── shared/                       app-weite Huelle und Navigation
```

## Schichtregel

```text
presentation  ->  application  ->  repository  ->  source  ->  SQLite
```

Eine Schicht kennt nur die naechste darunter. Widgets greifen nie direkt auf die Datenbank zu.

## Abhaengigkeitsregeln

- `features/` darf `core/` und `data/` nutzen.
- `core/` darf kein Feature importieren.
- Ein Feature importiert kein anderes Feature; gemeinsame Teile wandern nach `core/` oder `shared/`.
- Jede Oberflaeche nutzt die Komponenten aus `core/design/widgets/`.

## Projekt initialisieren

Die plattformspezifischen Ordner und `pubspec.yaml` werden nicht von Hand angelegt. Im Wurzelverzeichnis ausfuehren:

```bash
flutter create --platforms=windows,macos --org de.anhaengerverwaltung .
flutter pub add fluent_ui intl
flutter pub add --dev flutter_lints
flutter analyze
```

`flutter create` ergaenzt nur fehlende Dateien und ueberschreibt die vorhandene `lib/`-Struktur nicht. Danach `lib/main.dart` pruefen, falls der Befehl eine Vorlage angelegt hat.
