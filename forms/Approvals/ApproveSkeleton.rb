require File.join(File.dirname(__FILE__),"../../standards.rb")
require File.join(File.dirname(__FILE__),"../../processes/software_process.rb")



  @@name = "ApprovalSkeleton"
  @@categories = "Playground"
  @@type = "ApprovalTemplate"
  @@image = "/kinetic/themes/acme/images/primo_icons/PNG/64x64/box.png"
  @@description = "Approval skeleton."
  @@task_description = "Approval skeleton"


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


        standard_approval_section_approver


        # Here is where questions go

        section  "Details Section"
        text "Details Header Text", "Details", 
        :style_class => " primaryColorHeader"

        section  "Details"

      text "Request Details", "<div id=\"request_details\">Details Description - should be replaced</div>"


      question "Approve", "Approve", 
      :list, 
      :list_box, 
      :horizontal, 
      :required, 
      :choice_list => "Approve" do
        choice "Yes"
        choice "No"
        event "Show Denial Reason",
          :insert_remove,
          :change,
          :also_require,
          :fire_if => %`obj.value== "No"` do
          target "Denial Section",
            :section,
            :insert
        end
        event "Hide Denial Reason",
          :insert_remove,
          :change,
          :also_make_optional,
          :fire_if => %`obj.value== "Yes"` do
          target "Denial Section",
            :section,
            :remove
        end        
      end

      # question "Notes", "Notes", 
      # :free_text,
      # :size => "75",
      # :rows => "3"

      section  "Denial Section",
      :removed
      text "Denial Details", "Denial Details", 
      :style_class => " primaryColorHeader"

      question "Denial Notes", "Denial Notes", 
      :free_text,
      :size => "75",
      :rows => "3"



  end


  standard_approval_page_confirmation


  end




