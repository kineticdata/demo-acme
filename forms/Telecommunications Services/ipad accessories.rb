require File.join(File.dirname(__FILE__),"../../standards.rb")




def build_accessory(name,desc,cost,image)

	@@name = name
	@@categories = "Telecommunications Services"
	@@type = "Telecom"
	@@image = image
	@@description = desc




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

	      question "Quantity", "Quantity", 
	      :integer,
	      :required,
	      :size => "2"

	      question "Notes", "Notes", 
	      :free_text,
	      :size => "75",
	      :rows => "3"

	  end


	  standard_page_confirmation

	end

end



accessories = Array.new



name = "iPad Keyboard Dock"
desc = "The iPad Keyboard Dock combines a charging dock with a full-size keyboard. The dock includes a rear dock connector port and an audio line out port."
cost = "$69.00"
image = "http://storeimages.apple.com/1766/store.apple.com/Catalog/regional/amr/ipad/img/accessories-keyboard-dock.jpg"

accessories << [name,desc,cost,image]



name = "iPad Dock"
desc = "The iPad Dock lets you dock and charge your iPad. It includes a rear dock connector and an audio line out port."
cost = "$29.00"
image = "http://storeimages.apple.com/1766/store.apple.com/Catalog/regional/amr/ipad/img/accessories-dock.jpg"

accessories << [name,desc,cost,image]



name = "iPad 10W USB Power Adapter"
desc = "The iPad 10W USB Power Adapter lets you charge your iPad directly through an electrical outlet. And the 6-foot-long power cord allows you to charge it from an even greater distance."
cost = "$29.00"
image = "http://storeimages.apple.com/1766/store.apple.com/Catalog/regional/amr/ipad/img/accessories-usb-adapter.jpg"

accessories << [name,desc,cost,image]



name = "iPad Case"
desc = "The iPad Case not only protects your iPad, it can be used in various positions. So it’s easy to type, look at photos and slideshows, or watch movies."
cost = "$39.00"
image = "http://storeimages.apple.com/1766/store.apple.com/Catalog/regional/amr/ipad/img/accessories-case.jpg"

accessories << [name,desc,cost,image]



name = "Apple iPad Camera Connection Kit"
desc = "The Camera Connection Kit gives you two ways to import photos and videos from a digital camera: using the camera&quot;s USB cable or using the included SD card reader."
cost = "$29.00"
image = "http://storeimages.apple.com/1766/store.apple.com/Catalog/regional/amr/ipad/img/accessories-camera-connection.jpg"

accessories << [name,desc,cost,image]



name = "Apple Dock Connector to VGA Adapter"
desc = "The iPad Dock Connector to VGA Adapter lets you connect your iPad to a TV, monitor, projector, or LCD that uses a VGA connector or cable so you can watch slideshows and movies."
cost = "$29.00"
image = "http://storeimages.apple.com/1766/store.apple.com/Catalog/regional/amr/ipad/img/accessories-vga.jpg"


accessories << [name,desc,cost,image]



accessories.each do |name,cost,desc,image|
  build_accessory(name,cost,desc,image)
end








