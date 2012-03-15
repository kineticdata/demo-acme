require File.join(File.dirname(__FILE__),"../../standards.rb")

@@name = "Departmental Multifunction Printer"
@@categories = "Network Services"
@@type = "Placeholder"
@@image = "#{@@standard_image_base}/print.png"
@@description = "Place an order for the supply of a department level multifunction printer/scanner/fax/copier."




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


      question "Estimate the level of daily usage", "Estimate the level of daily usage", 
      :list, 
      :list_box, 
      :horizontal, 
      :required, 
      :choice_list => "Usage" do
        choice "10 or less"
        choice "100 or less"
        choice "1000 or less"
        choice "More than 1000"        
      end


      question "Functions desired", "Functions desired", 
      :list, 
      :check_box, 
      :horizontal, 
      :required, 
      :choice_list => "PrinterFunctions" do
        choice "Print", "Print"
        choice "Scan", "Scan"
        choice "Copy", "Copy"
        choice "Fax", "Fax"
      end


      question "Color", "Color", 
      :list, 
      :list_box, 
      :horizontal, 
      :required, 
      :choice_list => "ColorChoice" do
        choice "Color"
        choice "Black and White"
      end



      question "Notes", "Notes", 
      :free_text,
      :size => "75",
      :rows => "3"

      
      
      
  end


  standard_page_confirmation

end

