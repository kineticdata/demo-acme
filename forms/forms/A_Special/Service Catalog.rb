require File.join(File.dirname(__FILE__),"../../standards.rb")

# Gets the ID of the catalog -- some of the background tables
# dont have the name -- so we get the ID
@@cat_inst_id = get_catalog_id(@@standard_catalog_name)

service_item @@standard_catalog_service_catalog_name do
  
  
  categories ""
  type "Launcher"
  form_type :launcher
  
  description %`Includes login, searching by template name, "My Requests" and "box" categorization.`
  display_page @@standard_catalog_page
  
  
  display_name @@standard_catalog_name_url
  authentication :template, :template_name => @@standard_authentication_form

  catalog @@standard_catalog_name

  header_content ""

  data_set @@standard_data_set
  
  visible_to_group @@standard_assignee
  management_group @@standard_management_group
  submission_group @@standard_submission_group
  
  page "Service Catalog Display",
    :confirmation,
    :vertical_buttons do

      text "Blank", "Blank" # This page is really rendered by the JSP - anything in the page is ignored.

  end
  
  
  
  
end

puts "Finished building: #{@@standard_web_server}/DisplayPage?name=#{@@standard_catalog_name_url}"


