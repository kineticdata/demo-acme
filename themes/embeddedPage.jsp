<%--
 $Rev: 45 $
 $Date: 2010-08-24 17:32:26 -0500 (Tue, 24 Aug 2010) $
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

<%@ include file="includes/yuiInclude.jspf" %>
<%@ include file="includes/kdInclude.jspf" %>

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

var clientManager= KD.utils.ClientManager;
KD.utils.Action.addListener(window, "load", clientManager.init, clientManager, true);


</script>

<jsp:getProperty name="customerSurvey" property="customHeaderContent"/>

</head>
<body>
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
</body>
</html>