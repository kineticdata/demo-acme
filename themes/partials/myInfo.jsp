<%--
 $Rev: 43 $
 $Date: 2010-08-24 16:02:28 -0500 (Tue, 24 Aug 2010) $
--%>
<%@page contentType="text/html; charset=UTF-8"%>
<%
response.setHeader("CACHE-CONTROL","no-cache, no-store, must-revalidate, max-age=0"); //HTTP 1.1
response.setDateHeader ("EXPIRES", 0); //prevents caching at the proxy server
response.setHeader("PRAGMA","NO-CACHE");%>
<%--Format a Sample People entry for display as a partial --%>
<% java.util.List resultsList=(java.util.List)request.getAttribute("resultsList"); %>

<img alt="close" src="themes/acme/images/whitecloseX.gif" style="float:right; cursor:pointer;" onclick="javascript:catalogHelper.hideMyInfo();">
<%
if(resultsList != null){
com.kd.arsHelpers.SimpleEntry entry=(com.kd.arsHelpers.SimpleEntry)resultsList.get(0);%>
<b>Name: </b><br/>
<%=entry.getEntryFieldValue("240000004")%> <%=entry.getEntryFieldValue("240000003")%><br/>
<b>Email: </b><br/>
<%=entry.getEntryFieldValue("260000002")%><br/>
<b>Phone: </b><br/>
<%=entry.getEntryFieldValue("240000002")%><br/>
<b>Department:</b><br/>
<%=entry.getEntryFieldValue("200000006")%> <br/>
<%}else{%>
<p>You were not found in the Sample People form. </p>
<p>
<a href="DisplayPage?name=UpdatePersonInfo">Update My Record</a>
</p>
<%}%>
