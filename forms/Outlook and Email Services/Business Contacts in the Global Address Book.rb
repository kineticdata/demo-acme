require File.join(File.dirname(__FILE__),"../../standards.rb")

@@name = "Business Contacts in the Global Address Book"
@@categories = "Outlook and Email Services"
@@type = "Screen shot sample"
@@image = "#{@@standard_image_base}/vcards.png"
@@description = "Contacts are listings in the Address Book for agents, vendors, partners and other widely-used business email addresses."

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




      question "Notes", "Notes", 
      :free_text,
      :size => "75",
      :rows => "3"

      
      
      
  end


  standard_page_confirmation

end

