require File.join(File.dirname(__FILE__),"../../standards.rb")

@@name = "Work Order"
@@categories = "Playground"
@@type = "Work Order"
@@image = "#{@@standard_image_base}/user.png"
@@description = "Basic Work Order."


service_item @@name do

  categories @@categories
  type @@type

  description build_description(@@name,@@description,@@image)


  standard_initial_form

  page "Initial Page",
    :contents,
    :horizontal_buttons,
    :submit_button_value => "Submit" do


    text "Header", build_description(@@name,@@description,@@image)


    standard_section_requester

    section  "Details Section"
    text "Details Header Text", "Details", 
    :style_class => " primaryColorHeader"

    section  "Details"

    text "Info", "<FLD>Multi-Purpose Info;600000115;BASE</FLD> "
    question "Notes", "Notes", :free_text,
      :required,
      :size => "60",
      :rows => "3",
      :field_map_number => "1"

    
  end


 
  standard_page_confirmation



  task_tree "#{@@name} Tree",
    :type => "Complete",
    :xml => "<taskTree schema_version=\"1.0\" version=\"\" builder_version=\"1.0.0\">\n  <name>#{@@name} Tree</name>\n  <author/>\n  <notes/>\n  <lastID>3</lastID>\n  <request>\n    <task name=\"Get Answer Set\" id=\"kinetic_request_submission_get_answer_set_v1_1\" definition_id=\"kinetic_request_submission_get_answer_set_v1\" x=\"150\" y=\"10\">\n      <version>1</version>\n      <configured>true</configured>\n      <defers>false</defers>\n      <deferrable>false</deferrable>\n      <visible>true</visible>\n      <parameters>\n        <parameter id=\"mode\" tooltip=\"If 'All' the entire set of questions will be used.  If 'Some' the questions listed in the 'Included Questions' parameter will be used.  In both cases, questions listed in the 'Excluded Questions' parameter will never be included in the generated output.\" label=\"Mode\" required=\"true\" dependsOnId=\"\" dependsOnValue=\"\" menu=\"All,Some\">All</parameter>\n        <parameter id=\"included_questions\" tooltip=\"A comma separated list of question menu labels that should be explicitly included in the question list.  This is only needed if the 'Mode' parameter is set to 'Some'.  Whitespace matters; ensure there are no spaces after a comma separating the menu labels (unless the question menu label includes a preceding space).\" label=\"Included Questions\" required=\"false\" dependsOnId=\"mode\" dependsOnValue=\"Some\" menu=\"\"/>\n        <parameter id=\"excluded_questions\" tooltip=\"A comma separated list of question menu labels that should be explicitly excluded from the question list.  Questions included in this list will be excluded even if they are included in the 'Included Questions' parameter.  Whitespace matters; ensure there are no spaces after a comma separating the menu labels (unless the question menu label includes a preceding space).\" label=\"Excluded Questions\" required=\"false\" dependsOnId=\"\" dependsOnValue=\"\" menu=\"\"/>\n        <parameter id=\"question_aliases\" tooltip=\"A specially formatted mapping of question labels in the answer hash to labels to be used in the answer set.  This is necessary when an answer should be forwarded, but the question's label varies from form to form.  The alias format is as follows:  OldQuestionLabel=NewQuestionLabel,RequesterFirstName=FirstName.\" label=\"Question Aliases\" required=\"false\" dependsOnId=\"\" dependsOnValue=\"\" menu=\"\"/>\n      </parameters>\n      <messages>\n        <message type=\"Create\"/>\n        <message type=\"Update\"/>\n        <message type=\"Complete\"/>\n      </messages>\n      <dependents>\n        <task type=\"Complete\" label=\"\" value=\"\">kinetic_task_instance_complete_with_answer_set_v1_2</task>\n      </dependents>\n    </task>\n    <task name=\"Complete Work Order\" id=\"kinetic_task_instance_complete_with_answer_set_v1_2\" definition_id=\"kinetic_task_instance_complete_with_answer_set_v1\" x=\"340\" y=\"10\">\n      <version>1</version>\n      <configured>true</configured>\n      <defers>false</defers>\n      <deferrable>false</deferrable>\n      <visible>true</visible>\n      <parameters>\n        <parameter id=\"deferral_token\" tooltip=\"The deferral token of the deferred task\" label=\"Deferral Token\" required=\"true\" dependsOnId=\"\" dependsOnValue=\"\" menu=\"\">&lt;%=@base['ng_EndpointSecret']%&gt;</parameter>\n        <parameter id=\"answer_set\" tooltip=\"The answer set of the submission\" label=\"Answer Set\" required=\"true\" dependsOnId=\"\" dependsOnValue=\"\" menu=\"\">&lt;%=@results['Get Answer Set']['Answer Set']%&gt;</parameter>\n      </parameters>\n      <messages>\n        <message type=\"Create\"/>\n        <message type=\"Update\"/>\n        <message type=\"Complete\"/>\n      </messages>\n      <dependents>\n        <task type=\"Complete\" label=\"\" value=\"\">kinetic_submission_update_v1_3</task>\n      </dependents>\n    </task>\n    <task name=\"Start\" id=\"start\" definition_id=\"system_start_v1\" x=\"10\" y=\"10\">\n      <version>1</version>\n      <configured>true</configured>\n      <defers>false</defers>\n      <deferrable>false</deferrable>\n      <visible>false</visible>\n      <parameters/>\n      <messages/>\n      <dependents>\n        <task type=\"Complete\" label=\"\" value=\"\">kinetic_request_submission_get_answer_set_v1_1</task>\n      </dependents>\n    </task>\n    <task name=\"Wrap up\" id=\"kinetic_submission_update_v1_3\" definition_id=\"kinetic_submission_update_v1\" x=\"380\" y=\"110\">\n      <version>1</version>\n      <configured>true</configured>\n      <defers>false</defers>\n      <deferrable>false</deferrable>\n      <visible>false</visible>\n      <parameters>\n        <parameter id=\"ValidationStatus\" tooltip=\"Validation status for the original request: Completed or Rejected for example.\" label=\"Validation Status\" required=\"true\" dependsOnId=\"\" dependsOnValue=\"\" menu=\"\">Completed</parameter>\n        <parameter id=\"RequestStatus\" tooltip=\"Value for the 'Request Status' field\" label=\"Request Status\" required=\"true\" dependsOnId=\"\" dependsOnValue=\"\" menu=\"Open,Closed\">Closed</parameter>\n      </parameters>\n      <messages>\n        <message type=\"Create\"/>\n        <message type=\"Update\"/>\n        <message type=\"Complete\"/>\n      </messages>\n      <dependents/>\n    </task>\n  </request>\n</taskTree>",
    :description => "Kinetic Task Process Tree",
    :notes => ""


end


