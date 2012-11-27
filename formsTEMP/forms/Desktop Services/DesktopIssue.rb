require File.join(File.dirname(__FILE__),"../../standards.rb")
require File.join(File.dirname(__FILE__),"../../processes/software_process.rb")


@@name = "Computer Problem"
@@categories = "Desktop Services, **New Services"
@@type = "ServiceItem"
@@image = "#{@@standard_image_base}/chip.png"
@@description = "Report a problem with a computer."
@@task_description = "Problem Report"


service_item @@name do

  categories @@categories
  type @@type

  description build_description(@@name,@@description,@@image)

  standard_initial_form

  standard_process_tree("Standard incident process",@@task_description)

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

    section  "Notes"
    question "Comments", "Issue description", :free_text,
      :blank,
      :size => "60",
      :rows => "4"      
      

    question "Attachment", "Screenshot", :attachment,
    	:size => "20",
    	:rows => "1",
    	:file_size_limit => "2048",
    	:upload_label => "Load",
    	:clear_label => "Clear"
      

end


standard_page_confirmation


end






