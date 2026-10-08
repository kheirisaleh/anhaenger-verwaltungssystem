# Review des Anforderungsdokuments

> Grundlage: `Anforderungsdokument_Anhaenger-Verwaltungssystem.pdf` (24.09.2026, 6 Seiten)
> Abgeglichen mit: `PROJECT_CONTEXT_AND_GOVERNANCE.md`, `PROJECT_STATUS.md`, `ADR-001`, `DESIGN_SYSTEM.md`, aktuellem Code auf `main` (`ce31ad0`)
> Stand: 08.10.2026
> Zweck: Lücken und Widersprüche sichtbar machen, **bevor** Datenbankmodell und Wireframes entstehen. Die Punkte sind Fragen an das Team, keine Entscheidungen.

---

## 1. Zusammenfassung

Das Anforderungsdokument ist für ein Schulprojekt solide: Rollen, Admin-Funktionen, Dashboard-Kennzahlen und ein Datenmodell-Entwurf sind vorhanden. Es wurde aber für eine **Webanwendung mit zwei Rollen** geschrieben. Durch ADR-001 (Desktop-App) und die Fokussierung auf die **Admin-Seite** sind mehrere Anforderungen nicht mehr eindeutig umsetzbar.

Kritisch für den Projektfortschritt sind vor allem:

| # | Thema | Warum kritisch |
|---|---|---|
| K1 | Wer legt Kunden und Verträge an? | Ohne Verträge bleiben Dashboard, Umsatz und Auslastung leer |
| K2 | Statusprotokoll braucht einen „Benutzer“ | Es gibt kein Benutzermodell und kein Login-Konzept |
| K3 | Datenmodell unvollständig | Interner Bezeichner, Statushistorie, Fotos, Benutzer fehlen |
| K4 | Kennzahlen nicht definiert | Auslastung, Umsatz pro Monat, „offene Verträge“ sind mehrdeutig |
| K5 | Kartenansicht vs. Offline-Pflicht | Karten-Kacheln benötigen Internet |

Diese Punkte sollten im Datenbank-Task (Task 1) und im Wireframe-Task (Task 2) geklärt werden.

---

## 2. Widersprüche zwischen Dokumenten

### W1 — Plattform

- PDF, Kap. 6: „Lokale Webanwendung, läuft im Browser“, „Optimiert für Desktop-Browser“.
- ADR-001: Flutter-Desktop-Anwendung für Windows.
- `PROJECT_STATUS.md` erwähnt, dass das ADR das PDF ersetzt. Im PDF selbst und im ADR fehlt dieser Hinweis.

**Empfehlung:** In ADR-001 einen Abschnitt „Abweichung vom Anforderungsdokument“ ergänzen. „Responsivität: Tablet wünschenswert“ in „Mindestfenstergröße“ umformulieren (z. B. 1280 × 720).

### W2 — Rolle Kunde und Admin-Fokus

- PDF, Kap. 2 und 4: Der **Kunde** legt sein Profil und seine Mietverträge selbst an. Der Admin hat nur **Lesezugriff** auf Kunden und Verträge.
- Projektfokus: nur die Admin-Oberfläche.

Folge: In der aktuellen Phase kann **niemand** Kunden oder Verträge anlegen. Dashboard (Kap. 5) und Status „Vermietet“ hängen aber vollständig an Verträgen.

**Empfehlung (Teamentscheidung):** Für diese Phase darf der Admin Kunden und Mietverträge anlegen und bearbeiten. Die Kundenrolle wird auf Phase 2 (Mobile-App) verschoben. Das sollte in einem ADR oder im Projektstatus festgehalten werden.

### W3 — Login und Protokoll-Benutzer

- PDF, 3.2: Statusänderung wird „mit Zeitstempel und **Benutzer**“ protokolliert.
- PDF, Kap. 6: „kein komplexes Login-System erforderlich“.
- Wireframe-Task: „Admin login“.

Offen: Gibt es mehrere Admin-Konten? Mit Passwort? Oder nur einen Namen beim Start?

**Empfehlung:** Einfachste tragfähige Lösung: Tabelle `app_user` (id, name), Auswahl des Benutzers beim Start, kein Passwort. Das genügt für das Protokoll und bleibt offline-tauglich.

### W4 — Kartenansicht

- PDF, 3.3: Standort „z. B. als Adresse oder auf einer Karte“.
- Governance: vollständig offline.

Kartenkacheln (OpenStreetMap usw.) benötigen eine Internetverbindung, zudem käme eine neue Dependency hinzu.

**Empfehlung:** Standort als Text (Adresse) und optional Koordinaten speichern. Karte als „nicht im Umfang“ dokumentieren oder höchstens als Link, der außerhalb der App geöffnet wird.

### W5 — Adresse des Kunden

- PDF, 4.1: Adresse als Straße, PLZ, Ort.
- PDF, Kap. 7 und Governance 7.3: `address` als ein Textfeld.

**Empfehlung:** Drei Felder (`street`, `postal_code`, `city`). Das erleichtert Suche, Validierung und spätere Exporte.

---

## 3. Lücken im Datenmodell

| Bereich | Lücke | Vorschlag für `DATABASE_MODEL.md` |
|---|---|---|
| Anhänger | „Interner Bezeichner“ wird in 3.1 gesucht, fehlt aber im Modell | Feld `internal_code`, eindeutig |
| Anhänger | `type` ist Freitext, das Dashboard wertet „beliebteste Typen“ aus | Feste Typenliste (Tabelle oder Enum), sonst zählen „Tieflader“ und „tieflader“ getrennt |
| Anhänger | Kein Preis / Tagessatz | Klären, ob der Preis nur im Vertrag steht (aktuell so) |
| Anhänger | `license_plate` ohne Eindeutigkeit | `UNIQUE`-Constraint |
| Anhänger | `updated_at` fehlt | Bei allen Tabellen `created_at` und `updated_at` |
| Statusprotokoll | Gefordert (3.2), aber keine Tabelle | `trailer_status_change` (trailer_id, old_status, new_status, changed_at, user_id) |
| Standort | Nur aktueller Wert, keine Historie | Klären, ob eine Historie gewünscht ist. Mindestens `location_updated_at` |
| Fotos | `photos` als „Liste“ ist in SQLite keine Spalte | Tabelle `photo` (id, owner_type oder getrennte FKs, file_path relativ zum App-Datenordner, created_at) |
| Schaden | `caused_by` ist Text, fachlich ein Enum | Enum wie im Code (`DamageCause`) |
| Schaden | Verursacher „Kunde“ – welcher Kunde? | Optionale FKs `customer_id` und/oder `contract_id` |
| Schaden | Kosten als „Dezimal“ | Geldbeträge als Integer in Cent speichern (SQLite kennt keinen echten Dezimaltyp) |
| Vertrag | `price` als Dezimal | Ebenfalls Cent-Integer |
| Vertrag | Kein Status für künftige Verträge | Ist ein Vertrag mit Start in der Zukunft „Aktiv“? Evtl. Status „Geplant“ ergänzen |
| Vertrag | Keine Überschneidungsprüfung | Regel: Ein Anhänger darf keine zwei nicht stornierten Verträge mit überlappendem Zeitraum haben |
| Vertrag | Bearbeiten „sofern noch nicht begonnen“ (4.2) | Regel im Application Layer, nicht nur in der UI |
| Benutzer | Fehlt komplett | Siehe W3 |
| Löschregeln | Nicht definiert | Was passiert beim Löschen eines Anhängers mit Verträgen oder Schäden? Vorschlag: kein Hard Delete, sondern Archivieren |

---

## 4. Unklare fachliche Regeln

### R1 — Status „Vermietet“ und Verträge

Der Anhängerstatus ist manuell änderbar (3.2), der Vertragsstatus existiert getrennt. Beide können sich widersprechen (Anhänger „Verfügbar“, aber aktiver Vertrag läuft).

Zu klären: Wird „Vermietet“ automatisch aus aktiven Verträgen abgeleitet oder manuell gesetzt? Darf ein Anhänger „In Wartung“ gehen, während ein Vertrag aktiv ist?

### R2 — Kennzahlen im Dashboard

| Kennzahl | Offene Frage |
|---|---|
| Vermietungen pro Monat | Zählt der Monat des Mietbeginns? Stornierte Verträge ausgeschlossen? |
| Umsatz pro Monat | Wird der Vertragspreis dem Startmonat zugerechnet oder anteilig auf die Tage verteilt? |
| Auslastungsrate | Formel? Vorschlag: vermietete Anhänger-Tage ÷ (Anzahl Anhänger × Tage im Monat) |
| Durchschnittliche Mietdauer | In Tagen oder Stunden? Nur abgeschlossene Verträge? |
| Offene Verträge | Nur „Aktiv“ oder auch zukünftige? |
| Vergleich Zeiträume | Fest „aktuelles Jahr vs. Vorjahr“ oder frei wählbar? |
| CSV-Export | Welche Berichte genau? Trennzeichen `;` (deutsches Excel) und Kodierung UTF-8 mit BOM empfohlen |

Diese Definitionen gehören in eine kurze Spezifikation, sonst rechnet jede KI-Session anders.

### R3 — Backup

PDF: „Manueller Export/Import“. Offen sind Format (SQLite-Datei + Fotos als ZIP?), Verhalten beim Import (überschreiben oder zusammenführen?) und Versionierung bei Schemaänderungen.

### R4 — Barrierefreiheit

„Kontrastreiche Darstellung“ ist nicht messbar. Vorschlag: WCAG AA (Kontrast mindestens 4,5:1 für Text). Die aktuellen Statusfarben erfüllen das mit weißem Text knapp (z. B. `statusMaintenance` ≈ 4,5:1).

---

## 5. Abweichungen zwischen Code und Dokumentation

| Fundstelle | Befund |
|---|---|
| `README.md` | Sagt „Flutter-Code wird erst angelegt …“, der Code existiert aber bereits (PR #8–#11) |
| `PROJECT_STATUS.md` | Alle vier Foundation-Tasks als offen. Design System ist faktisch weitgehend fertig |
| `CHANGELOG.md` | Enthält weder Design System noch Flutter-Scaffold |
| `lib/core/constants/app_strings.dart` | UI-Texte ohne Umlaute („Anhaenger“, „Verfuegbar“). Anforderung: deutsche UI. Dart-Strings unterstützen UTF-8 problemlos. Teamentscheidung nötig |
| `lib/data/models/trailer_status.dart` | `DamageType`/`DamageCause` mit hartcodierten Texten statt `AppStrings` (Verstoß gegen Design-System-Regel 6) |
| `lib/core/formatting/app_formats.dart` | `DateFormat(..., 'de_DE')` wirft zur Laufzeit eine `LocaleDataException`, solange `initializeDateFormatting('de_DE')` (aus `package:intl/date_symbol_data_local.dart`) nicht in `main()` aufgerufen wird. Fällt erst auf, wenn das erste Datum formatiert wird |
| `lib/shared/app_shell.dart` | Jede Seite zeigt den Leertext „Keine Anhänger vorhanden“, auch Dashboard und Kunden |
| `DESIGN_SYSTEM.md` §5 | `AppDataTable` und `AppDialog` sind spezifiziert, aber nicht implementiert |
| `DESIGN_SYSTEM.md` §0 Regel 5 | Verweist auf „Abschnitt 8“, der Seitenaufbau steht in Abschnitt 7 |
| PDF 3.4 | Tippfehler „Vandalism“ (in Kap. 7 korrekt „Vandalismus“) |

---

## 6. Empfohlene Reihenfolge

1. **Teamentscheidung zu K1/W2 und W3** (Admin legt Kunden und Verträge an, einfaches Benutzermodell). Ohne diese Entscheidung ist das Datenmodell nicht stabil.
2. **`DATABASE_MODEL.md`** mit den Punkten aus Abschnitt 3, ER-Diagramm (Mermaid im Markdown genügt).
3. **ADR-002 Datenbankzugriff** (Drift vs. sqflite). Für ein Team, das stark mit KI arbeitet, spricht viel für Drift (typsicher, Migrationen, Fehler beim Kompilieren statt zur Laufzeit), aber das Team entscheidet.
4. **ADR-003 State Management** und **Routing**, bevor das erste Feature beginnt.
5. **Kennzahlen-Definitionen** (Abschnitt R2) als kurzes Dokument, z. B. `docs/requirements/DASHBOARD_METRICS.md`.
6. Wireframes auf Basis der geklärten Szenarien.
