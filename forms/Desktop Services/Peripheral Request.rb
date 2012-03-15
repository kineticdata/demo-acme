require File.join(File.dirname(__FILE__),"../../standards.rb")
require File.join(File.dirname(__FILE__),"../../processes/software_process.rb")


@@name = "Peripheral Request"
@@categories = "Desktop Services, **New Services"
@@type = "Screen shot sample"
@@image = "#{@@standard_image_base}/box.png"
@@description = "Order peripheral."
@@task_description = "Peripheral order"


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

      question "Peripheral Device", "Peripheral Device", :list,
      :list_box,
      :horizontal,
      :required,
      :choice_list => "Peripheral Devices",
      :required_text => "Peripheral Device" do
      choice "Keyboard"
      choice "Mouse"
      choice "Printer"
      choice "Monitor"
      event "Show Keyboard",
        :insert_remove,
        :change,
        :fire_if => %`obj.value== "Keyboard" ` do
        target "Keyboard Section",
          :section,
          :insert
        target "Monitor",
          :section,
          :remove
        target "Mouse Section",
          :section,
          :remove
        target "Printer Section",
          :section,
          :remove
      end
      event "Show Mouse",
        :insert_remove,
        :change,
        :fire_if => %`obj.value== "Mouse" ` do
        target "Mouse Section",
          :section,
          :insert
        target "Keyboard Section",
          :section,
          :remove
        target "Monitor",
          :section,
          :remove
        target "Printer Section",
          :section,
          :remove
      end
      event "Show Printer",
        :insert_remove,
        :change,
        :fire_if => %`obj.value== "Printer" ` do
        target "Printer Section",
          :section,
          :insert
        target "Keyboard Section",
          :section,
          :remove
        target "Monitor",
          :section,
          :remove
        target "Mouse Section",
          :section,
          :remove
      end
      event "Show Monitor",
        :insert_remove,
        :change,
        :fire_if => %`obj.value== "Monitor" ` do
        target "Monitor",
          :section,
          :insert
        target "Keyboard Section",
          :section,
          :remove
        target "Mouse Section",
          :section,
          :remove
        target "Printer Section",
          :section,
          :remove
      end
    end
    section  "Keyboard Section" do
      style "display:none;"
    end
    text "Keyboard Header", "Keyboard Details",
      :style_class => " standard_box secondColorHeader"
    question "Keyboard Type", "Keyboard Type", :list,
      :list_box,
      :horizontal,
      :choice_list => "Keyboard Type" do
      choice "Standard Keyboard"
      choice "Split Keyboard"
    end
    question "Keyboard Connection Type", "Keyboard Connection Type", :list,
      :list_box,
      :horizontal,
      :choice_list => "ConnectionType" do
      choice "USB"
      choice "PS2"
      choice "Wireless"
    end
    section  "Mouse Section" do
      style "display:none;"
    end
    text "Mouse Header", "Mouse Details",
      :style_class => " standard_box secondColorHeader"
    question "Mouse Type", "Mouse Type", :list,
      :list_box,
      :horizontal,
      :choice_list => "MouseType" do
      choice "Two Button Mouse"
      choice "Three Button Mouse"
      choice "Joystick Mouse"
      choice "Trackball"
      choice "External laptop portable mouse"
    end
    question "Mouse Connection Type", "Mouse Connection Type", :list,
      :list_box,
      :horizontal,
      :choice_list => "ConnectionType"
    section  "Printer Section" do
      style "display:none;"
    end
    text "Printer Header", "Printer Details",
      :style_class => " standard_box secondColorHeader"
    question "Printer Type", "Printer Type", :list,
      :list_box,
      :horizontal,
      :choice_list => "PrinterType" do
      choice "Black and White Laser"
      choice "Color Laser"
      choice "Color Inkjet"
      choice "Photo printer"
    end
    section  "Monitor" do
      style "display:none;"
    end
    text "Monitor Header", "Monitor Details",
      :style_class => " standard_box secondColorHeader"
    question "Monitor Type", "Monitor Type", :list,
      :list_box,
      :horizontal,
      :choice_list => "MonitorType" do
      choice "LCD"
      choice "CRT"
    end
    question "Monitor Size", "Monitor Size", :list,
      :list_box,
      :horizontal,
      :choice_list => "MonitorSize" do
      choice %`17"`
      choice %`19"`
      choice %`21"`
      choice %`25"`
    end
    section  "Notes"
    question "Comments", "Specific requirements about this request?", :free_text,
      :blank,
      :size => "60",
      :rows => "4"      
      
      

end


standard_page_confirmation


end






