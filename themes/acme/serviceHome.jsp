<%-- 
    Document   : home
    Created on : Oct 1, 2010, 10:09:55 AM
    Author     : Rob
--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<jsp:useBean id="customerSurvey" scope="request" class="com.kd.kineticSurvey.beans.CustomerSurvey"/>
<jsp:useBean id="UserContext" scope="session" class="com.kd.kineticSurvey.beans.UserContext"/>
<%@page contentType="text/html; charset=UTF-8"%>
<%
response.setHeader("CACHE-CONTROL","no-cache, no-store, must-revalidate, max-age=0"); //HTTP 1.1
response.setDateHeader ("EXPIRES", 0); //prevents caching at the proxy server
response.setHeader("PRAGMA","NO-CACHE");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>
<jsp:getProperty name="customerSurvey" property="surveyTemplateName"/>
</title>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() + "/resources/js/yui/build/carousel/assets/skins/sam/carousel.css"%>"/>
<%@ include file="includes/yuiInclude.jspf" %>
<%@ include file="includes/kdInclude.jspf" %>

<script type="text/javascript" src="<%=request.getContextPath() + "/resources/js/yui/build/carousel/carousel-min.js"%>"></script>
<script type="text/javascript" src="<%=request.getContextPath() + "/resources/js/yui/build/yahoo-dom-event/yahoo-dom-event.js"%>"></script>
<script type="text/javascript" src="<%=request.getContextPath() + "/resources/js/yui/build/element/element-min.js"%>"></script>

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
	<div id="contentPageSection" class="contentPageSection">
		<div id="headerSection" class="headerSection">
			<div class="headerWelcome" onclick='try {catalogHelper.showMyInfo();} catch(e) {}'>
				<div id="authenticatedName" class="loginInfo"><div class="welcomeText">Welcome</div> <div class="welcomeLoginName" id='loginName'><%= UserContext.getUserName()%></div></div>
			</div>

			<div class="headerLogout roundedBottom6">
				<a href="KSAuthenticationServlet?Logout=true" class="logout"> Logout</a>
			</div>
		</div>
                <div id="contentBody" class="">
                    <div class="dynamicText secondColorHeader standard_box">
                        <div id="serviceCatalogName" >Catalog Home</div>
                    </div>
                    <div id="topContentSection">
                        <div id="imageSection">
                            <!-- The Carousel container -->
                            <div id="carouselContainer">
                                <ol id="carousel">
                                    <li>
                                        <div class="scrollImage1">
                                            <div class="image1Text">Excellence in customer satisfaction.</div>
                                        </div>
                                    </li>
                                    <li>
                                        <div class="scrollImage2">
                                            <div class="image2Text">Services delivered at light speed.</div>
                                        </div>
                                    </li>
                                    <li>
                                        <div class="scrollImage3">
                                            <div class="image3Text">Bringing you new services<br/>and award-winning<br/>customer support.</div>
                                        </div>
                                    </li>
                                </ol>
                            </div>
                        </div>
                        <div id="loginSection">
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
                        </div>
                        <div style="clear:both;"></div>
                    </div>
                    <div id="bottomContentSection">
                        <div id="alertSection">
                            <div class="borderPadding">
                                <div class="dynamicText secondColorHeader standard_box">
                                       <div class="homeHeaderText">System Alerts</div>
                                </div>
                                <div class="contentLinks">
                                    <div class="contentLink" ><a target="_blank" href="http://support.kineticdata.com" class="alertLink">SAP - Inventory System Slow</a></div>
                                    <div class="contentLink" ><a target="_blank" href="http://www.kineticdata.com/training/registration.html" class="alertLink">Training Registration Down</a></div>
                                </div>
                            </div>
                        </div>
                        <div id="messageSection">
                            <div class="borderPadding">
                                 <div class="dynamicText secondColorHeader standard_box">
                                    <div class="homeHeaderText">What's New?</div>
                                </div>
                                 <div class="contentLinks">
                                     <div class="contentLink" ><a target="_blank" href="http://www.kineticdata.com/Products/KineticRequest/index.html" class="alertLink">Kinetic Request</a></div>
                                     <div class="contentLink" ><a target="_blank" href="http://www.kineticdata.com/Products/KineticSurvey/index.html" class="alertLink">Kinetic Survey</a></div>
                                     <div class="contentLink" ><a target="_blank" href="http://www.kineticdata.com/Products/KineticCalendar/index.html" class="alertLink">Kinetic Calendar</a></div>
                                     <div class="contentLink" ><a target="_blank" href="http://www.kineticdata.com/News/index.html" class="alertLink">Recent News</a></div>
                                </div>
                            </div>
                        </div>
                        <div id="highlightSection">
                            <div class="borderPadding">
                                <div class="dynamicText secondColorHeader standard_box">
                                    <div class="homeHeaderText">Scheduled Changes</div>
                                </div>
                                <div class="contentLinks">
                                    <div class="contentLink" ><a target="_blank" href="http://www.kineticdata.com/Products/KineticCalendar/index.html" class="alertLink">Remedy 7.6.3 Upgrade</a></div>
                                    <div class="contentLink" ><a target="_blank" href="http://www.kineticdata.com/Products/KineticCalendar/index.html" class="alertLink">AntiVirus Update</a></div>
                                    <div class="contentLink" ><a target="_blank" href="http://www.kineticdata.com/Products/KineticCalendar/index.html" class="alertLink">Server Move Scheduled</a></div>
                                </div>
                            </div>
                        </div>
                        <div style="clear:both;"></div>
                    </div>
                    <div style="clear:both;"></div>
                </div>
		<div id="footerSection" class="footerSection dynamicText ">
			Copyright &copy; 2010 Acme
		</div>
	</div>
<jsp:setProperty name="UserContext" property="errorMessage" value=""/>
    <script>
    (function () {
        var carousel;

        YAHOO.util.Event.onDOMReady(function (ev) {
            var carousel    = new YAHOO.widget.Carousel("carouselContainer", {
                        isCircular: true, numVisible: 1, autoPlayInterval: 10000
                });

            carousel.render(); // get ready for rendering the widget
            carousel.show();   // display the widget
            carousel.startAutoPlay();
        });
    })();
    </script>

</body>
</html>
