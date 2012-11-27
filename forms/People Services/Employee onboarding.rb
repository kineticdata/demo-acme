require File.join(File.dirname(__FILE__),"../../standards.rb")

@@name = "Employee Onboarding"
@@categories = "People Services"
@@type = "People Services"
@@image = "#{@@standard_image_base}/user.png"
@@description = "Collect information for onboarding a new employee."


service_item @@name do

  categories @@categories
  type @@type

  description build_description(@@name,@@description,@@image)

  standard_initial_form


  task_tree "New Task Process",
    :xml => %`<taskTree schema_version="1.0" version="" builder_version="1.0.0">
  <name>New Task Process</name>
  <author/>
  <notes/>
  <lastID>15</lastID>
  <request>
    <task name="Mark in progress" id="kinetic_submission_update_v1_1" definition_id="kinetic_submission_update_v1" x="40" y="80">
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
    <task name="Register new employee" id="sithco_incident_create_deferred_v1_2" definition_id="sithco_incident_create_deferred_v1" x="30" y="170">
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
        <parameter id="summary" tooltip="Summary" label="Summary" required="false" dependsOnId="" dependsOnValue="" menu="">Setup new employee</parameter>
        <parameter id="description" tooltip="Description" label="Description" required="false" dependsOnId="" dependsOnValue="" menu="">&lt;%=
ret_string = ""
@answers.each do |k,v|
ret_string = "\#{ret_string}\#{k}-&gt;\#{v}\\n"
end
ret_string
%&gt;</parameter>
      </parameters>
      <messages>
        <message type="Create"/>
        <message type="Update"/>
        <message type="Complete"/>
      </messages>
      <dependents/>
    </task>
    <task name="Resources Group" id="system_noop_v1_15" definition_id="system_noop_v1" x="380" y="420">
      <version/>
      <configured>true</configured>
      <defers>false</defers>
      <deferrable>false</deferrable>
      <visible>false</visible>
      <parameters/>
      <messages>
        <message type="Create"/>
        <message type="Update"/>
        <message type="Complete"/>
      </messages>
      <dependents>
        <task type="Complete" label="" value="&lt;%=@answers['Resources - Business Cards'] == &quot;Business Cards&quot;%>">sithco_incident_create_deferred_v1_4</task>
        <task type="Complete" label="" value="&lt;%=@answers['Resources - Phone']==&quot;Phone&quot;%>">sithco_incident_create_deferred_v1_8</task>
        <task type="Complete" label="" value="&lt;%=@answers['Resources - PC'] == &quot;PC&quot;%>">sithco_incident_create_deferred_v1_7</task>
        <task type="Complete" label="" value="&lt;%=@answers['Resources - Cube'] == &quot;Cube&quot; %>">sithco_incident_create_deferred_v1_6</task>
      </dependents>
    </task>
    <task name="Setup Basecamp access" id="sithco_incident_create_deferred_v1_14" definition_id="sithco_incident_create_deferred_v1" x="620" y="290">
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
        <parameter id="summary" tooltip="Summary" label="Summary" required="false" dependsOnId="" dependsOnValue="" menu="">Setup Basecamp access</parameter>
        <parameter id="description" tooltip="Description" label="Description" required="false" dependsOnId="" dependsOnValue="" menu="">&lt;%=
ret_string = ""
@answers.each do |k,v|
ret_string = "\#{ret_string}\#{k}-&gt;\#{v}\\n"
end
ret_string
%&gt;</parameter>
      </parameters>
      <messages>
        <message type="Create"/>
        <message type="Update"/>
        <message type="Complete"/>
      </messages>
      <dependents/>
    </task>
    <task name="Setup business cards" id="sithco_incident_create_deferred_v1_4" definition_id="sithco_incident_create_deferred_v1" x="650" y="600">
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
        <parameter id="summary" tooltip="Summary" label="Summary" required="false" dependsOnId="" dependsOnValue="" menu="">Setup business cards</parameter>
        <parameter id="description" tooltip="Description" label="Description" required="false" dependsOnId="" dependsOnValue="" menu="">&lt;%=
ret_string = ""
@answers.each do |k,v|
ret_string = "\#{ret_string}\#{k}-&gt;\#{v}\\n"
end
ret_string
%&gt;</parameter>
      </parameters>
      <messages>
        <message type="Create"/>
        <message type="Update"/>
        <message type="Complete"/>
      </messages>
      <dependents/>
    </task>
    <task name="Setup cube" id="sithco_incident_create_deferred_v1_6" definition_id="sithco_incident_create_deferred_v1" x="650" y="420">
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
        <parameter id="summary" tooltip="Summary" label="Summary" required="false" dependsOnId="" dependsOnValue="" menu="">Setup cube</parameter>
        <parameter id="description" tooltip="Description" label="Description" required="false" dependsOnId="" dependsOnValue="" menu="">&lt;%=
ret_string = ""
@answers.each do |k,v|
ret_string = "\#{ret_string}\#{k}-&gt;\#{v}\\n"
end
ret_string
%&gt;</parameter>
      </parameters>
      <messages>
        <message type="Create"/>
        <message type="Update"/>
        <message type="Complete"/>
      </messages>
      <dependents/>
    </task>
    <task name="Setup HRReview access" id="sithco_incident_create_deferred_v1_13" definition_id="sithco_incident_create_deferred_v1" x="620" y="220">
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
        <parameter id="summary" tooltip="Summary" label="Summary" required="false" dependsOnId="" dependsOnValue="" menu="">Setup HRReview access</parameter>
        <parameter id="description" tooltip="Description" label="Description" required="false" dependsOnId="" dependsOnValue="" menu="">&lt;%=
ret_string = ""
@answers.each do |k,v|
ret_string = "\#{ret_string}\#{k}-&gt;\#{v}\\n"
end
ret_string
%&gt;</parameter>
      </parameters>
      <messages>
        <message type="Create"/>
        <message type="Update"/>
        <message type="Complete"/>
      </messages>
      <dependents/>
    </task>
    <task name="Setup Oracle access" id="sithco_incident_create_deferred_v1_12" definition_id="sithco_incident_create_deferred_v1" x="630" y="150">
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
        <parameter id="summary" tooltip="Summary" label="Summary" required="false" dependsOnId="" dependsOnValue="" menu="">Setup Oracle access</parameter>
        <parameter id="description" tooltip="Description" label="Description" required="false" dependsOnId="" dependsOnValue="" menu="">&lt;%=
ret_string = ""
@answers.each do |k,v|
ret_string = "\#{ret_string}\#{k}-&gt;\#{v}\\n"
end
ret_string
%&gt;</parameter>
      </parameters>
      <messages>
        <message type="Create"/>
        <message type="Update"/>
        <message type="Complete"/>
      </messages>
      <dependents/>
    </task>
    <task name="Setup PC" id="sithco_incident_create_deferred_v1_7" definition_id="sithco_incident_create_deferred_v1" x="650" y="480">
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
        <parameter id="summary" tooltip="Summary" label="Summary" required="false" dependsOnId="" dependsOnValue="" menu="">Setup computer</parameter>
        <parameter id="description" tooltip="Description" label="Description" required="false" dependsOnId="" dependsOnValue="" menu="">&lt;%=
ret_string = ""
@answers.each do |k,v|
ret_string = "\#{ret_string}\#{k}-&gt;\#{v}\\n"
end
ret_string
%&gt;</parameter>
      </parameters>
      <messages>
        <message type="Create"/>
        <message type="Update"/>
        <message type="Complete"/>
      </messages>
      <dependents/>
    </task>
    <task name="Setup phone" id="sithco_incident_create_deferred_v1_8" definition_id="sithco_incident_create_deferred_v1" x="650" y="540">
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
        <parameter id="summary" tooltip="Summary" label="Summary" required="false" dependsOnId="" dependsOnValue="" menu="">Setup phone</parameter>
        <parameter id="description" tooltip="Description" label="Description" required="false" dependsOnId="" dependsOnValue="" menu="">&lt;%=
ret_string = ""
@answers.each do |k,v|
ret_string = "\#{ret_string}\#{k}-&gt;\#{v}\\n"
end
ret_string
%&gt;</parameter>
      </parameters>
      <messages>
        <message type="Create"/>
        <message type="Update"/>
        <message type="Complete"/>
      </messages>
      <dependents/>
    </task>
    <task name="Setup SAP access" id="sithco_incident_create_deferred_v1_10" definition_id="sithco_incident_create_deferred_v1" x="630" y="10">
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
        <parameter id="summary" tooltip="Summary" label="Summary" required="false" dependsOnId="" dependsOnValue="" menu="">Setup SAP access</parameter>
        <parameter id="description" tooltip="Description" label="Description" required="false" dependsOnId="" dependsOnValue="" menu="">&lt;%=
ret_string = ""
@answers.each do |k,v|
ret_string = "\#{ret_string}\#{k}-&gt;\#{v}\\n"
end
ret_string
%&gt;</parameter>
      </parameters>
      <messages>
        <message type="Create"/>
        <message type="Update"/>
        <message type="Complete"/>
      </messages>
      <dependents/>
    </task>
    <task name="Setup TimeTracker access" id="sithco_incident_create_deferred_v1_11" definition_id="sithco_incident_create_deferred_v1" x="630" y="80">
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
        <parameter id="summary" tooltip="Summary" label="Summary" required="false" dependsOnId="" dependsOnValue="" menu="">Setup TimeTracker access</parameter>
        <parameter id="description" tooltip="Description" label="Description" required="false" dependsOnId="" dependsOnValue="" menu="">&lt;%=
ret_string = ""
@answers.each do |k,v|
ret_string = "\#{ret_string}\#{k}-&gt;\#{v}\\n"
end
ret_string
%&gt;</parameter>
      </parameters>
      <messages>
        <message type="Create"/>
        <message type="Update"/>
        <message type="Complete"/>
      </messages>
      <dependents/>
    </task>
    <task name="Start" id="start" definition_id="system_start_v1" x="270" y="10">
      <version>1</version>
      <configured>true</configured>
      <defers>false</defers>
      <deferrable>false</deferrable>
      <visible>false</visible>
      <parameters/>
      <messages/>
      <dependents>
        <task type="Complete" label="" value="">kinetic_submission_update_v1_1</task>
        <task type="Complete" label="" value="">sithco_incident_create_deferred_v1_2</task>
        <task type="Complete" label="" value="">system_noop_v1_9</task>
        <task type="Complete" label="" value="">system_noop_v1_15</task>
      </dependents>
    </task>
    <task name="Systems Group" id="system_noop_v1_9" definition_id="system_noop_v1" x="370" y="10">
      <version/>
      <configured>true</configured>
      <defers>false</defers>
      <deferrable>false</deferrable>
      <visible>false</visible>
      <parameters/>
      <messages>
        <message type="Create"/>
        <message type="Update"/>
        <message type="Complete"/>
      </messages>
      <dependents>
        <task type="Complete" label="" value="&lt;%=@answers['Systems - SAP'] == &quot;SAP&quot;%>">sithco_incident_create_deferred_v1_10</task>
        <task type="Complete" label="" value="&lt;%=@answers['Systems - TimeTracker'] == &quot;TimeTracker&quot;%>">sithco_incident_create_deferred_v1_11</task>
        <task type="Complete" label="" value="&lt;%=@answers['Systems - Oracle']==&quot;Oracle&quot;%>">sithco_incident_create_deferred_v1_12</task>
        <task type="Complete" label="" value="&lt;%=@answers['Systems - HRReview']==&quot;HRReview&quot;%>">sithco_incident_create_deferred_v1_13</task>
        <task type="Complete" label="" value="&lt;%=@answers['Systems - Basecamp']==&quot;Basecamp&quot;%>">sithco_incident_create_deferred_v1_14</task>
      </dependents>
    </task>
  </request>
</taskTree>`,
    :description => "Kinetic Task Process Tree",
    :notes => "Employee onboarding process"



  page "Initial Page",
    :contents,
    :horizontal_buttons,
    :submit_button_value => "Next->" do


    text "Header", build_description(@@name,@@description,@@image)


    standard_section_requester


    section  "New employee Content Section"

    text "Details Header Text", "New employee details", 
    :style_class => " primaryColorHeader"

    question "Name Prefix", "Name Prefix", :list,
      :list_box,
      :horizontal,
      :editor_label => "NamePrefix",
      :choice_list => "NamePrefix" do
      choice "Mr."
      choice "Mrs."
      choice "Ms."
      choice "Dr."
      choice "Hon."
    end
    
    question "First Name", "First Name", :free_text,
      :required,
      :size => "35",
      :rows => "1",
      :required_text => "First name is required"
      
    question "Middle Name", "Middle Name", :free_text,
      :size => "15",
      :rows => "1",
      :validation_text => "Middle Name ()"
      
    question "Last Name", "Last Name", :free_text,
      :required,
      :size => "35",
      :rows => "1",
      :required_text => "Last name is required" 

    question "Address Line 1", "Address Line 1", :free_text,
      :size => "50",
      :rows => "1"
      
    question "Address Line 2", "Address Line 2", :free_text,
      :size => "50",
      :rows => "1"
        
    question "City", "City", :free_text,
      :size => "30",
      :rows => "1"
      
    question "State", "State", :list,
      :list_box,
      :horizontal,
      :choice_list => "States" do 
        choice "Alabama"
        choice "Alaska"
        choice "Arizona"
        choice "Arkansas"
        choice "California"
        choice "Colorado"
        choice "Connecticut"
        choice "Delaware"
        choice "Florida"
        choice "Georgia"
        choice "Hawaii"
        choice "Idaho"
        choice "Illinois"
        choice "Indiana"
        choice "Iowa"
        choice "Kansas"
        choice "Kentucky"
        choice "Louisiana"
        choice "Maine"
        choice "Maryland"
        choice "Massachusetts"
        choice "Michigan"
        choice "Minnesota"
        choice "Mississippi"
        choice "Missouri"
        choice "Montana"
        choice "Nebraska"
        choice "Nevada"
        choice "New Hampshire"
        choice "New Jersey"
        choice "New Mexico"
        choice "New York"
        choice "North Carolina"
        choice "North Dakota"
        choice "Ohio"
        choice "Oklahoma"
        choice "Oregon"
        choice "Pennsylvania"
        choice "Rhode Island"
        choice "South Carolina"
        choice "South Dakota"
        choice "Tennessee"
        choice "Texas"
        choice "Utah"
        choice "Vermont"
        choice "Virginia"
        choice "Washington"
        choice "West Virginia"
        choice "Wisconsin"
        choice "Wyoming"
    end
    
    question "Zip", "Zip", :free_text,
      :required,
      :size => "5",
      :rows => "1",
      :required_text => "You must enter a zip code",
      :pattern_label => "Zip",
      :pattern => "^\\d{5}$",
      :validation_text => "Zip (Zip)"


  end
  
  
  
  page "Items selection",
    :contents,
    :previous_button,
    :horizontal_buttons,
    :submit_button_value => "Next->",
    :previous_button_value => "<-Prev",
    :display_page => @@standard_display_page do


    branching "Phone Page", %`<FLD>Resources - Phone;ANSWER</FLD> = "Phone"`
    branching "Business card page", %`<FLD>Resources - Business Cards;ANSWER</FLD> = "Business Cards"`
    branching "Cube page", %`<FLD>Resources - Cube;ANSWER</FLD> = "Cube"`
    branching "PC page", %`<FLD>Resources - PC;ANSWER</FLD>="PC"`
    branching "Confirmation Page", :always
    
    
    event "SetAllResources",
      :set_fields_internal,
      :load,
      :fire_if => "1==1" do
      field_map "Resources - Business Cards", "Business Cards",
        :visible_in_table => "Yes",
        :table_label => ""
      field_map "Resources - Cube", "Cube",
        :visible_in_table => "Yes",
        :table_label => ""
      field_map "Resources - PC", "PC",
        :visible_in_table => "Yes",
        :table_label => ""
      field_map "Resources - Phone", "Phone",
        :visible_in_table => "Yes",
        :table_label => ""
    end
    

    text "Header", build_description(@@name,"",@@image)


    text "Service Item Description", "Select items required for new employee:
     <b><FLD>First Name;ANSWER</FLD> <FLD>Last Name;ANSWER</FLD></b>", 
     :style_class => " primaryColorHeader"
      
      
    question "Department", "Department", :list,
      :list_box,
      :horizontal,
      :required,
      :choice_list => "DepartmentList",
      :field_map_number => "17" do
      choice "Accounting"
      choice "Engineering"
      choice "Finance"
      choice "Human Resources"
      choice "Information Technology"
      choice "Marketing"
      choice "Manufacturing"
      choice "Purchasing"
      
      event "SetFinance",
        :set_fields_internal,
        :change,
        :fire_if => %`obj.value== "Finance"` do
        field_map "Systems", "$NULL$",
          :visible_in_table => "Yes",
          :table_label => ""
        field_map "Systems - SAP", "SAP",
          :visible_in_table => "Yes",
          :table_label => ""
        field_map "Systems - Oracle", "Oracle",
          :visible_in_table => "Yes",
          :table_label => ""
      end
      
      event "SetHR",
        :set_fields_internal,
        :change,
        :fire_if => %`obj.value== "Human Resources"` do
        field_map "Systems", "$NULL$",
          :visible_in_table => "Yes",
          :table_label => ""
        field_map "Systems - HRReview", "HRReview",
          :visible_in_table => "Yes",
          :table_label => ""
      end
    end
    
    
    question "Region", "Region", :list,
      :list_box,
      :horizontal,
      :required,
      :choice_list => "RegionList",
      :field_map_number => "18" do
      choice "East"
      choice "North East"
      choice "South"
      choice "West"
      choice "Midwest"
      choice "EMEA"
    end
    
    question "Role", "Role", :list,
      :list_box,
      :horizontal,
      :required,
      :choice_list => "RoleList",
      :field_map_number => "19" do
      choice "Employee"
      choice "Management"
      choice "Temporary"
      choice "Contract"
      choice "Executive"
      event "ManagementBasecamp",
        :set_fields_internal,
        :change,
        :fire_if => %`obj.value== "Management" ` do
        field_map "Systems - Basecamp", "Basecamp",
          :visible_in_table => "Yes",
          :table_label => ""
      end
      event "ManagementUnsetOnClear",
        :set_fields_internal,
        :change,
        :fire_if => %`obj.value== "" ` do
        field_map "Systems - Basecamp", "$NULL$",
          :visible_in_table => "Yes",
          :table_label => ""
      end
    end
    
    text "Resources Description", "Resources", 
     :style_class => " primaryColorHeader"    
    
    
    section  "Resources Section"
    question "Resources", "Resources", :list,
      :check_box,
      :horizontal,
      :choice_list => "ResourceList",
      :field_map_number => "20" do
      choice "Business Cards"
      choice "Cube"
      choice "PC"
      choice "Phone"
      check_box_map "Business Cards", "21"
      check_box_map "Cube", "22"
      check_box_map "PC", "23"
      check_box_map "Phone", "24"
    end
    

    text "Systems Description", "Systems", 
     :style_class => " primaryColorHeader"    
    
    section  "Systems Section"
    question "Systems", "Systems", :list,
      :check_box,
      :horizontal,
      :choice_list => "SystemsList" do
      choice "Basecamp"
      choice "HRReview"
      choice "Oracle"
      choice "TimeTracker"
      choice "SAP"
    end
    
  end
  
  
  
  page "Phone Page",
    :contents,
    :horizontal_buttons,
    :submit_button_value => "Next->",
    :display_page => @@standard_display_page do
      
    branching "Business card page", %`<FLD>Resources - Business Cards;ANSWER</FLD> = "Business Cards"`
    branching "Cube page", %`<FLD>Resources - Cube;ANSWER</FLD> = "Cube"`
    branching "PC page", %`<FLD>Resources - PC;ANSWER</FLD> = "PC"`
    branching "Confirmation Page", :always
    
    
    text "Header", build_description(@@name,"",@@image)
    
    text "Phone Description", "Phone", 
     :style_class => " primaryColorHeader"    
     

    question "What is the phone number?", "What is the phone number?", 
      :free_text,
      :required,
      :size => "20",
      :rows => "1",
      :pattern_label => "USPhone",
      :pattern => "^\\(\\d{3}\\)\\d{3}-\\d{4}$",
      :validation_text => "Example phone:(612)555-1111",
      :field_map_number => "31"
  end






  page "Business card page",
    :contents,
    :vertical_buttons,
    :submit_button_value => "Next->",
    :display_page => @@standard_display_page do
    branching "Cube page", %`<FLD>Resources - Cube;ANSWER</FLD> = "Cube"`
    branching "PC page", %`<FLD>Resources - PC;ANSWER</FLD> = "PC"`
    branching "Confirmation Page", :always


    text "Header", build_description(@@name,"",@@image)


    text "Person Description", "Person information", 
     :style_class => " primaryColorHeader"

    # TODO - Get this to be dynamic filled out -- not hard coded?
    text "BusinessCard", "<b><FLD>First Name;ANSWER</FLD> <FLD>Middle Name;ANSWER</FLD> <FLD>Last Name;ANSWER</FLD></b><br/>
    <FLD>Address Line 1;ANSWER</FLD>
    <FLD>Address Line 2;ANSWER</FLD><br/>
    <FLD>City;ANSWER</FLD>, <FLD>State;ANSWER</FLD> <FLD>Zip;ANSWER</FLD><br/>
    <FLD>What is the phone number?;ANSWER</FLD><br/>"
    
    
    text "Business Card Description", "Business card", 
     :style_class => " primaryColorHeader"

    text "Card Count", "How many business cards do you need?"
    question "Quantity", "Quantity", 
      :list,
      :list_box,
      :horizontal,
      :required,
      :choice_list => "BusinessCardQty",
      :field_map_number => "32" do
      choice "50"
      choice "100"
      choice "500"
      choice "1000"
      choice "5000"
    end
  end
  
  
  page "Cube page",
    :contents,
    :horizontal_buttons,
    :submit_button_value => "Next->",
    :display_page => @@standard_display_page do
      
      
    branching "PC page", %`<FLD>Resources - PC;ANSWER</FLD> = "PC"`
    branching "Confirmation Page", :always


    text "Header", build_description(@@name,"",@@image)
    
    
    text "Cube Description", "Cube", 
     :style_class => " primaryColorHeader"    



    question "Cube location?", "Cube location?", 
      :free_text,
      :required,
      :size => "20",
      :rows => "1",
      :field_map_number => "33"
      
    question "Cube style?", "Cube style?", 
      :list,
      :list_box,
      :horizontal,
      :required,
      :choice_list => "CubeStyle",
      :field_map_number => "34" do
      choice "Open"
      choice "Closed"
      choice "Shared"
    end
  end
  
  
  page "PC page",
    :contents,
    :horizontal_buttons,
    :submit_button_value => "Next->",
    :display_page => @@standard_display_page do


    text "Header", build_description(@@name,"",@@image)
    
    
    text "Computer Description", "Computer", 
     :style_class => " primaryColorHeader"    
    
    

    question "What standard PC config?", "What standard PC config?", 
      :list,
      :radio_button,
      :horizontal,
      :required,
      :choice_list => "StdPCConfig",
      :field_map_number => "35" do
      choice "Manager-desktop"
      choice "Manager-laptop"
      choice "Developer-1"
      choice "Developer-2"
      choice "Data Entry"
    end
    
  end
  

  # TODO - Should add a standard page - review here -- with "Submit Button"
  

  standard_page_confirmation

  
  
end
