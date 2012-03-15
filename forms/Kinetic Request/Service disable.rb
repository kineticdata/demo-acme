require File.join(File.dirname(__FILE__),"../../standards.rb")

@@name = "Disable a service"
@@categories = "Kinetic Request"
@@type = "Network"
@@image = "#{@@standard_image_base}/gear.png"
@@description = "Disable a service in the catalog."




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


      # TODO - Make a list of services in catalog
      question "Service name", "Service name", 
      :free_text,
      :required,
      :size => "25",
      :rows => "1"

      question "Shutdown time", "Shutdown time", 
      :free_text,
      :required,
      :size => "25",
      :rows => "1"


      question "Description", "Description", 
      :free_text,
      :required,
      :size => "75",
      :rows => "6"






      
  end


  standard_page_confirmation

end

