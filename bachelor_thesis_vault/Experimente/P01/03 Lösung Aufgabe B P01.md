```javascript 
(function executeRule(current, previous) {

    var assignmentGroup = '';

    // Standardgruppe anhand der Kategorie ermitteln
    var mappingGR = new GlideRecord('u_category_group_mapping');
    mappingGR.addQuery('u_category', current.category);
    mappingGR.query();

    if (mappingGR.next()) {
        assignmentGroup = mappingGR.u_group.toString();
    }

    // Priorität prüfen
    if (current.priority == '1') {

        // Anzahl offener Incidents der Standardgruppe ermitteln
        var incidentGR = new GlideRecord('incident');
        incidentGR.addQuery('assignment_group', assignmentGroup);
        incidentGR.addQuery('state', 'NOT IN', '6,7'); // 6=Resolved, 7=Closed
        incidentGR.query();

        var openCount = incidentGR.getRowCount();

        if (openCount > 10) {

            // Major Incident Team ermitteln
            var majorGroupGR = new GlideRecord('sys_user_group');
            majorGroupGR.addQuery('name', 'Major Incident Team');
            majorGroupGR.query();

            if (majorGroupGR.next()) {
                current.assignment_group = majorGroupGR.getUniqueValue();
            }

        } else {
            current.assignment_group = assignmentGroup;
        }

    } else if (current.priority == '3' || current.priority == '4') {

        current.assignment_group = assignmentGroup;
    }

})(current, previous);
```
