require File.join(File.dirname(__FILE__),"../../standards.rb")




def build_form(system_task)

  @@name = "Schedule #{system_task} Task"
  @@categories = "Operations"
  @@type = "Screen shot sample"
  @@image = "#{@@standard_image_base}/box.png"
  @@description = "Schedule #{system_task}."


  service_item @@name do

    categories @@categories
    type @@type

    description build_description(@@name,@@description,@@image)

    standard_initial_form
  


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


        question "Server", "Server", 
        :list, 
        :radio_button, 
        :horizontal, 
        :choice_list => "ServerNames" do
          choice "Eel"
          choice "Fox"
          choice "Platypus"
          choice "Rabbit"
          choice "Squirrel"
        end


        question "Summary", "Summary", 
        :free_text,
        :required,
        :size => "60", 
        :rows => "1"
  
        question "Notes", "Notes", 
        :free_text, 
        :size => "60", 
        :rows => "3"



text "RefreshCalendar","  
<script>

function refresh() {
    var iframe, base, ci, title, qual, src;
    iframe = getIframe();
    if (iframe) {
        
        //************************************************************
        // User entered values
        ci = KD.utils.Action.getQuestionValue('Server');
        
        //************************************************************
        if (!ci || ci.length == 0) {
            alert('Please select a server.');
            return null;
        }
        
        // show the loading image on first load
        showLoading(iframe);

        // Specify a calendar name - this could also be a drop-down with all the available Calendars
        base = 'http://demo.kineticdata.com/KinCal/calendar?CalendarName=sithco_sample_scheduled_changes_param_ci';
        title = 'Changes';
        
        // Build up the Remedy qualification
        qual = '';
        if (ci && ci.length > 0) {
            qual += ci;
            title = ci + " " + title;
        }
        
        // Constructs the entire iFrame source - making sure to encode all the user entered data
        src = base + '&ci=' + encodeURIComponent(qual);
        iframe.src = src;
    }
}


</script>
"


text "RefreshButton","<button name='submit' type='button' onclick='refresh();return false;'>Refresh</button>"

text "ScheduleWindow","
<iframe style='width: 800px; height: 600px; ' 
scrolling='no' 
name='iframeId 
class='advPlayer' 
id='iframeId' 
frameborder='0' 
src='http://demo.kineticdata.com/KinCal/calendar?CalendarName=sithco_sample_scheduled_changes_param_ci&ci=Fox'>

</iframe>

"


  end


  standard_page_confirmation


  end
  
end



#["Reboot","Restore","Backup","Failover"].each do |task|
["Reboot"].each do |task|
  build_form(task)
end


