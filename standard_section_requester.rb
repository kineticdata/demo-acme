

def standard_section_requester

  section  "Submitter" do
    style "display:none;"
  end
  
  question "Requester First Name", "First Name", 
  :free_text, 
  :required, 
  :advance_default, 
  :answer_mapping => "First Name",
  :editor_label => "Req First Name", 
  :default_form => "KS_SAMPLE_People", 
  :default_field => "First Name", 
  :default_qual => "'AR Login'=$\\USER$", 
  :size => "20", 
  :rows => "1", 
  :max => "50", 
  :required_text => "Requester First Name"

  question "Requester Last Name", "Last Name", 
  :free_text, 
  :required, 
  :advance_default, 
  :answer_mapping => "Last Name",
  :editor_label => "Req Last Name", 
  :default_form => "KS_SAMPLE_People", 
  :default_field => "Last Name", 
  :default_qual => "'AR Login'=$\\USER$", 
  :size => "20", 
  :rows => "1", 
  :max => "100", 
  :required_text => "Requester Last Name" 
   
  question "Requester Employee Number", "Employee Number", 
  :free_text, 
  :advance_default, 
  :answer_mapping => "Contact ID", 
  :editor_label => "Req Employee \#", 
  :default_form => "KS_SAMPLE_People", 
  :default_field => "EmployeeNumber", 
  :default_qual => "'AR Login'=$\\USER$", 
  :size => "20", 
  :rows => "1", 
  :max => "20"

  question "Requester Email Address", "Email", 
  :email, 
  :required, 
  :advance_default, 
  :answer_mapping => "Contact Info Value", 
  :editor_label => "Req Email Address", 
  :default_form => "KS_SAMPLE_People", 
  :default_field => "Email", 
  :default_qual => "'AR Login'=$\\USER$", 
  :size => "20", 
  :required_text => "Requester Email", 
  :pattern_label => "Standard Email Address", 
  :pattern => "^[\\w-\\.]+\\@[\\w\\.-]+\\.[a-zA-Z]{2,4}$", 
  :validation_text => "Requester Email Address (Standard Email Address)"

end