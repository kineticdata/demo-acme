<%--
 $Rev: 43 $
 $Date: 2010-08-24 16:02:28 -0500 (Tue, 24 Aug 2010) $
--%>
<%@page contentType="text/html; charset=UTF-8"%>
<%
response.setHeader("CACHE-CONTROL","no-cache, no-store, must-revalidate, max-age=0"); //HTTP 1.1
response.setDateHeader ("EXPIRES", 0); //prevents caching at the proxy server
response.setHeader("PRAGMA","NO-CACHE");%>
<%--Format a list of KS_SRV_CustomerSurvey entries in a table  --%>
<% java.util.List resultsList=(java.util.List)request.getAttribute("resultsList");
if(resultsList != null){
    String partial = "../../themes/acme/partials/selectedRequests";
%>
  <% com.kd.arsHelpers.SimpleEntry entry=(com.kd.arsHelpers.SimpleEntry)resultsList.get(0); %>
      <%String openCount = (String)entry.getEntryFieldValue("700001001");
      	if (openCount != null && openCount.trim().length() >0 && !openCount.trim().equals("0")) { %>
	    <divclass="actionItemRowLine">
		    <div class="actionItemRow">	    	
	    	  <div id="inprogress_requests" style="display:block;" class='summaryItem' onclick='catalogHelper.showRequestPanel(this); catalogHelper.showSelectedRequests(true, false, this, "<%=partial%>"); '>In Progress&nbsp;(<%= entry.getEntryFieldValue("700001001")%>)</div>
		    </div>
	    </div>
      <%}%>
      <%String closedCount = (String)entry.getEntryFieldValue("700001002");
      	if (closedCount != null && closedCount.trim().length() >0 && !closedCount.trim().equals("0")) { %>
	    <div class="actionItemRowLine">
		    <div class="actionItemRow">	    	
		      <div id="closed_requests" style="display:block;" class='summaryItem' onclick='catalogHelper.showRequestPanel(this); catalogHelper.showSelectedRequests(false, false, this, "<%=partial%>");'>Closed&nbsp;(<%= entry.getEntryFieldValue("700001002")%>)</div>
		    </div>
	    </div>
      <%}%>
      <%String forAppCount = (String)entry.getEntryFieldValue("700001003");
      	if (forAppCount != null && forAppCount.trim().length() >0 && !forAppCount.trim().equals("0")) { %>
	    <div class="actionItemRowLine"">
		    <div class="actionItemRow">	    	
	      		<div id="open_approvals_requests" style="display:block;" class='summaryItem' onclick='catalogHelper.showRequestPanel(this); catalogHelper.showSelectedRequests(true, true, this, "<%=partial%>");'>Needing approval&nbsp;(<%= entry.getEntryFieldValue("700001003")%>)</div>
		    </div>
	    </div>
      <%}%>
      <%String pendCount = (String)entry.getEntryFieldValue("700001006");
      	if (pendCount != null && pendCount.trim().length() >0 && !pendCount.trim().equals("0")) { %>
	    <div class="actionItemRowLine"">
		    <div class="actionItemRow">	    	
	      		<div id="pending_actions_requests" style="display:block;" class='summaryItem' onclick='catalogHelper.showRequestPanel(this);var options={isOpen:true,isApproval:true,isActionPending:true,clickedEl:this,partial:"<%=partial%>"};catalogHelper._showSelectedRequests(options);'>Pending Actions&nbsp;(<%= entry.getEntryFieldValue("700001006")%>)</div>
		    </div>
	    </div>
      <%}%>
      <%String appCount = (String)entry.getEntryFieldValue("700001005");
      	if (appCount != null && appCount.trim().length() >0 && !appCount.trim().equals("0")) { %>
	    <div class="actionItemRowLine">
		    <div class="actionItemRow">	    	
		      <div id="closed_approvals_requests" style="display:block;" class='summaryItem' onclick='catalogHelper.showRequestPanel(this); catalogHelper.showSelectedRequests(false, true, this, "<%=partial%>");'>Completed<br> Approval&nbsp;(<%= entry.getEntryFieldValue("700001005")%>)</div>
		    </div>
	    </div>
      <%}%>
<%} %>
