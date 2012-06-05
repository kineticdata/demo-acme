<%--
 $Rev: 68 $
 $Date: 2010-09-01 23:00:57 -0500 (Wed, 01 Sep 2010) $
--%>
<%@page contentType="text/html; charset=UTF-8"%>
<%
response.setHeader("CACHE-CONTROL","no-cache, no-store, must-revalidate, max-age=0"); //HTTP 1.1
response.setDateHeader ("EXPIRES", 0); //prevents caching at the proxy server
response.setHeader("PRAGMA","NO-CACHE");%>
<%-- Format a list of KS_RQT_SurveyTemplateAttrInst_Category_join entries in boxes by category including link to the template and title --%>
<%
java.util.List resultsList = (java.util.List) request.getAttribute("resultsList");
com.kd.kineticSurvey.beans.UserContext userContext = (com.kd.kineticSurvey.beans.UserContext) request.getSession().getAttribute("UserContext");
if (resultsList != null) {
	java.util.Hashtable categoryOrder = new java.util.Hashtable();
	java.util.SortedMap categoryItemsHash = new java.util.TreeMap();
	java.util.Hashtable serviceItemsHash = new java.util.Hashtable();

	for (int i = 0, j = 0; i < resultsList.size(); i++) {
		com.kd.arsHelpers.SimpleEntry entry = (com.kd.arsHelpers.SimpleEntry) resultsList.get(i);
		String categoryName = (String) entry.getEntryFieldValue("700401900");
		String templateNameID = (String) entry.getEntryFieldValue("700001000");// Template Name
		templateNameID = templateNameID.replaceAll(" ", "");
        String templateId = (String) entry.getEntryFieldValue("179");
        String formattedTemplateId = String.format("%03d", i) + "__" + templateId;
			
		if (categoryOrder.get(categoryName)==null) {
			categoryOrder.put(categoryName, new Integer(j));
            j += 1;
		}
		
		Integer order = (Integer)categoryOrder.get(categoryName);
		
		categoryName = String.format("%03d",order.intValue())+"__"+categoryName;  

		java.util.SortedMap serviceItems = (java.util.SortedMap)categoryItemsHash.get(categoryName);
		if (serviceItems==null) {
			serviceItems = new java.util.TreeMap();
		}
		serviceItems.put(formattedTemplateId, entry);

		categoryItemsHash.put(categoryName, serviceItems);
		serviceItemsHash.put(formattedTemplateId, entry);
	}
%>

<div id='serviceItemsHolder'>
	<div id='categoryItems'>
<%
	for (java.util.Iterator i = categoryItemsHash.keySet().iterator() ; i.hasNext() ;) {
		String categoryName = (String) i.next();
		categoryName = categoryName.substring(5);
		
		String categoryID=categoryName.replaceAll(" ", "");
%>		
		<div id='category_<%=categoryID%>'class='categoryItem' onclick='catalogHelper.selectCategory(this)'>
			<div class="category_item_label" onmouseover="catalogHelper.highlightCategory(this)" onmouseout="catalogHelper.removeHighlightCategory(this)" onmouseleave="catalogHelper.removeHighlightCategory(this)"><%=categoryName %></div>
		</div>
<%
	}
%>
	
		<div id='quick_links'>
			<div id='quick_links_border'>
				<div id='quick_links_label' class="rounded6">
					Quick Links
				</div>
				<div id='quick_links_holder'>
				</div>
			</div>
		</div>
	</div>

	<div id='categoryServiceItems' class='categoryServiceItemsDiv rounded6 curvyRedraw'>
		<div id='serviceItemsList_holder'>
		</div>
		<div id='serviceItemLaunch_holder'>
		</div>
	</div>

	<div id='serviceItemPlaceholder' style="display: none;">
<%
	
	for (java.util.Iterator i = categoryItemsHash.keySet().iterator() ; i.hasNext() ;) {
		String categoryName = (String) i.next();
		String categoryID=categoryName.replaceAll(" ", "");
		categoryID = categoryID.substring(5);
		
		%>
		<div id='serviceItems_<%=categoryID %>' style='display:none;'>
			<%
			java.util.SortedMap serviceItems = (java.util.SortedMap)categoryItemsHash.get(categoryName);
			for (java.util.Iterator esi = serviceItems.keySet().iterator() ; esi.hasNext() ;) {
			try {
				String key = (String)esi.next();
				
				com.kd.arsHelpers.SimpleEntry entry = (com.kd.arsHelpers.SimpleEntry) serviceItems.get(key);
				String templateName = (String) entry.getEntryFieldValue("700001000");
                String templateId = (String) entry.getEntryFieldValue("179");
			%>
				<div id='serviceItem_<%=templateId %>' class='serviceItem_item' onclick='catalogHelper.selectServiceItem(this)'  onmouseover="catalogHelper.highlightServiceItem(this)" onmouseout="catalogHelper.removeHighlightServiceItem(this)" onmouseleave="catalogHelper.removeHighlightServiceItem(this)"><%=templateName %></div>
			<%
			} catch (Exception ee) {
			%>
			<p> <%=ee%></p>
			<%
			}
			}
			%>
		</div>
	<%	
	}
%>
	</div>
	
	<div id='serviceItemLaunch_Placeholder' style="display: none;">
<%
	for (java.util.Enumeration e = serviceItemsHash.keys() ; e.hasMoreElements() ;) {
		String formattedTemplateID = (String) e.nextElement();
        String templateID = formattedTemplateID.substring(5);
		
		com.kd.arsHelpers.SimpleEntry entry = (com.kd.arsHelpers.SimpleEntry)serviceItemsHash.get(formattedTemplateID);
		String description = (String) entry.getEntryFieldValue("700001010");
		%>
		<div id='launch_<%=templateID %>' class='launch_serviceItem'>
			<div id="descriptionContainer_<%=templateID%>" class="descriptionContainer">
                <div id="descriptionText_<%=templateID%>" class="descriptionText">
                    <%= description %>
                </div>
		<% if (true || description.indexOf("http://") ==-1) {
		%>
                <div class='continueButton rounded6'>
        			<% String URL = "DisplayPage?srv="+java.net.URLEncoder.encode(templateID, "UTF-8"); %>
                    <input type="button" class="templateButton" value="Request" onclick="window.location='<%=URL%>'; this.disabled='disabled';" title=""/>
                </div>
		<%}%>
            </div>
        </div>
	<%
	}
	%>
	
		<div class="launch_serviceItem" id="launch_NotCategorized" style="display: block;">
			<div class="descriptionContainer">
                <div class="descriptionText">
                    <p>This service item has not been categorized.</p>
                </div>
                <div class="continueButton rounded6">
                    <input type="button" title="" value="Request" class="templateButton UncategorizedServiceItemButton "/>
                </div>
			</div>	
		</div>
	</div>
</div>
	
<%

} else {
%>
    <p>No Category results found</p>
<%
}
%>