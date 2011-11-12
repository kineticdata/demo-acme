require File.join(File.dirname(__FILE__),"../../standards.rb")
require File.join(File.dirname(__FILE__),"../../processes/software_process.rb")



def build_form(product)

  @@name = "#{product} install"
  @@categories = "Desktop Services"
  @@type = "Screen shot sample"
  @@image = "#{@@standard_image_base}/box.png"
  @@description = "Request installation of #{product}."
  @@task_description = "#{product} install"


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


        question "Business justification", "Business justification", 
        :free_text,
        :required,
        :size => "60", 
        :rows => "3"

  end


  standard_page_confirmation


  end
  
end




[
  "Adobe Reader",
  "Adobe Photoshop",
  "Microsoft Office",
  "Microsoft Word",
  "Microsoft Powerpoint",
  "Microsoft Excel",
  "Microsoft Access",
  "Remedy Client",
  "SAP Client"
  ].each do |product|
  build_form(product)
end



