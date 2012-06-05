<%--
 $Rev: 77 $
 $Date: 2010-09-09 14:49:27 -0500 (Thu, 09 Sep 2010) $
--%>
<%@page contentType="text/html; charset=UTF-8"%>
<%
response.setHeader("CACHE-CONTROL","no-cache, no-store, must-revalidate, max-age=0"); //HTTP 1.1
response.setDateHeader ("EXPIRES", 0); //prevents caching at the proxy server
response.setHeader("PRAGMA","NO-CACHE");
%>

<%-- Format a list of KS_SRV_SurveyTemplate entries in an unordered list including link to the template and title --%>
<% java.util.List resultsList=(java.util.List)request.getAttribute("resultsList");%>
<div>
	<div id="searchCategoryLabelHolder" class="searchCategoryLabelHolder" style="">
		<div class="categoryItem categorySelected">
			<div class="categorySelected category_item_label" style="">Search Results</div>
		</div>
	</div>
	<div id="searchResults_ServiceItems" class="serviceItemResults roundedLeft6 curvyRedraw" style="">
<% if(resultsList != null){
%>
		  <% java.util.Iterator iter = resultsList.iterator();
		  while(iter.hasNext()){
		    com.kd.arsHelpers.SimpleEntry entry=(com.kd.arsHelpers.SimpleEntry)iter.next();
		    entry.getEntryFieldValue("700002489");

			String URL=entry.getEntryFieldValue("700002489");
			URL = URL.substring(URL.indexOf("DisplayPage"));
			String templateName = (String) entry.getEntryFieldValue("700001000");
			String templateNameID = templateName.replaceAll(" ", "");
		    %>
		    <div>
		    	<div  srv='<%=(String) entry.getEntryFieldValue("179")%>' id='search_serviceItem_<%=(String) entry.getEntryFieldValue("179")%>'class='serviceItem_item' onclick='catalogHelper.selectSearchServiceItem(this)'  onmouseover="catalogHelper.highlightServiceItem(this)" onmouseout="catalogHelper.removeHighlightServiceItem(this)" onmouseleave="catalogHelper.removeHighlightServiceItem(this)"><%=templateName %></div>
		    </div>
		    <%}%>
	</div
<%} else{%>
    <div>
	<div class='serviceItem_item'>No results found </div>
    </div>
<%} %>
	</div>
</div>    