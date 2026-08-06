# Task A: Genehmiger-Eskalation bei Change Requests

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

| Objekt           | Feld/Eigenschaft          | Beschreibung                                                                                                |
| ---------------- | ------------------------- | ----------------------------------------------------------------------------------------------------------- |
| `change_request` | `risk`                    | Choice-Feld<br>`low = 4`/`moderate = 3`/`high = 2`                                                          |
| `change_request` | `requested_by`            | Referenz auf `sys_user`                                                                                     |
| `change_request` | `u_approval_group`        | Zielfeld für Gruppenzuweisung                                                                               |
| `change_request` | `u_approver`              | Zielfeld für direkte Zuweisung an eine Person                                                               |
| `sys_user_group` | `u_department`            | Referenz auf Abteilung                                                                                      |
| `sys_user_group` | `u_group_type`            | Bei Genehmigungsgruppen = `approval`                                                                        |
| `sys_user`       | `department`              | Referenz auf Abteilung                                                                                      |
| `sys_user`       | `u_available`             | Boolean, Verfügbarkeit des Genehmigers                                                                      |
| Rolle            | `change_approver`         | Berechtigung für Genehmiger (verknüpft über Tabelle `sys_user_has_role`, kein direktes Feld auf `sys_user`) |
| Gruppe           | `Change Escalation Board` | Feste Eskalationsgruppe (bereits angelegt)                                                                  |

## Vorbereitete Business Rule

Eine Business Rule auf `change_request` (before insert) ist bereits mit folgendem Grundgerüst angelegt:

```javascript 

(function executeRule(current, previous) {

// TODO: Genehmiger/Gruppe gemäß Aufgabenstellung ermitteln und zuweisen

})(current, previous);

```

Die gesamte Logik ist innerhalb dieser Business Rule zu implementieren.

## Vorgehen

Bearbeiten Sie die Aufgabe wie in Ihrer regulären Arbeitspraxis. Nutzen Sie ausschließlich die Testinstanz sowie, sofern zugewiesen, das bereitgestellte KI-Werkzeug. Verzichten Sie auf allgemeine Websuche oder externe Quellen während der Bearbeitung. Melden Sie Ihre Lösung mit dem Button _Ready for Testing_, sobald Sie sie für vollständig und korrekt halten. Die Bearbeitungszeit starten nach Betätigung des Button _Start_.