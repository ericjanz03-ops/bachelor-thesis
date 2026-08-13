**Prompt** [**Schreibe mir bitte eine Business Rule für... | Versuchen Sie es in Copilot Chat**](https://m365.cloud.microsoft/chat/entity1-d870f6cd-4aa5-4d42-9626-ab690c041429/eyJpZCI6IlZYTmxjbFl4ZkdoMGRIQnpPaTh2YzNWaWMzUnlZWFJsTFdsdWRDNXZabVpwWTJVdVkyOXRMM3hQU1VRNk5EWTNOR0ZpTVdRdE56azJZaTAwWWpWaExXSTBZekF0TUdVM1lXUTFNR1l4WmpJNGZESmlPR0l3WlRWaExUVXlZbUl0TkdGa1pTMDVZV1ppTFRFd00yVmpNV0ppTW1KaU9Id3lNREkyTFRBNExURXlWREV5T2pJM09qSTJMamM0T0RNME9UVmEiLCJzY2VuYXJpbyI6InNoYXJlTGlua1ZpYVJpY2hDb3B5IiwicHJvcGVydGllcyI6eyJwcm9tcHRTb3VyY2UiOiJ1c2VyIiwiY2xpY2tUaW1lc3RhbXAiOiIyMDI2LTA4LTEyVDEyOjI3OjI2Ljg1NFoifSwiY2hhdFR5cGUiOiJ3ZWIiLCJ2ZXJzaW9uIjoxLjF9 "https://m365.cloud.microsoft/chat/entity1-d870f6cd-4aa5-4d42-9626-ab690c041429/eyjpzci6ilzytmxjbfl4zkdomgriqnppath2yznwawmzunlzwfjstfdsdwrdnxzabvpwwtjvdvkyoxrmm3hqu1vrnk5ewtnor0zptvdrde56azjzatawwwpwaexxstbzekf0tudvm1lxutfnr1l4wmpjngzesmlpr0l3wlrwaexuvxlzbul0tkdga1ptmdvzv1pptfrfd00yvmpnv0pptw1kau9id3lnrekytfrbnexurxlwrev5t2pjm09qstjmamm0t0rnme9uvmeilcjzy2vuyxjpbyi6innoyxjltglua1zpyvjpy2hdb3b5iiwichjvcgvydgllcyi6eyjwcm9tchrtb3vyy2uioij1c2vyiiwiy2xpy2tuaw1lc3rhbxaioiiymdi2lta4lteyvdeyoji3oji2ljg1nfoifswiy2hhdfr5cguioij3zwiilcj2zxjzaw9uijoxljf9")  

Schreibe mir bitte eine Business Rule für ServiceNow, die auf folgendem Gerüst basiert: (function executeRule(current, previous) { // TODO: Bearbeitungsgruppe gemäß Aufgabenstellung ermitteln und zuweisen })(current, previous);   
Als Logik für die Business Rule Entscheidung gebe ich dir einen Screenshot mit.   
Weitere Info: Die Gruppe soll in das Feld "assignment_group" auf dem current Record eingetragen werden.
![[Pasted image 20260813085705.png]]

**Antwort**  

Basierend auf dem Diagramm habe ich folgende Logik herausgelesen:

1. **Priority = 3 (Moderate) oder 4 (Low)**  
    → Standard-Bearbeitungsgruppe anhand der Incident-Kategorie aus `u_category_group_mapping` ermitteln.
2. **Priority = 1 (Critical)**  
    → Zunächst ebenfalls die Standard-Bearbeitungsgruppe anhand der Kategorie ermitteln. → Anschließend prüfen, ob dieser Gruppe mehr als **10 offene Incidents** zugewiesen sind (Status ≠ Resolved und ≠ Closed). → Wenn **mehr als 10 offene Incidents** vorhanden sind: → Gruppe **"Major Incident Team"** zuweisen. → Sonst: → Standard-Bearbeitungsgruppe verwenden.

Hier ein vollständiges Beispiel für die Business Rule:


```javascript
(function executeRule(current, previous) {  
  
   var assignmentGroup = '';  
  
   // Standardgruppe anhand der Kategorie ermitteln  
   var mappingGR = new GlideRecord('u_category_group_mapping');  
   mappingGR.addQuery('u_category', current.category);  
   mappingGR.query();  
  
   if (mappingGR.next()) {  
       assignmentGroup = mappingGR.u_group.toString();  
   }  
  
   // Priorität prüfen  
   if (current.priority == '1') {  
  
       // Anzahl offener Incidents der Standardgruppe ermitteln  
       var incidentGR = new GlideRecord('incident');  
       incidentGR.addQuery('assignment_group', assignmentGroup);  
       incidentGR.addQuery('state', 'NOT IN', '6,7'); // 6=Resolved, 7=Closed  
       incidentGR.query();  
  
       var openCount = incidentGR.getRowCount();  
  
       if (openCount > 10) {  
  
           // Major Incident Team ermitteln  
           var majorGroupGR = new GlideRecord('sys_user_group');  
           majorGroupGR.addQuery('name', 'Major Incident Team');  
           majorGroupGR.query();  
  
           if (majorGroupGR.next()) {  
               current.assignment_group = majorGroupGR.getUniqueValue();  
           }  
  
       } else {  
           current.assignment_group = assignmentGroup;  
       }  
  
   } else if (current.priority == '3' || current.priority == '4') {  
  
       current.assignment_group = assignmentGroup;  
   }  
  
})(current, previous);
```


### Optimierte Variante mit `GlideAggregate`

Falls die Instanz viele Incidents enthält, ist diese Variante performanter:


```javascript
(function executeRule(current, previous) {  
  
   var assignmentGroup = '';  
  
   var mappingGR = new GlideRecord('u_category_group_mapping');  
   mappingGR.addQuery('u_category', current.category);  
   mappingGR.query();  
  
   if (mappingGR.next()) {  
       assignmentGroup = mappingGR.u_group.toString();  
   } else {  
       return;  
   }  
  
   if (current.priority == '1') {  
  
       var ga = new GlideAggregate('incident');  
       ga.addQuery('assignment_group', assignmentGroup);  
       ga.addQuery('state', 'NOT IN', '6,7');  
       ga.addAggregate('COUNT');  
       ga.query();  
  
       var openCount = 0;  
       if (ga.next()) {  
           openCount = parseInt(ga.getAggregate('COUNT'), 10);  
       }  
  
       if (openCount > 10) {  
  
           var majorGroupGR = new GlideRecord('sys_user_group');  
           majorGroupGR.addQuery('name', 'Major Incident Team');  
           majorGroupGR.query();  
  
           if (majorGroupGR.next()) {  
               current.assignment_group = majorGroupGR.getUniqueValue();  
           }  
  
       } else {  
           current.assignment_group = assignmentGroup;  
       }  
  
   } else if (current.priority == '3' || current.priority == '4') {  
  
       current.assignment_group = assignmentGroup;  
   }  
  
})(current, previous);
```

Die zweite Variante würde ich für eine produktive ServiceNow-Implementierung bevorzugen.