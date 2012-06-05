<%--
 $Rev: 94 $
 $Date: 2010-09-15 11:06:12 -0400 (Wed, 15 Sep 2010) $
--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="RequestPages" scope="request" class="java.util.Vector"/>
<jsp:useBean id="UserContext" scope="session" class="com.kd.kineticSurvey.beans.UserContext"/>
<%@include file="../../resources/partials/reviewFunctions.jsp"%>
<%
    com.kd.kineticSurvey.beans.CustomerSurveyReview customerSurvey = null;
    if (RequestPages.size() > 0) {
        customerSurvey = (com.kd.kineticSurvey.beans.CustomerSurveyReview) RequestPages.get(0);
%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <title><%=customerSurvey.getSurveyTemplateName()%></title>

        <%@ include file="includes/yuiInclude.jspf" %>
        <%@ include file="includes/kdInclude.jspf" %>
        
        <link href="resources/css/ks_basic.css" rel="stylesheet" type="text/css"/>
        <link href="<%=request.getContextPath() + "/resources/js/yui/build/fonts/fonts-min.css"%>" rel="stylesheet" type="text/css"/>
        <link href="<%=request.getContextPath() + "/resources/js/yui/build/datatable/assets/skins/sam/datatable.css"%>" rel="stylesheet" type="text/css"/>


        <%--Include Remedy-created style/javascript info--%>
        <%
            java.util.Iterator itrStyles = RequestPages.iterator();
            while (itrStyles.hasNext()) {
                com.kd.kineticSurvey.beans.CustomerSurveyReview cs = (com.kd.kineticSurvey.beans.CustomerSurveyReview) itrStyles.next(); %>
                <%= cs.getStyleInfo() %>
        <% } %>

        <script type="text/javascript">
            function ks_initSessionVars() {
                clientManager.successMessage = '<%=customerSurvey.getSuccessMessage()%><jsp:getProperty name="UserContext" property="successMessage" />';
                clientManager.errorMessage = '<%=customerSurvey.getErrorMessage()%><jsp:getProperty name="UserContext" property="errorMessage" />';
                clientManager.sessionId='<%=customerSurvey.getCustomerSessionInstanceID()%>';
                clientManager.customerSurveyId='<%=customerSurvey.getCustomerSurveyInstanceID()%>';
                clientManager.authenticated=<%= UserContext.isAuthenticated()%>;
                clientManager.userName='<%= UserContext.getUserName()%>';
                clientManager.templateId='<%=customerSurvey.getSurveyTemplateInstanceID()%>';
                clientManager.submitType='ReviewRequest';
                clientManager.originatingPage='';
                clientManager.authenticationType='<%= UserContext.getAuthenticationType()%>';
                clientManager.isAuthenticationRequired='<%= customerSurvey.isAuthenticationRequired()%>';
                clientManager.isNewPage='TRUE';
                clientManager.webAppContextPath='<%=request.getContextPath()%>';
		    clientManager.themesDirectory = 'themes/acme/';
            }
            var pageIds = [];
            <%
                if (customerSurvey.getLoadAllPages()) {
                    java.util.Iterator loadEvents = RequestPages.iterator();
                    while (loadEvents.hasNext()) {
                        com.kd.kineticSurvey.beans.CustomerSurveyReview cs = (com.kd.kineticSurvey.beans.CustomerSurveyReview) loadEvents.next();
            %>
                        pageIds.push("<%=cs.getSanitizedPageId()%>");
            <%
                    }
                }
            %>
            var clientManager = KD.utils.ClientManager;
            var reviewObj = { clientManager: clientManager, loadAllPages: <%=customerSurvey.getLoadAllPages()%>, pageIds: pageIds };
            KD.utils.Action.addListener(window, "load", KD.utils.Review.init, reviewObj, true);
        </script>
        <%=customerSurvey.getCustomHeaderContent()%>
    </head>
    <body class="loadAllPages_<%=customerSurvey.getLoadAllPages()%>">
	<div id="contentPageSection" class="contentPageSection">
		<div id="headerSection" class="headerSection">
			<div class="returnToCatalog roundedBottom6">
				<a href='DisplayPage?name=ACME_Catalog' class="returnToCatalogLink">Return to Catalog</a>
			</div>
			<div class="headerLogout roundedBottom6">
				<a href="KSAuthenticationServlet?Logout=true" class="logout"> Logout</a>
			</div>
			<div class="KSR_Number">
				<%String requestID="";
				  if (customerSurvey != null && customerSurvey.getCustomerSurveyBase()!=null) {
				    String originatingID = (String)customerSurvey.getCustomerSurveyBase().getEntryFieldValue("700088607");
				    if (originatingID!=null && originatingID.length()>0) {
				    	requestID=originatingID;
				    } else {
						requestID=(String)customerSurvey.getCustomerSurveyBase().getEntryFieldValue("1");
					}
				  }
				%>
				<%=requestID%>
			</div>
		</div>
        	<div id="reviewContent">
            	<%
	            String renderClass = "";
      	      if (!customerSurvey.getLoadAllPages()) { %>
            	    <%= renderPageTabs(RequestPages, renderClass) %>
	            <% } else { %>
      	          <%= renderPages(RequestPages, renderClass) %>
            	<% } %>
            	<input type="hidden" name="templateID" id= "templateID" value="<%=customerSurvey.getSurveyTemplateInstanceID()%>"/>
            	<input type="hidden" name="pageID" id="pageID" value=""/>
        	</div>
		<div id="footerSection" class="footerSection dynamicText ">
			Copyright &copy; 2010 Acme
		</div>
    </div>
    </body>
</html>
<% } else { %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <title>Review Request</title>
    </head>
    <body>
        <div>This request could either not be found, or it did not have any valid content pages.</div>
    </body>
</html>
<% } %>
