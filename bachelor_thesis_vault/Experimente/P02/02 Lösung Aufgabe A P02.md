```javascript 
(function executeRule(current, previous /* null when async */) {

    gs.info('[CR_APPROVAL] Business Rule gestartet für Change: ' + current.getDisplayValue('number'));

    // Antragsteller prüfen
    var requesterId = current.getValue('requested_by');

    if (!requesterId) {
        gs.info('[CR_APPROVAL] Kein requested_by gesetzt.');
        return;
    }

    gs.info('[CR_APPROVAL] requested_by: ' + requesterId);

    // Antragsteller laden
    var requester = new GlideRecord('sys_user');
    if (!requester.get(requesterId)) {
        gs.info('[CR_APPROVAL] Benutzer konnte nicht geladen werden.');
        return;
    }

    var departmentId = requester.getValue('department');

    gs.info('[CR_APPROVAL] Department: ' + departmentId);

    if (!departmentId) {
        gs.info('[CR_APPROVAL] Benutzer hat kein Department.');
        return;
    }

    var risk = current.getValue('risk');

    gs.info('[CR_APPROVAL] Risiko-Wert: ' + risk +
        ' | Anzeigewert: ' + current.getDisplayValue('risk'));

    // Low (4) oder Moderate (3)
    if (risk == '4' || risk == '3') {

        gs.info('[CR_APPROVAL] Pfad LOW/MODERATE betreten.');

        var groupGR = new GlideRecord('sys_user_group');
        groupGR.addQuery('u_department', departmentId);
        groupGR.setLimit(1);
        groupGR.query();

        if (groupGR.next()) {

            gs.info('[CR_APPROVAL] Gruppe gefunden: ' +
                groupGR.getDisplayValue('name') +
                ' (' + groupGR.getUniqueValue() + ')');

            current.setValue('assignment_group', groupGR.getUniqueValue());
            current.setValue('assigned_to', '');

        } else {

            gs.info('[CR_APPROVAL] Keine Gruppe mit u_department=' +
                departmentId + ' gefunden.');
        }
    }

    // High (2) oder Very High (1)
    else if (risk == '2' || risk == '1') {

        gs.info('[CR_APPROVAL] Pfad HIGH/VERY HIGH betreten.');

        var approverFound = false;

        var roleGR = new GlideRecord('sys_user_has_role');
        roleGR.addQuery('role.name', 'approver_user');
        roleGR.addQuery('user.active', true);
        roleGR.addQuery('user.department', departmentId);
        roleGR.setLimit(1);
        roleGR.query();

        if (roleGR.next()) {

            gs.info('[CR_APPROVAL] Genehmiger gefunden: ' +
                roleGR.user.getDisplayValue());

            current.setValue('assigned_to', roleGR.getValue('user'));
            current.setValue('assignment_group', '');

            approverFound = true;
        }

        if (!approverFound) {

            gs.info('[CR_APPROVAL] Kein Genehmiger gefunden. Suche Escalation Group.');

            var escalationGroup = new GlideRecord('sys_user_group');
            escalationGroup.addQuery('name', 'Change Escalation Board');
            escalationGroup.setLimit(1);
            escalationGroup.query();

            if (escalationGroup.next()) {

                gs.info('[CR_APPROVAL] Escalation Group gefunden: ' +
                    escalationGroup.getUniqueValue());

                current.setValue('assignment_group', escalationGroup.getUniqueValue());
                current.setValue('assigned_to', '');

            } else {

                gs.info('[CR_APPROVAL] Gruppe "Change Escalation Board" nicht gefunden.');
            }
        }
    }

    else {

        gs.info('[CR_APPROVAL] Risiko entspricht keinem erwarteten Wert. Risk=' + risk);
    }

    gs.info('[CR_APPROVAL] Business Rule beendet.');

})(current, previous);
```
