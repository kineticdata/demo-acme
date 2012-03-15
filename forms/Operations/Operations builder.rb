require File.join(File.dirname(__FILE__),"../../standards.rb")




def build_form(product)

  @@name = "Create #{product} Incident"
  @@categories = "Operations"
  @@type = "Screen shot sample"
  @@image = "#{@@standard_image_base}/box.png"
  @@description = "Report issues with #{product}."


  service_item @@name do

    categories @@categories
    type @@type

    description build_description(@@name,@@description,@@image)

    standard_initial_form
  


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

# TODO - get rid of servers question - not relevant
        question "Servers", "Servers", 
        :list, 
        :check_box, 
        :horizontal, 
        :choice_list => "UnixServers" do
          choice "Dawn", "Dawn"
          choice "Gandalf", "Gandalf"
          choice "yoda", "yoda"
          choice "wookie", "wookie"
          choice "fred", "fred"
          choice "barney", "barney"
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
  


  end


  standard_page_confirmation


  end
  
end



["Bind","MySQL","Postgresql","Oracle","Apache","DNS","LDAP","SSH"].each do |product|
  build_form(product)
end


