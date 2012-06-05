def standard_approval_page_confirmation


  page "Confirmation Page", 
  :confirmation, 
  :vertical_buttons do


    section  "Details"

    text "Service Item Description", "<p>#{build_description(@@name,"<p>&nbsp;</p>",@@image)}</p>"

    text "Thanks", "Thank you", 
    :style_class => " primaryColorHeader"

    text "Thanks/Submission ID", "<p>Thanks for your answer.</p>"
    
    text "Request Info", ""

    text "Return to catalog/improve our service", %|
    <p><a href="DisplayPage?name=#{@@standard_catalog_name_url}">Back to the service catalog</a><br/></p>
    <p><a href="DisplayPage?name=#{@@standard_catalog_survey_name_url}&custId=<FLD>CustomerSurveyInstanceId;179;BASE</FLD>">Help improve our service</a></p>
    |

  end
  
end
