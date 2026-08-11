## Sessiondaten

| Feld                                     | Wert                   |
| ---------------------------------------- | ---------------------- |
| Teilnehmer-ID                            | Max Kuczil             |
| Datum                                    | 11.08.                 |
| Uhrzeit Start / Ende                     |                        |
| Gruppe (Latin-Square-Zuordnung)          | G1                     |
| Reihenfolge Aufgaben                     | Aufgabe A → Aufgabe B  |
| Bedingung Aufgabe 1                      | ohne Copilot           |
| Bedingung Aufgabe 2                      | mit Copilot            |
| Copilot-Modus                            | Schnelle Antwort (fix) |
| Copilot-Modellversion (falls zutreffend) | GPT-5.5                |
| Erfahrungsgruppe (Junior/Senior)         | Junior                 |


---

## Beobachtungslog Aufgabe A

**Task:** Genehmiger-Eskalation bei Change Requests **Bedingung:** ohne Copilot

- 11:09 Uhr angefangen 
- keine Nutzung von SN Utils
- nutzt xplore
- 


---

## Beobachtungslog Aufgabe B

**Task:** Ticket-Routing bei Incidents **Bedingung:** mit Copilot

+ zu 2.: Ist die zuständige gruppe die aus 1.?

# Sonstige Hinweise



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
|Maximale Bearbeitungszeit pro Aufgabe|___ Minuten|Bearbeitung wird beendet, Status im Log als "Timeout" vermerkt|
|Maximale Anzahl Iterationszyklen|___|Bei Erreichen: Rücksprache, ob Fortsetzung sinnvoll|
|Abbruch auf Wunsch des Teilnehmenden|—|Grund erfragen (freiwillig), im Protokoll vermerken|

---

## Post-Session-Notizen

## **Allgemeine Auffälligkeiten (Verhalten, Kommentare, Hawthorne-Effekt-Indizien):**

## **Technische Probleme (Instanz, ATF, Logging):**

## **Subjektiver Eindruck Schwierigkeitsgrad Aufgabe A vs. B:**

## **Sonstiges:**