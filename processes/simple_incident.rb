

def simple_indident_process_tree(description,task_to_perform)
  
  task_tree "Simple Incident",
            :xml => %`<taskTree schema_version="1.0" version="" builder_version="1.0.0">
                    <name>#{description}</name>
                    <author/>
                    <notes/>
                    <lastID>3</lastID>
                    <request>
                    
                    
                      <task name="Create IT Incident" id="sithco_incident_create_deferred_v1_1" definition_id="sithco_incident_create_deferred_v1" x="220" y="280">
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
                          <parameter id="summary" tooltip="Summary" label="Summary" required="false" dependsOnId="" dependsOnValue="" menu="">#{task_to_perform}</parameter>
                          <parameter id="description" tooltip="Description" label="Description" required="false" dependsOnId="" dependsOnValue="" menu="">&lt;%=
ret_string = ""
skip_fields = ["Req First Name","Req Last Name","Req Employee #","Req Email Address"]
@answers.each do |k,v|
  next if skip_fields.include?(k)
  ret_string = "\#{ret_string}\#{k}-&gt;\#{v}\\n"
end
ret_string
%&gt;

Link to request: http://demo.kineticdata.com/kinetic/ReviewRequest?csrv=&lt;%=@dataset['CustomerSurveyInstanceId']%&gt;

</parameter>
                        </parameters>
                        <messages>
                          <message type="Create">Created IT Ticket \#&lt;%=@results['Create IT Incident']['Entry Id']%&gt;</message>
                          <message type="Update">There has been an update to IT Ticket \#&lt;%=@results['Create IT Incident']['Entry Id']%&gt;</message>
                          <message type="Complete">Completed IT Ticket \#&lt;%=@results['Create IT Incident']['Entry Id']%&gt;</message>
                        </messages>
                        <dependents>
                          <task type="Complete" label="" value="">kinetic_submission_update_v1_3</task>
                        </dependents>
                      </task>
                      
                      
                      <task name="Request Complete" id="kinetic_submission_update_v1_3" definition_id="kinetic_submission_update_v1" x="320" y="510">
                        <version>1</version>
                        <configured>true</configured>
                        <defers>false</defers>
                        <deferrable>false</deferrable>
                        <visible>True</visible>
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
                      
                      
                      <task name="Mark Request In progress" id="kinetic_submission_update_v1_2" definition_id="kinetic_submission_update_v1" x="50" y="150">
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
                      
                      
                      <task name="Start" id="start" definition_id="system_start_v1" x="180" y="10">
                        <version>1</version>
                        <configured>true</configured>
                        <defers>false</defers>
                        <deferrable>false</deferrable>
                        <visible>false</visible>
                        <parameters/>
                        <messages/>
                        <dependents>
                          <task type="Complete" label="" value="">sithco_incident_create_deferred_v1_1</task>
                          <task type="Complete" label="" value="">kinetic_submission_update_v1_2</task>
                        </dependents>
                      </task>
                      
                      
                      
                    </request>
                  </taskTree>`,
            :description => "Kinetic Task Process Tree",
            :notes => "A new task process"
  
end




