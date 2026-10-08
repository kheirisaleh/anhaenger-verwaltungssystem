# ADR-002: Umfang der Admin-Oberfläche und Benutzermodell

> Status: Akzeptiert
> Datum: 08.10.2026
> Bezug: `docs/requirements/REQUIREMENTS_REVIEW.md` (K1, K2, K5, W2–W5, R1)

## 1. Kontext

Das Anforderungsdokument wurde für eine Webanwendung mit den Rollen Administrator und Kunde geschrieben. Der Projektumfang ist auf die Admin-Oberfläche begrenzt. Dadurch entstehen Lücken:

- Laut PDF legt nur der Kunde Profile und Verträge an. Der Admin hat nur Lesezugriff. Ohne Kundenoberfläche kann niemand Verträge erfassen, Dashboard und Status „Vermietet“ bleiben leer.
- Statusänderungen sollen mit Benutzer protokolliert werden, ein Login-System ist aber ausdrücklich nicht erforderlich.
- Eine Kartenansicht widerspricht der Offline-Pflicht.
- Anhängerstatus und Vertragsstatus können sich widersprechen.

## 2. Entscheidungen

### 2.1 Admin verwaltet Kunden und Verträge

In der aktuellen Phase legt der Administrator Kunden und Mietverträge an und bearbeitet sie. Die Rolle Kunde mit eigenem Zugang wird auf die spätere Mobile-App (Phase 2) verschoben.

### 2.2 Einfaches Benutzermodell ohne Passwort

- Tabelle `app_user` mit Namen der Mitarbeiter.
- Beim Start wählt die Person ihren Namen aus. Kein Passwort.
- Der gewählte Benutzer wird bei Statusänderungen, Verträgen und Schadenseinträgen gespeichert.
- Benutzer werden in den Einstellungen angelegt und deaktiviert, nicht gelöscht.

Begründung: erfüllt die Protokollpflicht (PDF 3.2) und „kein komplexes Login“ (PDF Kap. 6), funktioniert offline und erzeugt keinen Aufwand für Passwortspeicherung.

### 2.3 Standort ohne Karte

Der Standort wird als Adresse (Text) und optional als Koordinaten gespeichert. Eine eingebettete Kartenansicht ist nicht im Umfang, da Kartendaten eine Internetverbindung benötigen.

### 2.4 Vertragsablauf und Anhängerstatus

Der Vertragsstatus erhält einen zusätzlichen Wert **Geplant**:

```text
Geplant ──Übergabe──> Aktiv ──Rückgabe──> Abgeschlossen
   │
   └──> Storniert
```

| Ereignis | Vertrag | Anhänger |
|---|---|---|
| Vertrag anlegen | Geplant | unverändert |
| Übergabe an Kunden | Aktiv | Vermietet (automatisch) |
| Rückgabe | Abgeschlossen | Verfügbar (automatisch) |
| Stornieren (nur aus Geplant) | Storniert | unverändert |

Regeln:

- „Vermietet“ wird nie manuell gesetzt, sondern nur durch die Übergabe.
- Eine Übergabe ist nur möglich, wenn der Anhänger „Verfügbar“ ist.
- Solange ein Vertrag aktiv ist, ist der Anhängerstatus nicht manuell änderbar.
- Verfügbar, In Wartung und Gesperrt setzt der Admin manuell.
- Verträge sind nur im Status Geplant bearbeitbar (PDF 4.2: „sofern noch nicht begonnen“).
- Für denselben Anhänger dürfen sich geplante und aktive Verträge zeitlich nicht überschneiden.

### 2.5 Archivieren statt Löschen

Anhänger und Kunden werden nicht gelöscht, sondern archiviert. Archivierte Datensätze erscheinen nicht in Listen und Auswahlfeldern, bleiben aber für Verträge, Schäden und Berichte erhalten. Verträge werden storniert, nicht gelöscht. Schadenseinträge dürfen gelöscht werden (PDF 3.4).

## 3. Konsequenzen

- `ContractStatus` im Code und die Status-Badges im Design System erhalten den Wert `planned` / „Geplant“.
- Ein Wireframe für die Benutzerauswahl beim Start wird benötigt.
- Kundenverwaltung und Vertragsverwaltung werden vollwertige Admin-Features (Anlegen, Bearbeiten), nicht nur Leseansichten.
- Das Datenmodell folgt diesen Regeln: `docs/database/DATABASE_MODEL.md`.
