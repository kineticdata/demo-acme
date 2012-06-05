<%@page contentType="text/html; charset=UTF-8"%>
<%
response.setHeader("CACHE-CONTROL","no-cache, no-store, must-revalidate, max-age=0"); //HTTP 1.1
response.setDateHeader ("EXPIRES", 0); //prevents caching at the proxy server
response.setHeader("PRAGMA","NO-CACHE");%>
<%-- Format a list of KS_RQT_Conversation entries--%>
<%
java.util.List resultsList = (java.util.List) request.getAttribute("resultsList");
if (resultsList != null) {
	java.text.SimpleDateFormat simpleDateFormat = new java.text.SimpleDateFormat("MM/dd/yyyy HH:mm:ss");
	java.text.DateFormat dateFormat = java.text.DateFormat.getDateTimeInstance(java.text.DateFormat.SHORT, java.text.DateFormat.MEDIUM, request.getLocale());

	for (int i = 0; i < resultsList.size(); i++) {
		com.kd.arsHelpers.SimpleEntry entry = (com.kd.arsHelpers.SimpleEntry) resultsList.get(i);
		String message = (String) entry.getEntryFieldValue("240000002");

        java.util.Date createdAtDate = simpleDateFormat.parse(entry.getEntryFieldValue("3"), new java.text.ParsePosition(0));
		%>
		<span><%=message%> <i>(<%=dateFormat.format(createdAtDate)%>)</i> </span><br>
		<%
	}
} else {
%>
<p> No Messages. <p>
<%
}
%>