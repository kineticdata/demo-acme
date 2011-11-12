require File.join(File.dirname(__FILE__),"../../standards.rb")

@@name = "Email Journaling"
@@categories = "Outlook and Email Services"
@@type = "Screen shot sample"
@@image = "#{@@standard_image_base}/address_book.png"
@@description = "Message Journaling can become necessary because of political reasons or new regulations. 
Many organizations in the healthcare and insurance industry or financial services must record the communication between their customers and their employees."


# There are three different types of journaling that you can enable in Exchange Server 2003.
# 
# Message-only journaling
# Message-only journaling captures all messages from users on a specific mailbox database and sends the message copy to a specified journaling mailbox.
# 
# BCC journaling
# BCC journaling is message-only journaling with a capture of BCC recipients. When BCC journaling is enabled, Exchange Server captures all recipients (TO / CC / BCC).
# 
# Note: 
# BCC journaling doesn’t work if the recipient list contains hidden distribution lists, query-based distribution lists, or distribution lists that have another expansion server.
# 
# Envelope journaling
# Envelope journaling is different from message-only journaling and BCC journaling in that it allows you to archive P1 message headers (envelope headers). This includes information about the recipients, including BCC recipients and recipients from distribution groups.




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




      question "Notes", "Notes", 
      :free_text,
      :size => "75",
      :rows => "3"

      
      
      
  end


  standard_page_confirmation

end

