<%--
 $Rev: 43 $
 $Date: 2010-08-24 16:02:28 -0500 (Tue, 24 Aug 2010) $
--%>
<%@page contentType="text/html"%>
<%--Format a list of KS_SRV_CustomerSurvey entries in a table  --%>
<% java.util.List resultsList=(java.util.List)request.getAttribute("resultsList");
%>
   <table id="systemFormDetails">
<%
   if (resultsList != null) {

      for (int i = 0; i < resultsList.size(); i++) {
		com.kd.arsHelpers.SimpleEntry entry = (com.kd.arsHelpers.SimpleEntry) resultsList.get(i);
	
		String systemForm = entry.getEntryFieldValue("700004127");
		String status = entry.getEntryFieldValue("700004125");
		String csrv = entry.getEntryFieldValue("179");
		%>	 
		<tr class="systemFormDetailsRow"><td><%=systemForm%></td><td><%=status%></td><td><%=csrv%></td></tr>
		<%
      }
   }

%>
   </table>
