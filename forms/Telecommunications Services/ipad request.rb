require File.join(File.dirname(__FILE__),"../../standards.rb")
require File.join(File.dirname(__FILE__),"../../processes/simple_incident.rb")


@@name = "iPad request"
@@categories = "Telecommunications Services,**New Services"
@@type = "Placeholder"
@@image = "http://storeimages.apple.com/1766/store.apple.com/Catalog/regional/amr/ipad/img/overview-wifi.png"
@@description = "iPad request."
@@task_description = "#{@@name}"



service_item @@name do

  categories @@categories
  type @@type

  description build_description(@@name,@@description,@@image)

  standard_initial_form

  simple_indident_process_tree("Standard incident process",@@task_description)


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



      question "Disk Size", "Disk Size", 
      :list, 
      :list_box, 
      :horizontal, 
      :required, 
      :choice_list => "Urgency" do
        choice "16GB"
        choice "32GB"
        choice "64GB"
      end



      question "3G Enabled", "3G Enabled", 
      :list, 
      :list_box, 
      :horizontal, 
      :required, 
      :choice_list => "3G" do
        choice "Yes"
        choice "No"
      end





      question "Business Justification", "Business Justification", 
      :free_text,
      :required, 
      :size => "75",
      :rows => "3"



      question "Engraving Message", "Engraving Message - leave blank if none", 
      :free_text,
      :size => "75",
      :rows => "3"




      
      
  end


  standard_page_confirmation

end

