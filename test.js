(function executeRule(current, previous) {

    if (!current.requested_by || !current.risk) {
        return;
    }

    var requester = new GlideRecord('sys_user');

    if (!requester.get(current.requested_by)) {
        return;
    }

    var department = requester.department;

    // Risiko niedrig oder mittel
    if (current.risk == '3' || current.risk == '4') {

        var departmentId = requester.getValue('department');

        var grp = new GlideRecord('sys_user_group');
        grp.addQuery('u_department', departmentId);
        grp.addQuery('u_group_type', 'approval');
        grp.query();

        if (grp.next()) {
            current.u_approval_group = grp.getUniqueValue();
        }

        return;
    }

    // Risiko hoch
    if (current.risk == '2') {

        var approver = findAvailableApprover(department);

        if (approver) {
            current.u_approver = approver;
        } else {
            current.u_approval_group = '7942f5882bda0f904686f06fe291bfab';
        }
    }

    function findAvailableApprover(departmentId) {

        var user = new GlideRecord('sys_user');
        user.addQuery('department', departmentId);
        user.addQuery('u_available', true);
        user.query();

        while (user.next()) {

            // Prüfen, ob Benutzer die erforderliche Genehmiger-Rolle hat
            var roleCheck = new GlideRecord('sys_user_has_role');
            roleCheck.addQuery('user', user.sys_id);
            roleCheck.addQuery('role.name', 'change_approver'); // ggf. Rollenname anpassen
            roleCheck.query();

            if (roleCheck.next()) {
                return user.sys_id.toString();
            }
        }

        return null;
    }

})(current, previous);