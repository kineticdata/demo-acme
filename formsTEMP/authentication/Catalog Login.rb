require File.join(File.dirname(__FILE__),"../standards.rb")


service_item @@standard_authentication_form do
  catalog @@standard_catalog_name
  categories ""
  type "Launcher"

  form_type :launcher

  description %`Includes login, searching by template name, "My Requests" and "box" categorization.`
  display_page @@standard_login_page
  display_name ""
  header_content ""


  data_set @@standard_data_set
  
  # This needs to be visible to everybody ???
  # as it is a login screen
  visible_to_group "0;"
  management_group @@standard_management_group
  submission_group @@standard_submission_group


  page "Service Catalog Display",
    :confirmation,
    :vertical_buttons do

       text "Blank", "Blank" # This page is really rendered by the JSP - anything in the page is ignored.

  end
end
