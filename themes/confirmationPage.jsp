<%--
 $Rev: 45 $
 $Date: 2010-08-24 18:32:26 -0400 (Tue, 24 Aug 2010) $
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
KD.utils.Action.addListener(window, "load", KD.utils.Util.checkCachePageLoad, clientManager, true);
KD.utils.Action.addListener(window, "unload", KD.utils.Util.resetCachePageValues, clientManager, true);

<%-- ReviewRequest override, used to avoid the need to have to maintain existing service item to remove the iFrame callback event --%>
KD.utils.Action.addListener(window, "load", purgeReviewRequestCallback);
function purgeReviewRequestCallback() {
    var iFrameObj = document.getElementById('reviewRequest');
    if (iFrameObj) {
        YAHOO.util.Event.purgeElement(iFrameObj);
    }
}
<%-- END ReviewRequest override--%>
</script>

<jsp:getProperty name="customerSurvey" property="customHeaderContent"/>

<%
  String requestID="";
  if (customerSurvey != null && customerSurvey.getCustomerSurveyBase()!=null) {
    String originatingID = (String)customerSurvey.getCustomerSurveyBase().getEntryFieldValue("700088607");
    if (originatingID!=null && originatingID.length()>0) {
        requestID=originatingID;
    } else {
        requestID=(String)customerSurvey.getCustomerSurveyBase().getEntryFieldValue("1");
    }
  }
%>
                
</head>
<body>
	<div id="contentPageSection" class="contentPageSection rounded6">
		<div id="headerSection" class="headerSection">
			<div class="returnToCatalog roundedBottom6">
				<a href='DisplayPage?name=ACME_Catalog' class="returnToCatalogLink">Return to Catalog</a>
			</div>
			<div class="headerLogout roundedBottom6">
				<a href="KSAuthenticationServlet?Logout=true" class="logout"> Logout</a>
			</div>
			<div class="KSR_Number">
				<%= requestID %>
			</div>
		</div>
        
        <div class="pageQuestionsForm">
            <div class="templateContent">
                <div class="templateSection">
                    <div class="dynamicText standard_box secondColorHeader">
                        <jsp:getProperty name="customerSurvey" property="surveyTemplateName"/>
                    </div>
                </div>
                <div class="templateSection">
                    <div class="dynamicText" >
                        <p>Thanks for your submission.</p>
                        <p><b>Submission ID: </b><%= requestID %></p>
                    </div>
                </div>
            </div>
        </div>
        
		<div id="footerSection" class="footerSection dynamicText ">
			Copyright &copy; 2010 Acme
		</div>
	</div>
<jsp:setProperty name="UserContext" property="errorMessage" value=""/>
</body>
</html>
