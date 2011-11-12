require File.join(File.dirname(__FILE__),"../../standards.rb")

@@name = "Dedicated Hosting Environment"
@@image = "#{@@standard_image_base}/harddisk.png"
@@categories = "Servers and Storage, **New Services"
@@type = "Screen shot sample"
@@description = %`
<strong>DESCRIPTION:</strong>
<br>Dedicated Hosting Environments service offering ensures end-to-end 
delivery and back-end management of a Windows or Linux application hosting 
environment and includes hardware provisioning and installation, 
network  connectivity and access, failover capabilities (based on the level of 
service  selected), backup and restore, and other professional services needed to  
support a dedicated hosting environment<p>
<strong>SERVICE LEVEL DESCRIPTION:</strong><br>
	Several key service levels have been established, which apply across all 
service level options, but the targets associated with the service levels vary based 
on the option selected.  
These service levels include:  platform availability / accessibility 
during both prime-time and non-prime-time hours (specified by the 
customer as part of a service request for this offering); a common completion-time 
for new installation requests; 
a common response-time for user-reported service disruptions; and specified service 
restoration times designed to support the availability/accessibility requirements of the selected 
service level option.<br>

<strong>NOTE:</strong>  despite the allowance for customer-specified prime-time hours, 
?business days? as used in the service level objectives means Monday 
through Friday, 7am to 7pm, local requestor time.
<P><strong>PRICE DESCRIPTION:</strong><P>

<table style="border:1px solid grey;" cellspacing="0px" >

<th id="" rowspan="1" colspan="1" class="desc  yui-dt-first yui-dt-desc">
<div id="" class="">
<span class="">Type</span></div></th>

<th id="" rowspan="1" colspan="1" class="desc  yui-dt-first yui-dt-desc">
  <div id="" class="">
  <span class="">Charge</span>
  </div>
</th>

<tr>
<td style="border: 1px solid grey;"><strong>Class C</strong></td>
<td style="border: 1px solid grey;">One-time $5,000.00 procurement/installation fee 
(includes hw/os, network connectivity and dns configuration, testing, 
backup/restore capabilities, security suite, anti-virus/spyware, and other 
current, relevant professional services).</td>
</tr>

<tr>
<td style="border: 1px solid grey;"><strong>Class B</strong></td>
<td style="border: 1px solid grey;">One-time $11,000.00 procurement/installation 
fee (includes hw/os, network connectivity and dns configuration, 
failover configuration and automation, testing, backup/restore capabilities, 
security suite, anti-virus/spyware, and other current, relevant professional services).</td>
</tr>

<tr>
<td style="border: 1px solid grey;"><strong>Class A</strong></td>
<td style="border: 1px solid grey;">One-time $23,000.00 procurement/installation fee 
(includes hw/os, network connectivity and dns configuration, advanced failover configuration 
and automation, testing, backup/restore capabilities, security suite, anti-virus/spyware, 
and other current, relevant professional services).</td>
</tr>

</table>

`




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

      text "Configuration", "Configuration", 
      :style_class => " primaryColorHeader"
    
  
      question "Operating System", "Operating System", 
      :list, 
      :list_box, 
      :horizontal, 
      :required, 
      :choice_list => "Operating System" do
        choice "Windows"
        choice "Linux"
      end



      question "Service Class", "Service Class", 
      :list, 
      :list_box, 
      :horizontal, 
      :required, 
      :choice_list => "Service Class" do
        choice "A"
        choice "B"
        choice "C"
      end


      question "Operating Hours", "Operating Hours", 
      :free_text,
      :required,
      :size => "75",
      :rows => "1"


      question "Additional Requirements", "Additional Requirements", 
      :free_text,
      :size => "75",
      :rows => "3"

      
  end


  standard_page_confirmation

end










