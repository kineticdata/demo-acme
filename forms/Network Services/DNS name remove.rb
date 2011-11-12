require File.join(File.dirname(__FILE__),"../../standards.rb")

@@name = "Remove DNS name"
@@categories = "Network Services"
@@type = "Network"
@@image = "#{@@standard_image_base}/globe.png"
@@description = "Remove an existing name from our #{@@standard_company_base_domain_name} domain."




service_item @@name do

  categories @@categories
  type @@type

  description build_description(@@name,@@description,@@image)

  standard_initial_form

  page "Initial Page",
    :contents,
    :horizontal_buttons,
    :submit_button_value => "Submit",
    :display_page => @@standard_display_page do
      
      
    text "Service Item Description", "<p>#{build_description(@@name,@@description,@@image)}</p>"


      standard_section_requester


      # Here is where questions go

      section  "Details Section"

      text "Details Header Text", "Details", 
      :style_class => " primaryColorHeader"

      section  "Details"


      question "Requested DNS name to remove", "Requested DNS name to remove", 
      :free_text,
      :required,
      :size => "25",
      :rows => "1"

      
  end


  standard_page_confirmation

end

