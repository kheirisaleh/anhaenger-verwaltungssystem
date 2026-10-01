# Technologieentscheidung: Verwaltungsoberfläche Anhängervermietung

## 1. Ausgangslage und Anforderungen

Im Rahmen des Schulprojekts soll zunächst eine **Verwaltungsoberfläche (Backend-UI ohne echtes Backend)** für Betreiber einer Anhängervermietung entwickelt werden. Die Anwendung dient der Verwaltung von Anhängern, Kunden und Buchungen. In einer späteren Projektphase soll zusätzlich eine **Smartphone-App** entstehen, über die Mieter Anhänger buchen können.

Daraus ergeben sich folgende zentrale Anforderungen an die Technologie:

- Muss unter **Windows** lauffähig sein (Zielplattform der Verwaltungsoberfläche)
- Sollte **plattformübergreifend** einsetzbar sein, um die spätere Mobile App mit möglichst viel wiederverwendbarem Code umsetzen zu können
- Entwicklung erfolgt auf **macOS**-Rechnern
- Der Lehrer äußerte eine **Präferenz gegen klassische Web-Technologien** (ohne nähere Begründung), weshalb Lösungen bevorzugt werden, die als "native" Anwendung wahrgenommen werden
- Lokale Datenhaltung (SQLite) statt eines echten Servers in dieser Projektphase
- Ein möglichst originalgetreues **Windows-Erscheinungsbild** ist wünschenswert, da die Zielgruppe (Betreiber) die App primär unter Windows nutzt

## 2. Entscheidung

Wir haben uns für **Flutter mit der Programmiersprache Dart** in Kombination mit dem Community-Paket **`fluent_ui`** (Implementierung von Microsofts Fluent Design System) entschieden.

- **Flutter/Dart** als Grundlage für UI und Anwendungslogik, kompiliert zu einer nativen Windows-Anwendung (`.exe`)
- **`fluent_ui`** als Widget-Bibliothek, damit die Verwaltungsoberfläche wie eine "echte" Windows-11-Anwendung aussieht (Navigationsleiste, Akzentfarben, Fluent-typische Steuerelemente) statt wie eine generische Material-/Android-Oberfläche
- **`drift`** (bzw. alternativ `sqflite` + `sqflite_common_ffi`) für die lokale SQLite-Datenhaltung, plattformübergreifend nutzbar
- Datenzugriff über eine eigene Repository-Abstraktionsschicht, damit spätere Anbindung an ein echtes Backend ohne UI-Änderungen möglich ist

## 3. Nutzwertanalyse

Zur objektiven Absicherung der Entscheidung wurde eine gewichtete Nutzwertanalyse durchgeführt. Bewertet wurden fünf realistische Alternativen anhand von acht Kriterien (Skala 1 = sehr schlecht bis 5 = sehr gut).

### 3.1 Kriterien und Gewichtung

| Kriterium | Gewichtung | Begründung der Gewichtung |
|---|---|---|
| Cross-Platform-Fähigkeit (Desktop + spätere Mobile App) | 20 % | Kernanforderung, da App-Phase 2 folgt und Code-Wiederverwendung erwünscht ist |
| Windows-natives Erscheinungsbild | 15 % | Zielgruppe nutzt Windows produktiv, native Optik erhöht Akzeptanz |
| Lernkurve / Entwicklungsaufwand für Schulprojekt | 15 % | Begrenzte Projektzeit, keine professionelle Vorerfahrung im Team vorausgesetzt |
| Performance / native Ausführung | 10 % | Anwendung soll flüssig laufen, kein Browser-Overhead |
| "Kein-Web"-Charakter | 10 % | Explizite Präferenz des Lehrers zu berücksichtigen |
| SQLite-/Datenbank-Unterstützung | 10 % | Zentrale technische Anforderung für Phase 1 |
| Ökosystem, Dokumentation, Community | 10 % | Wichtig für Problemlösung während eines Schulprojekts ohne professionellen Support |
| Eignung für Entwicklung auf macOS | 10 % | Entwicklungsrechner sind Macs |
| **Summe** | **100 %** | |

### 3.2 Bewertungsmatrix

| Kriterium | Gewicht | Flutter + fluent_ui | .NET MAUI | Qt / C++ | Electron | Tauri |
|---|---|---|---|---|---|---|
| Cross-Platform-Fähigkeit | 20 % | 5 | 4 | 4 | 3 | 3 |
| Windows-natives Erscheinungsbild | 15 % | 5 | 4 | 4 | 2 | 2 |
| Lernkurve / Aufwand | 15 % | 3 | 3 | 1 | 4 | 2 |
| Performance | 10 % | 5 | 4 | 5 | 2 | 4 |
| "Kein-Web"-Charakter | 10 % | 5 | 5 | 5 | 1 | 1 |
| SQLite-Unterstützung | 10 % | 5 | 4 | 4 | 4 | 4 |
| Ökosystem / Dokumentation | 10 % | 4 | 3 | 3 | 5 | 3 |
| Eignung für macOS-Entwicklung | 10 % | 4 | 2 | 3 | 4 | 3 |

### 3.3 Gewichtete Punktzahlen

| Technologie | Gewichteter Gesamtwert (von 5,0) |
|---|---|
| **Flutter + fluent_ui** | **4,50** |
| .NET MAUI | 3,65 |
| Qt / C++ | 3,55 |
| Electron | 3,10 |
| Tauri | 2,70 |

**Ergebnis:** Flutter mit `fluent_ui` erzielt mit deutlichem Abstand den höchsten Nutzwert und wird als Technologie für das Projekt festgelegt.

## 4. Betrachtung der Alternativen

**.NET MAUI (C#/.NET)**
Zweitplatzierte Alternative. Bietet ebenfalls Desktop- und Mobile-Unterstützung aus einer Codebasis sowie eine native Windows-Optik (WinUI 3-basiert). Nachteile: Die Windows-Zielplattform lässt sich von macOS aus in der Praxis nur eingeschränkt entwickeln und testen, und es gab in der jüngeren Vergangenheit Qualitäts- und Stabilitätsprobleme in Standard-Komponenten. Für ein Team ohne C#-Vorkenntnisse zudem kein klarer Vorteil gegenüber Dart.

**Qt / C++**
Technisch sehr leistungsfähig und "nativ" im klassischen Sinn, mit gutem plattformübergreifendem Windows-Look. Der entscheidende Nachteil ist die hohe Einstiegshürde durch C++, die für ein Schulprojekt mit begrenzter Zeit ein erhebliches Risiko darstellt.

**Electron (JavaScript/HTML/CSS)**
Größtes Ökosystem und schnellster Einstieg, da Web-Technologien oft bereits bekannt sind. Scheidet jedoch aus zwei Gründen aus: Die Oberfläche ist im Kern eine in ein Fenster eingebettete Webseite (Chromium), was der ausdrücklichen Präferenz des Lehrers gegen Web-Technologien widerspricht, und der Ressourcenverbrauch (Arbeitsspeicher, Programmgröße) ist im Vergleich am höchsten. Zudem gibt es keine native Mobile-Option für Phase 2.

**Tauri (Rust + Web-Frontend)**
Erzeugt zwar kleine, performante native Executables, die Oberfläche selbst wird aber weiterhin mit HTML/CSS/JavaScript gebaut und in einer System-Webview dargestellt. Damit ist der "Kein-Web"-Anspruch nicht erfüllt. Zusätzlich erfordert die Backend-Anbindung Rust-Kenntnisse, was den Lernaufwand erhöht.

## 5. Bekannte Risiken und offene Punkte

- **Build-Prozess:** Eine Windows-`.exe` lässt sich nicht direkt auf macOS erzeugen. Geplante Lösung: automatisierter Build über eine GitHub-Actions-Pipeline mit einem `windows-latest`-Runner. Alternativ steht ein Windows-Rechner in der Schule zur Verfügung.
- **`fluent_ui` ist ein inoffizielles Community-Paket** (nicht von Google/Microsoft selbst) und wird von einer kleinen Zahl an Maintainern gepflegt. Sollte es während des Projekts zu Kompatibilitätsproblemen kommen, kann alternativ auf Flutters offizielles Material-3-Theming ausgewichen werden, ohne die Kernentscheidung (Flutter/Dart) zu ändern.
- **Datenmodell-Abstraktion:** Um den späteren Wechsel von lokaler SQLite-Speicherung zu einem echten Server-Backend (Phase 2/3) ohne größere UI-Umbauten zu ermöglichen, wird von Beginn an eine Repository-Schnittstelle zwischen UI und Datenhaltung eingezogen.

## 6. Fazit

Flutter/Dart in Kombination mit `fluent_ui` erfüllt die Anforderungen des Projekts am besten: eine Codebasis für Desktop- und spätere Mobile-Entwicklung, eine native, Windows-typische Optik, gute SQLite-Unterstützung sowie eine für ein Schulprojekt vertretbare Lernkurve. Die Nutzwertanalyse bestätigt diese Einschätzung mit dem höchsten gewichteten Gesamtwert (4,50 von 5,0) unter allen betrachteten Alternativen.
