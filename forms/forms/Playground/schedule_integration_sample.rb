require File.join(File.dirname(__FILE__),"../../standards.rb")

@@name = "Schedule Integration Sample"
@@categories = "Playground"
@@type = "Playground"
@@image = "#{@@standard_image_base}/calendar.png"
@@description = "Sample form for scheduling."


service_item @@name do

  categories @@categories
  type @@type

  description build_description(@@name,@@description,@@image)


  standard_initial_form



  page "Initial Page",
    :contents,
    :horizontal_buttons,
    :submit_button_value => "Next->" do


    text "Header", build_description(@@name,@@description,@@image)


    standard_section_requester



    section  "Details Section"
    text "Details Header Text", "Details",
      :style_class => " primaryColorHeader"
    section  "Details"
    
    question "Summary", "Summary", :free_text,
      :required,
      :size => "60",
      :rows => "1"
    question "Notes", "Notes", :free_text,
      :size => "60",
      :rows => "3"

    text "ScheduleWindow", "
    <iframe style='width: 99%; height: 600px; ' 
    scrolling='yes' name='iframeId class='advPlayer' id='iframeId' frameborder='0' 
    src='http://demo.kineticdata.com/schedule/calendar?CalendarName=tech_schedule'>
    </iframe>
    "
  end


 
  standard_page_confirmation



end
