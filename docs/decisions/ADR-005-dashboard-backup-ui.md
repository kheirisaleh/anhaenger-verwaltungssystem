# ADR-005: Kennzahlen, Datensicherung und Bedienkonzept

> Status: Akzeptiert
> Datum: 08.10.2026
> Bezug: `REQUIREMENTS_REVIEW.md` R2 und R3, ADR-002

## 1. Dashboard-Kennzahlen

Berechnung in `lib/features/dashboard/application/dashboard_metrics.dart`, getestet in `test/features/dashboard_metrics_test.dart`.

| Kennzahl | Definition |
|---|---|
| Vermietungen pro Monat | Verträge mit Status Aktiv oder Abgeschlossen, zugeordnet nach dem Monat des Mietbeginns, letzte 12 Monate |
| Umsatz pro Monat | Summe der Preise dieser Verträge, ebenfalls nach Monat des Mietbeginns |
| Auslastung | gebuchte Anhänger-Zeit im aktuellen Monat (alle nicht stornierten Verträge) ÷ (Anzahl nicht archivierter Anhänger × Dauer des Monats) |
| Offene Verträge | Status Geplant oder Aktiv, mit Summe der Preise |
| Umsatz und Vermietungen seit Jahresbeginn | Aktiv oder Abgeschlossen, Mietbeginn zwischen 1. Januar und heute. Vergleich mit demselben Zeitraum des Vorjahres |
| Ø Mietdauer | Mittelwert von Mietende minus Mietbeginn in Tagen, nur abgeschlossene Verträge |
| Beliebteste Typen | Anzahl aktiver und abgeschlossener Verträge je Anhängertyp, Top 5 |

CSV-Export: Semikolon als Trennzeichen, UTF-8 mit BOM, damit Excel Umlaute korrekt anzeigt.

## 2. Datensicherung

- **Export:** Ordner `Anhaenger-Backup_<Datum>_<Uhrzeit>` im gewählten Verzeichnis mit `database/app.sqlite` (konsistente Kopie per `VACUUM INTO`) und `images/`.
- **Import:** Ordner mit `database/app.sqlite` auswählen. Die Anwendung schließt die Datenbank, ersetzt Datenbank und Fotos und startet neu. Danach wird der Benutzer neu ausgewählt.
- Ein Zusammenführen von Datenbeständen ist nicht vorgesehen.

## 3. Bedienkonzept

- **Löschen** von Anhängern und Kunden verschiebt ins Archiv (ADR-002 §2.5). In den Listen blendet „Archivierte anzeigen“ sie wieder ein, „Wiederherstellen“ holt sie zurück. Schäden, Fotos und Anhängertypen ohne Verwendung werden endgültig gelöscht. Verträge werden storniert.
- Detailseiten und Dialoge werden mit `pushScopedPage` und `showScopedDialog` (`lib/shared/scoped_navigation.dart`) geöffnet. Sie liegen in Flutter außerhalb des Widget-Baums der Hauptseite und bekommen `AppScope` so mitgegeben.
- Wiederverwendbare Tabellen eines Features (`DamageTable`, `ContractTable`) dürfen in Detailseiten anderer Features eingebettet werden. Controller anderer Features werden nicht importiert.

## 4. Beispieldaten

`SampleDataSeeder` (`lib/data/sources/`) legt beim ersten Start einer leeren Datenbank Beispieldaten über die Repositories an, also mit allen Fachregeln: 8 Anhänger, 8 Kunden, Vertragshistorie der letzten 12 Monate, laufende, geplante und stornierte Verträge, 6 Schäden. In den Einstellungen lassen sie sich in eine leere Datenbank erneut laden.

## 5. Neue Dependency

`file_selector` (offizielles Flutter-Paket) für Foto-Auswahl, Export-Speicherort und Backup-Ordner. Unter macOS ist dafür die Berechtigung `com.apple.security.files.user-selected.read-write` eingetragen.
