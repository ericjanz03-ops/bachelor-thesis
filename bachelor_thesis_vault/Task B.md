# Task B: Ticket-Routing bei Incidents

## Kontext

Eingehende Incidents sollen automatisch an die passende Bearbeitungsgruppe weitergeleitet werden, statt dies manuell festzulegen.

## Anforderung

Implementieren Sie __eine Business Rule__, die beim Anlegen eines Incidents automatisch die zuständige Bearbeitungsgruppe ermittelt:

1. Bei niedriger oder mittlerer Priorität soll die Standard-Bearbeitungsgruppe anhand der Kategorie des Incidents zugewiesen werden.
2. Bei kritischer Priorität soll zusätzlich geprüft werden, ob die zuständige Gruppe aktuell überlastet ist (mehr als 10 offene Incidents, d. h. Status ungleich „Resolved"/„Closed").
3. Ist die zuständige Gruppe überlastet, soll stattdessen die Gruppe `Major Incident Team` zugewiesen werden.
4. Ist die Kategorie fehlend oder unbekannt, soll der Incident dennoch erfolgreich angelegt werden können. Ein unbehandelter Fehler darf die Verarbeitung nicht unterbrechen. Es muss immer eine Zuweisungsgruppe hinterlegt werden. Wie mit der Gruppenzuweisung in diesem Fall verfahren wird, liegt in Ihrem Ermessen.
5. Das Ergebnis der Zuweisung muss im Feld `assignment_group` auf dem Incident hinterlegt werden.

## Datenmodell-Referenz

Folgende Daten existieren wie definiert in der Instanz:

| Objekt                     | Feld/Eigenschaft      | Beschreibung                                                                                                               |
| -------------------------- | --------------------- | -------------------------------------------------------------------------------------------------------------------------- |
| `incident`                 | `category`            | Kategorie des Incidents                                                                                                    |
| `incident`                 | `priority`            | Choice-Feld<br>`planning = 5`/`low = 4`/`moderate = 3`/ `high = 2`/`critical = 1`                                          |
| `incident`                 | `assignment_group`    | Zielfeld für die Gruppenzuweisung (Standardfeld, Referenz auf `sys_user_group`)                                            |
| `incident`                 | `state`               | Zur Bestimmung offener Incidents  <br>`new = 1`/`in progress = 2`/`on hold = 3`/`resolved = 6`/`closed = 7`/`canceled = 8` |
| `u_category_group_mapping` | `u_category`          | Choice-Feld<br>enthält die gleiches Optionen wie incident.category                                                         |
| `u_category_group_mapping` | `u_group`             | Referenz auf `sys_user_group` Standardgruppe für diese Kategorie                                                           |
| Gruppe                     | `Major Incident Team` | Feste Eskalationsgruppe                                                                                                    |

## Vorbereitete Business Rule

Eine Business Rule auf `incident` (before insert) ist bereits mit folgendem Grundgerüst angelegt:

```javascript
(function executeRule(current, previous) {

    // TODO: Bearbeitungsgruppe gemäß Aufgabenstellung ermitteln und zuweisen
    
})(current, previous);
```

Die gesamte Logik ist innerhalb dieser Business Rule zu implementieren.

## Vorgehen

Bearbeiten Sie die Aufgabe wie in Ihrer regulären Arbeitspraxis. Nutzen Sie ausschließlich die Testinstanz sowie, sofern zugewiesen, das bereitgestellte KI-Werkzeug. Verzichten Sie auf allgemeine Websuche oder externe Quellen während der Bearbeitung. Melden Sie Ihre Lösung mit dem Button _Ready for Testing_, sobald Sie sie für vollständig und korrekt halten. Die Bearbeitungszeit starten nach Betätigung des Button _Start_.
