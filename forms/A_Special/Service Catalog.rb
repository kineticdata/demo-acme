require File.join(File.dirname(__FILE__),"../../standards.rb")

# Gets the ID of the catalog -- some of the background tables
# dont have the name -- so we get the ID
@@cat_inst_id = get_catalog_id(@@standard_catalog_name)

service_item @@standard_catalog_service_catalog_name do
  
  
  categories ""
  type "Launcher"
  form_type :launcher
  
  description %`Includes login, searching by template name, "My Requests" and "box" categorization.`
  display_page @@standard_catalog_page
  
  
  display_name @@standard_catalog_name_url
  authentication :template, :template_name => @@standard_authentication_form

  catalog @@standard_catalog_name

  header_content ""

  web_server @@standard_web_server
  data_set @@standard_data_set
  
  visible_to_group @@standard_assignee
  management_group @@standard_management_group
  submission_group @@standard_submission_group
  
  page "Service Catalog Display",
    :confirmation,
    :vertical_buttons,
    :style_class => " catalogTemplate" do
#    style "", "OVERFLOW: hidden;", :html_id
    style "", "overflow:visible !important;", :html_id
    

# This shows the list of Categories on the left
# Why do we have instanceId,Survey_Template_Name,Anonymous_URL
    event "Display Service Items",
      :custom_action,
      :load do
      custom_code "var connection=new KD.utils.Callback(catalogHelper.processServiceItems,KD.utils.Action._addInnerHTML,['serviceItems'], true);
      KD.utils.Action.makeAsyncRequest('getAllServiceItems', clientAction.actionId, connection, '', '../../'+clientManager.themesDirectory+'partials/serviceItems', true);"
      data_request "KS_RQT_SurveyTemplateAttrInst_Category_join",
        :name => "Categorized Service Items List",
        :fields_available => "instanceId,Category,Survey_Template_Name,Anonymous_URL",
        :sort_fields => "SortOrder,Category,Priority,Survey_Template_Name",
        :max_entries => "250",
        :sort_order => "Ascending",
        :qualification => %`'Status'<"Inactive" AND 'ServiceCatalog'="#{@@standard_catalog_name}"`        
        
    end
    
    
    event "Display Request Summary",
      :custom_action,
      :load do
      custom_code "var connection=new KD.utils.Callback(catalogHelper.processServiceItemSummary,KD.utils.Action._addInnerHTML,['myServiceItemSummary']); 
      KD.utils.Action.makeAsyncRequest('myServiceItemSummary', clientAction.actionId, connection, '', '../../'+clientManager.themesDirectory+'partials/actionItems');"
      data_request "KS_RQT_ServiceCatalog_UserServiceItems",
        :name => "Get My Request Stats",
        :fields_available => "OpenRequests,ClosedRequests,OpenApprovalRequests,ApprovalRequests",
        :sort_fields => "",
        :max_entries => "1",
        :sort_order => "Ascending",
        :qualification => %`'User ID' = "$\\USER$" AND 'CategoryInstanceID' = "#{@@cat_inst_id}"`        
        
    end
    
    
    event "Get My Info",
      :custom_action,
      :load do
      custom_code "var connection=new KD.utils.Callback(KD.utils.Action._addInnerHTML,KD.utils.Action._addInnerHTML,['myInfo']); 
      KD.utils.Action.makeAsyncRequest('myInfo', clientAction.actionId, connection, '', '../../'+clientManager.themesDirectory+'partials/myInfo', true);"
      data_request "KS_SAMPLE_People",
        :name => "Get My Info",
        :fields_available => "Department,Email,First Name,Last Name,Phone Number",
        :sort_fields => "",
        :max_entries => "1",
        :sort_order => "Ascending",
        :qualification => %`'AR Login'= "$\\USER$"`
    end
    
    
    
    
    
    section  "Popups",
      :style_class => " pageHeader curvyRedraw" do
      style "position:static !important; border:0 none;height:0;margin:0;overflow:hidden;"
    end

    # What is a custom_action ???
    # How does this work?    
    text "Selected Request Original Task Engine", %`<div id="selectedRequestOrig" style="position:static !important;"></div>` do
      style "position:static !important;"
      event "Get Selected Request",
        :custom_action,
        :custom_event do
        custom_code ""
        data_request "KS_RQT_CustomerSurvey_Task_join",
          :name => "Get Selected Request with Tasks",
          :fields_available => "Task_Status,TaskName,Last_Message,Last_Status,Task_Type,Sequence,Version,Request_Status,ValidationStatus",
          :sort_fields => "Sequence",
          :max_entries => "999",
          :sort_order => "Ascending",
          :qualification => %`'CustomerSurveyInstanceId'= "<FLD>nothing;paramCustomerSurveyID;BASE</FLD>"`
      end
    end
    
    
    text "Selected Request Kinetic Task Engine", %`<div id="selectedRequest" style="position:static !important;"></div>` do
      
      style "position:static !important;"
      event "Get Select Request Details",
        :custom_action,
        :custom_event do
        custom_code ""
        # Took out fields_available -- User_Indicator - as field does not exist
        data_request "KS_TSK_CUSTSRV_TaskInstance_Msg_join",
          :name => "Get Request Details",
          :fields_available => "Task Name,Create Date,Description,Version,\
          Instance Message,Modified Date3,Create Date2,Visible,\
          NotesForCustomer,instanceId,instanceId2,MessageCreate Date,\
          TaskRequest ID,Request_Status,ValidationStatus,IntegrationID,UseTaskEngine",
          :sort_fields => "TaskRequest ID,Create Date2,Create Date,Modified Date3",
          :max_entries => "999",
          :sort_order => "Ascending",
          :qualification => %`('CustomerSurveyInstanceId'="<FLD>nothing;paramCustomerSurveyID;BASE</FLD>" OR  \
          'OriginatingID' ="<FLD>nothing;paramCustomerSurveyID;BASE</FLD>")`
      end
    end


# Remove conversations - until this improves    
    # 
    # text "Conversation Loader", "" do
    #   event "Load Conversation",
    #     :custom_action,
    #     :custom_event do
    #     custom_code ""
    #     data_request "KS_RQT_Conversation",
    #       :name => "Load Conversation",
    #       :fields_available => "Create Date,Message",
    #       :sort_fields => "",
    #       :max_entries => "100",
    #       :sort_order => "Ascending",
    #       :qualification => %`'Source_InstanceID'= "<FLD>Approver ID;Approver ID;BASE</FLD>" ||  'Target_InstanceID' = "<FLD>Approver ID;Approver ID;BASE</FLD>" `
    #   end
    # end
    # 


    
    section  "My Info Section",
      :removed,
      :style_class => " userInfoSection"
      
      
    text "My Info Text", %`<div id = "myInfo" class="userInfo"></div>`
    
    
    section  "Title Section",
      :style_class => " catalogTitleSection"
    text "Service Catalog Name", %`<div id="serviceCatalogName"><FLD>Survey Template Name;700001000;BASE</FLD></div>`,
      :style_class => " secondColorHeader standard_box rounded4" do
      style "FONT-WEIGHT: bold;FONT-SIZE: 1.5em;POSITION: relative; text-align:center;"
    end
    
    
    section  "Search Section",
      :style_class => " catalogSearchSection"
    question "Search", "Search", :free_text,
      :size => "20",
      :rows => "1",
      :style_class => " searchInput ",
      :field_map_number => "1" do
      style "height: 20px;padding-left:328px;", :all
      style "display: inline;", :answer_label
      style "display: inline;", :question_label
      event "Search Service Items on Keyup",
        :custom_action,
        :keyup do
        custom_code "var value=obj.value;var searchReturn=YAHOO.util.Dom.get('searchReturn');
        if (value && value != '' && value.length >1){	
          var connection=new KD.utils.Callback(catalogHelper.processSearchResult,KD.utils.Action._addInnerHTML,['searchReturn'], false);
          KD.utils.Action.makeAsyncRequest('searchServiceItems', clientAction.actionId, connection, 'serviceName='+value, '../../'+clientManager.themesDirectory+'partials/searchList',true);	
          catalogHelper.showSearchResults();} else if (!value || value ==''){	catalogHelper.hideSearchResults();
        }"
        data_request "KS_SRV_SurveyTemplate",
          :name => "Service Item Search",
          :fields_available => "Type,Survey_Template_Name,Survey_Description,Anonymous_URL,instanceId",
          :sort_fields => "Survey_Template_Name",
          :max_entries => "20",
          :sort_order => "Ascending",
          :qualification => %`('Survey_Template_Name' LIKE "%<FLD>Service Name;serviceName;BASE</FLD>%" AND NOT( 'Survey_Template_Name' = "Approval Form")) AND \
          'Category'="#{@@standard_catalog_name}" AND (('SpecialTemplate'="") OR ('SpecialTemplate' = $\\NULL$))`
      end
    end
    
    section  "Category Label Section",
      :style_class => " categoryLabelSection"
    text "Category Label Text", "<div class='categoryLabelImage'></div>",
      :style_class => " categoryLabelText" do
      event "Categories",
        :custom_action,
        :click do
        custom_code "catalogHelper.showMainDisplay();"
      end
    end
    
    
    section  "Content Section",
      :style_class => " contentSection" do
      style "OVERFLOW: hidden;"
    end
    
    text "My Requests", %`
    <div id="yui-dt-paginator0" class="yui-dt-paginator yui-pg-container topPaginator"> </div>
    <div id="selectedServiceItems"></div>
    <div id="yui-dt-paginator1" class="yui-dt-paginator yui-pg-container"> </div>
    `,
      :removed,
      :style_class => " requestsLayer" do
      style "font-size: 11px;"
      event "Get Open Service Items",
        :custom_action,
        :custom_event do
        custom_code "/*Using the catalogUtils.showSelectedRequests */"

        # Took out fields_available -- User_Indicator - as field does not exist
        data_request "KS_RQT_CustomerSurvey_Task_join",
          :name => "Get Selected Requests",
          :fields_available => "Survey_Template_Name,Create Date,ValidationStatus,\
          CustomerSurveyID,TaskName,Task_Status,Last_Message,TaskModificationDate,\
          NotesForCustomer,Form,Submit Type,CustomerSurveyInstanceId,Request_Status,\
          CustomerSurveyStatus,Version,OriginatingID_Display,OriginatingID",
          # Took out Sequence - as field does not exist
          #:sort_fields => "CustomerSurveyID,Sequence",
          :sort_fields => "CustomerSurveyID",
          :max_entries => "500",
          :sort_order => "Descending",
          :qualification => %`'Submitter'="$\\USER$" AND 'Request_Status'="<FLD>status;status;BASE</FLD>" AND \
          'Category'="#{@@standard_catalog_name}" AND (((("<FLD>submitType;submitType;BASE</FLD>" = "Approval") OR \
          ("<FLD>submitType;submitType;BASE</FLD>" = "Approval Task")) AND (('Submit Type' = "Approval") OR \
          ('Submit Type' = "Approval Task"))) OR (("<FLD>submitType;submitType;BASE</FLD>" = "Request") AND \
          ((('Submit Type' != "Approval") AND ('Submit Type' != "Approval Task")) OR ('Submit Type' =  $\\NULL$)))) \
          AND ('Survey_Template_Name' != "Conversation Create")`
      end
    end
    



# TODO -- I THINK THIS CAN BE DELETED -- SHOULD OTHERS BE DELTED
# How does this work qualification -- 'Category'="<FLD>category;category;BASE</FLD>"   
# Where does the <FLD>category....</FLD> come from?

    text "Service Items", %`<div id="serviceItems"></div>`,
      :style_class => " serviceItemsLayer" do
      style "padding: 0px !important; margin-top:1px;"
      event "Do All Items In Category",
        :custom_action,
        :custom_event do
        custom_code "/*Using the catalogUtils.getAllCategoryItems */"
        data_request "KS_RQT_SurveyTemplateAttrInst_Category_join",
          :name => "All Service Items for a Category",
          :fields_available => "Category,Survey_Template_Name,Anonymous_URL,IconHTML,Number_of_Items,Priority,DrillDownTemplate_InstanceID",

# Sort order does not seem to be respected
# Neither does qualification -- is this text item (Service Items) not used???
#          :sort_fields => "Priority",
          :sort_fields => "Survey_Template_Name",
          :max_entries => "250",
          :sort_order => "Ascending",
          :qualification => %`'Status'<"Inactive" AND \
          'ServiceCatalog'="#{@@standard_catalog_name}" AND \
          'Category'="<FLD>category;category;BASE</FLD>"`
      end
    end
    
    
    text "Search Results", %`<div id="searchReturn" class='searchReturnResult rounded4' style='display:none;'></div>`
    section  "Action Section",
      :style_class => " actionItemsSection"
    text "Service Item Summary", %`<div id="myServiceItemSummary"></div>`,
      :style_class => " serviceItemSummary" do
      event "Get Service Item Description",
        :custom_action,
        :custom_event do
        custom_code "/*  fired from catalogHelper.selectServiceItem() */"
        data_request "KS_SRV_SurveyTemplate",
          :name => "Get Service Item Description",
          :fields_available => "Survey_Description",
          :sort_fields => "",
          :max_entries => "1",
          :sort_order => "Ascending",
          :qualification => %`'instanceId'= "<FLD>TemplateID;templateId;BASE</FLD>"`
      end
    end
    
    
    section  "Quick Links Section",
      :removed
    text "Quick links", "
    <div class='quick_link'> www.#{@@standard_company_name}.com </div>
    <div class='quick_link'> 401(k) Plan </div>
    <div class='quick_link'> Medica Health Care Plan </div>
    ",
      :style_class => " quick_linksDiv"
      
  end
  
  
  
  
end
