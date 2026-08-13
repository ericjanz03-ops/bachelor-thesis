## Sessiondaten

| Feld                                     | Wert                  |
| ---------------------------------------- | --------------------- |
| Teilnehmer                               | Michael Königseder    |
| Datum                                    | 12.08.                |
| Uhrzeit Start / Ende                     | 11:00 - 12:30         |
| Gruppe (Latin-Square-Zuordnung)          | G3                    |
| Reihenfolge Aufgaben                     | Aufgabe A → Aufgabe B |
| Bedingung Aufgabe 1                      | mit Copilot           |
| Bedingung Aufgabe 2                      | ohne Copilot          |
| Copilot-Modus                            | Schnelle Antwort      |
| Copilot-Modellversion (falls zutreffend) | GPT-5.5               |
| Erfahrungsgruppe (Junior/Senior)         | Senior                |


---

## Beobachtungslog Aufgabe A

**Task:** Genehmiger-Eskalation bei Change Requests **Bedingung:** ohne Copilot

- 11:13 start
- geht ohne nachzusehen von der Rolle approver_user aus
- +1 min da vergessen auf start zu klicken beim 2. mal start
- Copilot spuckt einmal keinen Code aus --> beenden und neu starten hat geholfen
- zu sehr am standard
- Felder assignment_group und assigned_to statt individuelle Felder u_approval_group und u_approver befüllt --> Aufgabenstellung nicht genau genau gelesen, da er das Copilot von sich aus mitgegeben hat

---
## Beobachtungslog Aufgabe B

**Task:** Ticket-Routing bei Incidents **Bedingung:** mit Copilot

- 12:07 start
- Copilot chat leider direkt im Anschluss gelöscht

---

# Sonstige Hinweise

-

## **Auffälligkeiten Prompt-Verhalten (nur bei Copilot-Bedingung):**


---

## Interventionstypen (Klassifikationsschema)

Jede Intervention wird nach Typ erfasst — Grundlage für die spätere Unterscheidung von technischer und inhaltlicher Hilfe in der Auswertung.

| Typ                           | Beschreibung                                                     | Beispiel                                                  | Zulässig?                                                                |
| ----------------------------- | ---------------------------------------------------------------- | --------------------------------------------------------- | ------------------------------------------------------------------------ |
| **T – Technisch**             | Hilfe bei Bedienung der Instanz/UI, nicht bei der Lösung selbst  | "Wo finde ich den Skript-Editor?", ATF-Suite hängt        | Ja, jederzeit                                                            |
| **I – Inhaltlich (kritisch)** | Hinweis zur eigentlichen Problemlösung / Logik der Business Rule | "Wie greife ich auf die Abteilung des Antragstellers zu?" | Nein — nur nach vorab definierten Eskalationsregeln, mit Protokollierung |
| **A – Abbruch/Timeout**       | Experimentator beendet die Bearbeitung wegen Zeitüberschreitung  | Timeout erreicht ohne bestandene ATF-Suite                | Nach Timeout-Regel                                                       |

**Hinweis:** Jede I-Intervention ist ein potenzieller Störfaktor für die interne Validität und muss im Beobachtungslog mit Zeitstempel, Wortlaut (sinngemäß) und Begründung dokumentiert werden, damit sie in 4.3/5.3.2 nachvollziehbar berücksichtigt werden kann.

---

## Timeout- / Abbruchregeln

|Regel|Wert|Konsequenz|
|---|---|---|
|Maximale Bearbeitungszeit pro Aufgabe|45 Minuten|Bearbeitung wird beendet, Status im Log als "Timeout" vermerkt|
|Abbruch auf Wunsch des Teilnehmenden|nein|Grund erfragen (freiwillig), im Protokoll vermerken|

---

# Auswertung
## Aufgabe A – Rohdaten aus u_test_session_log

**Bedingung:** mit Copilot

|Zyklus|Event (start/ready)|Zeitstempel|Ausführungs-ID (ATF)|ATF-Ergebnis (Pass/Fail, x/y Tests)|Fehlernotiz|Notiz|
|---|---|---|---|---|---|---|
|1|start_1||||||
|1|ready_1||||||
|2|start_2||||||
|2|ready_2||||||
|...|||||||

**Abschluss:** 
- Task Completion: nicht erreicht
- Timeout: ja

---

## Aufgabe B – Rohdaten aus u_test_session_log

**Bedingung:** ohne Copilot

|Zyklus|Event (start/ready)|Zeitstempel|Ausführungs-ID (ATF)|ATF-Ergebnis (Pass/Fail, x/y Tests)|Fehlernotiz|Notiz|
|---|---|---|---|---|---|---|
|1|start_1||||||
|1|ready_1||||||
|2|start_2||||||
|...|||||||

**Abschluss:**
- Task Completion: erreicht bei Zyklus 1
- Timeout / Abbruch: nein

---

## Berechnete Effizienzmetriken (pro Aufgabe, aus obigen Rohdaten)

|Metrik|Aufgabe A|Aufgabe B|Berechnung (Referenz Metriken.md)|
|---|---|---|---|
|Time-to-first-draft|||start_1 → ready_1|
|Time-to-first-pass|||start_1 → erster bestandener ready_N|
|Debugging-Zeit|||Σ (start_i → ready_i) für i = 2 bis N|
|Iterationszyklen|||Anzahl start-Einträge bis erster Pass|
|Rework-Rate|||fehlgeschlagene ready-Einträge / alle ready-Einträge|
|First-Time-Right (ja/nein)|||Pass bereits bei Zyklus 1?|
|Qualitätsadj. Effizienz|||Time-to-first-pass / Anzahl Tests (bzw. Timeout / best. Tests)|

---

## Übertrag in Protokoll-Kopfdaten

Diese Werte anschließend oben ins `01 Protokoll <Name>.md` übernehmen:

- Uhrzeit Start / Ende (gesamte Session):
- Copilot-Modellversion (Screenshot-Beleg vorhanden: ja/nein):
- Anzahl Interventionen (T / I / A) je Aufgabe: