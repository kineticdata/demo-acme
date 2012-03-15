require File.join(File.dirname(__FILE__),"/standard_section_requester.rb")
require File.join(File.dirname(__FILE__),"/standard_approval_section_approver.rb")

require File.join(File.dirname(__FILE__),"/standard_page_confirmation.rb")
require File.join(File.dirname(__FILE__),"/standard_approval_page_confirmation.rb")

require File.join(File.dirname(__FILE__),"/standard_initial_form.rb")


@@standard_company_name = "Acme"
@@standard_catalog_name = "ACME"
@@standard_catalog_name_url = "ACME_Catalog"
@@standard_catalog_survey_name_url = "ACME_ImproveOurService"
@@standard_authentication_form = "Catalog Login"

@@standard_company_base_domain_name = "acme.com"

@@standard_catalog_service_catalog_name = "ACME Service Portal"


@@standard_themes_base = "/themes/acme"
@@standard_image_base = "/kinetic/themes/acme/images/primo_icons/PNG/64x64"


@@standard_display_page = "#{@@standard_themes_base}/displayPage.jsp"
@@standard_confirmation_page = "#{@@standard_themes_base}/confirmationPage.jsp"
@@standard_catalog_page = "#{@@standard_themes_base}/serviceCatalog.jsp"



@@standard_web_server = "http://demo.kineticdata.com/kinetic/"


@@standard_data_set = "SYSTEM_DEFAULTS"
@@standard_header_content = %||


@@standard_assignee = "0;"
@@standard_management_group = "Public"
@@standard_submission_group = "Public"


# Assumes Klink already loaded
# Gets the ID of the catalog -- some of the background tables
# dont have the name -- so we get the ID
def get_catalog_id(name)

  # KURL/Klink
  # # Assumes finds only one
  # entry_id = Kinetic::Link::entries('KS_SRV_Category', %|'600000500'="#{name}" AND '700036000'="Kinetic Request"|).first
  # 
  # # Gets the instanceId
  # catalog_guid = Kinetic::Link::entry('KS_SRV_Category', entry_id)["179"]
  # 
  # return catalog_guid
  
  # KURL/ARSModels
  # Assumes finds only one
  form = Kinetic::Model.forms("KS_SRV_Category")
  entry = form.find_entries(:single,:conditions=> [%|'600000500'="#{name}" AND '700036000'="Kinetic Request"|])
  return entry[179]
end



def build_description(name,description,image)
  
  return %`
    <div class="serviceItemDescriptionHeader rounded6" >#{name}</div>
    <div id="descriptionContent" class="descriptionContent">                     
      <div style="float:right;padding-left:5px;padding-bottom:5px;">
        <img src="#{@@standard_image_base}/#{image}"/>
      </div>
      <br/>
      #{description}<br/>
    </div>
    <div style="clear:both;"> </div>
  `
  
end




