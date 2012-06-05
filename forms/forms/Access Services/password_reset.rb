require File.join(File.dirname(__FILE__),"../../standards.rb")

@@name = "Password reset"
@@categories = "Access Services"
@@type = "Access"
@@image = "#{@@standard_image_base}/user.png"
@@description = "Reset password."




service_item @@name do

  categories @@categories
  type @@type

  description build_description(@@name,@@description,@@image)

  standard_initial_form
  
  
    task_tree "iWise password reset",
    :xml => %`<taskTree schema_version="1.0" version="" builder_version="1.0.0">
  <name>iWise password reset</name>
  <author/>
  <notes/>
  <lastID>4</lastID>
  <request>
    <task name="Create password reset incident" id="iwise_incident_create_v1_2" definition_id="iwise_incident_create_v1" x="270" y="140">
      <version>1</version>
      <configured>true</configured>
      <defers>true</defers>
      <deferrable>true</deferrable>
      <visible>true</visible>
      <parameters>
        <parameter id="email_address" tooltip="The email address of the requester." label="Requester Email" required="true" dependsOnId="" dependsOnValue="" menu="">&lt;%=@answers['Req Email Address']%&gt;</parameter>
        <parameter id="short_description" tooltip="A short description of the incident." label="Short Description" required="true" dependsOnId="" dependsOnValue="" menu="">Password reset</parameter>
        <parameter id="description" tooltip="A full description indicating the reason for opening a new incident." label="Description" required="true" dependsOnId="" dependsOnValue="" menu="">For these systems:
&lt;%=@answers['Systems']%&gt;</parameter>
        <parameter id="symptom_type" tooltip="The type of symptom the iWise Help Desk incident will be created with." label="Symptom Type" required="true" dependsOnId="" dependsOnValue="" menu="">Password</parameter>
        <parameter id="sub_type" tooltip="The subtype of symptom the iWise Help Desk incident will be created with." label="Sub Type" required="true" dependsOnId="" dependsOnValue="" menu="">Reset</parameter>
      </parameters>
      <messages>
        <message type="Create"/>
        <message type="Update"/>
        <message type="Complete"/>
      </messages>
      <dependents>
        <task type="Complete" label="" value="">kinetic_submission_update_v1_3</task>
      </dependents>
    </task>
    <task name="Mark request in progress" id="kinetic_submission_update_v1_1" definition_id="kinetic_submission_update_v1" x="270" y="40">
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
    <task name="Start" id="start" definition_id="system_start_v1" x="10" y="10">
      <version>1</version>
      <configured>true</configured>
      <defers>false</defers>
      <deferrable>false</deferrable>
      <visible>false</visible>
      <parameters/>
      <messages/>
      <dependents>
        <task type="Complete" label="" value="">kinetic_submission_update_v1_1</task>
        <task type="Complete" label="" value="">iwise_incident_create_v1_2</task>
      </dependents>
    </task>
    <task name="Mark request complete" id="kinetic_submission_update_v1_3" definition_id="kinetic_submission_update_v1" x="290" y="260">
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
  </request>
</taskTree>`,
    :description => "Kinetic Task Process Tree",
    :notes => "A new task process"
    
    
  
  

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



        question "Systems", "Systems", 
        :list, 
        :check_box, 
        :horizontal, 
        :choice_list => "Systems" do
          choice "SAP"
          choice "iWise"
          choice "salesforce.com"
          choice "Active Directory"
        end

      
      
      
  end


  standard_page_confirmation

end

