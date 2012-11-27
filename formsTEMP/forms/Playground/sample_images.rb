require File.join(File.dirname(__FILE__),"../../standards.rb")

@@name = "Sample Primo Images"
@@categories = "Playground"
@@type = "Playground"
@@image = "#{@@standard_image_base}/user.png"
@@description = "Sample Primo images - all."




image_names = "access_black.png
access_blue.png
address_black.png
address_blue.png
address_book.png
archive.png
attachment.png
barcode.png
battery_empty.png
battery_full.png
battery_half.png
blackboard.png
block_black.png
block_blue.png
blog.png
blog_accept.png
blog_add.png
blog_compose.png
blog_delete.png
blog_private.png
bluetooth_black.png
bluetooth_blue.png
bookmark.png
box.png
box_open.png
briefcase.png
button_black_eject.png
button_black_ffw.png
button_black_first.png
button_black_last.png
button_black_pause.png
button_black_play.png
button_black_rec.png
button_black_repeat.png
button_black_rew.png
button_black_stop.png
button_blue_eject.png
button_blue_ffw.png
button_blue_first.png
button_blue_last.png
button_blue_pause.png
button_blue_play.png
button_blue_rec.png
button_blue_repeat.png
button_blue_rew.png
button_blue_stop.png
button_grey_eject.png
button_grey_ffw.png
button_grey_first.png
button_grey_last.png
button_grey_pause.png
button_grey_play.png
button_grey_rec.png
button_grey_repeat.png
button_grey_rew.png
button_grey_stop.png
calculator.png
calendar.png
camera.png
cd.png
certificate.png
chart_bar.png
chart_pie.png
chip.png
clock.png
coffee.png
comment_accept.png
comment_add.png
comment_delete.png
comment_edit.png
comment_private.png
comments.png
compass.png
copy.png
credit_card_amex.png
credit_card_mastercard.png
credit_card_visa.png
credit_cards.png
currency_black_dollar.png
currency_black_euro.png
currency_black_pound.png
currency_black_yuan.png
currency_blue_dollar.png
currency_blue_euro.png
currency_blue_pound.png
currency_blue_yuan.png
database_active.png
database_inactive.png
delivery.png
design.png
email.png
email_accept.png
email_add.png
email_compose.png
email_delete.png
email_forward.png
email_open.png
email_reply.png
email_send.png
exchange.png
file_download.png
file_upload.png
filter.png
folder.png
folder_add.png
folder_block.png
folder_delete.png
folder_download.png
folder_email.png
folder_lock.png
folder_open.png
folder_search.png
folder_sent.png
folder_upload.png
folder_user.png
game_pad.png
gear.png
gift.png
globe.png
harddisk.png
help_black.png
help_blue.png
home.png
inbox.png
info_black.png
info_blue.png
ipod.png
key.png
keyboard.png
label.png
label_black_buy.png
label_black_hot.png
label_black_new.png
label_blue_buy.png
label_blue_hot.png
label_blue_new.png
laptop.png
link.png
lock.png
micphone.png
mobile.png
monitor.png
mouse.png
music.png
news.png
notepad.png
outbox.png
paste.png
pencil.png
photo.png
power_black.png
power_blue.png
print.png
puzzle.png
receipt.png
recycle_bin.png
rss_black.png
rss_blue.png
save.png
saving.png
search.png
shopping_bag.png
shopping_basket.png
shopping_basket_2.png
shopping_cart.png
shopping_trolley.png
speaker.png
speaker_mute.png
star_full.png
star_half.png
star_none.png
sticker_black.png
sticker_black_50off.png
sticker_black_sale.png
sticker_blue.png
sticker_blue_50off.png
sticker_blue_sale.png
sub_black_accept.png
sub_black_add.png
sub_black_delete.png
sub_black_down.png
sub_black_next.png
sub_black_prev.png
sub_black_remove.png
sub_black_rotate_ccw.png
sub_black_rotate_cw.png
sub_black_up.png
sub_blue_accept.png
sub_blue_add.png
sub_blue_delete.png
sub_blue_down.png
sub_blue_next.png
sub_blue_prev.png
sub_blue_remove.png
sub_blue_rotate_ccw.png
sub_blue_rotate_cw.png
sub_blue_up.png
tag.png
telephone_black.png
telephone_blue.png
tools.png
unlock.png
user.png
user_group.png
vcards.png
video.png
wallet.png
warning_black.png
warning_blue.png
windows.png
"
















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



    section  "Images Section"
    text "Details Header Text", "Details",
      :style_class => " primaryColorHeader"
    

      image_names.split.each do |img_name|

        text "Image #{img_name}", %!<img src="#{@@standard_image_base}/#{img_name}" alt="#{img_name}"</img> #{img_name} <br/>!


      end



  end


 
  standard_page_confirmation



end
