require File.join(File.dirname(__FILE__),"../../standards.rb")

@@name = "Request access to demo catalog"
@@categories = "Kinetic Request"
@@type = "Access"
@@image = "#{@@standard_image_base}/user.png"
@@description = "Request user account for demo catalog."




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


      question "First name", "First name", 
      :free_text,
      :required,
      :size => "25",
      :rows => "1"

      question "Last name", "Last name", 
      :free_text,
      :required,
      :size => "25",
      :rows => "1"

      question "Preferred account name", "Preferred account name", 
      :free_text,
      :required,
      :size => "25",
      :rows => "1"

      question "Email address", "Email address", 
      :free_text,
      :required,
      :pattern_label => "Standard Email Address", 
      :pattern => "^[\\w-\\.]+\\@[\\w\\.-]+\\.[a-zA-Z]{2,4}$", 
      :validation_text => "Email Address not valid - Example: joe@someco.com",
      :size => "25",
      :rows => "1"

      
  end


  standard_page_confirmation

end

