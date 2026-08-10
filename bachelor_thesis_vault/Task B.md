## Task B

**Kontext:** Eingehende Incidents sollen automatisch an die passende Bearbeitungsgruppe weitergeleitet werden.

**Anforderung:** Implementieren Sie eine Business Rule, die beim Anlegen eines Incidents automatisch die zuständige Bearbeitungsgruppe ermittelt:

1. Bei niedriger oder mittlerer Priorität: Standard-Bearbeitungsgruppe anhand der Kategorie zuweisen.
2. Bei kritischer Priorität zusätzlich prüfen, ob die zuständige Gruppe überlastet ist (mehr als 10 Incidents in Bearbeitung). Falls ja, dann weisen Sie bitte die Gruppe „Major Incident Team" zu.
3. Ergebnis im Zuweisungsgruppen-Feld des Incidents hinterlegen.

**Wo Sie suchen müssen:**

| Was Sie brauchen                             | Suchraum (eingegrenzt)                                                                                                      |
| -------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------- |
| Kategorie, Priorität, Zuweisungsfeld, Status | Standardfelder auf dem Incident-Formular                                                                                    |
| Zuordnung Kategorie → Standardgruppe         | Es existiert eine eigene Tabelle dafür. Suchen Sie im Tabellenverzeichnis nach einer Tabelle mit Bezug zu Kategorie/Mapping |
## Vorbereitete Business Rule

Eine Business Rule auf `incident` (before insert) ist bereits mit folgendem Grundgerüst angelegt:

```javascript
(function executeRule(current, previous) {

    // TODO: Bearbeitungsgruppe gemäß Aufgabenstellung ermitteln und zuweisen
    
})(current, previous);
```

Die gesamte Logik ist innerhalb dieser Business Rule zu implementieren.

## Vorgehen

Bearbeiten Sie die Aufgabe wie in Ihrer regulären Arbeitspraxis. Nutzen Sie ausschließlich die Demoinstanz sowie, sofern zugewiesen, das bereitgestellte KI-Werkzeug. Auf der Instanz dürfen Sie sich frei bewegen. Verzichten Sie auf allgemeine Websuche oder externe Quellen während der Bearbeitung. Melden Sie Ihre Lösung mit dem Button _Ready for Testing_, sobald Sie sie für vollständig und korrekt halten. Die Bearbeitungszeit startet nach Betätigung des Button _Start_.