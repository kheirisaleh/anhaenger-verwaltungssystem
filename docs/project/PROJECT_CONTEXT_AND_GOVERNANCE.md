# Anhänger-Verwaltungssystem — Project Context & Governance

> **Status:** Initial project baseline  
> **Date:** 2026-10-01  
> **Purpose:** Zentrale Referenz für Teammitglieder und KI-Assistenten

---

## 1. Projektziel

Im Rahmen eines Schulprojekts wird eine **Verwaltungsoberfläche für eine Anhängervermietung** entwickelt.

Der aktuelle Projektumfang konzentriert sich auf die **Administrator-/Verwaltungsseite**. Eine spätere Projektphase kann zusätzlich eine Smartphone-App für Mieter vorsehen.

Das System soll dem Betreiber eine vollständige Übersicht und Kontrolle über den Fuhrpark ermöglichen sowie Kunden, Verträge und Schadenshistorien verwalten.

### Wichtiger Grundsatz

Die aktuelle Anwendung muss **vollständig offline lauffähig** sein.

- Kein Server für den aktuellen Projektstand
- Kein Cloud-Backend
- Keine Internetverbindung als Voraussetzung für den normalen Betrieb
- Lokale Datenhaltung
- Lokale Dateien/Fotos
- Lokale Backup-Funktion

Die vorhandenen Projektdokumente nennen eine lokale Webanwendung bzw. Verwaltungsoberfläche und lokale Speicherung (z. B. SQLite oder lokale JSON-Datenbank). Die Technologieentscheidung legt Flutter/Dart und SQLite als gewählte Richtung fest.

---

# 2. Aktuell festgelegter Technologie-Stack

## 2.1 UI und Anwendung

- **Flutter**
- **Dart**
- Zielplattform der Verwaltungsoberfläche: **Windows**
- Entwicklung auf **macOS**
- spätere Wiederverwendung für eine Mobile-App soll grundsätzlich möglich sein

## 2.2 UI-Framework

- **`fluent_ui`**
- Ziel: Windows-/Fluent-typisches Erscheinungsbild
- Die Oberfläche soll wie eine konsistente Windows-Anwendung wirken und nicht wie eine generische Material-/Android-App.

`fluent_ui` ist ein Community-Paket und nicht das offizielle Microsoft-Fluent-UI-Paket. Dieses Risiko ist bekannt.

## 2.3 Datenbank

- **SQLite**
- Die Datenbank liegt lokal auf dem jeweiligen Rechner.
- Als technische Lösung wurde **Drift** bzw. alternativ `sqflite + sqflite_common_ffi` betrachtet.
- Die konkrete Entscheidung zwischen diesen SQLite-Zugriffstechnologien muss noch als eigene technische Entscheidung dokumentiert werden, falls noch nicht final festgelegt.

## 2.4 Datenzugriff

Zwischen UI/Business-Logik und konkreter Datenhaltung soll eine **Repository-Abstraktionsschicht** liegen.

Grundidee:

```text
UI
 ↓
Business Logic / Application Layer
 ↓
Repository
 ↓
Local SQLite
```

Dadurch soll eine spätere Anbindung eines echten Backends möglich werden, ohne die UI grundlegend umbauen zu müssen.

**Wichtig:** Ein Remote-Backend gehört aktuell nicht zum laufenden System und darf keine Voraussetzung für den Betrieb sein.

---

# 3. Offline-Prinzip

## 3.1 Verbindliche Regel

> Die Anwendung muss in der aktuellen Projektphase vollständig ohne Internetverbindung funktionieren.

Alle Kernfunktionen müssen lokal funktionieren.

Dazu gehören insbesondere:

- Login/Rollentrennung, soweit im aktuellen Umfang benötigt
- Dashboard
- Anhänger-Verwaltung
- Statusverwaltung
- Standortverwaltung
- Schadenshistorie
- Fotos
- Kundeninformationen
- Mietverträge
- Berichte
- CSV-Export
- Daten-Backup/Import

## 3.2 Lokale Fotos

Fotos dürfen nicht von externen URLs oder Cloud-Speichern abhängig sein.

Geplante Richtung:

```text
Application Data
├── database/
│   └── app.sqlite
└── images/
    ├── trailers/
    └── damages/
```

Die genaue Speicherstrategie und Pfadverwaltung muss in der Architektur-/Datenbankdokumentation festgelegt werden.

## 3.3 Offline-Backup

Backup soll lokal funktionieren.

Geplante Funktionen:

```text
Export Backup
    ↓
lokale Backup-Datei
```

und

```text
Import Backup
    ↓
lokale SQLite-Daten
```

Das genaue Backup-Format und die Sicherheitsregeln werden später festgelegt.

---

# 4. Benutzerrollen

Das ursprüngliche Anforderungsdokument definiert zwei Rollen:

## Administrator

Mitarbeiter des Verleihs.

Aufgaben:

- Fuhrpark verwalten
- Schadenshistorie verwalten
- Kundendaten lesen
- Verträge einsehen
- Dashboard und Berichte nutzen

## Kunde

Mieter.

Im ursprünglichen Gesamtkonzept:

- eigenes Kundenprofil verwalten
- Mietverträge anlegen
- Vertragshistorie einsehen

**Aktueller Entwicklungsschwerpunkt:** Administrator-/Verwaltungsoberfläche.

---

# 5. Funktionale Anforderungen — Administrator

## 5.1 Anhänger-Liste

Die Anwendung soll:

- alle Anhänger anzeigen
- Listen- oder Kachelansicht ermöglichen
- nach Status filtern
- nach Kennzeichen suchen
- nach Typ suchen
- nach internem Bezeichner suchen

Statuswerte:

- Verfügbar
- Vermietet
- In Wartung
- Gesperrt

## 5.2 Statusverwaltung

Für jeden Anhänger:

- aktueller Status sichtbar
- Status änderbar
- Statusänderung mit Zeitstempel protokollieren
- Benutzer der Änderung protokollieren

## 5.3 Standort

Für jeden Anhänger:

- aktueller Standort anzeigen
- Standort manuell eingeben
- Standort aktualisieren
- Darstellung als Adresse oder Koordinaten ist vorgesehen
- Kartenansicht ist im Anforderungsdokument als Möglichkeit genannt

## 5.4 Schadenshistorie

Pro Anhänger:

- bisherige Schäden anzeigen
- Unfälle anzeigen
- sonstige Ereignisse anzeigen
- neuen Schaden anlegen
- bestehende Einträge bearbeiten
- bestehende Einträge löschen
- chronologisch anzeigen
- nach Datum filtern
- nach Schadensart filtern

Schadenseintrag:

- Datum
- Beschreibung
- Schadensart
- Verursacher
- Kosten optional
- Fotos optional

Schadensarten:

- Unfall
- Vandalismus
- Verschleiß
- Sonstiges

Verursacher:

- Kunde
- Intern
- Unbekannt

## 5.5 Anhänger-Fotos

Pro Anhänger:

- ein oder mehrere Fotos
- Fotos im Detailbereich anzeigen
- Upload
- Ersetzen
- Löschen

---

# 6. Dashboard und Berichte

Das Dashboard ist laut Anforderungsdokument ausschließlich für Administratoren vorgesehen.

## 6.1 Vermietungsübersicht

- Anzahl der Vermietungen pro Monat
- Balkendiagramm
- letzte 12 Monate
- Umsatz pro Monat
- Liniendiagramm
- Vergleich ausgewählter Zeiträume möglich

## 6.2 Fuhrpark-Status

Kompaktansicht:

- Anzahl verfügbar
- Anzahl vermietet
- Anzahl in Wartung
- Anzahl gesperrt
- Auslastungsrate des aktuellen Monats

## 6.3 Marketing- und Finanzkennzahlen

- beliebteste Anhängertypen nach Vermietungen
- durchschnittliche Mietdauer
- Umsatz kumuliert / Jahr bis heute
- offene Verträge
- Gesamtwert offener Verträge
- CSV-Export

---

# 7. Datenmodell — fachliche Basis

Die vorhandene Spezifikation definiert mindestens folgende Kernobjekte:

```text
Anhänger
Schadenseintrag
Kunde
Mietvertrag
```

## 7.1 Anhänger

| Feld | Typ | Beschreibung |
|---|---|---|
| id | Integer | Primärschlüssel |
| license_plate | Text | Kennzeichen |
| type | Text | Anhänger-Typ |
| status | Enum | Verfügbar, Vermietet, In Wartung, Gesperrt |
| current_location | Text | Aktuelle Adresse oder Koordinaten |
| photos | Liste | Dateipfade zu Bildern |
| created_at | Datum | Anlagedatum |

## 7.2 Schadenseintrag

| Feld | Typ | Beschreibung |
|---|---|---|
| id | Integer | Primärschlüssel |
| trailer_id | Integer | Fremdschlüssel auf Anhänger |
| event_date | Datum | Datum des Ereignisses |
| description | Text | Beschreibung |
| damage_type | Enum | Unfall, Vandalismus, Verschleiß, Sonstiges |
| caused_by | Text | Kunde / Intern / Unbekannt |
| cost | Dezimal | Optional |
| photos | Liste | Dateipfade zu Fotos |

## 7.3 Kunde

| Feld | Typ | Beschreibung |
|---|---|---|
| id | Integer | Primärschlüssel |
| first_name | Text | Vorname |
| last_name | Text | Nachname |
| email | Text | E-Mail |
| phone | Text | Telefonnummer |
| address | Text | Vollständige Adresse |
| license_number | Text | Führerscheinnummer, optional |

## 7.4 Mietvertrag

| Feld | Typ | Beschreibung |
|---|---|---|
| id | Integer | Primärschlüssel |
| customer_id | Integer | Fremdschlüssel auf Kunde |
| trailer_id | Integer | Fremdschlüssel auf Anhänger |
| start_date | Datum/Zeit | Mietbeginn |
| end_date | Datum/Zeit | Mietende |
| pickup_location | Text | Abholort |
| return_location | Text | Rückgabeort |
| price | Dezimal | Vereinbarter Preis |
| status | Enum | Aktiv, Abgeschlossen, Storniert |

## 7.5 Noch zu spezifizieren

Das fachliche Datenmodell ist die Grundlage, aber folgende Punkte müssen in einem separaten Datenbankdokument präzisiert werden:

- vollständige Relationen
- Indizes
- Constraints
- Löschregeln
- Zeitstempel
- Audit-/Statusänderungsprotokoll
- Speicherung von Fotos
- Migrationen
- Backup-/Restore-Strategie
- genaue SQLite/Drift-Struktur

---

# 8. Architekturprinzipien

## 8.1 Trennung der Verantwortlichkeiten

UI, Business Logic und Datenzugriff werden getrennt.

Grundprinzip:

```text
Presentation
     ↓
Application / Domain
     ↓
Repository
     ↓
Data Source
     ↓
SQLite
```

Die genaue Schichtung wird in `ARCHITECTURE.md` verbindlich dokumentiert.

## 8.2 Keine direkte Datenbankkommunikation aus UI

UI-Komponenten dürfen nicht direkt SQLite-Abfragen ausführen.

Nicht:

```text
Widget → SQLite
```

Sondern:

```text
Widget
 ↓
Controller / Application Logic
 ↓
Repository
 ↓
SQLite
```

## 8.3 Feature-basierte Struktur

Geplante Feature-Bereiche:

```text
dashboard
trailers
damages
customers
contracts
```

Eine mögliche Projektstruktur:

```text
lib/
├── core/
├── data/
├── features/
│   ├── dashboard/
│   ├── trailers/
│   ├── damages/
│   ├── customers/
│   └── contracts/
└── shared/
```

Die genaue Ordnerstruktur wird vor Beginn der parallelen Entwicklung verbindlich festgelegt.

---

# 9. Design-System

Da mehrere Personen und mehrere KI-Assistenten am Projekt arbeiten werden, soll die visuelle Gestaltung zentral standardisiert werden.

Es wird ein eigenes Dokument geben:

```text
docs/design-system/DESIGN_SYSTEM.md
```

Darin sollen mindestens definiert werden:

- Farben
- Akzentfarbe
- Hintergrundfarben
- Typography
- Schriftgrößen
- Abstände / Spacing
- Border Radius
- Größen und Zustände von Buttons
- Eingabefelder
- Tabellen
- Cards
- Dialoge
- Navigation
- Status-Badges
- Icons
- Fehlermeldungen
- Success-/Warning-/Error-Zustände
- Loading States
- Empty States

## Grundregel

> Ein Feature soll vorhandene Design-System-Komponenten wiederverwenden und nicht eigenständig ein alternatives UI-System einführen.

Beispiele für zentrale Komponenten:

```text
AppButton
AppTextField
AppCard
AppDataTable
AppDialog
AppStatusBadge
```

Die tatsächlichen Komponenten werden erst nach Festlegung des Design Systems implementiert.

---

# 10. Wireframes

Vor der Implementierung sollen Wireframes für die wichtigsten Screens erstellt werden.

Geplante Bereiche:

```text
Dashboard
Anhänger-Liste
Anhänger-Detail
Anhänger bearbeiten
Schadenshistorie
Schaden erstellen/bearbeiten
Kundenübersicht
Kundendetail
Vertragsübersicht
Vertragsdetail
Einstellungen / Backup
```

Wireframes dienen als gemeinsame visuelle Spezifikation.

Geplanter Ablageort:

```text
docs/wireframes/
```

Die Wireframes müssen vor der Implementierung des jeweiligen Features abgestimmt werden, damit verschiedene Teammitglieder nicht unterschiedliche Layouts entwickeln.

---

# 11. Dokumentationsstruktur

Das Projekt soll nicht nur Code enthalten, sondern eine nachvollziehbare technische Dokumentation.

Geplante Struktur:

```text
docs/
├── requirements/
├── architecture/
├── database/
├── wireframes/
├── design-system/
└── decisions/
```

Zusätzliche zentrale Dokumente:

```text
README.md
AGENTS.md
DEVELOPMENT_GUIDELINES.md
CHANGELOG.md
```

## Geplante Dokumente

### `DEVELOPMENT_GUIDELINES.md`

Regeln für:

- Code
- Architektur
- Naming
- Dependencies
- Tests
- Git
- Pull Requests
- AI-Nutzung

### `ARCHITECTURE.md`

Regeln für:

- Schichten
- Abhängigkeiten
- Repository Pattern
- Datenfluss
- lokale Datenhaltung
- Feature-Struktur

### `DATABASE_MODEL.md`

Dokumentiert:

- Tabellen
- Beziehungen
- Felder
- Constraints
- Indizes
- Migrationen
- Foto-/Dateiverwaltung

### `DESIGN_SYSTEM.md`

Dokumentiert die gemeinsame visuelle Sprache.

### `AGENTS.md`

Direkte Arbeitsregeln für KI-Assistenten.

---

# 12. AI-Entwicklungsprinzip

Da das Team KI intensiv für Design und Programmierung einsetzen möchte, ist ein gemeinsamer AI-Kontext besonders wichtig.

## Grundprinzip

> KI darf implementieren, aber die Projektregeln bestimmen Architektur, Design und technische Entscheidungen.

Ein KI-Assistent soll nicht bei jeder Aufgabe eine eigene Architektur erfinden.

Vor einer Implementierung soll der Assistent die relevanten Projektregeln lesen.

Minimal:

```text
AGENTS.md
DEVELOPMENT_GUIDELINES.md
ARCHITECTURE.md
relevante Feature-Dokumentation
DESIGN_SYSTEM.md
```

## Geplante AI-Regeln

Ein KI-Assistent soll:

1. bestehende Architektur berücksichtigen
2. bestehende Komponenten wiederverwenden
3. keine unnötigen Dependencies hinzufügen
4. keine Architektur eigenmächtig ändern
5. keine Datenbankstruktur ohne abgestimmte Änderung verändern
6. keine anderen Features unnötig verändern
7. Tests für relevante Business Logic ergänzen
8. bestehende Naming-Regeln einhalten
9. Design-System-Regeln einhalten
10. bei größeren Architekturänderungen zuerst die Änderung dokumentieren bzw. begründen

---

# 13. Einheitlicher Entwicklungsprozess

Jede Aufgabe soll möglichst nach demselben Ablauf bearbeitet werden:

```text
Requirement
    ↓
Issue
    ↓
Wireframe / Design (falls relevant)
    ↓
Technical clarification
    ↓
Feature Branch
    ↓
Implementation
    ↓
Tests
    ↓
Pull Request
    ↓
Code Review
    ↓
Merge
```

Niemand soll eine größere Funktion einfach direkt in `main` entwickeln.

---

# 14. Git- und GitHub-Workflow

GitHub soll nicht nur als Code-Speicher dienen, sondern als zentrale Projektmanagement-Plattform.

## 14.1 Repository

Geplanter Name:

```text
anhaenger-verwaltungssystem
```

Beschreibung:

```text
Offline desktop administration system for trailer rental management, built with Flutter and Dart.
```

## 14.2 Branches

Geplante Struktur:

```text
main
└── develop
    ├── feature/dashboard
    ├── feature/trailer-management
    ├── feature/damage-history
    ├── feature/customer-management
    └── feature/rental-contracts
```

Die endgültige Branch-Strategie wird vor dem ersten Team-Development verbindlich festgelegt.

## 14.3 Feature Branches

Beispiele:

```text
feature/dashboard
feature/trailer-management
feature/damage-history
feature/customer-management
feature/rental-contracts
```

## 14.4 Pull Requests

Feature Branches sollen über Pull Requests integriert werden.

Ein PR soll mindestens enthalten:

- Beschreibung
- Bezug zur Issue
- Änderungen
- Tests
- relevante Screenshots bei UI-Änderungen
- Hinweise auf Architektur-/Datenbankänderungen

---

# 15. GitHub Issues

Jede konkrete Aufgabe soll als Issue erfasst werden.

Beispiel:

```text
Feature: Trailer Management

Task:
Implement trailer status filtering.

Requirements:
- Filter by status
- Search by license plate
- Reset filters

Constraints:
- Use existing design system
- Use TrailerRepository
- Do not add dependencies
- Do not modify unrelated features

Acceptance Criteria:
- ...
```

## Aufgaben-Zuordnung

Jede konkrete Aufgabe soll möglichst genau **einer verantwortlichen Person** zugeordnet werden.

Dadurch ist sichtbar:

```text
Task
 ↓
Assignee
 ↓
Branch
 ↓
Pull Request
 ↓
Review
 ↓
Done
```

---

# 16. GitHub Projects

GitHub Projects soll für die Projektplanung genutzt werden.

Geplantes Kanban:

```text
BACKLOG
   ↓
TODO
   ↓
IN PROGRESS
   ↓
REVIEW
   ↓
DONE
```

Jede größere Aufgabe soll einem Projektstatus und einer verantwortlichen Person zugeordnet sein.

---

# 17. Milestones / Phasen

Das Projekt soll in nachvollziehbare Phasen aufgeteilt werden.

Eine mögliche Struktur ist:

```text
Phase 0 — Project Setup
Phase 1 — Foundation
Phase 2 — Database & Repository
Phase 3 — Design System
Phase 4 — Core Admin Features
Phase 5 — Dashboard & Reports
Phase 6 — Testing & Quality
Phase 7 — Documentation & Release
```

Die konkreten Milestones und deren Umfang werden noch gemeinsam festgelegt.

---

# 18. Code-Qualität

Das Projekt soll nicht nur funktional, sondern nachvollziehbar und wartbar sein.

Geplante Qualitätsregeln:

- Dart Formatting
- Static Analysis
- keine unnötigen Warnings
- Tests für relevante Logik
- nachvollziehbare Commit Messages
- Code Review
- keine unnötigen Dependencies
- keine Secrets im Repository
- keine hartcodierten lokalen Benutzerpfade
- keine unnötige Kopplung zwischen Features

---

# 19. Commit-Konvention

Geplante Conventional-Commit-artige Struktur:

```text
feat: add trailer status filter
fix: prevent invalid rental dates
refactor: extract trailer repository
test: add trailer repository tests
docs: update architecture decision
```

Typen können beispielsweise sein:

```text
feat
fix
refactor
test
docs
chore
build
```

Die endgültige Commit-Regel wird in `DEVELOPMENT_GUIDELINES.md` festgelegt.

---

# 20. Definition of Done

Eine Aufgabe gilt erst als fertig, wenn die relevanten Punkte erfüllt sind:

```text
[ ] Requirement umgesetzt
[ ] UI entspricht dem Design System
[ ] Architekturregeln eingehalten
[ ] bestehende Komponenten wiederverwendet
[ ] keine unnötigen Dependencies
[ ] relevante Tests vorhanden/aktualisiert
[ ] Analyzer ohne relevante Fehler
[ ] bestehende Tests erfolgreich
[ ] Dokumentation bei Bedarf aktualisiert
[ ] Pull Request erstellt
[ ] Code Review durchgeführt
[ ] Issue/Project Status aktualisiert
```

---

# 21. Technologieentscheidung und bekannte Risiken

Die Technologieentscheidung dokumentiert folgende Auswahl:

- Flutter + fluent_ui
- .NET MAUI
- Qt / C++
- Electron
- Tauri

In der vorhandenen Nutzwertanalyse wurde Flutter + fluent_ui mit dem höchsten gewichteten Gesamtwert bewertet.

Die Dokumentation nennt unter anderem:

- Cross-Platform-Fähigkeit
- Windows-Erscheinungsbild
- Lernkurve
- Performance
- "Kein-Web"-Charakter
- SQLite-Unterstützung
- Ökosystem
- Eignung für macOS

als Bewertungskriterien.

## Bekannte Risiken

### Windows Build

Eine Windows-`.exe` lässt sich nicht direkt auf macOS erzeugen.

Geplante Möglichkeiten:

- GitHub Actions mit Windows Runner
- Windows-Rechner in der Schule

### fluent_ui

`fluent_ui` ist ein Community-Paket.

Als Fallback wurde offizielles Flutter Material 3 genannt, ohne die grundlegende Flutter/Dart-Entscheidung aufzugeben.

### Datenmodell-Abstraktion

Repository-Abstraktion soll einen späteren Wechsel von lokaler SQLite-Speicherung zu einem echten Backend ermöglichen.

---

# 22. Docker

## Aktuelle Entscheidung

**Docker ist für die aktuelle Offline-Desktop-Anwendung nicht erforderlich.**

Begründung:

- aktuelle Anwendung benötigt keinen Server
- SQLite läuft lokal
- die Anwendung muss vollständig offline funktionieren
- Docker würde für Flutter Desktop und lokale SQLite-Datenhaltung aktuell keinen zentralen Projektbedarf lösen

## Später

Falls ein echtes Backend in einer späteren Projektphase entsteht, kann Docker für Backend und Server-Infrastruktur erneut bewertet werden.

---

# 23. Was aktuell NICHT als final entschieden gilt

Folgende Punkte wurden bisher als Richtung/Plan diskutiert und müssen noch ausdrücklich finalisiert werden:

- exakte Flutter-Projektordnerstruktur
- Drift vs. `sqflite + sqflite_common_ffi`
- genaue State-Management-Lösung
- Routing-Lösung
- vollständige Design-Tokens
- genaue Wireframes
- vollständiges Datenbank-Schema
- Migration-Strategie
- Backup-Format
- exakte Git-Branch-Strategie
- genaue GitHub Project-Struktur
- konkrete Teammitglieder und Assignees
- CI/CD Workflow
- Lizenz
- Release-Strategie

Diese Punkte dürfen nicht von einzelnen KI-Assistenten eigenmächtig als Projektstandard festgelegt werden.

---

# 24. Entscheidungsregel für zukünftige Änderungen

Wenn eine technische Entscheidung Auswirkungen auf mehrere Features hat, soll sie nicht stillschweigend innerhalb einer einzelnen Task getroffen werden.

Beispiele:

- neue Dependency
- Wechsel des State Managements
- Änderung des Datenmodells
- Änderung der Architektur
- Änderung des Design Systems
- Änderung des Storage-Konzepts
- Einführung eines Backends

Solche Änderungen sollen als technische Entscheidung dokumentiert werden.

Geplanter Ablageort:

```text
docs/decisions/
```

Beispiel:

```text
ADR-001-technology-stack.md
ADR-002-database-access.md
ADR-003-state-management.md
```

---

# 25. Zentrale Projektregel

> **Ein Projekt, eine Architektur, ein Design-System, ein Datenmodell und ein gemeinsamer Entwicklungsprozess.**

Mehrere Personen und KI-Assistenten dürfen parallel entwickeln, aber die Ergebnisse müssen sich an denselben Regeln orientieren.

Das Ziel ist nicht, dass alle Personen exakt denselben Code schreiben.

Das Ziel ist:

- gleiche Architektur
- gleiche Konventionen
- gleiche UI-Sprache
- gleiche Datenmodell-Regeln
- gleiche Qualitätsanforderungen
- nachvollziehbare Zusammenarbeit
- reproduzierbare Entwicklung durch Menschen und KI

---

# 26. Aktueller nächster Schritt

Bevor Feature-Entwicklung beginnt:

1. GitHub Repository erstellen
2. Teammitglieder hinzufügen
3. GitHub Project einrichten
4. Milestones definieren
5. Issue Templates erstellen
6. Pull Request Template erstellen
7. `DEVELOPMENT_GUIDELINES.md` finalisieren
8. `ARCHITECTURE.md` finalisieren
9. Datenbankmodell detaillieren
10. Wireframes erstellen
11. Design System definieren
12. `AGENTS.md` für KI-Assistenten erstellen
13. Flutter-Projekt initialisieren
14. CI/Quality Checks einrichten
15. erste Foundation-Tasks bearbeiten

Erst danach sollte die parallele Feature-Entwicklung im Team beginnen.

---

## Source Basis

Dieser Projektkontext basiert auf:

- dem bereitgestellten **Anforderungsdokument „Anhaenger-Verwaltungssystem“**
- der bereitgestellten **Technologieentscheidung „Verwaltungsoberfläche Anhängervermietung“**
- den im Projektgespräch bestätigten Entscheidungen, insbesondere zum Offline-Betrieb, zur Team-/AI-Zusammenarbeit und zur geplanten GitHub-Projektorganisation.

Wo etwas noch nicht endgültig entschieden wurde, ist es in diesem Dokument ausdrücklich als offen bzw. geplant gekennzeichnet.
