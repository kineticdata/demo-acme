def standard_initial_form
  
  catalog @@standard_catalog_name
  display_name ""
  display_page @@standard_display_page
  header_content ""
  web_server @@standard_web_server
  
  data_set @@standard_data_set

  visible_to_group @@standard_assignee
  management_group @@standard_management_group
  submission_group @@standard_submission_group

  allow_anonymous false

  
end
