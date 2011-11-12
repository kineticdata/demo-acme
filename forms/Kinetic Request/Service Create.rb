require File.join(File.dirname(__FILE__),"../../standards.rb")

@@name = "Create new service"
@@categories = "Kinetic Request"
@@type = "Network"
@@image = "#{@@standard_image_base}/gear.png"
@@description = "Create a new service to be registered in the catalog."




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


      question "Service name", "Service name", 
      :free_text,
      :required,
      :size => "25",
      :rows => "1"

      question "Service description", "Service description", 
      :free_text,
      :required,
      :size => "75",
      :rows => "6"

      question "Icon name", "Icon name", 
      :free_text,
      :required,
      :size => "25",
      :rows => "1"

      # TODO - Figure out how to dynamically show the list
      question "Category", "Category", 
      :free_text,
      :required,
      :size => "25",
      :rows => "1"





      
  end


  standard_page_confirmation

end

