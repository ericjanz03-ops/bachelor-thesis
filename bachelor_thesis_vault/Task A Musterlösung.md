
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