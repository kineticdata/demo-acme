<%--
 $Rev: 43 $
 $Date: 2010-08-24 16:02:28 -0500 (Tue, 24 Aug 2010) $
--%>
<%@page contentType="text/html; charset=UTF-8"%>
<%
response.setHeader("CACHE-CONTROL","no-cache, no-store, must-revalidate, max-age=0"); //HTTP 1.1
response.setDateHeader ("EXPIRES", 0); //prevents caching at the proxy server
response.setHeader("PRAGMA","NO-CACHE");%>

<% java.util.List resultsList=(java.util.List)request.getAttribute("resultsList");
if(resultsList != null){
	com.kd.arsHelpers.SimpleEntry entry=(com.kd.arsHelpers.SimpleEntry)resultsList.get(0);
  	String spec = (String)entry.getEntryFieldValue("536870914");
%>
	<div id="ProductSpecification">
		<%=spec%>
	</div>
<%} else {%>
No records found
<%}%>