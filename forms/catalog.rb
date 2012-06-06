require File.join(File.dirname(__FILE__),"standards.rb")

catalog @@standard_catalog_name,
  :description => @@standard_catalog_name,
  :web_server_url => @@standard_web_server,
  :display_page => @@standard_display_page,
  :assignee_group => "0;",
  :management_group => "Public" do
    
  category "**New Services",
    :active,
    :sort_order => "5"
  category "Access Services",
    :active,
    :sort_order => "10"
  category "Advanced IT Services",
    :active,
    :sort_order => "20"
  category "Desktop Services",
    :active,
    :sort_order => "30"
  category "Facilities",
    :active,
    :sort_order => "32"
  category "Meeting Services",
    :active,
    :sort_order => "33"
  category "Office Supplies",
    :active,
    :sort_order => "35"
  category "Operations",
    :active,
    :sort_order => "40"
  category "Outlook and Email Services",
    :active,
    :sort_order => "45"
  category "People Services",
    :active,
    :sort_order => "50"
  category "Servers and Storage",
    :active,
    :sort_order => "55"
  category "Telecommunications Services",
    :active,
    :sort_order => "60"
  category "Network Services",
    :active,
    :sort_order => "32"
    
# OPTIONAL CATEGORIES 
    
  category "Kinetic Request",
    :active,
    :sort_order => "95"    
  category "Playground",
    :active,
    :sort_order => "99"

  category "Work Order",
    :active,
    :sort_order => "99"
    
  logout_action :go_to_template,
    :template_name => @@standard_catalog_service_catalog_name,
    :catalog_name => @@standard_catalog_name
    
end
