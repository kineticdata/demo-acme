require File.join(File.dirname(__FILE__),"../../standards.rb")
require File.join(File.dirname(__FILE__),"../../processes/software_process.rb")


@@name = "Profile"
@@categories = ""
@@type = "ServiceItem"
@@image = "#{@@standard_image_base}/user.png"
@@description = "Update personal information."
@@task_description = "Person Update"


service_item @@name do

  categories @@categories
  type @@type

  description build_description(@@name,@@description,@@image)

  standard_initial_form
  display_name "#{@@standard_catalog_name}_UserProfile"

  standard_process_tree("Standard incident process",@@task_description)

  page "Initial Page",
    :contents,
    :horizontal_buttons,
    :submit_button_value => "Submit" do
    
    
    text "Service Item Description", "<p>#{build_description(@@name,@@description,"")}</p>"

    text "Gravatar", "<div id=\"gravatar\" style=\"float:right;\"></div>\n<script type=\"text/javascript\">\njQuery(document).ready(function() {\ngravatar($.trim($('.email input').val()), '#gravatar');\n});\n</script>"
    

    section  "Submitter"
    question "Requester First Name", "First Name", :free_text,
      :required,
      :advance_default,
      :editor_label => "Req First Name",
      :answer_mapping => "First Name",
      :default_form => "KS_SAMPLE_People",
      :default_field => "First Name",
      :default_qual => "'AR Login'=$\\USER$",
      :size => "20",
      :rows => "1",
      :max => "50",
      :required_text => "Requester First Name"
    question "Requester Last Name", "Last Name", :free_text,
      :required,
      :advance_default,
      :editor_label => "Req Last Name",
      :answer_mapping => "Last Name",
      :default_form => "KS_SAMPLE_People",
      :default_field => "Last Name",
      :default_qual => "'AR Login'=$\\USER$",
      :size => "20",
      :rows => "1",
      :max => "100",
      :required_text => "Requester Last Name"
    question "Requester Email Address", "Email", :email,
      :required,
      :advance_default,
      :editor_label => "Req Email Address",
      :answer_mapping => "Contact Info Value",
      :default_form => "KS_SAMPLE_People",
      :default_field => "Email",
      :default_qual => "'AR Login'=$\\USER$",
      :size => "20",
      :required_text => "Requester Email",
      :pattern_label => "Standard Email Address",
      :pattern => "^[\\w-\\.]+\\@[\\w\\.-]+\\.[a-zA-Z]{2,4}$",
      :validation_text => "Requester Email Address (Standard Email Address)",
      :style_class => " email ",
      :field_map_number => "1"
    question "Address", "Address", :free_text,
      :advance_default,
      :default_form => "KS_SAMPLE_People",
      :default_field => "AddrLine1",
      :default_qual => "'AR Login'=$\\USER$",
      :size => "20",
      :rows => "1",
      :field_map_number => "2"
    question "City", "City", :free_text,
      :advance_default,
      :default_form => "KS_SAMPLE_People",
      :default_field => "City",
      :default_qual => "'AR Login'=$\\USER$",
      :size => "20",
      :rows => "1",
      :field_map_number => "3"
    question "State", "State", :free_text,
      :advance_default,
      :default_form => "KS_SAMPLE_People",
      :default_field => "State/Prov",
      :default_qual => "'AR Login'=$\\USER$",
      :size => "20",
      :rows => "1",
      :field_map_number => "4"
    question "Zip", "Zip", :free_text,
      :advance_default,
      :default_form => "KS_SAMPLE_People",
      :default_field => "Postal Code",
      :default_qual => "'AR Login'=$\\USER$",
      :size => "20",
      :rows => "1",
      :field_map_number => "5"
      

	end


standard_page_confirmation


end



