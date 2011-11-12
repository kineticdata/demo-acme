require File.join(File.dirname(__FILE__),"/standard_section_requester.rb")
require File.join(File.dirname(__FILE__),"/standard_page_confirmation.rb")
require File.join(File.dirname(__FILE__),"/standard_initial_form.rb")


@@standard_company_name = "Acme"
@@standard_catalog_name = "ACME IT"
@@standard_catalog_name_url = "ACME_Catalog"
@@standard_catalog_survey_name_url = "ACME_ImproveOurService"
@@standard_authentication_form = "Catalog Login"
@@standard_company_base_domain_name = "acme.com"
@@standard_catalog_service_catalog_name = "ACME Service Portal"

@@standard_web_server = "http://demo.kineticdata.com/kinetic/"
@@standard_image_base = "/kinetic/themes/acme/images/primo_icons/PNG/64x64"
@@standard_themes_base = "/themes/acme"

@@standard_display_page = "#{@@standard_themes_base}/displayPage.jsp"
@@standard_confirmation_page = "#{@@standard_themes_base}/confirmationPage.jsp"
@@standard_catalog_page = "#{@@standard_themes_base}/serviceCatalog.jsp"

@@standard_data_set = "SYSTEM_DEFAULTS"
@@standard_header_content = ""
@@standard_assignee = "0;"
@@standard_management_group = "Public"
@@standard_submission_group = "Public"

# Gets the ID of the catalog 
# Some of the background tables don't have the name -- so we get the ID
def get_catalog_id(name)
# TODO - change this assumption???
# Assumes we only find one
#  entry_id = Kinetic::Link::entries('KS_SRV_Category', %|'600000500'="#{name}" AND '700036000'="Kinetic Request"|).first
#  catalog_guid = Kinetic::Link::entry('KS_SRV_Category', entry_id)["179"]
#  return catalog_guid
  form = Kinetic::Model.forms("KS_SRV_Category")
  entry = form.find_entries(:single,:conditions=> [%|'600000500'="#{name}" AND '700036000'="Kinetic Request"|])
  return entry[179] # GUID
end

# Builds a nice description with an image
# TODO - should this move to the JSP???
def build_description(name,description,image)
  return %`
    <div class="serviceItemDescriptionHeader rounded6" >#{name}</div>
    <div id="descriptionContent" class="descriptionContent">                     
      <div style="float:right;padding-left:5px;padding-bottom:5px;">
        <img src="#{image}"/>
      </div>
      <div style="clear:both;"> </div>
      <br/>
      #{description}<br/>
    </div>
  `
end




