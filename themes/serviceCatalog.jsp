<%--
 $Rev: 110 $
 $Date: 2010-10-12 09:58:46 -0500 (Tue, 12 Oct 2010) $
--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<jsp:useBean id="customerSurvey" scope="request" class="com.kd.kineticSurvey.beans.CustomerSurvey"/>
<jsp:useBean id="UserContext" scope="session" class="com.kd.kineticSurvey.beans.UserContext"/>

<%@include file="logAccess.jspf"%>

<%@page contentType="text/html; charset=UTF-8"%>
<%
response.setHeader("CACHE-CONTROL","no-cache, no-store, must-revalidate, max-age=0"); //HTTP 1.1
response.setDateHeader ("EXPIRES", 0); //prevents caching at the proxy server
response.setHeader("PRAGMA","NO-CACHE");
%>
<html>
<head>
<script type="text/javascript">var _sf_startpt=(new Date()).getTime()</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>
<jsp:getProperty name="customerSurvey" property="surveyTemplateName"/>
</title>

<%@ include file="includes/yuiInclude.jspf" %>
<%@ include file="includes/kdInclude.jspf" %>

<%--Include Remedy-created style/javascript info--%>
<jsp:getProperty name="customerSurvey" property="styleInfo"/>
<script type="text/javascript">
function ks_initSessionVars(){
	clientManager.themesDirectory = 'themes/acme/';
	clientManager.successMessage = "<jsp:getProperty name="customerSurvey"  property="successMessage" /><jsp:getProperty name="UserContext" property="successMessage" />";
	clientManager.errorMessage = "<jsp:getProperty name="customerSurvey"  property="errorMessage" /><jsp:getProperty name="UserContext" property="errorMessage" />";
	clientManager.sessionId='<jsp:getProperty name="customerSurvey" property="customerSessionInstanceID"/>';
	clientManager.authenticated=<%= UserContext.isAuthenticated()%>;
	clientManager.userName='<%= UserContext.getUserName()%>';
	clientManager.templateId='<jsp:getProperty name="customerSurvey" property="surveyTemplateInstanceID"/>';
	clientManager.customerSurveyId='<jsp:getProperty name="customerSurvey" property="customerSurveyInstanceID"/>';
	clientManager.originatingPage='<%= UserContext.getOriginatingPage()%>';
	clientManager.authenticationType='<%= UserContext.getAuthenticationType()%>';
	clientManager.isAuthenticationRequired='<%= customerSurvey.isAuthenticationRequired()%>';
}

var clientManager= KD.utils.ClientManager;
var catalogUtils=KD.utils.CatalogUtils;

function runLoadFunction() {
	clientManager.init();
	KINETIC.catalog.Helper.keepSessionAlive();
}

KD.utils.Action.addListener(window, "load", runLoadFunction);

KD.utils.Action.addListener(window, "unload", KD.utils.Util.resetCachePageValues, clientManager, true);

</script>

<jsp:getProperty name="customerSurvey" property="customHeaderContent"/>

</head>
<body class=" yui-skin-sam" onresize="KINETIC.catalog.Helper.setRequestsViewSize()">
	<div id="contentPageSection" class="contentPageSection rounded6 curvyRedraw">
		<div id="headerSection" class="headerSection">
			<div class="headerWelcome" onclick='try {catalogHelper.showMyInfo();} catch(e) {}'>
				<div id="authenticatedName" class="loginInfo"><div class="welcomeText">Welcome</div> <div class="welcomeLoginName" id='loginName'><%= UserContext.getUserName()%></div></div>
			</div>

			<div class="headerLogout roundedBottom6">
				<a href="KSAuthenticationServlet?Logout=true" class="logout"> Logout</a>
			</div>
		</div>
			<jsp:getProperty name="customerSurvey" property="questions"/>
			<%if (request.getParameter("srv") != null) {%>
			<input type="hidden" name="srv" value="<%=request.getParameter("srv")%>"/>
			<%}%>
			<%if (request.getParameter("csrv") != null) {%>
			<input type="hidden" name="csrv" value="<%=request.getParameter("csrv")%>"/>
			<%}%>
			<form name='sessionInfo' method='post' action='' onsubmit=''>
				<input type="hidden" name="templateID" id="templateID" value="<jsp:getProperty name="customerSurvey" property="surveyTemplateInstanceID"/>"/>
				<input type="hidden" name="sessionID" id="sessionID" value="<jsp:getProperty name="customerSurvey" property="customerSessionInstanceID"/>"/>
				<input type="hidden" name="surveyRequestID" id="surveyRequestID" value="<jsp:getProperty name="customerSurvey" property="customerSurveyRequestID"/>"/>
				<input type="hidden" name="pageID" id="pageID" value="<jsp:getProperty name="customerSurvey" property="pageInstanceID"/>"/>
			</form>
		<div id="footerSection" class="footerSection dynamicText ">
			Copyright &copy; 2010 Acme
		</div>
	</div>
<jsp:setProperty name="UserContext" property="errorMessage" value=""/>
<script type="text/javascript">
var _sf_async_config={uid:9729,domain:"demo.kineticdata.com"};
(function(){
function loadChartbeat() {
window._sf_endpt=(new Date()).getTime();
var e = document.createElement('script');
e.setAttribute('language', 'javascript');
e.setAttribute('type', 'text/javascript');
e.setAttribute('src',
(("https:" == document.location.protocol) ? "https://s3.amazonaws.com/" : "http://") +
"static.chartbeat.com/js/chartbeat.js");
document.body.appendChild(e);
}
var oldonload = window.onload;
window.onload = (typeof window.onload != 'function') ?
loadChartbeat : function() { oldonload(); loadChartbeat(); };
})();

</script>
</body>
</html>
