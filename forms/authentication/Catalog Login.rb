require File.join(File.dirname(__FILE__),"../standards.rb")


service_item @@standard_authentication_form do
  catalog @@standard_catalog_name
  categories ""
  type "Launcher"


  description %`Includes login, searching by template name, "My Requests" and "box" categorization.`
  display_page @@standard_catalog_page
  display_name ""
  header_content %`<script type="text/javascript">

  function setFocus (elementId) {
    if (elementId == null) {return;}
    var el = document.getElementById(elementId);        
    if (el) {
      el.select();
      el.focus();
    }
  }
  function submitLogin (el) {
    if (el) {
      el.disabled = "disabled";
      el.form.submit();
    }
  }

  </script>`


  data_set @@standard_data_set
  
  # This needs to be visible to everybody ???
  # as it is a login screen
  visible_to_group "0;"
  management_group @@standard_management_group
  submission_group @@standard_submission_group



  style ".headerWelcome", "display: none;", :css_class
  style ".headerLogout", "display: none;", :css_class
  style "\#loginHeader", "padding-left: 6px;", :combined



  page "Service Catalog Display",
    :confirmation,
    :vertical_buttons,
    :display_page => @@standard_catalog_page do
    style "", "overflow:visible !important;", :html_id
    
    event "Remove Login Box if Authenticated",
      :insert_remove,
      :load,
      :fire_if => "clientManager.authenticated==true " do
      target "Login Box",
        :text,
        :remove
      target "Redirect to Service Catalog",
        :text,
        :insert
    end
    event "Set focus to UserName",
      :custom_action,
      :load,
      :fire_if => "clientManager.authenticated !=true " do
      custom_code "setFocus('UserName');"
    end
    section  "Content Section",
      :style_class => " standard_box"
    text "Service Catalog Name", %`<div id="serviceCatalogName"><FLD>Survey Template Name;700001000;BASE</FLD></div>`,
      :style_class => " secondColorHeader standard_box siName"
    text "Login Box", %`<div id="message" class="loginErrorMessage"></div>
    <div class="standard_box  templateSection" style="padding:0;" id="loginLayer">
      <div id="loginHeader" class="primaryColorHeader standard_box">Please Login</div>
      <form name='Login' id="loginForm" method='post' action='KSAuthenticationServlet' style='margin:10px;'>
        <p><label for="UserName"><strong>User</strong></label><br />
        <input name="UserName" class="loginField" type="text" id="UserName" size="25" maxlength="50" /></p>
        <p><label for="Password"><strong>Password</strong></label><br />
        <input name="Password" class="loginField" type="password" id="Password" size="25" maxlength="50"/></p>
        <p style="display:none;"><label for="Authentication"><strong>Authentication String</strong></label><br />
        <input name="Authentication" class="loginField" type="text" id="Authentication" size="25" maxlength="50" /></p>
        <p><input name="Submit" type="submit" id="Login" value="Login" style="font-size:10px;" onclick="submitLogin(this);"/></p>
        <input type="hidden" name="originatingPage" id="originatingPage" value="" />
        <input type="hidden" name="sessionID" id="loginSessionID" value="" />
        <input type="hidden" name="authenticationType" id="authenticationType" value="" />
      </form>
    </div>`,
      :style_class => " loginBox"
    text "Redirect to Service Catalog", %`Are you trying to access the <a href="DisplayPage?name=#{@@standard_catalog_name_url}">service catalog?</a>`,
      :removed,
      :style_class => " catalogRedirectLink "
  end
end
