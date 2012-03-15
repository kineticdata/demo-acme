require File.join(File.dirname(__FILE__),"../../standards.rb")

@@name = "Issue with electrical"
@@categories = "Facilities"
@@type = "Facilities"
@@image = "#{@@standard_image_base}/tools.png"
@@description = "Report an electrical issue."




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


      question "Details of issue", "Details of issue", 
      :free_text,
      :required,
      :size => "75",
      :rows => "3"


      question "Urgency", "Urgency", 
      :list, 
      :list_box, 
      :horizontal, 
      :required, 
      :choice_list => "Urgency" do
        choice "High"
        choice "Medium"
        choice "Low"
      end



      
  end


  standard_page_confirmation

end

