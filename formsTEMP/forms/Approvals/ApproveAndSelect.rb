require File.join(File.dirname(__FILE__),"../../standards.rb")
require File.join(File.dirname(__FILE__),"../../processes/software_process.rb")



  @@name = "Approval and select additional approver"
  @@categories = ""
  @@type = "Screen shot sample"
  @@image = "#{@@standard_image_base}/box.png"
  @@description = "Approval and select additional approver."
  @@task_description = "Approval and select additional approver"


  service_item @@name do

    categories @@categories
    type @@type

    description build_description(@@name,@@description,@@image)

    standard_initial_form
  
    standard_process_tree("Standard incident process",@@task_description)

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



      question "Approve", "Approve", 
      :list, 
      :list_box, 
      :horizontal, 
      :required, 
      :choice_list => "Approve" do
        choice "Yes"
        choice "No"
        
      event "MakeAdditionalApprover",
        :insert_remove,
        :change,
        :also_require,
        :fire_if => %`obj.value== "Yes"` do
        target "Additional Approver Section",
          :section,
          :insert
      end
      event "RemoveAdditionalApprover",
        :insert_remove,
        :change,
        :also_make_optional,
        :fire_if => %`obj.value== "No"` do
        target "Additional Approver Section",
          :section,
          :remove
      end        
        
        
        
        
      end



      question "Notes", "Notes", 
      :free_text,
      :size => "75",
      :rows => "3"



      section  "Additional Approver Section",
            :removed

      
        text "Additional Approver Text", "Additional Approver", 
        :style_class => " primaryColorHeader"


      question "Additional approver", "Additional approver", 
      :list, 
      :list_box, 
      :horizontal, 
      :choice_list => "Additional approver" do
        choice "Joe Smith"
        choice "Jane Doe"
      end



      



  end


  standard_page_confirmation


  end




