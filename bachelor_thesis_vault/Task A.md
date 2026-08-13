## Task A 

**Kontext:** Genehmiger für Change Requests werden aktuell manuell zugewiesen. Dies soll automatisiert werden.

**Anforderung:** Implementieren Sie eine Business Rule, die beim Anlegen eines Change Requests automatisch einen passenden Genehmiger zuweist:

1. Bei geringem oder mittlerem Risiko: Genehmigungsgruppe der Abteilung (Department) des Antragstellers zuweisen.
2. Bei hohem Risiko: verfügbaren Genehmiger aus der Abteilung direkt zuweisen. Ist keiner verfügbar, Gruppe „Change Escalation Board" zuweisen.
3. Ergebnis auf dem Change Request hinterlegen.


**Wo Sie suchen müssen:**

| Was Sie brauchen                                             | Suchraum                                                                                                |
| ------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------- |
| Risiko, Antragsteller                                        | Standardfeld auf dem Change-Request-Formular                                                            |
| Zielfelder für Genehmigungsgruppe/Genehmiger                 | Individuelle Felder auf dem Change-Request-Formular                                                     |
| Abteilungszuordnung und Kennzeichnung als Genehmigungsgruppe | Auf dem Gruppen-Datensatz (`sys_user_group`)                                                            |
| Verfügbarkeit eines Genehmigers                              | Auf dem Benutzerprofil (`sys_user`)                                                                     |
| Berechtigung als Genehmiger                                  | Rollen sind nicht direkt auf dem Benutzerprofil gespeichert. Prüfen Sie die Tabelle `sys_user_has_role` |
## Vorbereitete Business Rule

Eine Business Rule auf `change_request` (before insert) ist bereits mit folgendem Grundgerüst angelegt:

```javascript 

(function executeRule(current, previous) {

// TODO: Genehmiger/Gruppe gemäß Aufgabenstellung ermitteln und zuweisen

})(current, previous);

```

Die gesamte Logik ist innerhalb dieser Business Rule zu implementieren.

## Vorgehen

Bearbeiten Sie die Aufgabe wie in Ihrer regulären Arbeitspraxis. Nutzen Sie ausschließlich die Demoinstanz sowie, sofern zugewiesen, das bereitgestellte KI-Werkzeug. Auf der Instanz dürfen Sie sich frei bewegen. Verzichten Sie auf allgemeine Websuche oder externe Quellen während der Bearbeitung. Melden Sie Ihre Lösung mit dem Button _Ready for Testing_, sobald Sie sie für vollständig und korrekt halten. Die Bearbeitungszeit startet nach Betätigung des Button _Start_.