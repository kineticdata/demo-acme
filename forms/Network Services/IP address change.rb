require File.join(File.dirname(__FILE__),"../../standards.rb")

@@name = "IP address change"
@@categories = "Network Services"
@@type = "Network"
@@image = "#{@@standard_image_base}/globe.png"
@@description = "Change an existing IP address to a new IP address."




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


      question "Existing IP address", "Existing IP address", 
      :free_text,
      :required,
      :pattern_label => "IP Address",
      :pattern => "^(\\d{1,2}|1\\d\\d|2[0-4]\\d|25[0-5])\\.(\\d{1,2}|1\\d\\d|2[0-4]\\d|25[0-5])\\.(\\d{1,2}|1\\d\\d|2[0-4]\\d|25[0-5])\\.(\\d{1,2}|1\\d\\d|2[0-4]\\d|25[0-5])$",
      :validation_text => "Existing IP address must be valid - Example: 1.2.3.4",
      :size => "25",
      :rows => "1"

      
      question "New IP address", "New IP address", 
      :free_text,
      :required,
      :pattern_label => "IP Address",
      :pattern => "^(\\d{1,2}|1\\d\\d|2[0-4]\\d|25[0-5])\\.(\\d{1,2}|1\\d\\d|2[0-4]\\d|25[0-5])\\.(\\d{1,2}|1\\d\\d|2[0-4]\\d|25[0-5])\\.(\\d{1,2}|1\\d\\d|2[0-4]\\d|25[0-5])$",
      :validation_text => "New IP address must be valid - Example: 1.2.3.4",
      :size => "25",
      :rows => "1"
      

      
  end


  standard_page_confirmation

end

