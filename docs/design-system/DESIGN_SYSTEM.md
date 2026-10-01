# DESIGN_SYSTEM.md

> Anhaenger-Verwaltungssystem — Flutter + fluent_ui
> Diese Datei zusammen mit jeder Aufgabe an die KI geben.
> Die KI darf keine eigenen Farben, Abstaende, Komponenten oder Texte erfinden.

---

## 0. Regeln (verbindlich)

1. Keine rohen Farben (`Color(0x...)`, `Colors.*`) ausserhalb dieser Datei. Immer `AppColors`.
2. Keine rohen Zahlen fuer Abstaende oder Radien. Immer `AppSpacing` / `AppRadius`.
3. Keine rohen `TextStyle`. Immer `AppText`.
4. Nie `Button`, `TextBox`, `ContentDialog` direkt im Feature-Code. Immer die `App*`-Komponenten.
5. Jede Seite hat genau denselben Aufbau (siehe Abschnitt 8).
6. Alle UI-Texte sind Deutsch. Fehler-, Lade- und Leer-Texte sind in Abschnitt 9 vorgegeben.
7. Keine neuen Dependencies. Nur `fluent_ui`.
8. Keine Kommentare, keine Emojis im Code. Variablennamen Englisch.

---

## 1. Farben

```dart
abstract final class AppColors {
  static const accent = Color(0xFF0F6CBD);
  static const accentHover = Color(0xFF115EA3);

  static const background = Color(0xFFF3F2F1);
  static const surface = Color(0xFFFFFFFF);
  static const border = Color(0xFFE1DFDD);
  static const divider = Color(0xFFEDEBE9);

  static const textPrimary = Color(0xFF201F1E);
  static const textSecondary = Color(0xFF605E5C);
  static const textDisabled = Color(0xFFA19F9D);
  static const textOnAccent = Color(0xFFFFFFFF);

  static const success = Color(0xFF107C10);
  static const warning = Color(0xFFCA5010);
  static const danger = Color(0xFFA4262C);

  static const statusAvailable = Color(0xFF107C10);
  static const statusRented = Color(0xFF0F6CBD);
  static const statusMaintenance = Color(0xFFCA5010);
  static const statusBlocked = Color(0xFF605E5C);
}
```

Nur Hellmodus. Kein Darkmode in diesem Projekt.

---

## 2. Typografie

Schriftart: Segoe UI (Systemstandard unter Windows).

```dart
abstract final class AppText {
  static const pageTitle = TextStyle(fontSize: 28, fontWeight: FontWeight.w600, color: AppColors.textPrimary);
  static const sectionTitle = TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.textPrimary);
  static const cardTitle = TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textPrimary);
  static const body = TextStyle(fontSize: 14, color: AppColors.textPrimary);
  static const bodyMuted = TextStyle(fontSize: 14, color: AppColors.textSecondary);
  static const label = TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary);
  static const caption = TextStyle(fontSize: 12, color: AppColors.textSecondary);
}
```

Pro Seite genau ein `pageTitle`.

---

## 3. Abstaende und Radien

```dart
abstract final class AppSpacing {
  static const xs = 4.0;
  static const sm = 8.0;
  static const md = 16.0;
  static const lg = 24.0;
  static const xl = 32.0;
}

abstract final class AppRadius {
  static const sm = 4.0;
  static const md = 8.0;
}
```

Feste Anwendung:

| Stelle | Wert |
|---|---|
| Seitenrand (Padding der Page) | `AppSpacing.lg` |
| Abstand zwischen Sektionen | `AppSpacing.lg` |
| Abstand zwischen Formularfeldern | `AppSpacing.md` |
| Abstand Label zu Eingabefeld | `AppSpacing.xs` |
| Padding in Karten | `AppSpacing.md` |
| Abstand zwischen Buttons | `AppSpacing.sm` |

---

## 4. Icons

Nur `FluentIcons`. Feste Zuordnung, nicht abweichen:

| Aktion | Icon |
|---|---|
| Hinzufuegen | `FluentIcons.add` |
| Bearbeiten | `FluentIcons.edit` |
| Loeschen | `FluentIcons.delete` |
| Speichern | `FluentIcons.save` |
| Suchen | `FluentIcons.search` |
| Filter | `FluentIcons.filter` |
| Zurueck | `FluentIcons.back` |
| Dashboard | `FluentIcons.view_dashboard` |
| Anhaenger | `FluentIcons.car` |
| Schaeden | `FluentIcons.warning` |
| Kunden | `FluentIcons.people` |
| Vertraege | `FluentIcons.document` |
| Einstellungen | `FluentIcons.settings` |
| Export | `FluentIcons.download` |
| Foto | `FluentIcons.photo2` |
| Standort | `FluentIcons.map_pin` |

Icongroesse: 16 in Buttons und Tabellen, 20 in der Navigation, 48 in Leerzustaenden.

---

## 5. Komponenten

Alle liegen in `lib/core/design/widgets/`.

### AppButton
Varianten: `primary`, `secondary`, `danger`, `subtle`
Hoehe 32, horizontales Padding `AppSpacing.md`, Radius `AppRadius.sm`.
Optionales fuehrendes Icon, Groesse 16, Abstand `AppSpacing.sm` zum Text.
Zustaende: normal, hover, pressed, disabled, loading (Text wird durch `ProgressRing` Groesse 16 ersetzt).
Pro Dialog oder Formular genau ein `primary`. Alles andere `secondary`.
`danger` nur fuer Loeschen.

### AppTextField
Label oberhalb in `AppText.label`, Abstand `AppSpacing.xs`.
Hoehe 32, Rahmen `AppColors.border`, Fokusrahmen `AppColors.accent`.
Fehlertext unterhalb in `AppText.caption` mit `AppColors.danger`.
Pflichtfelder: Label endet mit einem Sternzeichen.

### AppCard
Hintergrund `AppColors.surface`, Rahmen `AppColors.border`, Radius `AppRadius.md`, Padding `AppSpacing.md`.
Kein Schatten. Optionaler Titel in `AppText.cardTitle`, darunter `AppSpacing.sm`.

### AppDataTable
Kopfzeile: `AppText.label`, Hintergrund `AppColors.background`, Hoehe 36.
Datenzeile: Hoehe 40, Trennlinie `AppColors.divider`, Hover `AppColors.background`.
Zellen-Padding horizontal `AppSpacing.md`.
Zahlen und Betraege rechtsbuendig, Text linksbuendig.
Datum immer `TT.MM.JJJJ`. Betrag immer `1.234,50 Euro`.
Aktionsspalte immer ganz rechts, nur Icon-Buttons.
Keine Zebrastreifen, keine Sortierpfeile ausser bei explizit sortierbaren Spalten.

### AppDialog
Breite 480 (gross: 640). Titel `AppText.sectionTitle`, Inhalt Padding `AppSpacing.lg`.
Buttons unten rechts, Reihenfolge: links `secondary` Abbrechen, rechts `primary` Bestaetigen.
Loeschdialoge nutzen `danger` statt `primary`.

### AppStatusBadge
Nur fuer Status aus dem Datenmodell. Niemand setzt Statusfarben manuell.
Hoehe 22, horizontales Padding `AppSpacing.sm`, Radius `AppRadius.sm`, Text `AppText.caption` in Weiss.

| Status | Text | Farbe |
|---|---|---|
| available | Verfuegbar | `statusAvailable` |
| rented | Vermietet | `statusRented` |
| maintenance | In Wartung | `statusMaintenance` |
| blocked | Gesperrt | `statusBlocked` |

Vertragsstatus: Aktiv (`statusRented`), Abgeschlossen (`statusAvailable`), Storniert (`statusBlocked`).

### Navigation
`NavigationView` mit linker `NavigationPane`, Modus `open`, Breite 260.
Reihenfolge fest: Dashboard, Anhaenger, Schaeden, Kunden, Vertraege, Einstellungen.
Einstellungen immer im Fussbereich der Pane.

---

## 6. Formulare

Einspaltig, maximale Breite 560.
Reihenfolge: Pflichtfelder zuerst, optionale danach.
Aktionsleiste unten rechts: Abbrechen, dann Speichern.
Validierung erst beim Verlassen des Feldes, nicht bei jedem Tastendruck.

---

## 7. Seitenaufbau (fuer jede Seite gleich)

```text
Seitentitel (AppText.pageTitle)
Aktionsleiste rechts (Primaeraktion ganz rechts)
AppSpacing.lg
Filter-/Suchbereich (falls vorhanden)
AppSpacing.md
Inhalt (AppDataTable oder AppCard-Raster)
```

Detailseiten: links Hauptinhalt, rechts Seitenbereich mit Breite 320 fuer Status, Standort und Metadaten.

---

## 8. Leer-, Lade- und Fehlerzustaende

Jede Liste und jede Detailansicht muss alle drei Zustaende behandeln.

### AppLoadingState
Zentriertes `ProgressRing` Groesse 32, darunter `AppSpacing.md`, Text `AppText.bodyMuted`.
Text: `Daten werden geladen...`

### AppEmptyState
Zentriert: Icon Groesse 48 in `AppColors.textDisabled`, `AppSpacing.md`, Titel `AppText.cardTitle`, `AppSpacing.xs`, Beschreibung `AppText.bodyMuted`, `AppSpacing.md`, optionaler `primary` Button.

### AppErrorState
Gleicher Aufbau, Icon `FluentIcons.error` in `AppColors.danger`, Button `secondary` mit Text `Erneut versuchen`.

---

## 9. Standardtexte (nicht abweichen)

| Situation | Text |
|---|---|
| Laden | Daten werden geladen... |
| Allgemeiner Fehler | Die Daten konnten nicht geladen werden. |
| Keine Anhaenger | Keine Anhaenger vorhanden. Legen Sie den ersten Anhaenger an. |
| Keine Schaeden | Fuer diesen Anhaenger sind keine Schaeden erfasst. |
| Keine Kunden | Keine Kunden vorhanden. |
| Keine Vertraege | Keine Mietvertraege vorhanden. |
| Kein Suchergebnis | Keine Ergebnisse fuer Ihre Suche. |
| Pflichtfeld leer | Dieses Feld ist erforderlich. |
| Ungueltige E-Mail | Bitte geben Sie eine gueltige E-Mail-Adresse ein. |
| Ungueltiger Zeitraum | Das Mietende muss nach dem Mietbeginn liegen. |
| Loeschen bestaetigen | Moechten Sie diesen Eintrag wirklich loeschen? |
| Erfolgreich gespeichert | Die Aenderungen wurden gespeichert. |

Buttontexte fest: `Speichern`, `Abbrechen`, `Loeschen`, `Bearbeiten`, `Hinzufuegen`, `Schliessen`, `Erneut versuchen`, `Exportieren`.

---

## 10. Checkliste vor dem Pull Request

```text
[ ] keine rohen Farben, Abstaende, Radien, TextStyles
[ ] nur App*-Komponenten verwendet
[ ] Seitenaufbau nach Abschnitt 7
[ ] Leer-, Lade- und Fehlerzustand vorhanden
[ ] Texte aus Abschnitt 9 uebernommen
[ ] Datum und Betrag im Standardformat
[ ] keine neue Dependency
```
