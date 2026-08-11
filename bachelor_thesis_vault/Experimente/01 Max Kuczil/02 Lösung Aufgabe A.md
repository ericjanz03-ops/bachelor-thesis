```javascript 
(function executeRule(current, previous /*null when async*/) {

	var risk = current.getValue('risk');

	if(risk == 3 || risk == 4){
		
		//Antragsteller Department holen
		var requestorDepartment = current.getValue('requested_by.department');

		//Gruppe überprüfen
		var gr = new GlideRecord('sys_user_group');
		gr.addQuery('u_department', requestorDepartment);
		gr.addQuery('u_group_type','approval');
		gr.query();

		if (gr.next()){
			var finalGroup = gr.getUniqueValue();
			current.setValue('u_approval_group',finalGroup);
		}

	}

	if(risk == 2){

		//Genehmiger überprüfen
		var gr = new GlideRecord('sys_user');
		gr.addQuery('u_department', requestorDepartment);
		gr.addQuery('u_available',true);
		gr.query();	

		if (gr.next()){

			var grA = new GlideRecord('sys_user_has_role');
			grA.addQuery('user', gr.getUniqueValue());
			grA.addQuery('role', '0acf65442bda0f904686f06fe291bfa0');
			grA.query();

			if(grA.hasNext()){

				current.setValue('u_approver',gr.getUniqueValue());
			}
			
		} else{
			
			current.setValue('u_approval_group','7942f5882bda0f904686f06fe291bfab');
		}	
	}

})(current, previous);
```
