/**
 * The KINETIC global namespace object
 * @class KINETIC
 * @static
 */
if (typeof KINETIC == "undefined") {
    KINETIC = {};
}
if (typeof KINETIC.catalog == "undefined") {
    KINETIC.catalog = {};
}

if (! KINETIC.catalog.Helper){

    KINETIC.catalog.Helper= new function(){
        this.currentCategorySI=null;
        this.currentServiceItemLaunch=null;
        this.categoriesLoaded=false;
        this.summaryLoaded=false;
        this.currentRequestAction=null;
        this.siDescriptions={};

        this.keepSessionAlive = function(){
            KD.utils.ClientManager.checkSession();
            setTimeout('catalogHelper.keepSessionAlive()', 1000*60*19);
        }

        this.processSearchResult = function(o) {
            KD.utils.Action._addInnerHTML(o);



            var height = YAHOO.util.Dom.get('categoryServiceItems').clientHeight;
            var offsetHeight = YAHOO.util.Dom.get('serviceItemsHolder').clientHeight;

            var searchReturnDiv = YAHOO.util.Dom.get('searchReturn');
            searchReturnDiv.style.top=-(offsetHeight-10)+'px';
            searchReturnDiv.style.height=height+'px';
            var searchResultServiceItemsDiv = YAHOO.util.Dom.get('searchResults_ServiceItems');
            YAHOO.util.Dom.get('searchCategoryLabelHolder').style.height=height+'px';
            searchResultServiceItemsDiv.style.height=height+'px';
			
			
			
            catalogHelper.clearCurrentServiceItemLaunch();

            var elId=o.argument[0];
            if(elId){
                if (curvyBrowser.isIE || curvyBrowser.isOp) {
                    var el = YAHOO.util.Dom.get(elId[0]);

                    var settings = {
                        tl: {
                            radius: 6
                        },
                        tr: {
                            radius: 0
                        },
                        bl: {
                            radius: 0
                        },
                        br: {
                            radius: 0
                        },
                        antiAlias: true
                    }

                    var divs = KD.utils.Util.getElementsByClassName("serviceItemResults", "div", el);

                    for (var i=0; i<divs.length; i++) {
                        curvyCorners(settings, divs[i]);
                    }
                }
							
            }
        }

        this.setRequestsViewSize = function() {
            // This logic is only applicable for the catalog page.
            // TODO - what is this??? -- JDS
            if (clientManager.templateId!='KR03b666d211df8e3b000423ba6808')
                return;
				
            var requestsDiv = KD.utils.Util.getTextObject('My Requests');
            if (requestsDiv.style.display=='block') {
                var divY = YAHOO.util.Dom.getY(requestsDiv);

                var vHeight = YAHOO.util.Dom. getViewportHeight();
                vHeight = vHeight - divY - 50;
                requestsDiv.style.height= vHeight + 'px';

                var rowHeight;
                var tableDiv = YAHOO.util.Dom.get('selectedServiceItems');
                if (tableDiv) {
                    try {
                        tableDiv = new YAHOO.util.Element(tableDiv);
                        var tbody = tableDiv.getElementsByClassName('yui-dt-data', 'tbody');
							
                        if (tbody != undefined && tbody.length>0) {
                            var tbodyElement = new YAHOO.util.Element(tbody[0]);
                            var rows = tbodyElement.getElementsByClassName('yui-dt-first', 'tr');
							
                            if (rows != undefined && rows.length>0) {
                                rowHeight = rows[0].clientHeight

                                var rowCount = vHeight/rowHeight;
                                var extra=2;
									
                                if (navigator.userAgent.toLowerCase().indexOf('chrome') > -1 || navigator.userAgent.toLowerCase().indexOf('opera') > -1) {
                                    extra=5;
                                }
									
                                catalogHelper.requestsTable.configs.paginator.setRowsPerPage(Math.round(rowCount-extra));
                            }
                        }
                    } catch (e) {}
                }
            }
        }
	
        this.showMyInfo = function() {
            var section = KD.utils.Util.getElementObject("My Info Section", "SECTION_");

            if (section.style.display=='block') {
                section.style.display='none';
            } else {
                section.style.display='block';
            }
			
        }
        this.hideMyInfo = function() {
            var section = KD.utils.Util.getElementObject("My Info Section", "SECTION_");
            section.style.display='none';
        }

        this.showMainDisplay = function(){
            var mainPanel = YAHOO.util.Dom.get('serviceItems');
            mainPanel.style.display='block';

            var siPanel = YAHOO.util.Dom.get('categoryServiceItems');
            siPanel.style.display='block';

            this.resetSearch();
            this.resetRequests();

            var catHeight = YAHOO.util.Dom.get('categoryItems').clientHeight;
            var contentHeight = this.getContentHeight();

            if (catHeight>500) {
                YAHOO.util.Dom.get('serviceItemsHolder').style.height = catHeight+30+"px";
                var serviceItemsHeight = Math.round(.97*(catHeight+30));
				if (curvyBrowser.isIE) {
					curvyCorners.adjust(YAHOO.util.Dom.get('categoryServiceItems'), 'style.height', serviceItemsHeight + "px");
                                        curvyCorners.adjust(YAHOO.util.Dom.get('contentPageSection'),'style.height',contentHeight + "px");
                                        // TO DO: implement contentpagesection height
				} else {
	                YAHOO.util.Dom.get('categoryServiceItems').style.height = serviceItemsHeight + "px";
                        // TO DO: implement contentpagesection height
				}

                YAHOO.util.Dom.get('serviceItemsList_holder').style.height = serviceItemsHeight + "px";
                YAHOO.util.Dom.get('serviceItemLaunch_holder').style.height = serviceItemsHeight + "px";

            }
            curvyCorners.redraw();
            this.hideMyInfo();
            if (this.oServiceItemPanel)
                this.oServiceItemPanel.hide();
            this.reflectLastAction();

            //KD.utils.ClientManager.renderSimpleLogin();
        }

        this.getContentHeight = function(){
            var catHeight = YAHOO.util.Dom.get('categoryItems').clientHeight;
            var tempHeight = 56 + 30 + catHeight + 30 + 15 + 20;
            return tempHeight;
        }

        this.showSearchResults = function(){
            this.resetRequests();

            var mainPanel = YAHOO.util.Dom.get('serviceItems');
            mainPanel.style.display='block';

            var siPanel = YAHOO.util.Dom.get('categoryServiceItems');
            siPanel.style.display='block';

            var searchReturn=YAHOO.util.Dom.get('searchReturn');
            if (searchReturn)
                searchReturn.style.display='block';
			
            this.hideMyInfo();
        }

        this.hideSearchResults = function(){
            var searchReturn=YAHOO.util.Dom.get('searchReturn');
            searchReturn.innerHTML = '';

            this.showMainDisplay();
        }

        this.showRequestPanel = function(obj){
            this.currentRequestAction = obj;
            this.resetSearch();
            KD.utils.Action.insertElement('My Requests')
            this.setRequestsViewSize();
			
            var mainPanel = YAHOO.util.Dom.get('serviceItems');
            mainPanel.style.display='none';

            var siPanel = YAHOO.util.Dom.get('categoryServiceItems');
            siPanel.style.display='none';

            var holder = new YAHOO.util.Element('myServiceItemSummary');

            var selected = holder.getElementsByClassName('requestsSelected', 'div');
            for (var i=0; i<selected.length; i++) {
                var el  = new YAHOO.util.Element(selected[i]);
                el.removeClass('requestsSelected');
            }

            el = new YAHOO.util.Element(obj);
            el.addClass('requestsSelected');
            this.hideMyInfo();
			
            this.setLastRequestsAction(obj.id);
        }

        this.resetRequests = function() {
            KD.utils.Action.removeElement('My Requests')
            var holder = new YAHOO.util.Element('myServiceItemSummary');

            var selected = holder.getElementsByClassName('requestsSelected', 'div');
            for (var i=0; i<selected.length; i++) {
                var el  = new YAHOO.util.Element(selected[i]);
                el.removeClass('requestsSelected');
            }
            this.clearRequestsAction();
        }
		
        this.resetSearch = function(){
            // Hide Search results panel
            var searchReturn=YAHOO.util.Dom.get('searchReturn');
            if (searchReturn)
                searchReturn.style.display='none';

            KD.utils.Action.setQuestionValue('Search','');

            var siPanel = YAHOO.util.Dom.get('categoryServiceItems');
            if (siPanel)
                siPanel.style.visibility='visible';
        }

        this.selectCategory = function(obj){
            var id = obj.id.replace('category_','');
            var holder = new YAHOO.util.Element('serviceItemsHolder');

            this.resetSearch();

            var selected = holder.getElementsByClassName('categorySelected', 'div');
            for (var i=0; i<selected.length; i++) {
                var el  = new YAHOO.util.Element(selected[i]);
                el.removeClass('categorySelected');
            }

            el = new YAHOO.util.Element(obj);
            el.addClass('categorySelected');

            // Switch in the reflected Category Service Items
            var siPlaceHolder = YAHOO.util.Dom.get('serviceItemPlaceholder');
            var siListHolder = YAHOO.util.Dom.get('serviceItemsList_holder');

            if (this.currentCategorySI && siPlaceHolder && siListHolder) {
                try {
                    var siDiv=siListHolder.removeChild(this.currentCategorySI);
                    if (siDiv) {
                        siDiv.style.display='none';
                        // Place back into PlaceHolder
                        siPlaceHolder.appendChild(siDiv);
                    }
                } catch (e) {}
            }

            siDiv = YAHOO.util.Dom.get('serviceItems_'+id);
            if (siDiv) {
                if (siPlaceHolder) {
                    siPlaceHolder.removeChild(siDiv);
                }

                if (siListHolder) {
                    siListHolder.appendChild(siDiv);
                }
                siDiv.style.display='block';

                this.currentCategorySI=siDiv;
            }
            this.clearSelectedServiceItem();

            this.clearCurrentServiceItemLaunch();
            this.hideMyInfo();
			
            this.setLastCategoryAction(obj.id);


        }

        this.clearSelectedServiceItem = function() {
            var holder = new YAHOO.util.Element('serviceItemsList_holder');
            var selected = holder.getElementsByClassName('serviceItemSelected', 'div');
            for (var i=0; i<selected.length; i++) {
                var el  = new YAHOO.util.Element(selected[i]);
                el.removeClass('serviceItemSelected');
            }
        }

        this.clearSearchSelectedServiceItem = function() {
            var holder = new YAHOO.util.Element('searchResults_ServiceItems');
            var selected = holder.getElementsByClassName('serviceItemSelected', 'div');
            for (var i=0; i<selected.length; i++) {
                var el  = new YAHOO.util.Element(selected[i]);
                el.removeClass('serviceItemSelected');
            }
        }

        this.getXmlRecordField = function (obj, fieldId) {
            if (obj && obj.responseXML) {
                var record = obj.responseXML.getElementsByTagName("record")[0];
                var fields = record.getElementsByTagName("field");
                for (var i = 0; i < fields.length; i += 1) {
                    var fieldIdValue = fields[i].getAttribute('id');
                    if (fieldIdValue == fieldId) {
                        if (fields[i].text) {
                            return fields[i].text; //IE
                        } else {
                            return fields[i].textContent;
                        }
                    }
                }
            }
            return undefined;
        }

        this.getClickedServiceItem = function (obj) {
            var selEl = obj;
            // figure out which element was selected that triggered this action
            // if it came from a simple data response, will be wrapped up in the
            // argument property.
            if (obj && obj.argument && KD.utils.Util.isArray(obj.argument)) {
                // if the object was specified as an array, the descriptionText is
                // the first element, and the clicked service item is the
                // second element
                if (KD.utils.Util.isArray(obj.argument[0])) {
                    selEl = obj.argument[0][1];
                } else {
                    selEl = obj.argument[0];
                }
            }
            return selEl;
        }

        this.getServiceItemDescription = function (obj, prefix, fSuccess, fFailure) {
            var id = obj.id.replace(prefix, ''),
            launchHolder, siSummary, dynTextLayer, sdrId,
            clientAction, connection, paramStr;

            // get the service item description from the server
            siSummary = YAHOO.util.Dom.get('myServiceItemSummary');
            dynTextLayer = siSummary.parentNode;
            if (dynTextLayer) {
                sdrId = KD.utils.Util.getIDPart(dynTextLayer.id);
                if (sdrId) {
                    // need to store a copy of the current launched service item
                    // because the node will get wiped out when the AJAX loader
                    // image is displayed
                    if (catalogHelper.currentServiceItemLaunch) {
                        catalogHelper.currentServiceItemLaunch = catalogHelper.currentServiceItemLaunch.cloneNode(true);
                    }
                    launchHolder = YAHOO.util.Dom.get('serviceItemLaunch_holder');
                    paramStr = "templateId=" + id;
                    clientAction = KD.utils.ClientManager.customEvents.getItem(sdrId)[0];
                    connection = new KD.utils.Callback(fSuccess, fFailure, [launchHolder, obj], true);
                    KD.utils.Action.makeAsyncRequest('getSiDesc', clientAction.actionId, connection, paramStr, '', true);
                } else {
                    catalogHelper.showSelectedServiceItem(obj);
                    return;
                }
            }
        }

        this.selectServiceItem = function (obj) {
            var prefix = 'serviceItem_',
            id = obj.id.replace(prefix,''),
            success = catalogHelper.showSelectedServiceItem,
            failure = catalogHelper.showSelectedServiceItem,
            desc = catalogHelper.siDescriptions[id];
                
            if (desc != null && desc != undefined) {
                // description was in the cache, use it
                catalogHelper.showSelectedServiceItem(obj, desc);
                return;
            }
            
            // it wasn't in the cache, get it from the server
            catalogHelper.getServiceItemDescription(obj, prefix, success, failure);
        }

        this.showSelectedServiceItem = function (obj, desc) {
            var selEl = catalogHelper.getClickedServiceItem(obj),
            prefix = 'serviceItem_', id, el,
            siLaunchPlaceHolder, siLaunchHolder, launchDiv, loaderImg, method,
            descTextDiv, descriptionContainers, requestDescriptionHeight,
            catHeight, serviceItemsHeight;

            // bail out if the clicked service item could not be determined
            if (!selEl) {
                return;
            }

            // just want the instanceid of the service item
            id = selEl.id.replace(prefix,'');

            // if the description wasn't provided directly, look into the
            // simple data response object to get it
            if (desc == null || desc == undefined) {
                desc = catalogHelper.getXmlRecordField(obj, "Survey_Description") || "";
                // cache the description
                catalogHelper.siDescriptions[id] = desc;
            }

            catalogHelper.clearSelectedServiceItem();
            catalogHelper.clearCurrentServiceItemLaunch();

            el = new YAHOO.util.Element(selEl);
            el.addClass('serviceItemSelected');

            // Switch in the reflected Service Item Launch info
            siLaunchPlaceHolder = YAHOO.util.Dom.get('serviceItemLaunch_Placeholder');
            siLaunchHolder = YAHOO.util.Dom.get('serviceItemLaunch_holder');
            loaderImg = siLaunchHolder.getElementsByTagName("img")[0];
            if (loaderImg) {
                loaderImg.parentNode.removeChild(loaderImg);
            }

            launchDiv = YAHOO.util.Dom.get('launch_'+id);
            if (!launchDiv) {
                // do this for IE6
                method = function(el) {return el.id == 'launch_' + id;}
                launchDiv = YAHOO.util.Dom.getElementsBy(method, 'div', siLaunchPlaceHolder)[0]
            }
            // get the description text element and add the description
            descTextDiv = YAHOO.util.Dom.getElementsByClassName("descriptionText", "div", launchDiv)[0];
            descTextDiv.innerHTML = desc;

            launchDiv = launchDiv.parentNode.removeChild(launchDiv);
            launchDiv = siLaunchHolder.appendChild(launchDiv);
            launchDiv.style.display='block';

            catalogHelper.currentServiceItemLaunch=launchDiv;

            descriptionContainers = YAHOO.util.Dom.get('descriptionContainer_' + id);
            if (!descriptionContainers) {
                // do this for IE6
                method = function(el) {return el.id == 'descriptionContainer_' + id;}
                descriptionContainers = YAHOO.util.Dom.getElementsBy(method, 'div', siLaunchHolder)[0]
            }
            requestDescriptionHeight = descriptionContainers.offsetHeight;
            catHeight = YAHOO.util.Dom.get('categoryItems').offsetHeight;

	    var orig_height1;
	    var orig_height2;
	    var new_height1;
	    var new_height2;

            if (requestDescriptionHeight>500){
                var contentHeight = KINETIC.catalog.Helper.getContentHeight();
                var tempHeight = requestDescriptionHeight - catHeight;
                contentHeight = contentHeight+tempHeight;

                YAHOO.util.Dom.get('serviceItemsHolder').style.height = requestDescriptionHeight+30+"px";
                serviceItemsHeight = Math.round(.97*(requestDescriptionHeight+30));
				if (curvyBrowser.isIE) {
					curvyCorners.adjust(YAHOO.util.Dom.get('categoryServiceItems'), 'style.height', serviceItemsHeight + "px");
                                        curvyCorners.adjust(YAHOO.util.Dom.get('contentPageSection'),'style.height',contentHeight + "px");
                                        // TO DO: implement contentpagesection height
				} else {
	                YAHOO.util.Dom.get('categoryServiceItems').style.height = serviceItemsHeight + "px";
                        // TO DO: implement contentpagesection height
				}

		orig_height1 = YAHOO.util.Dom.get('serviceItemsList_holder').style.height;
		orig_height2 = YAHOO.util.Dom.get('serviceItemLaunch_holder').style.height;
	    	new_height1 = serviceItemsHeight + "px";
	    	new_height2 = serviceItemsHeight + "px";

                YAHOO.util.Dom.get('serviceItemsList_holder').style.height = serviceItemsHeight + "px";
                YAHOO.util.Dom.get('serviceItemLaunch_holder').style.height = serviceItemsHeight + "px";
            } else if (catHeight>500) {
                var contentHeight = KINETIC.catalog.Helper.getContentHeight();

                YAHOO.util.Dom.get('serviceItemsHolder').style.height = catHeight+30+"px";
                serviceItemsHeight = Math.round(.97*(catHeight+30));
				if (curvyBrowser.isIE) {
					curvyCorners.adjust(YAHOO.util.Dom.get('categoryServiceItems'), 'style.height', serviceItemsHeight + "px");
                                        curvyCorners.adjust(YAHOO.util.Dom.get('contentPageSection'),'style.height',contentHeight + "px");
                                        // TO DO: implement contentpagesection height
				} else {
	                YAHOO.util.Dom.get('categoryServiceItems').style.height = serviceItemsHeight + "px";
                        // TO DO: implement contentpagesection height
				}
		orig_height1 = YAHOO.util.Dom.get('serviceItemsList_holder').style.height;
		orig_height2 = YAHOO.util.Dom.get('serviceItemLaunch_holder').style.height;
	    	new_height1 = serviceItemsHeight + "px";
	    	new_height2 = serviceItemsHeight + "px";

                YAHOO.util.Dom.get('serviceItemsList_holder').style.height = serviceItemsHeight + "px";
                YAHOO.util.Dom.get('serviceItemLaunch_holder').style.height = serviceItemsHeight + "px";
            }

	    if (curvyBrowser.isIE && (orig_height1 != new_height1 || orig_height2 != new_height2)) {
	    	curvyCorners.redraw();
	    }

            catalogHelper.hideMyInfo();
        }

        this.selectSearchServiceItem = function (obj) {
            var prefix = 'search_serviceItem_',
            id = obj.id.replace(prefix,''),
            success = catalogHelper.showSelectedSearchItem,
            failure = catalogHelper.showSelectedSearchItem,
            desc = catalogHelper.siDescriptions[id];

            if (desc != null && desc != undefined) {
                // description was in the cache, use it
                catalogHelper.showSelectedSearchItem(obj, desc);
                return;
            }

            // it wasn't in the cache, get it from the server
            catalogHelper.getServiceItemDescription(obj, prefix, success, failure);
        }

        this.showSelectedSearchItem = function (obj, desc) {
            var selEl = catalogHelper.getClickedServiceItem(obj),
            prefix = 'search_serviceItem_', id, el,
            siLaunchPlaceHolder, siLaunchHolder, launchDiv, loaderImg, method,
            descTextDiv;

            // bail out if the clicked service item could not be determined
            if (!selEl) {
                return;
            }

            // just want the instanceid of the service item
            id = selEl.id.replace(prefix,'');

            // if the description wasn't provided directly, look into the
            // simple data response object to get it
            if (desc == null || desc == undefined) {
                desc = catalogHelper.getXmlRecordField(obj, "Survey_Description") || "";
                // put the description in the cache so it won't
                // be loaded from the server again
                catalogHelper.siDescriptions[id] = desc;
            }

            catalogHelper.clearSearchSelectedServiceItem();
            catalogHelper.clearCurrentServiceItemLaunch();

            el = new YAHOO.util.Element(selEl);
            el.addClass('serviceItemSelected');

            // Switch in the reflected Service Item Launch info
            siLaunchPlaceHolder = YAHOO.util.Dom.get('serviceItemLaunch_Placeholder');
            siLaunchHolder = YAHOO.util.Dom.get('serviceItemLaunch_holder');
            loaderImg = siLaunchHolder.getElementsByTagName("img")[0];
            if (loaderImg) {
                loaderImg.parentNode.removeChild(loaderImg);
            }

            launchDiv = YAHOO.util.Dom.get('launch_' + id);
            if (!launchDiv) {
                // do this for IE6
                method = function(el) {return el.id == 'launch_' + id;}
                launchDiv = YAHOO.util.Dom.getElementsBy(method, 'div', siLaunchPlaceHolder)[0]
            }

            if (launchDiv) { // Service Item has been associated to a Category
                // get the description text element and add the description
                descTextDiv = YAHOO.util.Dom.getElementsByClassName("descriptionText", "div", launchDiv)[0];
                descTextDiv.innerHTML = desc;
                launchDiv = launchDiv.parentNode.removeChild(launchDiv);
            } else { // Not related to a Service Item.
                launchDiv = YAHOO.util.Dom.get('launch_NotCategorized');
                var but = YAHOO.util.Dom.getElementsByClassName('UncategorizedServiceItemButton', 'input', launchDiv);
                but[0].onclick = function() {
                    window.location="DisplayPage?srv=" + encodeURIComponent(id);
                };
            }

            launchDiv = siLaunchHolder.appendChild(launchDiv);
            launchDiv.style.display='block';

            catalogHelper.currentServiceItemLaunch=launchDiv;

            descriptionContainers = YAHOO.util.Dom.get('descriptionContainer_' + id);
            if (!descriptionContainers) {
                // do this for IE6
                method = function(el) {return el.id == 'descriptionContainer_' + id;}
                descriptionContainers = YAHOO.util.Dom.getElementsBy(method, 'div', siLaunchHolder)[0]
            }
            requestDescriptionHeight = descriptionContainers.offsetHeight;
            catHeight = YAHOO.util.Dom.get('categoryItems').offsetHeight;
	    var searchReturnOffset=0;

	    var orig_height1;
	    var orig_height2;
	    var new_height1;
	    var new_height2;

            if (requestDescriptionHeight>500){
                YAHOO.util.Dom.get('serviceItemsHolder').style.height = requestDescriptionHeight+30+"px";
                serviceItemsHeight = Math.round(.97*(requestDescriptionHeight+30));
				if (curvyBrowser.isIE) {
					curvyCorners.adjust(YAHOO.util.Dom.get('categoryServiceItems'), 'style.height', serviceItemsHeight + "px");
					curvyCorners.adjust(YAHOO.util.Dom.get('searchResults_ServiceItems'), 'style.height', serviceItemsHeight + "px");
                                        curvyCorners.adjust(YAHOO.util.Dom.get('contentPageSection'),'style.height',contentHeight + "px");
                                        // TO DO: implement contentpagesection height
                            } else {
	                		YAHOO.util.Dom.get('categoryServiceItems').style.height = serviceItemsHeight + "px";
	                		YAHOO.util.Dom.get('searchResults_ServiceItems').style.height = serviceItemsHeight + "px";
                        		// TO DO: implement contentpagesection height
			    }

		orig_height1 = YAHOO.util.Dom.get('categoryServiceItems').style.height;
		orig_height2 = YAHOO.util.Dom.get('searchResults_ServiceItems').style.height;
	    	new_height1 = serviceItemsHeight + "px";
	    	new_height2 = serviceItemsHeight + "px";

		searchReturnOffset=12;
            } else if (catHeight>500) {
                YAHOO.util.Dom.get('serviceItemsHolder').style.height = catHeight+30+"px";
                serviceItemsHeight = Math.round(.97*(catHeight+30));
				if (curvyBrowser.isIE) {
					curvyCorners.adjust(YAHOO.util.Dom.get('categoryServiceItems'), 'style.height', serviceItemsHeight + "px");
					curvyCorners.adjust(YAHOO.util.Dom.get('searchResults_ServiceItems'), 'style.height', serviceItemsHeight + "px");
                                        curvyCorners.adjust(YAHOO.util.Dom.get('contentPageSection'),'style.height',contentHeight + "px");
                                        // TO DO: implement contentpagesection height
				} else {
	                		YAHOO.util.Dom.get('categoryServiceItems').style.height = serviceItemsHeight + "px";
	                		YAHOO.util.Dom.get('searchResults_ServiceItems').style.height = serviceItemsHeight + "px";
                        		// TO DO: implement contentpagesection height
				}
		orig_height1 = YAHOO.util.Dom.get('categoryServiceItems').style.height;
		orig_height2 = YAHOO.util.Dom.get('searchResults_ServiceItems').style.height;
	    	new_height1 = serviceItemsHeight + "px";
	    	new_height2 = serviceItemsHeight + "px";

	    	searchReturnOffset=6;
            }
    	    //YAHOO.util.Dom.get('searchReturn').style.top = -(serviceItemsHeight+searchReturnOffset)+"px";

	    if (curvyBrowser.isIE && (orig_height1 != new_height1 || orig_height2 != new_height2)) {
	    	curvyCorners.redraw();
	    }

            catalogHelper.hideMyInfo();

        }

        this.clearCurrentServiceItemLaunch = function() {
            if (catalogHelper.currentServiceItemLaunch) {
                var siLaunchPlaceHolder = YAHOO.util.Dom.get('serviceItemLaunch_Placeholder'),
                    launchDiv = catalogHelper.currentServiceItemLaunch;

                try {
                    launchDiv = launchDiv.parentNode.removeChild(launchDiv);
                } catch (e) {}
                launchDiv.style.display='none';
                // Place back into PlaceHolder
                launchDiv = siLaunchPlaceHolder.appendChild(launchDiv);
                catalogHelper.currentServiceItemLaunch=null;
            }
        }

        this.setLastCategoryAction = function(id){
            KD.utils.Util.setCookie("KD_LastCategoryAction_ID", id, 10000000);
            this.clearRequestsAction();
        }

        this.clearRequestsAction = function(){
            KD.utils.Util.deleteCookie("KD_LastRequestsAction_ID");
        }
        this.setLastRequestsAction = function(id){
            KD.utils.Util.setCookie("KD_LastRequestsAction_ID", id, 10000000);
        }

        this.reflectLastAction = function(){
            if (catalogHelper.categoriesLoaded && catalogHelper.summaryLoaded) {
                var id = KD.utils.Util.getCookie("KD_LastRequestsAction_ID");
                if (id) {
                    var el = new YAHOO.util.Dom.get(id);
                    if(el && el.id != undefined) {
                        el.onclick();
                    }
                } else {
                    id = KD.utils.Util.getCookie("KD_LastCategoryAction_ID");
				
                    if (id) {
                        el = new YAHOO.util.Dom.get(id);
                        if(el && el.id != undefined) {
                            el.onclick();
                        }
                    } else {
                        catalogHelper.setCategoryDefaultSelection();
                    }
                }
            }
        }

        this.processServiceItemSummary = function(o) {
            KD.utils.Action._addInnerHTML(o);
            var elId=o.argument[0];
            if(elId){
                if (curvyBrowser.isIE || curvyBrowser.isOp) {
                    var el = YAHOO.util.Dom.get(elId[0]);

                    var settings = {
                        tl: {
                            radius: 6
                        },
                        tr: {
                            radius: 0
                        },
                        bl: {
                            radius: 6
                        },
                        br: {
                            radius: 0
                        },
                        antiAlias: true
                    }

                    var divs = KD.utils.Util.getElementsByClassName("actionItemRow", "div", el);

                    for (var i=0; i<divs.length; i++) {
                        curvyCorners(settings, divs[i]);
                    }
                }
            }
            catalogHelper.summaryLoaded=true;
//            setTimeout('catalogHelper.reflectLastAction()',100);
        }

        this.showDetails = function(csrv) {
            window.open(KD.utils.ClientManager.webAppContextPath+'/ReviewRequest?csrv='+csrv+'&excludeByName=Review Page&reviewPage='+clientManager.themesDirectory+'reviewRequest', '_blank');
        }

        this.processServiceItems = function(o){
            KD.utils.Action._addInnerHTML(o);
            var elId=o.argument[0];

            // Move the Quick Links Section
            var page = KD.utils.Util.getElementsByClassName("templateContent", "div", document);
            var pageEl = new YAHOO.util.Element(page[0]);

            var quickLinksObj = KD.utils.Util.getElementObject("Quick Links Section", "SECTION_");

            try {
                pageEl.removeChild(quickLinksObj);

                var quickLinksHolderObj = YAHOO.util.Dom.get("quick_links_border");
                quickLinksHolderObj.appendChild(quickLinksObj);

                quickLinksObj.style.display="block";
            } catch(e) {}

            var catHeight = YAHOO.util.Dom.get('categoryItems').clientHeight;
            var contentHeight = 56 + 30 + catHeight + 30 + 15 + 20;

            if (catHeight>500) {
                YAHOO.util.Dom.get('serviceItemsHolder').style.height = catHeight+30+"px";
                var serviceItemsHeight = Math.round(.97*(catHeight+30));
                YAHOO.util.Dom.get('categoryServiceItems').style.height = serviceItemsHeight + "px";
                YAHOO.util.Dom.get('serviceItemsList_holder').style.height = serviceItemsHeight + "px";
                YAHOO.util.Dom.get('serviceItemLaunch_holder').style.height = serviceItemsHeight + "px";

		if (curvyBrowser.isIE) {

                        curvyCorners.adjust(YAHOO.util.Dom.get('contentPageSection'),'style.height',contentHeight + "px");
                        	        curvyCorners.redraw();
		} 

                	if(elId){
					if (curvyBrowser.isIE || curvyBrowser.isOp) {
						var settings = {
							tl: {radius: 4},
							tr: {radius: 4},
							bl: {radius: 4},
							br: {radius: 4},
							antiAlias: true
							}
						div = YAHOO.util.Dom.get("categoryServiceItems");
						curvyCorners(settings, div);

						div = YAHOO.util.Dom.get("quick_links_label");
						curvyCorners(settings, div);

						div = YAHOO.util.Dom.get("searchReturn");
						curvyCorners(settings, div);

						div = YAHOO.util.Dom.get("requestItemsPanel");
						curvyCorners(settings, div);

						var siLaunchPlaceHolder = YAHOO.util.Dom.get('serviceItemLaunch_Placeholder');
						divs = KD.utils.Util.getElementsByClassName("continueButton", "div", siLaunchPlaceHolder);

						for (var i=0; i<divs.length; i++) {
							curvyCorners(settings, divs[i]);
						}

					}
				} 
           
            } else {
                contentHeight = 56 + 30 + 500 + 30 + 15 + 20;
                catHeight = 500;
                YAHOO.util.Dom.get('serviceItemsHolder').style.height = catHeight+30+"px";
                var serviceItemsHeight = Math.round(.97*(catHeight+30));
                YAHOO.util.Dom.get('categoryServiceItems').style.height = serviceItemsHeight + "px";
                YAHOO.util.Dom.get('serviceItemsList_holder').style.height = serviceItemsHeight + "px";
                YAHOO.util.Dom.get('serviceItemLaunch_holder').style.height = serviceItemsHeight + "px";


                if (curvyBrowser.isIE) {
                        curvyCorners.adjust(YAHOO.util.Dom.get('contentPageSection'),'style.height',contentHeight + "px");
                       	curvyCorners.redraw();
		}

                if(elId){
					if (curvyBrowser.isIE || curvyBrowser.isOp) {
						var settings = {
							tl: {radius: 4},
							tr: {radius: 4},
							bl: {radius: 4},
							br: {radius: 4},
							antiAlias: true
							}
						div = YAHOO.util.Dom.get("categoryServiceItems");
						curvyCorners(settings, div);

						div = YAHOO.util.Dom.get("quick_links_label");
						curvyCorners(settings, div);

						div = YAHOO.util.Dom.get("searchReturn");
						curvyCorners(settings, div);

						div = YAHOO.util.Dom.get("requestItemsPanel");
						curvyCorners(settings, div);

						var siLaunchPlaceHolder = YAHOO.util.Dom.get('serviceItemLaunch_Placeholder');
						divs = KD.utils.Util.getElementsByClassName("continueButton", "div", siLaunchPlaceHolder);

						for (var i=0; i<divs.length; i++) {
							curvyCorners(settings, divs[i]);
						}

					}
				} 
              

            } 

           catalogHelper.categoriesLoaded=true;
           setTimeout('catalogHelper.reflectLastAction()',500);
        }

        this.setCategoryDefaultSelection = function() {
            var siHolder = YAHOO.util.Dom.get('serviceItemsHolder');

            var category = KD.utils.Util.getElementsByClassName('categoryItem', 'div', siHolder);
            if (category.length > 0) {
                category[0].onclick();
            }

        }
		
        this.buildDataRequestURL = function(requestName, dataRequestId, paramString, useGetList, paramString){
            if(KD.utils.Action.sdrErrors == null){
                KD.utils.Action.sdrErrors = new KD.utils.Hash();
            }

            dataRequestId=encodeURIComponent(dataRequestId);
            requestName=encodeURIComponent(requestName);
            var sessionId=encodeURIComponent(KD.utils.ClientManager.sessionId);
            var now = new Date();
            var entryParam="";
            if(useGetList == true){
                entryParam="&useGetList=true"
            }
            var path = "SimpleDataRequest?requestName="+ requestName +"&dataRequestId="+ dataRequestId +"&sessionId="+sessionId +"&"+ paramString+entryParam+"&noCache="+now.getTime();
            return path;
        }
        
        this.myCustomFormatter = function(elLiner, oRecord, oColumn, oData) {
		
            if(oColumn.getKey()=="user_indicator") {
                if (oRecord.getData('user_indicator')=="NEW_MESSAGE") {
                    var params = 'paramCustomerSurveyID='+oRecord.getData("instance_id")+'&paramVersion='+oRecord.getData("version");

                    var image = clientManager.webAppContextPath+'/'+clientManager.themesDirectory+'images/conversation_alert.png';
                    elLiner.innerHTML = ' <img width="16px" src="'+image+'" onclick="javascript:catalogHelper.showSelectedRequest(\''+oRecord.getData('instance_id')+'\',null,\''+params+'\')"/>';
                }
            }
            if(oColumn.getKey()=="name") {
                var submitType = oRecord.getData('submit_type');
                var nameStr="";
                if (KINETIC.catalog.Helper.isApprovalRequest(submitType)) {
                    nameStr = oRecord.getData('originating_form');
                } else {
                    nameStr = oRecord.getData('name');
                }

                if (nameStr.length > 25) {
                    nameStr = nameStr.substring(0,22)+"...";
                }

                nameStr = nameStr.replace(/ /g, '&nbsp;');
                elLiner.innerHTML = nameStr;
            }
            if(oColumn.getKey()=="date") {
                var dt = new Date(oRecord.getData('date'));
                elLiner.innerHTML = KD.utils.Util.formatSimpleDateTime(dt);
            }

            if(oColumn.getKey()=="validation_status") {
                var statusStr = oRecord.getData('validation_status');
				
                var notes = oRecord.getData('notes');
                if (notes.length > 35) {
                    notes = notes.substring(0,32)+"...";
                }

                if (notes.length > 0) {
                    statusStr += ' ('+notes+')';
                }
                statusStr = statusStr.replace(/ /g, '&nbsp;');
                elLiner.innerHTML = statusStr;
            }
			
            if(oColumn.getKey()=="id") {
                var URL='';
                var titleVal='';
                var validation_status = oRecord.getData('validation_status');
                var requestStatus = oRecord.getData('request_status');
                var customerStatus = oRecord.getData('customer_status');
                var submitType = oRecord.getData('submit_type');
                var ID=oRecord.getData('id');
				
                if (customerStatus=='In Progress') {
                    URL = 'DisplayPage?csrv=' + oRecord.getData('instance_id');
                    titleVal = 'Complete current In Progress Request';
                } else if (KINETIC.catalog.Helper.isApprovalRequest(submitType) && customerStatus=='Sent') {
                    URL = 'DisplayPage?csrv=' + oRecord.getData('instance_id');
                    titleVal = 'Complete approval response';
                    ID = oRecord.getData('originating_id_display');
                } else if (submitType=='Fulfillment' && customerStatus=='New') {
                    URL = 'DisplayPage?csrv=' + oRecord.getData('instance_id');
                    titleVal = 'Complete fulfilment Task';
                    ID = oRecord.getData('originating_id_display');
                } else if (KINETIC.catalog.Helper.isApprovalRequest(submitType) && customerStatus=='Completed') {
                    var params = "paramCustomerSurveyID="+oRecord.getData('instance_id')+"&paramVersion="+oRecord.getData('version');
                    URL = 'javascript:catalogHelper.showSelectedRequest("'+oRecord.getData('originating_id')+'",null,"'+params+'")';
                    titleVal = 'View request fulfillment details.';
                    ID = oRecord.getData('originating_id_display');
                } else if (customerStatus=='Completed' || customerStatus=='Closed' ) {
                    var params = "paramCustomerSurveyID="+oRecord.getData('instance_id')+"&paramVersion="+oRecord.getData('version');
                    URL = 'javascript:catalogHelper.showSelectedRequest("'+oRecord.getData('instance_id')+'",null,"'+params+'")';
                    titleVal = 'View request fulfillment details.';
                }
				
				
                elLiner.innerHTML = "<a class='requestLink' title='"+titleVal+"' href='"+URL+"'>" + ID + "</a>";
				
            }
        }
        
        this.isApprovalRequest = function (submitType) {
            return (submitType == 'Approval' || submitType == 'Approval Task')
        }
		
        this.requestsTable;

        this.showSelectedRequests = function (isOpen, isApproval, clickedEl, partial, paramString) {
            var options = {
                isOpen: isOpen,
                isApproval: isApproval,
                isActionPending: false,
                clickedEl: clickedEl,
                partial: partial,
                paramString: paramString
            };
            this._showSelectedRequests(options);
        }

        this._showSelectedRequests = function (options) {
            var isOpen, isApproval, isActionPending, clickedEl, partial, paramString;
            isOpen = options.isOpen || false;
            isApproval = options.isApproval || false;
            isActionPending = options.isActionPending || false;
            clickedEl = options.clickedEl;
            partial = options.partial;
            paramString = options.paramString;
          
            // Retrieve the custom event to get the SDR Id
            var submitType = 'Request',
                actionPending = "Not Pending",
                currentStyle = clickedEl.className,
                myPartial = 'requestsWithTasks',
                status = 'Open',
                myRequests = Dom.get('selectedServiceItems'),
                dynTextLayer = myRequests.parentNode,
                instanceId = KD.utils.Util.getIDPart(dynTextLayer.id),
                clientAction = null,
                connection = null,
                tempClass = "",
                params = "";

            if (isApproval) {
                submitType = "Approval";
            }

            if (!isOpen) {
                status = "Closed";
            }

            if (isActionPending) {
                actionPending = "Pending";
            }

            if (paramString && paramString.length > 0) {
                if (paramString.indexOf("?") === 0) {
                    paramString = paramString.slice(1);
                }
                if (paramString.indexOf("&") !== 0) {
                    paramString = '&' + paramString;
                }
                params = paramString || "";
            }
            
            if (catalogHelper.requestsTable != undefined) {
                catalogHelper.requestsTable.destroy();
            }
        	
            // Add the custom formatter to the shortcuts
            YAHOO.widget.DataTable.Formatter.myCustom = catalogHelper.myCustomFormatter;

            XPath = function() {
                var myColumnDefs = [
                {
                    key:'date',
                    label:'Date',
                    sortable:true,
                    formatter:"myCustom"
                },

                {
                    key:'name',
                    label:'Name',
                    sortable:true,
                    formatter:"myCustom"
                },

                {
                    key:'validation_status',
                    label:'Status',
                    sortable:true,
                    formatter:"myCustom"
                },

                {
                    key:'id',
                    label:'Request ID',
                    sortable:true,
                    formatter:"myCustom"
                },

                {
                    key:'user_indicator',
                    label:'',
                    sortable:true,
                    formatter:"myCustom"
                },

                {
                    key:'submit_type',
                    label:'',
                    hidden:true
                },

                {
                    key:'instance_id',
                    label:'',
                    hidden:true
                },

                {
                    key:'request_status',
                    label:'',
                    hidden:true
                },

                {
                    key:'customer_status',
                    label:'',
                    hidden:true
                },

                {
                    key:'version',
                    label:'',
                    hidden:true
                },

                {
                    key:'originating_form',
                    label:'',
                    hidden:true
                },

                {
                    key:'originating_id_display',
                    label:'',
                    hidden:true
                },

                {
                    key:'originating_id',
                    label:'',
                    hidden:true
                },

                {
                    key:'notes',
                    label:'',
                    hidden:true
                }

                ];

                var clientAction = KD.utils.ClientManager.customEvents.getItem(instanceId)[0];

                params = 'status='+status+'&submitType='+submitType+'&actionPending='+actionPending+params;
                var path = catalogHelper.buildDataRequestURL('selectedServiceItems', clientAction.actionId, '', true, params);

                var myDataSource = new YAHOO.util.DataSource(path);
                myDataSource.responseType = YAHOO.util.DataSource.TYPE_XML;
                myDataSource.useXPath = true;
                myDataSource.responseSchema = {
                    metaFields: {},
                    resultNode: 'record',
                    fields: [{
                        key:'user_indicator',
                        locator:"field[@id='User_Indicator']"
                    },

                    {
                        key:'date',
                        locator:"field[@id='Create Date']"
                    },

                    {
                        key:'name',
                        locator:"field[@id='Survey_Template_Name']"
                    },

                    {
                        key:'originating_form',
                        locator:"field[@id='Form']"
                    },

                    {
                        key:"validation_status",
                        locator:"field[@id='ValidationStatus']"
                    },

                    {
                        key:"id",
                        locator:"field[@id='CustomerSurveyID']"
                    },

                    {
                        key:"submit_type",
                        locator:"field[@id='Submit Type']",
                        hidden:true
                    },

                    {
                        key:"instance_id",
                        locator:"field[@id='CustomerSurveyInstanceId']",
                        hidden:true
                    },

                    {
                        key:"request_status",
                        locator:"field[@id='Request_Status']",
                        hidden:true
                    },

                    {
                        key:"customer_status",
                        locator:"field[@id='CustomerSurveyStatus']",
                        hidden:true
                    },

                    {
                        key:"version",
                        locator:"field[@id='Version']",
                        hidden:true
                    },

                    {
                        key:"originating_id_display",
                        locator:"field[@id='OriginatingID_Display']",
                        hidden:true
                    },

                    {
                        key:"originating_id",
                        locator:"field[@id='OriginatingID']",
                        hidden:true
                    },

                    {
                        key:"notes",
                        locator:"field[@id='NotesForCustomer']",
                        hidden:true
                    }
                    ]
                };
				
				
                var oConfigs = {
                    MSG_ERROR: 'Your session may have expired. Please refresh the page.',
                    sortedBy:{
                        key:'date',
                        dir:'desc'
                    }
                    ,
                    paginator: new YAHOO.widget.Paginator({
                        rowsPerPage: 18,
                        alwaysVisible: true
                    })
									
                };

                catalogHelper.requestsTable= new YAHOO.widget.DataTable("selectedServiceItems", myColumnDefs, myDataSource, oConfigs);
                catalogHelper.requestsTable._sId="yui-dt";

                // Subscribe to events for row selection
                catalogHelper.requestsTable.subscribe("rowMouseoverEvent", catalogHelper.requestsTable.onEventHighlightRow);
                catalogHelper.requestsTable.subscribe("rowMouseoutEvent", catalogHelper.requestsTable.onEventUnhighlightRow);
                catalogHelper.requestsTable.subscribe("rowClickEvent", catalogHelper.requestsTable.onEventSelectRow);
                catalogHelper.requestsTable.subscribe("postRenderEvent", catalogHelper.IE8Hack);

                return {
                    oDS: myDataSource,
                    oDT: catalogHelper.requestsTable
                };
            }();
        }
        // This is a hack to ensure that when the table is drawn it displays properly in IE8.
        // Without this hack, if you load the table and keep the cursor outside of the table, the table background draws but not the data.
        this.IE8Hack = function() {
            catalogHelper.requestsTable.selectRow(0);
            catalogHelper.setRequestsViewSize();
        }

        // Show a selected request in its own panel
        this.showSelectedRequest = function (rqtId, partial, paramString) {
            //Retrieve the custom event to get the SDR Id
            var myPartial = '../../'+clientManager.themesDirectory+'partials/selectedRequest',
            selReqId = 'selectedRequest',
            selReqText,
            dynTextLayer,
            sdrId,
            clientAction = null,
            connection = null,
            paramStr = "",
            params;

            if (partial && partial.length > 0) {
                myPartial = partial;
            }

            if (paramString && paramString.length > 0) {
                if (paramString.indexOf("?") === 0) {
                    paramString = paramString.slice(1);
                }
                if (paramString.indexOf("&") !== 0) {
                    paramString = '&' + paramString;
                }
                paramStr = paramString || "";
            
                // determine which task engine this service item uses:
                // if version is null: < 4.5 engine
                // if version is not null: 4.5+ engine
                params = paramStr.split("&");
                for (var i=0; i<params.length; i+=1) {
                    var param = params[i].split("=");
                    if (param && param[0] === "paramVersion") {
                        if (param[1] !== null && param[1] !== "") {
                            selReqId = 'selectedRequest';
                        }
                        break;
                    }
                }
            }

            selReqText = YAHOO.util.Dom.get(selReqId);
            if (selReqText) {
                dynTextLayer = selReqText.parentNode;
                sdrId = KD.utils.Util.getIDPart(dynTextLayer.id);

                // build up the panel to display the requested service item
                this._buildPanel(rqtId, selReqText);

                // get the service item data from the server, and update the panel body
                if (sdrId) {
                    clientAction = KD.utils.ClientManager.customEvents.getItem(sdrId)[0];//Should only have one custom event
                    connection = new KD.utils.Callback(catalogHelper.taskDetails,KD.utils.Action._addInnerHTML,['tasks_panel_body'], true);
                    KD.utils.Action.makeAsyncRequest(myPartial, clientAction.actionId, connection, paramStr, myPartial);
                } else {
                    alert("No record found");
                }
            }
        };

        this.taskDetails = function(o) {
            KD.utils.Action._addInnerHTML(o);
            var elId=o.argument[0];
            if(elId){
                if (curvyBrowser.isIE || curvyBrowser.isOp) {
                    var el = YAHOO.util.Dom.get(elId[0]);

                    var settings = {
                        tl: {
                            radius: 4
                        },
                        tr: {
                            radius: 4
                        },
                        bl: {
                            radius: 4
                        },
                        br: {
                            radius: 4
                        },
                        antiAlias: true
                    }

                    var divs = KD.utils.Util.getElementsByClassName("rounded4", "div", el);

                    for (var i=0; i<divs.length; i++) {
                        curvyCorners(settings, divs[i]);
                    }
                }
            }
        }


        this.oServiceItemPanel=null;
        this._buildPanel = function(id, elId) {
            var  panelCfg, panelBody;

            if (this.oServiceItemPanel == null) {
                var page = KD.utils.Util.getElementsByClassName("templateContent", "div", document);
                var pageEl = new YAHOO.util.Element(page[0]);
                var top = YAHOO.util.Dom.getY(pageEl)+40;
                var left = YAHOO.util.Dom.getX(pageEl)+200;

                panelCfg = {
                    width:"480px",
                    x:left,
                    y:top,
                    zIndex:10000,
                    visible:false,
                    draggable:true,
                    close:true,
                    /*modal:true,*/
                    /*constraintoviewport:true,*/
                    underlay:"shadow",
                    iframe:false
                };

                this.oServiceItemPanel = new YAHOO.widget.ResizePanel("panel_" + id, panelCfg);
                this.oServiceItemPanel.setHeader("Service Item Details");
                this.oServiceItemPanel.setBody("<div><img alt='' src='resources/catalogIcons/ajax-loader.gif' style='margin:10px;padding:0px;' /><span>Loading your service item.</span></div>");
                this.oServiceItemPanel.render(elId);

                // give the panel body an id to grab onto
                panelBody = KD.utils.Util.getElementsByClassName("bd", "div", "panel_" + id)[0];
                if (panelBody) {
                    panelBody.id = "tasks_panel_body";
                }
            } else {
                this.oServiceItemPanel.setBody("<div><img alt='' src='resources/catalogIcons/ajax-loader.gif' style='margin:10px;padding:0px;' /><span>Loading your service item.</span></div>");
            }

            // show the panel
            this.oServiceItemPanel.show();
        }
        

        this.highlightCategory = function(obj) {
            el = new YAHOO.util.Element(obj);
            el.addClass('highlightCategory');
		
        }
        this.removeHighlightCategory = function(obj) {
            el = new YAHOO.util.Element(obj);
            el.removeClass('highlightCategory');
        }
        this.highlightServiceItem = function(obj) {
            el = new YAHOO.util.Element(obj);
            el.addClass('highlightServiceItem');
		
        }
        this.removeHighlightServiceItem = function(obj) {
            el = new YAHOO.util.Element(obj);
            el.removeClass('highlightServiceItem');
        }
		
        this.addReplyHTML  = "<textarea id='replyText' cols='45' rows='3' style='margin:2px;'></textarea> <br> "+
        "<input id='replyCancelButton' type='button' class='templateButton' style='background-color:#009900;margin:2px;' value='Cancel' onclick='catalogHelper.closeReply();'></input>"+
        "<input id='replySubmitButton' type='button' class='templateButton' style='background-color:#009900;margin:2px;' value='Reply'  onclick='catalogHelper.submitReply(this);'></input>";

        this.closeReply = function() {
            var holder=YAHOO.util.Dom.get("replyHolder");
            if (holder) {
                holder.innerHTML = this.replyHolderHTML;
                this.replyLink.style.display='block';
            }
        }
		
        this.replyLink;
		
        this.showReply = function(approvalID) {
            var holder=YAHOO.util.Dom.get("replyHolder");
            if (holder) {
                this.replyHolderHTML = holder.innerHTML;
                holder.innerHTML = this.addReplyHTML;
					
                this.replyLink = YAHOO.util.Dom.get('reply_'+approvalID);
                this.replyLink.style.display='none';

                // set focus to the reply text field
                this.setFocus(YAHOO.util.Dom.get("replyText"));
            }
        }
        this.showConversation = function(approvalID) {
            var paramStr = 'Approver ID='+approvalID;
            var obj = YAHOO.util.Dom.get('a_'+approvalID);
            if (obj.innerHTML=='Show Conversation') {
                connection = new KD.utils.Callback(KD.utils.Action._addInnerHTML,KD.utils.Action._addInnerHTML,['ConversationDiv_'+approvalID], true);
                var partial = '../../'+clientManager.themesDirectory+'partials/conversationMessages';

                KD.utils.Action.makeAsyncRequest('load Conversation', 'UI000C29234E93[L5GTAa6rLBQdCoA', connection, paramStr, partial);
                obj.innerHTML='Hide Conversation';
            } else {
                conDiv = YAHOO.util.Dom.get('ConversationDiv_'+approvalID);
                conDiv.innerHTML = '';
                obj.innerHTML='Show Conversation';
            }
        }

        this.submitReply = function(obj) {
            var iFrameObj = document.getElementById('addReplyFrame');
            var submitBut;

            YAHOO.util.Dom.get("replyText").disabled=true;
            YAHOO.util.Dom.get("replyCancelButton").disabled=true;
            YAHOO.util.Dom.get("replySubmitButton").disabled=true;

            if (iFrameObj.document) { /*IE*/
                window.frames['addReplyFrame'].document.getElementById('SRVQSTN_KS001C23CC73E9ChQ9TA45CCAg4ZsB').value=iFrameObj.getAttribute('CSRV');
                window.frames['addReplyFrame'].document.getElementById('SRVQSTN_KS001C23CC73E9MBU9TA1guHAgb50B').value=iFrameObj.getAttribute('approvalid');
                window.frames['addReplyFrame'].document.getElementById('SRVQSTN_KS001C23CC73E9ZxU9TA1-KHAgsp0B').value=YAHOO.util.Dom.get('replyText').value;
                submitBut = window.frames['addReplyFrame'].document.getElementById('BUTTON_AG001C23CC73E98hM9TAvzOCAgtpsB').childNodes[0];
            } else {
                iFrameObj.contentDocument.getElementById('SRVQSTN_KS001C23CC73E9ChQ9TA45CCAg4ZsB').value=iFrameObj.getAttribute('CSRV');
                iFrameObj.contentDocument.getElementById('SRVQSTN_KS001C23CC73E9MBU9TA1guHAgb50B').value=iFrameObj.getAttribute('approvalid');
                iFrameObj.contentDocument.getElementById('SRVQSTN_KS001C23CC73E9ZxU9TA1-KHAgsp0B').value=YAHOO.util.Dom.get('replyText').value;
                submitBut = iFrameObj.contentDocument.getElementById('BUTTON_AG001C23CC73E98hM9TAvzOCAgtpsB').childNodes[1];
            }
            submitBut.click();

            document.body.style.cursor = 'wait';
            setTimeout('catalogHelper.completeReplyPost()', 1000);
        }

        this.completeReplyPost = function() {
            var iFrameObj = document.getElementById('addReplyFrame');
            var obj;
            if (iFrameObj.document) { /*IE*/
                obj =window.frames['addReplyFrame'].document.getElementById('SRVQSTN_KS001C23CC73E9ChQ9TA45CCAg4ZsB');
            } else {
                obj = iFrameObj.contentDocument.getElementById('SRVQSTN_KS001C23CC73E9ChQ9TA45CCAg4ZsB');
            }
            if (obj) {
                setTimeout('catalogHelper.completeReplyPost()', 500);
                return;
            }

            document.body.style.cursor = '';
            alert('Your reply has been submitted.');
            catalogHelper.oServiceItemPanel.hide();
			
            if (this.currentRequestAction) {
                YAHOO.util.UserAction.click(this.currentRequestAction);
            }
        }

        this.setFocus = function (el) {
            if (el) {
                try {
                    el.select();
                    el.focus();
                } catch (e) {
                    // something failed, just ignore and let the user click
                }
            }
        }
		
    }
};

var catalogHelper = KINETIC.catalog.Helper;
