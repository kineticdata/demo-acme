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

 
  task_tree "New Task Process",
    :type => "Complete",
    :xml => "<taskTree schema_version=\"1.0\" version=\"\" builder_version=\"3.0.0\">\n  <name>New Task Process</name>\n  <author/>\n  <notes/>\n  <lastID>28</lastID>\n  <request>\n    <task name=\"Mark in progress\" id=\"kinetic_submission_update_v1_1\" definition_id=\"kinetic_submission_update_v1\" x=\"40\" y=\"80\">\n      <version>1</version>\n      <configured>true</configured>\n      <defers>false</defers>\n      <deferrable>false</deferrable>\n      <visible>false</visible>\n      <parameters>\n        <parameter id=\"ValidationStatus\" tooltip=\"Validation status for the original request: Completed or Rejected for example.\" label=\"Validation Status\" required=\"true\" dependsOnId=\"\" dependsOnValue=\"\" menu=\"\">In progress</parameter>\n        <parameter id=\"RequestStatus\" tooltip=\"Value for the 'Request Status' field\" label=\"Request Status\" required=\"true\" dependsOnId=\"\" dependsOnValue=\"\" menu=\"Open,Closed\">Open</parameter>\n      </parameters>\n      <messages>\n        <message type=\"Create\"/>\n        <message type=\"Update\"/>\n        <message type=\"Complete\"/>\n      </messages>\n      <dependents/>\n    </task>\n    \n    <task name=\"Resources Group\" id=\"system_noop_v1_15\" definition_id=\"system_noop_v1\" x=\"271\" y=\"352\">\n      <version/>\n      <configured>true</configured>\n      <defers>false</defers>\n      <deferrable>false</deferrable>\n      <visible>false</visible>\n      <parameters/>\n      <messages>\n        <message type=\"Create\"/>\n        <message type=\"Update\"/>\n        <message type=\"Complete\"/>\n      </messages>\n      <dependents>\n        \n        \n        \n        \n      <task type=\"Complete\" label=\"\" value=\"&lt;%=@answers['Resources - Cube'] == &quot;Cube&quot; %&gt;\">kinetic_sample_incident_create_v1_17</task><task type=\"Complete\" label=\"\" value=\"&lt;%=@answers['Resources - PC'] == &quot;PC&quot;%&gt;\">kinetic_sample_incident_create_v1_18</task><task type=\"Complete\" label=\"\" value=\"&lt;%=@answers['Resources - Phone']==&quot;Phone&quot;%&gt;\">kinetic_sample_incident_create_v1_19</task><task type=\"Complete\" label=\"\" value=\"&lt;%=@answers['Resources - Business Cards'] == &quot;Business Cards&quot;%&gt;\">kinetic_sample_incident_create_v1_20</task></dependents>\n    </task>\n    \n    \n    \n    \n    \n    \n    \n    \n    \n    <task name=\"Start\" id=\"start\" definition_id=\"system_start_v1\" x=\"270\" y=\"19\">\n      <version>1</version>\n      <configured>true</configured>\n      <defers>false</defers>\n      <deferrable>false</deferrable>\n      <visible>false</visible>\n      <parameters/>\n      <messages/>\n      <dependents>\n        <task type=\"Complete\" label=\"\" value=\"\">kinetic_submission_update_v1_1</task>\n        \n        <task type=\"Complete\" label=\"\" value=\"\">system_noop_v1_9</task>\n        <task type=\"Complete\" label=\"\" value=\"\">system_noop_v1_15</task>\n      <task type=\"Complete\" label=\"\" value=\"\">kinetic_sample_incident_create_v1_16</task></dependents>\n    </task>\n    <task name=\"Systems Group\" id=\"system_noop_v1_9\" definition_id=\"system_noop_v1\" x=\"409\" y=\"42\">\n      <version/>\n      <configured>true</configured>\n      <defers>false</defers>\n      <deferrable>false</deferrable>\n      <visible>false</visible>\n      <parameters/>\n      <messages>\n        <message type=\"Create\"/>\n        <message type=\"Update\"/>\n        <message type=\"Complete\"/>\n      </messages>\n      <dependents>\n        \n        \n        \n        \n        \n      <task type=\"Complete\" label=\"\" value=\"&lt;%=@answers['Systems - SAP'] == &quot;SAP&quot;%&gt;\">kinetic_sample_incident_create_v1_21</task><task type=\"Complete\" label=\"\" value=\"&lt;%=@answers['Systems - TimeTracker'] == &quot;TimeTracker&quot;%&gt;\">kinetic_sample_incident_create_v1_22</task><task type=\"Complete\" label=\"\" value=\"&lt;%=@answers['Systems - Oracle']==&quot;Oracle&quot;%&gt;\">kinetic_sample_incident_create_v1_23</task><task type=\"Complete\" label=\"\" value=\"&lt;%=@answers['Systems - HRReview']==&quot;HRReview&quot;%&gt;\">kinetic_sample_incident_create_v1_24</task><task type=\"Complete\" label=\"\" value=\"&lt;%=@answers['Systems - Basecamp']==&quot;Basecamp&quot;%&gt;\">kinetic_sample_incident_create_v1_25</task></dependents>\n    </task>\n  \n        <task name=\"Register new employee\" id=\"kinetic_sample_incident_create_v1_16\" definition_id=\"kinetic_sample_incident_create_v1\" x=\"56\" y=\"465\">\n      <version>1</version>\n      <configured>true</configured>\n      <defers>true</defers>\n      <deferrable>true</deferrable>\n      <visible>true</visible>\n      <parameters>\n      <parameter id=\"login_id\" label=\"Login ID\" required=\"true\" tooltip=\"Either the Remedy AR Login ID or the email address of the requester\" menu=\"\">&lt;%=@dataset['Submitter']%&gt;</parameter>\n      <parameter id=\"summary\" label=\"Summary\" required=\"false\" tooltip=\"A short summary of the incident\" menu=\"\">Setup new employee</parameter>\n      <parameter id=\"description\" label=\"Description\" required=\"false\" tooltip=\"A detailed description of the incident\" menu=\"\">&lt;%=\nret_string = \"\"\n@answers.each do |k,v|\nret_string = \"\#{ret_string}\#{k}-&gt;\#{v}\\n\"\nend\nret_string\n%&gt;</parameter>\n    </parameters><messages>\n        <message type=\"Create\"/>\n        <message type=\"Update\"/>\n        <message type=\"Complete\"/>\n      </messages>\n      <dependents/>\n    </task>\n      \n        <task name=\"Provision cube\" id=\"kinetic_sample_incident_create_v1_17\" definition_id=\"kinetic_sample_incident_create_v1\" x=\"472\" y=\"429\">\n      <version>1</version>\n      <configured>true</configured>\n      <defers>true</defers>\n      <deferrable>true</deferrable>\n      <visible>true</visible>\n      <parameters>\n      <parameter id=\"login_id\" label=\"Login ID\" required=\"true\" tooltip=\"Either the Remedy AR Login ID or the email address of the requester\" menu=\"\">&lt;%=@dataset['Submitter']%&gt;</parameter>\n      <parameter id=\"summary\" label=\"Summary\" required=\"false\" tooltip=\"A short summary of the incident\" menu=\"\">Provision Cube</parameter>\n      <parameter id=\"description\" label=\"Description\" required=\"false\" tooltip=\"A detailed description of the incident\" menu=\"\">&lt;%=\nret_string = \"\"\n@answers.each do |k,v|\nret_string = \"\#{ret_string}\#{k}-&gt;\#{v}\\n\"\nend\nret_string\n%&gt;</parameter>\n    </parameters><messages>\n        <message type=\"Create\"/>\n        <message type=\"Update\"/>\n        <message type=\"Complete\"/>\n      </messages>\n      <dependents><task type=\"Complete\" label=\"\" value=\"\">system_junction_v1_26</task></dependents>\n    </task>\n      \n        <task name=\"Provision PC\" id=\"kinetic_sample_incident_create_v1_18\" definition_id=\"kinetic_sample_incident_create_v1\" x=\"478\" y=\"467\">\n      <version>1</version>\n      <configured>true</configured>\n      <defers>true</defers>\n      <deferrable>true</deferrable>\n      <visible>true</visible>\n      <parameters>\n      <parameter id=\"login_id\" label=\"Login ID\" required=\"true\" tooltip=\"Either the Remedy AR Login ID or the email address of the requester\" menu=\"\">&lt;%=@dataset['Submitter']%&gt;</parameter>\n      <parameter id=\"summary\" label=\"Summary\" required=\"false\" tooltip=\"A short summary of the incident\" menu=\"\">Provision PC</parameter>\n      <parameter id=\"description\" label=\"Description\" required=\"false\" tooltip=\"A detailed description of the incident\" menu=\"\">&lt;%=\nret_string = \"\"\n@answers.each do |k,v|\nret_string = \"\#{ret_string}\#{k}-&gt;\#{v}\\n\"\nend\nret_string\n%&gt;</parameter>\n    </parameters><messages>\n        <message type=\"Create\"/>\n        <message type=\"Update\"/>\n        <message type=\"Complete\"/>\n      </messages>\n      <dependents><task type=\"Complete\" label=\"\" value=\"\">system_junction_v1_26</task></dependents>\n    </task>\n      \n        <task name=\"Provision phone\" id=\"kinetic_sample_incident_create_v1_19\" definition_id=\"kinetic_sample_incident_create_v1\" x=\"467\" y=\"509\">\n      <version>1</version>\n      <configured>true</configured>\n      <defers>true</defers>\n      <deferrable>true</deferrable>\n      <visible>true</visible>\n      <parameters>\n      <parameter id=\"login_id\" label=\"Login ID\" required=\"true\" tooltip=\"Either the Remedy AR Login ID or the email address of the requester\" menu=\"\">&lt;%=@dataset['Submitter']%&gt;</parameter>\n      <parameter id=\"summary\" label=\"Summary\" required=\"false\" tooltip=\"A short summary of the incident\" menu=\"\">Provision phone</parameter>\n      <parameter id=\"description\" label=\"Description\" required=\"false\" tooltip=\"A detailed description of the incident\" menu=\"\">&lt;%=\nret_string = \"\"\n@answers.each do |k,v|\nret_string = \"\#{ret_string}\#{k}-&gt;\#{v}\\n\"\nend\nret_string\n%&gt;</parameter>\n    </parameters><messages>\n        <message type=\"Create\"/>\n        <message type=\"Update\"/>\n        <message type=\"Complete\"/>\n      </messages>\n      <dependents><task type=\"Complete\" label=\"\" value=\"\">system_junction_v1_26</task></dependents>\n    </task>\n      \n        <task name=\"Provision business cards\" id=\"kinetic_sample_incident_create_v1_20\" definition_id=\"kinetic_sample_incident_create_v1\" x=\"472\" y=\"562\">\n      <version>1</version>\n      <configured>true</configured>\n      <defers>true</defers>\n      <deferrable>true</deferrable>\n      <visible>true</visible>\n      <parameters>\n      <parameter id=\"login_id\" label=\"Login ID\" required=\"true\" tooltip=\"Either the Remedy AR Login ID or the email address of the requester\" menu=\"\">&lt;%=@dataset['Submitter']%&gt;</parameter>\n      <parameter id=\"summary\" label=\"Summary\" required=\"false\" tooltip=\"A short summary of the incident\" menu=\"\">Provision business cards</parameter>\n      <parameter id=\"description\" label=\"Description\" required=\"false\" tooltip=\"A detailed description of the incident\" menu=\"\">&lt;%=\nret_string = \"\"\n@answers.each do |k,v|\nret_string = \"\#{ret_string}\#{k}-&gt;\#{v}\\n\"\nend\nret_string\n%&gt;</parameter>\n    </parameters><messages>\n        <message type=\"Create\"/>\n        <message type=\"Update\"/>\n        <message type=\"Complete\"/>\n      </messages>\n      <dependents><task type=\"Complete\" label=\"\" value=\"\">system_junction_v1_26</task></dependents>\n    </task>\n      \n        <task name=\"Provision SAP\" id=\"kinetic_sample_incident_create_v1_21\" definition_id=\"kinetic_sample_incident_create_v1\" x=\"647\" y=\"17\">\n      <version>1</version>\n      <configured>true</configured>\n      <defers>true</defers>\n      <deferrable>true</deferrable>\n      <visible>true</visible>\n      <parameters>\n      <parameter id=\"login_id\" label=\"Login ID\" required=\"true\" tooltip=\"Either the Remedy AR Login ID or the email address of the requester\" menu=\"\">&lt;%=@dataset['Submitter']%&gt;</parameter>\n      <parameter id=\"summary\" label=\"Summary\" required=\"false\" tooltip=\"A short summary of the incident\" menu=\"\">Provision SAP</parameter>\n      <parameter id=\"description\" label=\"Description\" required=\"false\" tooltip=\"A detailed description of the incident\" menu=\"\">&lt;%=\nret_string = \"\"\n@answers.each do |k,v|\nret_string = \"\#{ret_string}\#{k}-&gt;\#{v}\\n\"\nend\nret_string\n%&gt;</parameter>\n    </parameters><messages>\n        <message type=\"Create\"/>\n        <message type=\"Update\"/>\n        <message type=\"Complete\"/>\n      </messages>\n      <dependents><task type=\"Complete\" label=\"\" value=\"\">system_junction_v1_26</task></dependents>\n    </task>\n      \n        <task name=\"Provision TimeTracker\" id=\"kinetic_sample_incident_create_v1_22\" definition_id=\"kinetic_sample_incident_create_v1\" x=\"659\" y=\"56\">\n      <version>1</version>\n      <configured>true</configured>\n      <defers>true</defers>\n      <deferrable>true</deferrable>\n      <visible>true</visible>\n      <parameters>\n      <parameter id=\"login_id\" label=\"Login ID\" required=\"true\" tooltip=\"Either the Remedy AR Login ID or the email address of the requester\" menu=\"\">&lt;%=@dataset['Submitter']%&gt;</parameter>\n      <parameter id=\"summary\" label=\"Summary\" required=\"false\" tooltip=\"A short summary of the incident\" menu=\"\">Provision TimeTracker</parameter>\n      <parameter id=\"description\" label=\"Description\" required=\"false\" tooltip=\"A detailed description of the incident\" menu=\"\">&lt;%=\nret_string = \"\"\n@answers.each do |k,v|\nret_string = \"\#{ret_string}\#{k}-&gt;\#{v}\\n\"\nend\nret_string\n%&gt;</parameter>\n    </parameters><messages>\n        <message type=\"Create\"/>\n        <message type=\"Update\"/>\n        <message type=\"Complete\"/>\n      </messages>\n      <dependents><task type=\"Complete\" label=\"\" value=\"\">system_junction_v1_26</task></dependents>\n    </task>\n      \n        <task name=\"Provision Oracle\" id=\"kinetic_sample_incident_create_v1_23\" definition_id=\"kinetic_sample_incident_create_v1\" x=\"649\" y=\"122\">\n      <version>1</version>\n      <configured>true</configured>\n      <defers>true</defers>\n      <deferrable>true</deferrable>\n      <visible>true</visible>\n      <parameters>\n      <parameter id=\"login_id\" label=\"Login ID\" required=\"true\" tooltip=\"Either the Remedy AR Login ID or the email address of the requester\" menu=\"\">&lt;%=@dataset['Submitter']%&gt;</parameter>\n      <parameter id=\"summary\" label=\"Summary\" required=\"false\" tooltip=\"A short summary of the incident\" menu=\"\">Provision Oracle</parameter>\n      <parameter id=\"description\" label=\"Description\" required=\"false\" tooltip=\"A detailed description of the incident\" menu=\"\">&lt;%=\nret_string = \"\"\n@answers.each do |k,v|\nret_string = \"\#{ret_string}\#{k}-&gt;\#{v}\\n\"\nend\nret_string\n%&gt;</parameter>\n    </parameters><messages>\n        <message type=\"Create\"/>\n        <message type=\"Update\"/>\n        <message type=\"Complete\"/>\n      </messages>\n      <dependents><task type=\"Complete\" label=\"\" value=\"\">system_junction_v1_26</task></dependents>\n    </task>\n      \n        <task name=\"Provision HRReview\" id=\"kinetic_sample_incident_create_v1_24\" definition_id=\"kinetic_sample_incident_create_v1\" x=\"656\" y=\"177\">\n      <version>1</version>\n      <configured>true</configured>\n      <defers>true</defers>\n      <deferrable>true</deferrable>\n      <visible>true</visible>\n      <parameters>\n      <parameter id=\"login_id\" label=\"Login ID\" required=\"true\" tooltip=\"Either the Remedy AR Login ID or the email address of the requester\" menu=\"\">&lt;%=@dataset['Submitter']%&gt;</parameter>\n      <parameter id=\"summary\" label=\"Summary\" required=\"false\" tooltip=\"A short summary of the incident\" menu=\"\">Provision HRReview</parameter>\n      <parameter id=\"description\" label=\"Description\" required=\"false\" tooltip=\"A detailed description of the incident\" menu=\"\">&lt;%=\nret_string = \"\"\n@answers.each do |k,v|\nret_string = \"\#{ret_string}\#{k}-&gt;\#{v}\\n\"\nend\nret_string\n%&gt;</parameter>\n    </parameters><messages>\n        <message type=\"Create\"/>\n        <message type=\"Update\"/>\n        <message type=\"Complete\"/>\n      </messages>\n      <dependents><task type=\"Complete\" label=\"\" value=\"\">system_junction_v1_26</task></dependents>\n    </task>\n      \n        <task name=\"Provision Basecamp\" id=\"kinetic_sample_incident_create_v1_25\" definition_id=\"kinetic_sample_incident_create_v1\" x=\"666\" y=\"250\">\n      <version>1</version>\n      <configured>true</configured>\n      <defers>true</defers>\n      <deferrable>true</deferrable>\n      <visible>true</visible>\n      <parameters>\n      <parameter id=\"login_id\" label=\"Login ID\" required=\"true\" tooltip=\"Either the Remedy AR Login ID or the email address of the requester\" menu=\"\">&lt;%=@dataset['Submitter']%&gt;</parameter>\n      <parameter id=\"summary\" label=\"Summary\" required=\"false\" tooltip=\"A short summary of the incident\" menu=\"\">Provision Basecamp</parameter>\n      <parameter id=\"description\" label=\"Description\" required=\"false\" tooltip=\"A detailed description of the incident\" menu=\"\">&lt;%=\nret_string = \"\"\n@answers.each do |k,v|\nret_string = \"\#{ret_string}\#{k}-&gt;\#{v}\\n\"\nend\nret_string\n%&gt;</parameter>\n    </parameters><messages>\n        <message type=\"Create\"/>\n        <message type=\"Update\"/>\n        <message type=\"Complete\"/>\n      </messages>\n      <dependents><task type=\"Complete\" label=\"\" value=\"\">system_junction_v1_26</task></dependents>\n    </task>\n      \n        <task name=\"Wait\" id=\"system_junction_v1_26\" definition_id=\"system_junction_v1\" x=\"783\" y=\"495\">\n      <version>1</version>\n      <configured>true</configured>\n      <defers>false</defers>\n      <deferrable>false</deferrable>\n      <visible>false</visible>\n      <parameters/><messages>\n        <message type=\"Create\"/>\n        <message type=\"Update\"/>\n        <message type=\"Complete\"/>\n      </messages>\n      <dependents><task type=\"Complete\" label=\"\" value=\"\">kinetic_submission_update_v1_27</task></dependents>\n    </task>\n      \n        <task name=\"Close Request\" id=\"kinetic_submission_update_v1_27\" definition_id=\"kinetic_submission_update_v1\" x=\"785\" y=\"650\">\n      <version>1</version>\n      <configured>true</configured>\n      <defers>false</defers>\n      <deferrable>false</deferrable>\n      <visible>true</visible>\n      <parameters>\n    <parameter id=\"ValidationStatus\" required=\"true\" label=\"Validation Status\" tooltip=\"Validation status for the original request: Completed or Rejected for example.\" menu=\"\">Completed</parameter>\n    <parameter id=\"RequestStatus\" required=\"true\" label=\"Request Status\" tooltip=\"Value for the 'Request Status' field\" menu=\"Open,Closed\">Closed</parameter>\n</parameters><messages>\n        <message type=\"Create\"/>\n        <message type=\"Update\"/>\n        <message type=\"Complete\"/>\n      </messages>\n      <dependents/>\n    </task>\n      \n        \n      </request>\n</taskTree>",
    :description => "Kinetic Task Process Tree",
    :notes => "Employee onboarding process"

  
end
