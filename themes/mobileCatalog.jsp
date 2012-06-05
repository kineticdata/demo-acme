<%-- 
    Document   : mobileCatalog
    Created on : Apr 27, 2011, 2:41:55 PM
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

<jsp:getProperty name="customerSurvey" property="customHeaderContent"/>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() + "/resources/jquery.mobile-1.0a4.1/jquery.mobile-1.0a4.1.min.css"%>" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() + "/themes/acme/css/mobileTheme.css"%>" />
<script type="text/javascript" src="http://code.jquery.com/jquery-1.5.2.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() + "/resources/jquery.mobile-1.0a4.1/jquery.mobile-1.0a4.1.min.js"%>"></script>

</head>
<body>
    <div data-role="page" data-theme="acme">

	<div data-role="header">
		<h1>ACME Mobile Service Portal</h1>
	</div><!-- /header -->

	<div data-role="content" data-theme="acme">
            <a href="http://demo.kineticdata.com/kinetic/DisplayPage?srv=KSfcf2cdff91dc094b1dce460695fc2b6b7a" data-ajax="false" data-role="button" data-theme="acme">Create External Issue</a>
            <a href="http://demo.kineticdata.com/kinetic/DisplayPage?srv=KS28ca8b7ad82f3cec2d920d53d040aa407c" data-ajax="false" data-role="button" data-theme="acme">Create Facilities Issue</a>
            <a href="http://demo.kineticdata.com/kinetic/DisplayPage?srv=KS80d0851520647fbe65c7c4ba577aa9754" data-ajax="false" data-role="button" data-theme="acme">New Issue Approval</a>
            <jsp:setProperty name="UserContext" property="errorMessage" value=""/>
	</div><!-- /content -->

	<div data-role="footer">
		<h4>Copyright &copy; 2011 Acme</h4>
	</div><!-- /footer -->
    </div>
</body>
</html>
