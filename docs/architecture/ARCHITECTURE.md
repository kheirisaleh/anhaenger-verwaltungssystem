# Architektur

> Verbindlich für alle Features. Ordnerstruktur: `PROJECT_STRUCTURE.md`.
> Entscheidungen: ADR-002 (Umfang, Benutzer), ADR-003 (Drift), ADR-004 (State, Navigation).

## 1. Schichten

```text
features/<feature>/presentation   Seiten und Widgets
            │
features/<feature>/application    Controller (ChangeNotifier), Eingabevalidierung
            │
data/repositories                 Schnittstellen (abstract interface class)
            │
data/repositories/drift           Implementierungen, Fachregeln, Transaktionen
            │
core/database + data/sources      Drift-Datenbank, Dateiablage für Fotos
            │
SQLite-Datei + images/
```

- Eine Schicht kennt nur die darunterliegende.
- Widgets und Controller kennen nur die **Schnittstellen** (`TrailerRepository`), nie die Drift-Klassen (`DriftTrailerRepository`, `TrailerRow`).
- Drift-spezifische Typen verlassen `data/repositories/drift/` und `core/database/` nicht.

## 2. Wo gehört welche Regel hin?

| Regel | Ort | Beispiel |
|---|---|---|
| Pflichtfeld leer, E-Mail-Format | Controller (application) | „Dieses Feld ist erforderlich.“ |
| Fachregel, die Daten betrifft | Repository-Implementierung | Überschneidung von Verträgen, „Vermietet“ nur durch Übergabe |
| Datenintegrität | Datenbank (Constraints) | Fremdschlüssel, `CHECK (end_at > start_at)` |

Fachregeln liegen bewusst im Repository und nicht im Controller. Dadurch gelten sie für jede Oberfläche gleich und laufen in einer Transaktion. Verstöße werden als `RepositoryException` mit einem `RepositoryError` gemeldet. Die Oberfläche zeigt `exception.message` an. Der Text kommt aus `AppStrings`.

## 3. Datenfluss

```text
Repository.watchAll()  ──Stream──>  StreamBuilder / Controller  ──>  Widget
Widget  ──Aktion──>  Controller  ──>  Repository.create/update/...
                                          │
                                   Datenbank ändert sich
                                          │
                     Drift aktualisiert alle betroffenen Streams automatisch
```

Nach dem Speichern muss nichts manuell neu geladen werden.

## 4. Modelle

- `lib/data/models/` enthält unveränderliche Klassen (`Trailer`, `Customer`, `RentalContract` …) und die Enums.
- Für Anlegen und Bearbeiten gibt es `*Draft`-Klassen ohne `id` und Zeitstempel.
- Geldbeträge sind `int` in Cent. Anzeige mit `AppFormats.currencyFromCents`.
- Zeitpunkte sind `DateTime`. Anzeige mit `AppFormats.date` und `AppFormats.dateTime`.

## 5. Benutzer und Protokoll

- Beim Start wählt die Person ihren Namen (`UserSelectionPage`). Der Benutzer liegt in `AppScope.of(context).currentUser`.
- Methoden, die etwas protokollieren, verlangen `userId` (z. B. `changeStatus`, `handOver`, `create` bei Verträgen und Schäden).

## 6. Offline

- Keine Netzwerkzugriffe. Keine Pakete, die zur Laufzeit Internet benötigen.
- Datenbank und Fotos liegen im App-Datenordner (`getApplicationSupportDirectory`), unter Windows z. B. `%APPDATA%\de.anhaengerverwaltung\anhaenger_verwaltungssystem\`.

## 7. Tests

| Was | Wie |
|---|---|
| Repositories und Fachregeln | `test/data/`, In-Memory-Datenbank aus `test/helpers/test_database.dart` |
| Controller | mit echten Repositories auf In-Memory-Datenbank, ohne Widgets |
| Widgets | `testWidgets`, nur für wichtige Abläufe |

Jede neue Fachregel bekommt mindestens einen Test.
