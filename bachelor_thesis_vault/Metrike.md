# Effizienz

### 1. Time-to-first-draft

Zeitspanne vom ersten `start`-Eintrag bis zum **ersten** `ready_for_testing`-Eintrag derselben Aufgabe. Misst, wie lange der erste Lösungsversuch braucht, unabhängig davon, ob er besteht.

### 2. Time-to-first-pass

Zeitspanne vom ersten `start`-Eintrag bis zu dem `ready_for_testing`-Eintrag, dessen ATF-Lauf **erstmals alle 5 Testfälle** bestanden hat. Das ist deine zentrale Gesamtzeit-Metrik pro Aufgabe/Bedingung.

### 3. Debugging-Zeit

**Debugging-Zeit = Zeitspanne von `start_2` bis `ready_N` (finaler, bestandener ATF-Lauf)**

Bei mehr als zwei Zyklen (also mehrfachem Scheitern) heißt das konkret: die Summe aus allen Bearbeitungsphasen ab dem zweiten Zyklus:

`Debugging-Zeit = Σ (start_i → ready_i) für i = 2 bis N`

### 4. Iterationszyklen

Schlicht die **Anzahl der `start`-Einträge** pro Aufgabe bis zum ersten vollständigen Pass. Ein Zyklus = ein Start-Ready-Paar.

### 5. Rework-Rate

Anteil der Zyklen, die zu einem fehlgeschlagenen ATF-Lauf führten, an der Gesamtzahl der Zyklen:  
`Rework-Rate = (Anzahl fehlgeschlagener ready_for_testing-Einträge) / (Gesamtzahl ready_for_testing-Einträge)`

### 6. First-Time-Right-Quote

Binär/aggregiert über alle Teilnehmer: Anteil der Sitzungen, bei denen bereits der **erste** ATF-Lauf alle 5 Tests bestanden hat (also nur 1 Iterationszyklus nötig war):  
`FTR-Quote = Anzahl Teilnehmer mit Pass beim 1. Zyklus / Gesamtzahl Teilnehmer` (getrennt je Bedingung berechnen)

### 7. Qualitätsadjustierte Effizienz (Zeit pro bestandenem Testfall)

`Time-to-first-pass / 5` (bei vollständigem Pass) — bei Timeout/Abbruch stattdessen `Timeout-Zeit / Anzahl zuletzt bestandener Testfälle`, um auch nicht abgeschlossene Sitzungen sinnvoll vergleichbar zu machen, statt sie ganz auszuschließen.