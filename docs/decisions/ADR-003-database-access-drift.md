# ADR-003: Datenbankzugriff mit Drift

> Status: Akzeptiert
> Datum: 08.10.2026
> Bezug: ADR-001, `docs/database/DATABASE_MODEL.md`

## 1. Kontext

ADR-001 legt SQLite als lokale Datenbank fest und lässt offen, ob der Zugriff über `drift` oder über `sqflite` mit `sqflite_common_ffi` erfolgt. Das Team entwickelt stark KI-gestützt. Mehrere Personen und KI-Sessions arbeiten parallel am selben Datenmodell.

## 2. Entscheidung

Der Datenbankzugriff erfolgt über **Drift** (`drift`, `drift_flutter`, Generator `drift_dev` mit `build_runner`).

## 3. Begründung

| Kriterium | Drift | sqflite |
|---|---|---|
| Fehler bei Spaltennamen und Typen | beim Kompilieren | erst zur Laufzeit |
| Ergebnis von Abfragen | typisierte Dart-Klassen | `Map<String, Object?>` |
| Migrationen | eingebaute Unterstützung | vollständig manuell |
| Reaktive Abfragen (`watch`) | eingebaut | manuell |
| Windows/macOS | über `drift_flutter`, SQLite wird mitgeliefert | zusätzlich `sqflite_common_ffi` |
| Generierungsschritt | ja (`build_runner`) | nein |

Ausschlaggebend ist die Typsicherheit: Fehler in KI-generiertem Code (falsche Spaltennamen, falsche Typen) fallen beim Kompilieren auf und nicht erst beim Öffnen eines Bildschirms.

## 4. Regeln

- Tabellen werden in `lib/core/database/tables.dart` definiert, die Datenbank in `lib/core/database/app_database.dart`.
- Generierte Dateien (`*.g.dart`) werden nicht eingecheckt. Nach dem Klonen und nach jeder Tabellenänderung: `dart run build_runner build --delete-conflicting-outputs`.
- Drift-Zeilenklassen heißen `<Name>Row` (z. B. `TrailerRow`) und verlassen die Repository-Implementierung nie. Nach außen gibt es nur die Modelle aus `lib/data/models/`.
- Jede Schemaänderung erhöht `schemaVersion` und braucht eine Migration in `AppDatabase.migration`.
- Fremdschlüssel werden in `beforeOpen` mit `PRAGMA foreign_keys = ON` aktiviert.
- Tests verwenden eine In-Memory-Datenbank (`test/helpers/test_database.dart`).

## 5. Konsequenzen

- Neue Dependencies: `drift`, `drift_flutter`, `path`, `path_provider` sowie als Dev-Dependencies `drift_dev` und `build_runner`.
- Mindestversion Dart 3.11 (Flutter-Stable ab Anfang 2026). Ältere Flutter-Installationen müssen mit `flutter upgrade` aktualisiert werden.
- Ein zusätzlicher Build-Schritt. Er ist in README, `AGENTS.md` und CI dokumentiert.
