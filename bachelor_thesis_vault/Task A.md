# Aufgabenstellung: Genehmiger-Eskalation bei Change Requests

## Kontext

In der aktuellen ServiceNow-Instanz werden Genehmiger für Change Requests manuell zugewiesen. Dies soll automatisiert werden.

## Anforderung

Implementieren Sie eine Business Rule, die beim Anlegen eines Change Requests automatisch einen passenden Genehmiger zuweist:

1. Bei Risiko-Level "Low" oder "Moderate" soll die zuständige Genehmigungsgruppe der Abteilung des Antragstellers (`requested_by.department`) zugewiesen werden.

2. Bei Risiko-Level "High" soll geprüft werden, ob innerhalb der Abteilung ein verfügbarer Genehmiger vorhanden ist. Ein Genehmiger gilt als verfügbar, wenn das Feld `u_available` auf dem `sys_user`-Datensatz `true` ist und der Nutzer die Rolle `change_approver` besitzt. Ist ein solcher Nutzer vorhanden, soll dieser direkt als Genehmiger zugewiesen werden.

3. Ist bei Risiko-Level "High" kein verfügbarer Genehmiger vorhanden, soll stattdessen die Gruppe mit dem Namen `Change Escalation Board` zugewiesen werden.

4. Fehlt die Abteilungszuordnung des Antragstellers, soll der Change Request dennoch erfolgreich angelegt werden können. Ein unbehandelter Fehler darf die Verarbeitung nicht unterbrechen. Es muss immer entweder ein Genehmiger oder eine Genehmigungsgruppe hinterlegt werden. Wie mit der Zuweisung in diesem Fall verfahren wird, liegt in Ihrem Ermessen.

5. Das Ergebnis der Zuweisung muss im Feld `u_approval_group` (bei Gruppenzuweisung) bzw. `u_approver` (bei direkter Zuweisung an eine Person) auf dem Change Request hinterlegt werden.

## Datenmodell-Referenz

| Objekt           | Feld/Eigenschaft          | Beschreibung                                                                                        |
| ---------------- | ------------------------- | --------------------------------------------------------------------------------------------------- |
| `change_request` | `risk`                    | Choice-Feld<br>`low = 4`/`moderate = 3`/`high = 2`                                                  |
| `change_request` | `requested_by`            | Referenz auf `sys_user`                                                                             |
| `change_request` | `u_approval_group`        | Zielfeld für Gruppenzuweisung                                                                       |
| `change_request` | `u_approver`              | Zielfeld für direkte Zuweisung an eine Person                                                       |
| `sys_user_group` | `u_department`            | Referenz auf Abteilung                                                                              |
| `sys_user_group` | `u_group_type`            | Bei Genehmigungsgruppen = `approval`                                                                |
| `sys_user`       | `department`              | Referenz auf Abteilung                                                                              |
| `sys_user`       | `u_available`             | Boolean, Verfügbarkeit des Genehmigers                                                              |
| Rolle            | `change_approver`         | Berechtigung für Genehmiger (verknüpft über `sys_user_has_role`, kein direktes Feld auf `sys_user`) |
| Gruppe           | `change_escalation_board` | Feste Eskalationsgruppe (bereits angelegt)                                                          |

## Vorbereitetes Artefakt

Eine Business Rule auf `change_request` (before insert/update) ist bereits mit folgendem Grundgerüst angelegt:

```javascript 

(function executeRule(current, previous) {

// TODO: Genehmiger/Gruppe gemäß Aufgabenstellung ermitteln und zuweisen

})(current, previous);

```

Die gesamte Logik ist innerhalb dieser Business Rule zu implementieren.

## Vorgehen

Bearbeiten Sie die Aufgabe wie in Ihrer regulären Arbeitspraxis. Nutzen Sie ausschließlich die Testinstanz sowie – sofern zugewiesen – das bereitgestellte KI-Werkzeug; verzichten Sie auf allgemeine Websuche oder externe Quellen während der Bearbeitung. Melden Sie Ihre Lösung, sobald Sie sie für vollständig und korrekt halten.




# Musterlösung

```javascript 
(function executeRule(current, previous) {

    try {
	    // '4' = low, '3' = moderate, '2' = high
        var risk = current.risk.toString();
        
        var departmentSysId = current.requested_by.department.toString();

        if (!departmentSysId) {
            // Anforderung 4: Abteilung fehlt -> trotzdem muss eine Zuweisung
            // erfolgen. Eskalationsgruppe dient hier als sicherer Fallback.
            assignEscalationGroup(current);
            return;
        }

        if (risk == '4' || risk == '3') {
            // Anforderung 1: Low/Moderate -> Genehmigungsgruppe der Abteilung
            assignDepartmentApprovalGroup(current, departmentSysId);
        } else if (risk == '2') {
            // Anforderung 2 & 3: High -> verfügbarer Genehmiger oder Eskalation
            var approverSysId = findAvailableApprover(departmentSysId);
            if (approverSysId) {
                current.u_approver = approverSysId;
            } else {
                assignEscalationGroup(current);
            }
        } else {
		    // Unerwarteter Risk-Wert -> Sicherheitsnetz, kein Change ohne
		    // Zuweisung
            assignEscalationGroup(current);
        }

    } catch (e) {
        // Anforderung 4: Verarbeitung darf durch keinen unbehandelten Fehler
        // unterbrochen werden. Eskalationsgruppe stellt sicher, dass immer
        // eine Zuweisung erfolgt.
        assignEscalationGroup(current);
    }

    function assignDepartmentApprovalGroup(gr, departmentSysId) {
        var groupGr = new GlideRecord('sys_user_group');
        groupGr.addQuery('u_department', departmentSysId);
        groupGr.addQuery('u_group_type', 'approval');
        groupGr.query();
        if (groupGr.next()) {
            gr.u_approval_group = groupGr.getUniqueValue();
        } else {
            // Keine passende Genehmigungsgruppe gefunden -> Eskalation
            assignEscalationGroup(gr);
        }
    }

    function findAvailableApprover(departmentSysId) {
        var userGr = new GlideRecord('sys_user');
        userGr.addQuery('department', departmentSysId);
        userGr.addQuery('u_available', true);
        userGr.query();
        while (userGr.next()) {
            if (userHasApproverRole(userGr.getUniqueValue())) {
                return userGr.getUniqueValue();
            }
        }
        return null;
    }

    function userHasApproverRole(userSysId) {
        var roleGr = new GlideRecord('sys_user_has_role');
        roleGr.addQuery('user', userSysId);
        roleGr.addQuery('role.name', 'change_approver');
        roleGr.query();
        return roleGr.next();
    }

    function assignEscalationGroup(gr) {
        var escGr = new GlideRecord('sys_user_group');
        escGr.addQuery('name', 'Change Escalation Board');
        escGr.query();
        if (escGr.next()) {
            gr.u_approval_group = escGr.getUniqueValue();
        }
    }
    
})(current, previous);
```