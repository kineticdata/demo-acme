require File.join(File.dirname(__FILE__),"../../standards.rb")

@@name = "Generic network assistance"
@@categories = "Network Services"
@@type = "Network"
@@image = "#{@@standard_image_base}/help_blue.png"
@@description = "Request assistance for various network topics. Examples: DNS, DHCP, TCP/IP, routers, switches, etc..."




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


      question "Question", "Question", 
      :free_text,
      :required,
      :size => "75",
      :rows => "3"

      
  end


  standard_page_confirmation

end

