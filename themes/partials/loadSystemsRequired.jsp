<%--
 $Rev: 43 $
 $Date: 2010-08-24 16:02:28 -0500 (Tue, 24 Aug 2010) $
--%>
<%@page contentType="text/html"%>
<%--Format a list of KS_SRV_CustomerSurvey entries in a table  --%>
<% java.util.List resultsList=(java.util.List)request.getAttribute("resultsList");
%>
   <table id="systemsRequired">
<%
   if (resultsList != null) {

      for (int i = 0; i < resultsList.size(); i++) {
		com.kd.arsHelpers.SimpleEntry entry = (com.kd.arsHelpers.SimpleEntry) resultsList.get(i);
	
		String instanceID = entry.getEntryFieldValue("179");
		String templateName = entry.getEntryFieldValue("700001000");
		%>	 
		<tr class="systemsRequiredRow"><td><%=instanceID%></td><td><%=templateName%></td></tr>
		<%
      }
   }

%>
   </table>
