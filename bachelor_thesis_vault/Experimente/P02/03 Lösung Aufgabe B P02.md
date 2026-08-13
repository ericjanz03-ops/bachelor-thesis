```javascript 
(function executeRule(current, previous /*null when async*/ ) {

    // TODO: Bearbeitungsgruppe gemäß Aufgabenstellung ermitteln und zuweisen
	var majorGroupSysID = "3726437d939e8fd0dcfefc16dd03d620";

    var mappingGR = new GlideRecord("u_category_group_mapping");
    mappingGR.addQuery("u_category", current.category);
    mappingGR.query();

    // No mapping found for category of inc
    if (!mappingGR.next()) {
        return;
    }

    var assignmentGroup = mappingGR.u_group.toString();

	// If priority is Critical = 1 then check count of incs
	if(current.priority == '1') {
		var grInc = new GlideAggregate("incident");
		grInc.addQuery("assignment_group", assignmentGroup);
		grInc.addQuery("state", "2");
		grInc.addAggregate("COUNT");
		grInc.query();
		
		// counter
		var count = 0;
		if(grInc.next()) {
			count = parseInt(grInc.getAggregate("COUNT"), 10);
		}
		// more than 10 incs then assign to Major Incident Team
		if(count > 10) {
			var majorGroupGR = new GlideRecord("sys_user_group");
			if(majorGroupGR.get(majorGroupSysID)) {
				assignmentGroup = majorGroupGR.getUniqueValue();
			}
		}
	}

	current.assignment_group = assignmentGroup;

})(current, previous);
```
