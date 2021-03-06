require File.join(File.dirname(__FILE__),"../../standards.rb")

@@name = "Register new DNS name"
@@categories = "Network Services"
@@type = "Network"
@@image = "#{@@standard_image_base}/globe.png"
@@description = "Register a new name for our #{@@standard_company_base_domain_name} domain."




service_item @@name do

  categories @@categories
  type @@type

  description build_description(@@name,@@description,@@image)

  standard_initial_form

  page "Initial Page",
    :contents,
    :horizontal_buttons,
    :submit_button_value => "Submit" do
      
      
    text "Service Item Description", "<p>#{build_description(@@name,@@description,@@image)}</p>"


      standard_section_requester


      # Here is where questions go

      section  "Details Section"

      text "Details Header Text", "Details", 
      :style_class => " primaryColorHeader"

      section  "Details"


      question "Requested DNS name", "Requested DNS name", 
      :free_text,
      :required,
      :size => "25",
      :rows => "1"
      
      question "IP address", "IP address", 
      :free_text,
      :required,
      :pattern_label => "IP Address",
      :pattern => "^(\\d{1,2}|1\\d\\d|2[0-4]\\d|25[0-5])\\.(\\d{1,2}|1\\d\\d|2[0-4]\\d|25[0-5])\\.(\\d{1,2}|1\\d\\d|2[0-4]\\d|25[0-5])\\.(\\d{1,2}|1\\d\\d|2[0-4]\\d|25[0-5])$",
      :validation_text => "IP address must be valid - Example: 1.2.3.4",
      :size => "25",
      :rows => "1"
      

      
  end


  standard_page_confirmation

end

