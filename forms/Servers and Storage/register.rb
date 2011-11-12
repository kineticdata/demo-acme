require File.join(File.dirname(__FILE__),"../../standards.rb")




@@name = "New server registration"
@@categories = "Servers and Storage, **New Services"
@@type = "Screen shot sample"
@@image = "http://i.dell.com/images/global/configurator/chassis/blade-poweredge-m805-right-120x107.jpg"
@@description = "Setup new server in the environment."

service_item @@name do

  categories @@categories
  type @@type

  description build_description(@@name,@@description,@@image)

  standard_initial_form


  task_tree "New server registration",
    :xml => %`<taskTree schema_version="1.0" version="1" builder_version="1.0.0">
  <name>New server registration</name>
  <author>John</author>
  <notes/>
  <lastID>11</lastID>
  <request>
    <task name="Mark request in progress" id="kinetic_submission_update_v1_6" definition_id="kinetic_submission_update_v1" x="470" y="110">
      <version>1</version>
      <configured>true</configured>
      <defers>false</defers>
      <deferrable>false</deferrable>
      <visible>false</visible>
      <parameters>
        <parameter id="ValidationStatus" tooltip="Validation status for the original request: Completed or Rejected for example." label="Validation Status" required="true" dependsOnId="" dependsOnValue="" menu="">In progress</parameter>
        <parameter id="RequestStatus" tooltip="Value for the 'Request Status' field" label="Request Status" required="true" dependsOnId="" dependsOnValue="" menu="Open,Closed">Open</parameter>
      </parameters>
      <messages>
        <message type="Create"/>
        <message type="Update"/>
        <message type="Complete"/>
      </messages>
      <dependents/>
    </task>
    <task name="Setup backup" id="sithco_incident_create_deferred_v1_3" definition_id="sithco_incident_create_deferred_v1" x="30" y="340">
      <version>1</version>
      <configured>true</configured>
      <defers>true</defers>
      <deferrable>true</deferrable>
      <visible>true</visible>
      <parameters>
        <parameter id="ar_login" tooltip="Ar Login" label="AR Login" required="false" dependsOnId="" dependsOnValue="" menu="">&lt;%=@dataset['Submitter']%&gt;</parameter>
        <parameter id="first_name" tooltip="First Name" label="First Name" required="false" dependsOnId="" dependsOnValue="" menu="">&lt;%=@answers['Req First Name']%&gt;</parameter>
        <parameter id="last_name" tooltip="Last Name" label="Last Name" required="false" dependsOnId="" dependsOnValue="" menu="">&lt;%=@answers['Req Last Name']%&gt;</parameter>
        <parameter id="email" tooltip="Email Address" label="Email" required="false" dependsOnId="" dependsOnValue="" menu="">&lt;%=@answers['Req Email Address']%&gt;</parameter>
        <parameter id="phone" tooltip="Telephone Number" label="Phone Number" required="false" dependsOnId="" dependsOnValue="" menu=""/>
        <parameter id="summary" tooltip="Summary" label="Summary" required="false" dependsOnId="" dependsOnValue="" menu="">Setup new server backup</parameter>
        <parameter id="description" tooltip="Description" label="Description" required="false" dependsOnId="" dependsOnValue="" menu="">Setup server for
&lt;%=@answers['Owning company']%&gt;
&lt;%=@answers['Server Name']%&gt;
&lt;%=@answers['IP Address']%&gt;</parameter>
      </parameters>
      <messages>
        <message type="Create"/>
        <message type="Update"/>
        <message type="Complete"/>
      </messages>
      <dependents>
        <task type="Complete" label="" value="">system_join_v1_8</task>
      </dependents>
    </task>
    <task name="Setup monitoring" id="sithco_incident_create_deferred_v1_4" definition_id="sithco_incident_create_deferred_v1" x="140" y="340">
      <version>1</version>
      <configured>true</configured>
      <defers>true</defers>
      <deferrable>true</deferrable>
      <visible>true</visible>
      <parameters>
        <parameter id="ar_login" tooltip="Ar Login" label="AR Login" required="false" dependsOnId="" dependsOnValue="" menu="">&lt;%=@dataset['Submitter']%&gt;</parameter>
        <parameter id="first_name" tooltip="First Name" label="First Name" required="false" dependsOnId="" dependsOnValue="" menu="">&lt;%=@answers['Req First Name']%&gt;</parameter>
        <parameter id="last_name" tooltip="Last Name" label="Last Name" required="false" dependsOnId="" dependsOnValue="" menu="">&lt;%=@answers['Req Last Name']%&gt;</parameter>
        <parameter id="email" tooltip="Email Address" label="Email" required="false" dependsOnId="" dependsOnValue="" menu="">&lt;%=@answers['Req Email Address']%&gt;</parameter>
        <parameter id="phone" tooltip="Telephone Number" label="Phone Number" required="false" dependsOnId="" dependsOnValue="" menu=""/>
        <parameter id="summary" tooltip="Summary" label="Summary" required="false" dependsOnId="" dependsOnValue="" menu="">Setup new server monitoring</parameter>
        <parameter id="description" tooltip="Description" label="Description" required="false" dependsOnId="" dependsOnValue="" menu="">Setup server for
&lt;%=@answers['Owning company']%&gt;
&lt;%=@answers['Server Name']%&gt;
&lt;%=@answers['IP Address']%&gt;</parameter>
      </parameters>
      <messages>
        <message type="Create"/>
        <message type="Update"/>
        <message type="Complete"/>
      </messages>
      <dependents>
        <task type="Complete" label="" value="">system_join_v1_8</task>
      </dependents>
    </task>
    <task name="Setup server" id="sithco_incident_create_deferred_v1_2" definition_id="sithco_incident_create_deferred_v1" x="230" y="100">
      <version>1</version>
      <configured>true</configured>
      <defers>true</defers>
      <deferrable>true</deferrable>
      <visible>true</visible>
      <parameters>
        <parameter id="ar_login" tooltip="Ar Login" label="AR Login" required="false" dependsOnId="" dependsOnValue="" menu="">&lt;%=@dataset['Submitter']%&gt;</parameter>
        <parameter id="first_name" tooltip="First Name" label="First Name" required="false" dependsOnId="" dependsOnValue="" menu="">&lt;%=@answers['Req First Name']%&gt;</parameter>
        <parameter id="last_name" tooltip="Last Name" label="Last Name" required="false" dependsOnId="" dependsOnValue="" menu="">&lt;%=@answers['Req Last Name']%&gt;</parameter>
        <parameter id="email" tooltip="Email Address" label="Email" required="false" dependsOnId="" dependsOnValue="" menu="">&lt;%=@answers['Req Email Address']%&gt;</parameter>
        <parameter id="phone" tooltip="Telephone Number" label="Phone Number" required="false" dependsOnId="" dependsOnValue="" menu=""/>
        <parameter id="summary" tooltip="Summary" label="Summary" required="false" dependsOnId="" dependsOnValue="" menu="">Setup new server</parameter>
        <parameter id="description" tooltip="Description" label="Description" required="false" dependsOnId="" dependsOnValue="" menu="">Setup server for
&lt;%=@answers['Owning company']%&gt;
&lt;%=@answers['Server Name']%&gt;
&lt;%=@answers['IP Address']%&gt;</parameter>
      </parameters>
      <messages>
        <message type="Create"/>
        <message type="Update"/>
        <message type="Complete"/>
      </messages>
      <dependents>
        <task type="Complete" label="Backup" value="&lt;%=@answers['Functions to setup - Backup'] == &quot;Backup&quot;%>">sithco_incident_create_deferred_v1_3</task>
        <task type="Complete" label="Monitoring" value="&lt;%=@answers['Functions to setup - Monitoring'] == &quot;Monitoring&quot; %>">sithco_incident_create_deferred_v1_4</task>
        <task type="Complete" label="Storage" value="&lt;%=@answers['Functions to setup - Storage'] == &quot;Storage&quot; %>">sithco_incident_create_deferred_v1_5</task>
        <task type="Complete" label="Nothing selected" value="&lt;%=@answers['Functions to setup'].nil?%>">kinetic_submission_update_v1_11</task>
      </dependents>
    </task>
    <task name="Setup storage" id="sithco_incident_create_deferred_v1_5" definition_id="sithco_incident_create_deferred_v1" x="270" y="330">
      <version>1</version>
      <configured>true</configured>
      <defers>true</defers>
      <deferrable>true</deferrable>
      <visible>true</visible>
      <parameters>
        <parameter id="ar_login" tooltip="Ar Login" label="AR Login" required="false" dependsOnId="" dependsOnValue="" menu="">&lt;%=@dataset['Submitter']%&gt;</parameter>
        <parameter id="first_name" tooltip="First Name" label="First Name" required="false" dependsOnId="" dependsOnValue="" menu="">&lt;%=@answers['Req First Name']%&gt;</parameter>
        <parameter id="last_name" tooltip="Last Name" label="Last Name" required="false" dependsOnId="" dependsOnValue="" menu="">&lt;%=@answers['Req Last Name']%&gt;</parameter>
        <parameter id="email" tooltip="Email Address" label="Email" required="false" dependsOnId="" dependsOnValue="" menu="">&lt;%=@answers['Req Email Address']%&gt;</parameter>
        <parameter id="phone" tooltip="Telephone Number" label="Phone Number" required="false" dependsOnId="" dependsOnValue="" menu=""/>
        <parameter id="summary" tooltip="Summary" label="Summary" required="false" dependsOnId="" dependsOnValue="" menu="">Setup new server storage</parameter>
        <parameter id="description" tooltip="Description" label="Description" required="false" dependsOnId="" dependsOnValue="" menu="">Setup server for
&lt;%=@answers['Owning company']%&gt;
&lt;%=@answers['Server Name']%&gt;
&lt;%=@answers['IP Address']%&gt;</parameter>
      </parameters>
      <messages>
        <message type="Create"/>
        <message type="Update"/>
        <message type="Complete"/>
      </messages>
      <dependents>
        <task type="Complete" label="" value="">system_join_v1_8</task>
      </dependents>
    </task>
    <task name="Start" id="start" definition_id="system_start_v1" x="400" y="10">
      <version>1</version>
      <configured>true</configured>
      <defers>false</defers>
      <deferrable>false</deferrable>
      <visible>false</visible>
      <parameters/>
      <messages/>
      <dependents>
        <task type="Complete" label="" value="">sithco_incident_create_deferred_v1_2</task>
        <task type="Complete" label="" value="">kinetic_submission_update_v1_6</task>
      </dependents>
    </task>
    <task name="Close request" id="kinetic_submission_update_v1_11" definition_id="kinetic_submission_update_v1" x="460" y="540">
      <version>1</version>
      <configured>true</configured>
      <defers>false</defers>
      <deferrable>false</deferrable>
      <visible>true</visible>
      <parameters>
        <parameter id="ValidationStatus" tooltip="Validation status for the original request: Completed or Rejected for example." label="Validation Status" required="true" dependsOnId="" dependsOnValue="" menu="">Completed</parameter>
        <parameter id="RequestStatus" tooltip="Value for the 'Request Status' field" label="Request Status" required="true" dependsOnId="" dependsOnValue="" menu="Open,Closed">Closed</parameter>
      </parameters>
      <messages>
        <message type="Create"/>
        <message type="Update"/>
        <message type="Complete"/>
      </messages>
      <dependents/>
    </task>
    <task name="Wait for selected" id="system_join_v1_8" definition_id="system_join_v1" x="140" y="470">
      <version>1</version>
      <configured>true</configured>
      <defers>false</defers>
      <deferrable>false</deferrable>
      <visible>false</visible>
      <parameters>
        <parameter id="type" tooltip="How many dependents must be completed before continuing?" label="Type:" required="true" dependsOnId="" dependsOnValue="" menu="All,Any,Some">Some</parameter>
        <parameter id="number" tooltip="If some, how many?" label="Number:" required="" dependsOnId="type" dependsOnValue="Some" menu="">&lt;%=@answers['Functions to setup'].split(",").size%&gt;</parameter>
      </parameters>
      <messages>
        <message type="Create"/>
        <message type="Update"/>
        <message type="Complete"/>
      </messages>
      <dependents>
        <task type="Complete" label="" value="">kinetic_submission_update_v1_11</task>
      </dependents>
    </task>
  </request>
</taskTree>`,
    :description => "Kinetic Task Process Tree",
    :notes => "A new task process"



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

      question "Owning company", "Owning company", 
      :list, 
      :list_box, 
      :horizontal, 
      :required, 
      :choice_list => "Companies" do
        choice "ABC"
        choice "Massive Company"
        choice "XYZ"        
      end




      question "Server Name", "Server Name", 
      :free_text,
      :required,
      :size => "30", 
      :rows => "1"


      question "IP Address", "IP Address", 
      :free_text,
      :required,
      :pattern_label => "IP Address",
      :pattern => "^(\\d{1,2}|1\\d\\d|2[0-4]\\d|25[0-5])\\.(\\d{1,2}|1\\d\\d|2[0-4]\\d|25[0-5])\\.(\\d{1,2}|1\\d\\d|2[0-4]\\d|25[0-5])\\.(\\d{1,2}|1\\d\\d|2[0-4]\\d|25[0-5])$",
      :validation_text => "IP address must be valid - Example: 1.2.3.4",
      :size => "30", 
      :rows => "1"


      
      
# TODO - get rid of servers question - not relevant
        question "Functions to setup", "Functions to setup", 
        :list, 
        :check_box, 
        :horizontal, 
        :choice_list => "Functions" do
          choice "Backup", "Backup"
          choice "Monitoring", "Monitoring"
          choice "Storage", "Storage"

        end


        question "Notes", "Notes", 
        :free_text, 
        :size => "60", 
        :rows => "3"
        
      
      
      

end


standard_page_confirmation


end


