# ADR-006: Bedienbarkeit und Tablet-Unterstützung

> Status: Akzeptiert
> Datum: 08.10.2026

## 1. Ziel

Die Oberfläche soll sich wie eine moderne Verwaltungsanwendung bedienen lassen, am Desktop und auf Tablets (Android). Handys im Hochformat werden bewusst nicht unterstützt.

## 2. Leitlinien

| Leitlinie | Umsetzung |
|---|---|
| Nichts abbrechen müssen | Fehlende Kunden, Anhänger oder Typen lassen sich direkt im Formular über „+ Neu“ anlegen und werden automatisch ausgewählt |
| Fehler vermeiden statt melden | Belegte Anhänger sind im Vertragsdialog für den gewählten Zeitraum ausgegraut, Hinweis bei Wartung/Gesperrt |
| Wenige Klicks für häufige Aufgaben | „Vermieten“ an jedem Anhänger, „Vertrag anlegen“ an jedem Kunden, „sofort übergeben“ beim Anlegen, Status direkt in der Detailansicht |
| Überblick auf einen Blick | „Heute zu tun“ im Dashboard, Zähler an Dashboard und Verträgen, Filter-Chips mit Anzahl |
| Schnell finden | Suche mit Lösch-Knopf, sortierbare Spalten, Trefferanzahl |
| Tastatur | Erstes Feld fokussiert, Enter speichert, Esc schließt |
| Tablet | Navigationsleiste klappt auf schmalen Bildschirmen automatisch ein, Tabellenzeilen 44 px hoch, Exporte landen ohne Speicherdialog im App-Ordner `Export/` |

## 3. Technische Regeln

- Dialoge, die etwas anlegen, geben das angelegte Objekt zurück (`Navigator.pop(result)`). Aufrufer prüfen mit `is Customer` usw. und nutzen `showScopedDialog<Object>`.
- Listen filtern im Controller auf dem Client (wenige hundert Datensätze), damit Chips Anzahlen anzeigen können.
- Fachliche Zustände wie „fällig“ und „überfällig“ sind Methoden am Modell (`RentalContract.isOverdue`), nicht in Widgets.

## 4. Android

- APK über die CI (Job `android`), signiert mit dem Debug-Schlüssel von Flutter. Installation per Datei („Unbekannte Quellen“ erlauben), nicht für den Play Store.
- CSV-Export und Datensicherung schreiben auf Android nach `Android/data/de.anhaengerverwaltung.anhaenger_verwaltungssystem/files/Export/`. Der Import nimmt dort die neueste Sicherung.
