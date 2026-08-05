
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