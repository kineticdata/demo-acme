require File.join(File.dirname(__FILE__),"../../standards.rb")

@@name = "Calendar Integration Sample"
@@categories = "Playground"
@@type = "Playground"
@@image = "#{@@standard_image_base}/calendar.png"
@@description = "Sample form for scheduling."


service_item @@name do

  categories @@categories
  type @@type

  description build_description(@@name,@@description,@@image)


  standard_initial_form

  # override the header contest from standard_initial_form
  header_content "<script>
function refreshSchedule(ci) {
  var iframe, iframeId, iframeDoc, base, title, params;

  iframeId = 'iframeId';
  iframe = YAHOO.util.Dom.get(iframeId);
  if (iframe) {
    // Set the base calendar URL
    base = 'http://demo.kineticdata.com/KinCal/calendar?CalendarName=sithco_sample_scheduled_changes_param_ci';

    // Set the calendar title
    title = ci + ' Scheduled Changes';

    // Set the calendar parameters - making sure to encode all the values
    params = '&ci=' + encodeURIComponent(ci) + '&CalendarTitle=' + encodeURIComponent(title);

    // adjust the schedule height
    iframe.style.height = '600px';

    // show the ajax loader
    iframeDoc = iframe.contentDocument || window.frames[iframeId].document;
    if (iframeDoc) {
      var waitMsg = iframeDoc.getElementById('waitMsg');
      if (waitMsg) {
        waitMsg.style.display = 'none';
      }
      var loading = iframeDoc.getElementById('ajaxloading');
      if (loading) {
        loading.style.display = 'block';
      }
    }

  // Constructs the entire iFrame source
  iframe.src = base + params;
  }
}
</script>"
  
  style ".link span", "color: #0000ff;text-decoration: underline; cursor:pointer;", :css_class
  style ".floatLeft", "float:left; width:40%;", :css_class



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
    question "Server", "Server", :list,
      :radio_button,
      :horizontal,
      :choice_list => "ServerNames",
      :style_class => " floatLeft ",
      :field_map_number => "1" do
      choice "Eel"
      choice "Fox"
      choice "Platypus"
      choice "Rabbit"
      choice "Squirrel"
      event "refresh calendar",
        :custom_action,
        :click do
        custom_code "refreshSchedule(obj.value);"
      end
    end
    text "Display Calendar", "<span id=\"displayCal\">Show Schedule</span>",
      :style_class => " floatLeft link" do
      event "show contents",
        :custom_action,
        :click do
        custom_code "
        var el = YAHOO.util.Dom.get('displayCal');
        var schedule = KD.utils.Util.getElementObject('ScheduleWindow', 'DYNAMIC_TEXT_');
        if (el.innerHTML == 'Show Schedule') {
          el.innerHTML = 'Hide Schedule';
          schedule.style.display = 'block';
          } else {
            el.innerHTML = 'Show Schedule';
            schedule.style.display = 'none';
          }
        "
      end
    end
    question "Summary", "Summary", :free_text,
      :required,
      :size => "60",
      :rows => "1"
    question "Notes", "Notes", :free_text,
      :size => "60",
      :rows => "3"
    text "ScheduleWindow", "<iframe style='width: 99%; height: 100px; ' 
    scrolling='yes' name='iframeId class='advPlayer' id='iframeId' frameborder='0'
    src='http://demo.kineticdata.com/KinCal/custom/waitingForSelection.html'>
    </iframe>",
      :removed
  end


 
  standard_page_confirmation



end
