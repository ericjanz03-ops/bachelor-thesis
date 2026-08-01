**Titel:** Generative KI zur Code-Generierung in ServiceNow-Implementierungen: Eine experimentelle Studie zu Entwicklungseffizienz und Codequalität **Gesamtumfang:** 55 Seiten (Textteil)

**Forschungslogik:** Eine übergeordnete Forschungsfrage (MRQ) → theoriegeleitete Ableitung von Hypothesen in 2.3.3 → empirische Prüfung in Kapitel 4 → Rückbindung an die MRQ in 5.1 und 6.1. Es gibt **keine** untergeordneten Forschungsfragen; die Strukturierungsleistung übernehmen die Hypothesen (und auf Metrikebene die GQM-Questions).

---

## 1 Einleitung — 4 S.

### 1.1 Motivation und Zielsetzung — 1 S.

- Historischer Einstieg (Manna & Waldinger 1971) → Paradigmenwechsel zu Natural-Language-to-Code (Jiang et al. 2026)
- Forschungslücke: Benchmarks bilden industrielle Realität nicht ab → Begründung für Feldnähe
- Relevanz ServiceNow: Marktdurchdringung (Proxy Statement), Low-Code + verbleibendes Scripting
- Spannungsfeld: Effizienzversprechen (Peng et al. 2023) vs. Qualitätsrisiko durch stochastische Generierung (Ghorbian et al. 2026; Liu et al. 2026)
- Zielsetzung in einem Absatz: technische **und** wirtschaftliche Perspektive
- _Status: bereits geschrieben._

### 1.2 Forschungsfrage — 1 S.

- Herleitung der MRQ aus der Motivation, MRQ im Wortlaut abgesetzt
- Kurze Erläuterung der beiden Perspektiven „technisch" und „wirtschaftlich" — beide Bestandteile der MRQ, beide müssen später bedient werden
- Ankündigung: Operationalisierung erfolgt über Hypothesen, die in 2.3.3 theoriegeleitet abgeleitet werden — hier **nicht** vorwegnehmen
- _Status: bereits geschrieben._ **Überschrift in der XLSX-Gliederung noch im Plural („Forschungsfragen") — auf Singular angleichen.**

### 1.3 Methodisches Vorgehen — 1 S.

- Literaturrecherche nach vom Brocke et al. → GQM (Basili & Rombach) → kontrolliertes Experiment (Wohlin et al.)
- Nur „was", nicht „warum/wie" — Begründung gehört in Kapitel 3
- _Status: bereits geschrieben._

### 1.4 Aufbau der Arbeit — 1 S.

- Kapitelweiser Durchlauf, je 2–3 Sätze
- Optional: Abbildung „Aufbau der Arbeit" (Adaption von Abbildung 1 aus dem Exposé)

---

## 2 Theoretische Grundlagen — 12 S.

### 2.1 Architektur und Entwicklung in ServiceNow-Modulen — 3 S.

- Plattformarchitektur: Instanzmodell, Now Platform als gemeinsame Datenbasis (`sys_*`-Tabellen, Tabellenvererbung)
- Low-Code-Paradigma und dessen Grenze: wo endet Konfiguration, wo beginnt Scripting
- Server-side Scripting-Artefakte, **Fokus auf Business Rules** (Trigger-Zeitpunkte before/after/async, `current`/`previous`, GlideRecord/GlideAggregate) — Klammer zum Experimentgegenstand
- Automated Test Framework (ATF) als plattformeigenes Testinstrument → Vorgriff auf die Messinfrastruktur
- **Weglassen:** Unternehmensgeschichte, Produktportfolio, Modulübersicht (ITSM/ITOM/HR …) außer in einem Satz. Nur architektonisch Relevantes.
- Quellen: ServiceNow Platform Technical Overview, Gartner MQ Low-Code, ergänzend Liu et al. 2026

### 2.2 Generative KI in der Softwareentwicklung — 3 S.

- KI → GenAI → LLM (Trichter), Tokenisierung, Embeddings, Transformer/Self-Attention, autoregressive Generierung
- Daraus abgeleitet: stochastische Natur ⇒ plausibler, nicht garantiert korrekter Code (Brücke zu den Qualitätsrisiken)
- Anwendungsfelder: Completion, Testgenerierung, Debugging, Doku, Refactoring
- Effizienzevidenz: Peng et al. 2023 — **Gegenevidenz METR 2025 ergänzen**, sonst wirkt der Abschnitt einseitig
- Qualitätsrisiken: Halluzinationen, Wartbarkeit, Sicherheit (Ghorbian et al.; Tosi 2024; Sun et al. 2026)
- Erfahrungsniveau-Effekt (Prather et al. 2024; Tona et al. 2024) → liefert die Vorlage für die Moderator-Hypothese in 2.3.3
- GenAI in Low-Code (Liu et al. 2026; Paliwal et al. 2024; Gorissen et al. 2025 als nächstliegende Vergleichsstudie)
- **Offen:** „QUELLE"-Platzhalter ersetzen (Ebert & Louridas, Tosi, Zhang et al., Prather et al., Liu et al., Paliwal et al., Gorissen et al.)
- _Status: Entwurf vorhanden._

### 2.3 Effizienz- und Qualitätsmessung in der Softwareentwicklung

#### 2.3.1 Grundlagen der Softwarequalitätsmessung nach ISO/IEC 25010 — 2 S.

- Modell der Produktqualität: 9 Merkmale, davon **explizite Auswahl** der relevanten: Functional Suitability, Maintainability, Reliability
- Begründung der Auswahl und der Nicht-Auswahl (Performance Efficiency, Security etc. im Experimentkontext nicht sinnvoll messbar)
- Herunterbrechen auf messbare Subcharakteristika (z. B. Modularity, Analysability, Modifiability)
- Abgrenzung Produktqualität vs. Quality in Use

#### 2.3.2 Konzepte der Produktivitätsmessung und der Goal-Question-Metric-Ansatz — 2 S.

- Problem der Produktivitätsmessung in der Softwareentwicklung (LOC-Kritik, Multidimensionalität, SPACE-Framework als Einordnung)
- GQM nach Basili & Rombach: Goal → Question → Metric, Top-down-Ableitung
- **GQM-Tabelle für diese Arbeit** — hier übernehmen die Questions die Feingliederung, die sonst Teilforschungsfragen leisten würden:
    - _Goal:_ Wirkung von GenAI-Unterstützung auf Entwicklungseffizienz und Codequalität bei der ServiceNow-Code-Generierung
    - _Questions:_ Wie verändert sich der Zeitbedarf? Wie verändert sich der Iterations-/Nacharbeitsaufwand? Wie verändert sich die funktionale Korrektheit? Wie verändert sich die Wartbarkeit?
    - _Metrics:_ Time-to-first-draft, Time-to-first-pass, Debugging-Zeit, Iterationszyklen, Rework-Rate, First-Time-Right-Quote, qualitätsadjustierte Effizienz
- Diese Tabelle ist das Scharnier zu 3.3 — dort nur noch Operationalisierung, nicht Herleitung

#### 2.3.3 Synthese und Ableitung der Forschungshypothesen — 2 S.

- Zusammenführung aus 2.1 (Kontext), 2.2 (Wirkmechanismus), 2.3.1/2.3.2 (Messbarkeit) — der Abschnitt ist das inhaltliche Herzstück des Theorieteils
- Ableitung der Hypothesen, jeweils mit einem Absatz theoretischer Fundierung (welche Quelle stützt sie) und Zuordnung zu den Metriken aus 2.3.2. Vorschlag:
    - **H1 (Zeit):** GenAI-Unterstützung reduziert die Bearbeitungszeit bis zur bestandenen Testsuite → Time-to-first-draft, Time-to-first-pass
    - **H2 (Prozess):** GenAI-Unterstützung verändert Iterationsaufwand und Nacharbeit → Iterationszyklen, Rework-Rate, Debugging-Zeit
    - **H3 (Qualität):** Die funktionale Korrektheit und Wartbarkeit unterscheidet sich zwischen den Bedingungen → ATF-Pass-Rate, First-Time-Right-Quote, ISO-25010-Rubrik
    - **H4 (Moderation):** Die Effekte aus H1–H3 fallen je nach Erfahrungsniveau unterschiedlich aus
- Je Hypothese Null- und Alternativhypothese explizit; gerichtet vs. ungerichtet bewusst wählen (bei Qualität spricht die widersprüchliche Befundlage für ungerichtet)
- Hinweis auf den explorativen Charakter: kleine Stichprobe ⇒ Hypothesen als Strukturierungsrahmen, nicht als konfirmatorischer Test
- **Wichtig:** Die wirtschaftliche Perspektive der MRQ wird bewusst _nicht_ hypothesenförmig geprüft — sie ist eine Ableitung aus den Ergebnissen (Kapitel 5.2). Das hier in einem Satz begründen, sonst wirkt die MRQ in 6.1 nur halb beantwortet.

---

## 3 Methodisches Forschungsdesign — 8 S.

### 3.1 Grundlagen der empirischen Software-Engineering-Forschung — 2 S.

- Empirische Strategien: Experiment, Case Study, Survey — und warum das kontrollierte Experiment hier passt
- Prozessmodell Wohlin et al.: Scoping, Planning, Operation, Analysis & Interpretation, Presentation
- Gütekriterien/Validitätstypen (Conclusion, Internal, Construct, External) — hier nur einführen, Anwendung erfolgt in 5.3
- Within-Subject vs. Between-Subject: Begründung der Within-Subject-Wahl (Stichprobengröße, individuelle Varianz) und deren Preis (Carry-over, Lerneffekte)

### 3.2 Experimentdesign nach Wohlin et al. — 3 S.

- **Scoping:** Ziel nach Wohlin-Template (Analyze … for the purpose of … with respect to … from the point of view of … in the context of …)
- **Planning:**
    - Kontextauswahl: Sub-Production-Instanz, ServiceNow-Entwickler aus dem Unternehmen, N ≈ 10–12
    - Variablen: UV = GenAI-Unterstützung (M365 Copilot Chat, Modus „Schnelle Antwort"), AVs = Effizienz-/Qualitätsmetriken, Moderator = Erfahrungsniveau, Störvariablen = Aufgabe und Reihenfolge
    - **Latin-Square-Design mit 4 Gruppen** — Tabelle mit Gruppenzuordnung (Aufgabe × Bedingung × Reihenfolge)
    - Aufgaben A (Genehmiger-Eskalation, `change_request`) und B (Ticket-Routing, `incident`): Beschreibung, TODO-Skelett, bewusste strukturelle Distinktheit
    - Instrumentierung: `u_test_session_log`, UI Actions „Start"/„Ready for Testing", System Properties, ATF-Suites (5 bzw. 4 Testfälle)
    - Ethik/Datenschutz: Einwilligung, **pseudonymisierte** Erhebung
- **Operation:** Briefing-Skript, Pilottest, Interventionsregeln, Timeout-/Abbruchregeln, Protokollierung des Copilot-Modells je Session
- Abbildung: Ablaufdiagramm einer Session

### 3.3 Operationalisierung der Messkriterien für das Softwareexperiment — 3 S.

- **Tabelle Effizienzmetriken:** je Metrik Definition, Datenquelle (Log-Event), Berechnungsvorschrift, Einheit
    - Time-to-first-draft, Time-to-first-pass, Debugging-Zeit (`start_2` → `ready_N`), Iterationszyklen, Rework-Rate, First-Time-Right-Quote, qualitätsadjustierte Effizienz
- Definition „Task Completion": alle ATF-Testfälle einer Suite in einem Lauf grün
- **Tabelle Qualitätsmetriken:** Zuordnung ISO-25010-Merkmal → Indikator → Erhebungsverfahren (statische Analyse, Review-Rubrik, ATF-Ergebnis) → Skala
- Bewertungsrubrik für die manuelle Qualitätsbewertung (inkl. Bewerteranzahl / Nachvollziehbarkeit)
- **Zuordnungstabelle Hypothese → Metrik(en) → Testverfahren** — sichert, dass jede Hypothese in Kapitel 4 prüfbar ist
- Geplantes Auswertungsverfahren: gepaarte Tests (Wilcoxon Signed-Rank bzw. gepaarter t-Test), Effektstärken (r bzw. Cohen's d), Konfidenzintervalle, Signifikanzniveau

---

## 4 Empirische Evaluierung und Auswertung — 18 S.

### 4.1 Stichprobenbeschreibung: Teilnehmerprofile und Erfahrungsniveaus — 2 S.

- Rekrutierung, tatsächliches N, Ausfälle/Ausschlüsse (inkl. Begründung)
- Deskriptive Tabelle: Berufserfahrung (Jahre), ServiceNow-Erfahrung, JavaScript-Kenntnis, bisherige GenAI-Nutzung
- Bildung der Erfahrungsgruppen (Junior/Senior) inkl. Kriterium und Trennschwelle → Voraussetzung für H4
- Gruppenzuordnung im Latin Square (tatsächliche Besetzung)

### 4.2 Vorstellung der entwickelten Artefakte — 4 S.

- Aufgabenstellungen A und B gekürzt (Vollversion in den Anhang)
- Referenzlösung je Aufgabe
- Repräsentative Teilnehmerlösungen: je ein Beispiel mit und ohne GenAI, mit Kurzkommentierung typischer Muster
- ATF-Testfälle tabellarisch (Anforderung → Testschritt → erwartetes Ergebnis)
- **Nicht** jede einzelne Lösung abdrucken — Auswahl begründen, Rest in den Anhang

### 4.3 Quantitative Analyse der Entwicklungseffizienz: Statistische Testverfahren — 4 S.

- Prüfung von **H1 und H2**
- Deskriptive Statistik je Metrik und Bedingung (Median, IQR, Min/Max) + Boxplots
- Prüfung der Testvoraussetzungen (Normalverteilung → Shapiro-Wilk) und daraus abgeleitete Testwahl
- Ergebnisse der gepaarten Tests je Metrik: Teststatistik, p-Wert, Effektstärke, KI
- Reihenfolge-/Carry-over-Effekt prüfen (Vergleich der Latin-Square-Sequenzen)
- **Nur berichten, nicht interpretieren** — Deutung erfolgt in 4.5 und Kapitel 5

### 4.4 Evaluation der Code-Qualität nach ISO 25010 — 4 S.

- Prüfung von **H3**
- Funktionale Korrektheit: ATF-Pass-Rate, First-Time-Right-Quote, Fehlertypen-Klassifikation (z. B. falscher Choice-Wert, fehlende Null-Prüfung, Performance-Antipattern)
- Wartbarkeit: Rubrik-Scores, Codelänge, Kommentierung, Struktur
- Statistische Prüfung analog 4.3
- Ggf. qualitative Auffälligkeiten des GenAI-Codes (z. B. übernommene, nicht plattformkonforme Muster)

### 4.5 Synthese der Qualitäts- und Effizienzergebnisse — 4 S.

- Zusammenführung: qualitätsadjustierte Effizienz — Zeitgewinn nur zählen, wenn Qualität gehalten wird
- Prüfung von **H4**: Interaktionseffekt Erfahrung × Bedingung; bei zu kleinem N Subgruppen deskriptiv statt inferenzstatistisch auswerten und das offen benennen
- Hypothesenübersicht in Tabellenform: H1…H4 → Ergebnis → Beleg (Metrik, Test, Effektstärke)
- Explorative Zusatzbefunde (z. B. Prompt-Verhalten, Beobachtungsprotokoll)

---

## 5 Diskussion der Ergebnisse — 10 S.

### 5.1 Reflexion der Ergebnisse und Prüfung der Hypothesen — 2 S.

- Einordnung je Hypothese: bestätigt / nicht bestätigt / kein Effekt nachweisbar
- Rückbindung an die Literatur: Übereinstimmung bzw. Abweichung zu Peng et al., METR 2025, Tosi, Gorissen et al. — und Erklärungsansätze für Abweichungen (Plattformspezifik, Aufgabengröße, Modellwahl)
- Nicht-signifikante Ergebnisse selbstbewusst behandeln: Effektstärke + KI + Power-Argument statt Entschuldigung
- Erste Teilantwort auf die MRQ (technische Perspektive)

### 5.2 Ökonomische Implikationen für IT-Dienstleister — 2 S.

- Deckt die wirtschaftliche Perspektive der MRQ ab — deduktive Übertragung der Ergebnisse, kein Hypothesentest (in 2.3.3 so angekündigt)
- Übertragung der Zeitgewinne auf Aufwandsschätzung, Tagessatz-/Festpreiskalkulation
- Beispielrechnung mit den gemessenen Werten (transparent als Modellrechnung mit Annahmen kennzeichnen)
- Konsequenzen für Rollenprofile, Senioritätsmix, Review-Aufwand und Qualitätssicherung

### 5.3 Limitationen und Validitätsbetrachtung

#### 5.3.1 Limitationen der Studie — 2 S.

- Stichprobengröße, Pilotstudiencharakter, statistische Power
- Aufgabenumfang: kurze Business Rules ≠ reale Projektkomplexität
- **Strukturelle Asymmetrie der Aufgaben** (N+1-Query in A vs. `GlideAggregate` in B) und Asymmetrie der Testfallanzahl (5 vs. 4)
- Modellabhängigkeit: nur M365 Copilot Chat, Modus „Schnelle Antwort", Modellversion im Erhebungszeitraum
- Subjektivität der Qualitätsbewertung

#### 5.3.2 Interne Validität nach Wohlin et al. — 2 S.

- Lern- und Carry-over-Effekte → Gegenmaßnahme Latin Square, empirische Prüfung aus 4.3
- Selektion und Freiwilligkeit der Teilnahme
- Instrumentierung: Log-Genauigkeit, Fehlbedienung der UI Actions, Konfiguration über System Properties
- Versuchsleitereffekt / Interventionsregeln, Hawthorne-Effekt durch Beobachtung

#### 5.3.3 Externe Validität nach Wohlin et al. — 2 S.

- Generalisierbarkeit auf andere Unternehmen, Instanzen, ServiceNow-Module
- Übertragbarkeit auf andere GenAI-Werkzeuge und Modellgenerationen (kurze Halbwertszeit)
- Laborsetting vs. Projektalltag (kein Zeitdruck, keine Legacy-Codebasis, kein Code Review)

---

## 6 Schlussbetrachtungen und Forschungsausblick — 3 S.

### 6.1 Fazit und Beantwortung der Forschungsfrage — 2 S.

- Kompakte Zusammenfassung der Hypothesenergebnisse (ohne Wiederholung der Statistik)
- **Geschlossene Beantwortung der MRQ** entlang ihrer beiden Bestandteile: technische Auswirkungen (aus H1–H4) und wirtschaftliche Auswirkungen (aus 5.2)
- Keine neuen Argumente, keine neuen Quellen
- **Überschrift in der XLSX-Gliederung noch im Plural — auf Singular angleichen.**

### 6.2 Zukünftiger Forschungsbedarf — 1 S.

- Replikation mit größerer Stichprobe / mehreren Unternehmen
- Längsschnitt: Wartbarkeit über die Zeit statt Momentaufnahme
- Vergleich mehrerer Modelle bzw. plattformeigener Assistenz (Now Assist)
- Komplexere Artefakttypen (Script Includes, Integrationen, Flow Designer)

---

## Anmerkungen zur Gliederung

1. **Roter Faden ohne Teilforschungsfragen:** Da nur eine MRQ existiert, tragen die Hypothesen die Gliederungslogik. Damit das für den Leser sichtbar wird, sollte jede empirische Sektion (4.3, 4.4, 4.5) im ersten Satz benennen, welche Hypothese sie prüft, und 3.3 die Zuordnungstabelle Hypothese → Metrik → Testverfahren enthalten.
2. **Die wirtschaftliche Hälfte der MRQ hat kein empirisches Gegenstück.** Das ist methodisch vertretbar, muss aber zweimal explizit gemacht werden: einmal in 2.3.3 (warum keine Hypothese) und einmal in 6.1 (wie die MRQ trotzdem vollständig beantwortet wird). Sonst ist das der naheliegendste Angriffspunkt im Kolloquium.
3. **Überschriften angleichen:** „1.2 Forschungsfragen" und „6.1 … Forschungsfragen" stehen noch im Plural — Typst-Entwurf verwendet bereits korrekt „Forschungsfrage".
4. **Kapitel 4 ist mit 18 Seiten das Schwergewicht** — realistisch nur füllbar mit großzügigem Einsatz von Tabellen und Diagrammen. Rohdaten und vollständige Aufgabenstellungen gehören in den Anhang (`options.appendix = true` in `doc.toml` steht derzeit auf `false`).
5. **Redundanzvermeidung:** 1.3 nennt die Methoden, 3.1/3.2 begründen sie. 2.3.2 leitet die Metriken her, 3.3 operationalisiert sie. 5.3.1 nennt Limitationen allgemein, 5.3.2/5.3.3 ordnen sie den Validitätstypen zu — Doppelnennungen dort bewusst kurz halten.