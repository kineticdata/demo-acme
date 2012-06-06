<%--
 $Rev: 43 $
 $Date: 2010-08-24 16:02:28 -0500 (Tue, 24 Aug 2010) $
--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<jsp:useBean id="customerSurvey" scope="request" class="com.kd.kineticSurvey.beans.CustomerSurvey"/>
<jsp:useBean id="UserContext" scope="session" class="com.kd.kineticSurvey.beans.UserContext"/>
<%@page contentType="text/html; charset=UTF-8"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>
<jsp:getProperty name="customerSurvey" property="surveyTemplateName"/>
</title>
<link rel="shortcut icon" href="<%=request.getContextPath()%>/favicon.ico" type="image/x-icon"/>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() + "/themes/acme/css/base.css"%>" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() + "/themes/acme/css/yui-skin/datatable.css"%>" />

<%--
<link href="<%=request.getContextPath() + "/resources/js/yui/build/fonts/fonts-min.css"%>" rel="stylesheet" type="text/css"/>
--%>

<link href="<%=request.getContextPath() + "/resources/js/yui/build/calendar/assets/calendar.css"%>" rel="stylesheet" type="text/css"/>
<link href="<%=request.getContextPath() + "/resources/js/yui/build/container/assets/container.css"%>" rel="stylesheet" type="text/css"/>
<% if((customerSurvey.getStylesheetFileName() != null) &&  (customerSurvey.getStylesheetFileName().trim().length() > 0)){%>
<link href="<jsp:getProperty name="customerSurvey"  property="stylesheetFileName"/>" rel="stylesheet" type="text/css"/>
<%}%>

<script type="text/javascript" src="<%=request.getContextPath() + "/resources/js/yui/build/yahoo-dom-event/yahoo-dom-event.js"%>"></script>
<script type="text/javascript" src="<%=request.getContextPath() + "/resources/js/yui/build/connection/connection-min.js"%>"></script>
<script type="text/javascript" src="<%=request.getContextPath() + "/resources/js/yui/build/element/element-min.js"%>"></script>
<script type="text/javascript" src="<%=request.getContextPath() + "/resources/js/yui/build/datasource/datasource-min.js"%>"></script>
<script type="text/javascript" src="<%=request.getContextPath() + "/resources/js/yui/build/datatable/datatable-min.js"%>"></script>
<script type="text/javascript" src="<%=request.getContextPath() + "/resources/js/yui/build/json/json-min.js"%>"></script>

<script type="text/javascript" src="<%=request.getContextPath() + "/resources/js/yui/build/calendar/calendar-min.js"%>"></script>
<script type="text/javascript" src="<%=request.getContextPath() + "/resources/js/yui/build/button/button-min.js"%>"></script>
<script type="text/javascript" src="<%=request.getContextPath() + "/resources/js/yui/build/container/container-min.js"%>"></script>
<script type="text/javascript" src="<%=request.getContextPath() + "/resources/js/kd_actions.js"%>"></script>
<script type="text/javascript" src="<%=request.getContextPath() + "/resources/js/kd_utils.js"%>"></script>
<script type="text/javascript" src="<%=request.getContextPath() + "/resources/js/kd_client.js"%>"></script>

<script type="text/javascript" src="<%=request.getContextPath() + "/themes/acme/js/curvycorners.js"%>"></script>
<script type="text/javascript" src="<%=request.getContextPath() + "/themes/acme/js/service_item.js"%>"></script>

<% if((customerSurvey.getJavascriptFileName() != null) &&  (customerSurvey.getJavascriptFileName().trim().length() > 0)){%>
<script type="text/javascript" src="<jsp:getProperty name="customerSurvey"  property="javascriptFileName"/>"></script>
<%}%>

<%--Include Remedy-created style/javascript info--%>
<jsp:getProperty name="customerSurvey" property="styleInfo"/>
<script type="text/javascript">
function ks_initSessionVars(){
clientManager.themesDirectory = 'themes/acme/';
clientManager.successMessage = '<jsp:getProperty name="customerSurvey"  property="successMessage" /><jsp:getProperty name="UserContext" property="successMessage" />';
clientManager.errorMessage = '<jsp:getProperty name="customerSurvey"  property="errorMessage" /><jsp:getProperty name="UserContext" property="errorMessage" />';
clientManager.sessionId='<jsp:getProperty name="customerSurvey" property="customerSessionInstanceID"/>';
clientManager.customerSurveyId='<jsp:getProperty name="customerSurvey" property="customerSurveyInstanceID"/>';
clientManager.authenticated=<%= UserContext.isAuthenticated()%>;
clientManager.userName='<%= UserContext.getUserName()%>';
clientManager.templateId='<jsp:getProperty name="customerSurvey" property="surveyTemplateInstanceID"/>';
clientManager.submitType='<jsp:getProperty name="customerSurvey" property="submitType"/>'
clientManager.originatingPage='<%= UserContext.getOriginatingPage()%>';
clientManager.authenticationType='<%= UserContext.getAuthenticationType()%>';
clientManager.isAuthenticationRequired='<%= customerSurvey.isAuthenticationRequired()%>';
clientManager.isNewPage=<jsp:getProperty name="customerSurvey" property="isNewPage"/>
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


var clientManager= KD.utils.ClientManager;
KD.utils.Action.addListener(window, "load", clientManager.init, clientManager, true);
KD.utils.Action.addListener(window, "load", KD.utils.Util.checkCachePageLoad, clientManager, true);
KD.utils.Action.addListener(window, "unload", KD.utils.Util.resetCachePageValues, clientManager, true);
KD.utils.Action.addListener(window, "load", setInitialHeight);

<%-- ReviewRequest override, used to avoid the need to have to maintain existing service item to remove the iFrame callback event --%>
KD.utils.Action.addListener(window, "load", purgeReviewRequestCallback);
function purgeReviewRequestCallback() {
    var iFrameObj = document.getElementById('reviewRequest');
    if (iFrameObj) {
        YAHOO.util.Event.purgeElement(iFrameObj);
    }
}

function registerFormCompleted(systemFormVal){
	window.parent.registerFormSubmitted(systemFormVal, clientManager.customerSurveyId);
}
function calldeRegisterFormSubmitted(systemFormVal){
	if (window.parent.deRegisterFormSubmitted)
		window.parent.deRegisterFormSubmitted(systemFormVal, clientManager.customerSurveyId);
}

function triggerResize() {
	setInitialHeight();
}

function setInitialHeight() {
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

<%-- END ReviewRequest override--%>
</script>

<jsp:getProperty name="customerSurvey" property="customHeaderContent"/>

</head>
<body>
	<div id="contentPageSection" class="contentPageSection rounded6 <%=formMode%>">
			<form name='pageQuestionsForm' id='pageQuestionsForm' class='pageQuestionsForm' method='post' action='SubmitPage'>
				<jsp:getProperty name="customerSurvey" property="questions"/>

				<% if (request.getParameter("srv")!= null) {%>
				<input type="hidden" name="srv" value="<%=request.getParameter("srv")%>"/>
				<%}%>
				<% if (request.getParameter("csrv")!= null) {%>
					<input type="hidden" name="csrv" value="<%=request.getParameter("csrv")%>"/>
				<%}%>

				<input type="hidden" name="templateID" id= "templateID" value="<jsp:getProperty name="customerSurvey" property="surveyTemplateInstanceID"/>"/>
				<input type="hidden" name="sessionID" id="sessionID" value="<jsp:getProperty name="customerSurvey" property="customerSessionInstanceID"/>"/>
				<input type="hidden" name="surveyRequestID" id="surveyRequestID" value="<jsp:getProperty name="customerSurvey" property="customerSurveyRequestID"/>"/>
				<input type="hidden" name="pageID" id="pageID"value="<jsp:getProperty name="customerSurvey" property="pageInstanceID"/>"/>
				</form>
	</div>		
<jsp:setProperty name="UserContext" property="errorMessage" value=""/>
</body>
</html>
