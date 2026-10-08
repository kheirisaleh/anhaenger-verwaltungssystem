# ADR-004: State Management, Abhängigkeiten und Navigation

> Status: Akzeptiert
> Datum: 08.10.2026

## 1. Kontext

Vor Beginn der parallelen Feature-Entwicklung müssen State Management, die Bereitstellung von Repositories und die Navigation einheitlich festgelegt sein. Sonst führt jede Person oder KI-Session ein eigenes Muster ein.

## 2. Entscheidung

### 2.1 State Management: Flutter-Bordmittel

- Zustand einer Seite liegt in einem **Controller**, der `ChangeNotifier` erweitert. Ablage: `lib/features/<feature>/application/<name>_controller.dart`.
- Die Oberfläche hört mit `ListenableBuilder` auf den Controller.
- Daten aus der Datenbank kommen als `Stream` aus dem Repository und werden im Controller oder direkt mit `StreamBuilder` verarbeitet.
- Kein zusätzliches Paket (kein Riverpod, kein provider, kein BLoC).

### 2.2 Abhängigkeiten: `AppScope`

- `AppDependencies` (`lib/shared/app_dependencies.dart`) erzeugt Datenbank und alle Repositories genau einmal.
- `AppScope.of(context)` liefert sie im Widget-Baum.
- Controller bekommen Repositories über den Konstruktor, nicht über `AppScope`. Dadurch sind sie ohne Widgets testbar.
- Der angemeldete Benutzer liegt in `AppDependencies.currentUser` (`ValueNotifier<AppUser?>`).

### 2.3 Navigation: ohne Router-Paket

- Hauptbereiche über die `NavigationPane` in `lib/shared/app_shell.dart`.
- Detailseiten mit `Navigator.of(context).push(FluentPageRoute<void>(builder: ...))`.
- Dialoge mit `showDialog` und `AppDialog`.
- Kein `go_router`. Deep Links und URLs sind für eine Desktop-Anwendung ohne Web-Ziel nicht nötig.

## 3. Muster

```dart
class TrailerListController extends ChangeNotifier {
  TrailerListController(this._trailers);

  final TrailerRepository _trailers;
  TrailerStatus? _status;

  TrailerStatus? get status => _status;

  Stream<List<Trailer>> get trailers =>
      _trailers.watchAll(query: TrailerQuery(status: _status));

  void filterByStatus(TrailerStatus? status) {
    _status = status;
    notifyListeners();
  }
}
```

Die Seite (ein `StatefulWidget`) erzeugt den Controller einmalig in `didChangeDependencies` mit `AppScope.of(context).trailers` und gibt ihn in `dispose` frei. In `initState` ist `AppScope.of` noch nicht verfügbar.

## 4. Konsequenzen

- Keine neue Dependency.
- Weniger Konzepte für Anfänger. Für KI-Assistenten ist das Muster eindeutig.
- Bei deutlich wachsender Komplexität kann später auf Riverpod gewechselt werden. Das wäre ein eigenes ADR.
