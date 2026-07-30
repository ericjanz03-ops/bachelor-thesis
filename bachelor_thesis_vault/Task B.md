# Aufgabenstellung: Ticket-Routing bei Incidents

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
| `incident`                 | `category`            | Kategorie des Incidents (String)                                                                                           |
| `incident`                 | `priority`            | Choice-Feld<br>`planning = 5`/`low = 4`/`moderate = 3`/ `high = 2`/`critical = 1`                                          |
| `incident`                 | `assignment_group`    | Zielfeld für die Gruppenzuweisung (Standardfeld, Referenz auf `sys_user_group`)                                            |
| `incident`                 | `state`               | Zur Bestimmung offener Incidents  <br>`new = 1`/`in progress = 2`/`on hold = 3`/`resolved = 6`/`closed = 7`/`canceled = 8` |
| `u_category_group_mapping` | `u_category`          | Choice-Feld<br>enthält die gleiches Optionen wie incident.category                                                         |
| `u_category_group_mapping` | `u_group`             | Referenz auf `sys_user_group` Standardgruppe für diese Kategorie                                                           |
| Gruppe                     | `Major Incident Team` | Feste Eskalationsgruppe                                                                                                    |

## Vorbereitetes Artefakt

Eine Business Rule auf `incident` (before insert) ist bereits mit folgendem Grundgerüst angelegt:

```javascript
(function executeRule(current, previous) {

    // TODO: Bearbeitungsgruppe gemäß Aufgabenstellung ermitteln und zuweisen
    
})(current, previous);
```

Die gesamte Logik ist innerhalb dieser Business Rule zu implementieren.

## Vorgehen

Bearbeiten Sie die Aufgabe wie in Ihrer regulären Arbeitspraxis. Nutzen Sie ausschließlich die Testinstanz sowie – sofern zugewiesen – das bereitgestellte KI-Werkzeug; verzichten Sie auf allgemeine Websuche oder externe Quellen während der Bearbeitung. Melden Sie Ihre Lösung, sobald Sie sie für vollständig und korrekt halten.

# Musterlösung

```javascript
(function executeRule(current, previous) {

    try {
	    // '1' = critical ... '5' = planning
        var priority = current.priority.toString(); 
        var category = current.category.toString();

        if (!category) {
            // Anforderung 4: Kategorie fehlt/unbekannt -> trotzdem muss eine
            // Zuweisungsgruppe hinterlegt werden. Eskalationsgruppe als
            // sicherer Fallback.
            assignMajorIncidentTeam(current);
            return;
        }

        var defaultGroupSysId = findDefaultGroupForCategory(category);

        if (!defaultGroupSysId) {
            // Kategorie vorhanden, aber kein Mapping gefunden -> ebenfalls
            // Fallback
            assignMajorIncidentTeam(current);
            return;
        }

        if (priority == '1') {
            // Anforderung 2 & 3: Kritisch -> Überlastungsprüfung
            if (isGroupOverloaded(defaultGroupSysId)) {
                assignMajorIncidentTeam(current);
            } else {
                current.assignment_group = defaultGroupSysId;
            }
        } else {
            // Anforderung 1: Low/Moderate (und High) -> Standardgruppe der
            // Kategorie
            current.assignment_group = defaultGroupSysId;
        }

    } catch (e) {
        // Anforderung 4: Kein unbehandelter Fehler darf die Verarbeitung
        // unterbrechen. Eskalationsgruppe stellt sicher, dass immer eine
        // Zuweisung erfolgt.
        assignMajorIncidentTeam(current);
    }

    function findDefaultGroupForCategory(category) {
        var mappingGr = new GlideRecord('u_category_group_mapping');
        mappingGr.addQuery('u_category', category);
        mappingGr.query();
        if (mappingGr.next()) {
            return mappingGr.u_group.toString();
        }
        return null;
    }

    function isGroupOverloaded(groupSysId) {
        var incGr = new GlideAggregate('incident');
        incGr.addQuery('assignment_group', groupSysId);
        incGr.addQuery('state', 'NOT IN', '6,7'); // ungleich Resolved/Closed
        incGr.addAggregate('COUNT');
        incGr.query();
        if (incGr.next()) {
            var count = parseInt(incGr.getAggregate('COUNT'), 10);
            return count > 10;
        }
        return false;
    }

    function assignMajorIncidentTeam(gr) {
        var escGr = new GlideRecord('sys_user_group');
        escGr.addQuery('name', 'Major Incident Team');
        escGr.query();
        if (escGr.next()) {
            gr.assignment_group = escGr.getUniqueValue();
        }
    }

})(current, previous);
```