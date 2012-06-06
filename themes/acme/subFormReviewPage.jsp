<%--
 $Rev: 43 $
 $Date: 2010-08-24 16:02:28 -0500 (Tue, 24 Aug 2010) $
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

        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() + "/themes/acme/css/base.css"%>" />

        <link href="<%=request.getContextPath() + "/resources/js/yui/build/calendar/assets/calendar.css"%>" rel="stylesheet" type="text/css"/>
        <link href="<%=request.getContextPath() + "/resources/js/yui/build/container/assets/container.css"%>" rel="stylesheet" type="text/css"/>
        <link href="resources/css/ks_basic.css" rel="stylesheet" type="text/css"/>
        <% if ((customerSurvey.getStylesheetFileName() != null) && (customerSurvey.getStylesheetFileName().trim().length() > 0)) {%>
        <link href="<%=customerSurvey.getStylesheetFileName()%>" rel="stylesheet" type="text/css"/>
        <%}%>
        <link href="<%=request.getContextPath() + "/resources/css/kd_review.css"%>" rel="stylesheet" type="text/css"/>

        <link href="<%=request.getContextPath() + "/resources/js/yui/build/fonts/fonts-min.css"%>" rel="stylesheet" type="text/css"/>
        <link href="<%=request.getContextPath() + "/resources/js/yui/build/datatable/assets/skins/sam/datatable.css"%>" rel="stylesheet" type="text/css"/>


        <script type="text/javascript" src="<%=request.getContextPath() + "/resources/js/yui/build/utilities/utilities.js"%>"></script>
        <script type="text/javascript" src="<%=request.getContextPath() + "/resources/js/yui/build/button/button-min.js"%>"></script>
        <script type="text/javascript" src="<%=request.getContextPath() + "/resources/js/yui/build/container/container-min.js"%>"></script>
        <script type="text/javascript" src="<%=request.getContextPath() + "/resources/js/yui/build/datasource/datasource-min.js"%>"></script>
        <script type="text/javascript" src="<%=request.getContextPath() + "/resources/js/yui/build/datatable/datatable-min.js"%>"></script>
        <script type="text/javascript" src="<%=request.getContextPath() + "/resources/js/yui/build/calendar/calendar-min.js"%>"></script>
        <script type="text/javascript" src="<%=request.getContextPath() + "/resources/js/yui/build/json/json-min.js"%>"></script>
        <script type="text/javascript" src="<%=request.getContextPath() + "/resources/js/kd_core.js"%>"></script>
        <script type="text/javascript" src="<%=request.getContextPath() + "/resources/js/kd_review-min.js"%>"></script>
        <script type="text/javascript" src="<%=request.getContextPath() + "/themes/acme/js/curvycorners.js"%>"></script>
        <script type="text/javascript" src="<%=request.getContextPath() + "/themes/acme/js/service_item.js"%>"></script>

        <% if ((customerSurvey.getJavascriptFileName() != null) && (customerSurvey.getJavascriptFileName().trim().length() > 0)) {%>
        <script type="text/javascript" src="<%=customerSurvey.getJavascriptFileName()%>"></script>
        <%}%>

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
            }
			<%String systemFormStr = request.getParameter("systemForm");%>
			<%String primaryCsrvStr = request.getParameter("primaryCsrv");%>
			<%String formMode = (request.getParameter("mode")!=null?request.getParameter("mode"):"standalone");%>
			var systemForm;
			var primaryCsrv;

			<%if (systemFormStr!=null && systemFormStr.length()>0) { %>
				systemForm = '<%=systemFormStr%>';
			<%}%>
			<%if (primaryCsrvStr!=null && primaryCsrvStr.length()>0) { %>
				primaryCsrv = '<%=primaryCsrvStr%>';
			<%}%>

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
			KD.utils.Action.addListener(window, "load", setInitialHeight);

			function setInitialHeight() {
				KD.utils.Review.init();
				var iFrameObj = frameElement;
				if (iFrameObj) {
					var elements = KD.utils.Util.getElementsByClassName("templateContent", "div");
					if (elements) {
						elements[0].style.top="0px";
						elements[0].style.left="0px";
					}

					iFrameObj.style.height = (YAHOO.util.Dom.getDocumentHeight()) + 'px';
					iFrameObj.style.width = (YAHOO.util.Dom.getDocumentWidth()) + 'px';	
				}
			}
        </script>
        <%=customerSurvey.getCustomHeaderContent()%>
    </head>
    <body class="loadAllPages_<%=customerSurvey.getLoadAllPages()%>">
        <div id="reviewContent" class=" <%=formMode%>">
            <%
            String renderClass = "frame";
            if (!customerSurvey.getLoadAllPages()) { %>
                <%= renderPageTabs(RequestPages, renderClass) %>
            <% } else { %>
                <%= renderPages(RequestPages, renderClass) %>
            <% } %>
            <input type="hidden" name="templateID" id= "templateID" value="<%=customerSurvey.getSurveyTemplateInstanceID()%>"/>
            <input type="hidden" name="pageID" id="pageID" value=""/>
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
