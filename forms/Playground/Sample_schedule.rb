require File.join(File.dirname(__FILE__),"../../standards.rb")

@@name = "Schedule Reboot Sample"
@@categories = "Playground"
@@type = "Playground"
@@image = "#{@@standard_image_base}/user.png"
@@description = "Sample form for scheduling."


service_item @@name do

  categories @@categories
  type @@type

  description build_description(@@name,@@description,@@image)


  standard_initial_form

  # override the header contest from standard_initial_form
  header_content "<script>\nfunction refreshSchedule(ci) {\n    var iframe, iframeId, iframeDoc, base, title, params;\n\n    iframeId = 'iframeId';\n    iframe = YAHOO.util.Dom.get(iframeId);\n    if (iframe) {\n        // Set the base calendar URL\n        base = 'http://demo.kineticdata.com/KinCal/calendar?CalendarName=sithco_sample_scheduled_changes_param_ci';\n        \n        // Set the calendar title\n        title = ci + ' Scheduled Changes';\n        \n        // Set the calendar parameters - making sure to encode all the values\n        params = '&ci=' + encodeURIComponent(ci) + '&CalendarTitle=' + encodeURIComponent(title);\n        \n        // adjust the schedule height\n        iframe.style.height = '600px';\n        \n        // show the ajax loader\n        iframeDoc = iframe.contentDocument || window.frames[iframeId].document;\n        if (iframeDoc) {\n            var waitMsg = iframeDoc.getElementById('waitMsg');\n            if (waitMsg) {\n                waitMsg.style.display = 'none';\n            }\n            var loading = iframeDoc.getElementById('ajaxloading');\n            if (loading) {\n                loading.style.display = 'block';\n            }\n        }\n        \n        // Constructs the entire iFrame source\n        iframe.src = base + params;\n    }\n}\n</script>"
  
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
        custom_code "var el = YAHOO.util.Dom.get('displayCal');\nvar schedule = KD.utils.Util.getElementObject('ScheduleWindow', 'DYNAMIC_TEXT_');\nif (el.innerHTML == 'Show Schedule') {\n  el.innerHTML = 'Hide Schedule';\n  schedule.style.display = 'block';\n} else {\n  el.innerHTML = 'Show Schedule';\n  schedule.style.display = 'none';\n}\n"
      end
    end
    question "Summary", "Summary", :free_text,
      :required,
      :size => "60",
      :rows => "1"
    question "Notes", "Notes", :free_text,
      :size => "60",
      :rows => "3"
    text "ScheduleWindow", "<iframe style='width: 99%; height: 100px; ' \nscrolling='yes' \nname='iframeId \nclass='advPlayer' \nid='iframeId' \nframeborder='0' \nsrc='http://demo.kineticdata.com/KinCal/custom/waitingForSelection.html'>\n</iframe>\n\n",
      :removed
  end


 
  standard_page_confirmation



end
