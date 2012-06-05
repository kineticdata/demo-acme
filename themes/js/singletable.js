/**
 * The KINETIC global namespace object
 * @class KINETIC
 * @static
 */
if (typeof KINETIC == "undefined") {
    KINETIC = {};
}
if (typeof KINETIC.table == "undefined") {
    KINETIC.table = {};
}

if (! KINETIC.table.SingleTable){

    KINETIC.table.SingleTable = function(){
		this.referenceID;
		this.primaryTable;
		this.primaryTableID;
		this.primaryDataRequestID;
		
		this.initialize = function(referenceIDParam, primaryTableIDParam, primaryDataRequestIDParam) {
			this.referenceID = referenceIDParam;
			this.primaryTableID = primaryTableIDParam;

			if (primaryDataRequestIDParam) {
				this.primaryDataRequestID = primaryDataRequestIDParam;
			} else {
				this.primaryDataRequestID = primaryTableIDParam;
			}
		}
	
		this.initialTableLoad = function() {
			this.loadTable();
		}

		this.sortPrimaryTable = function(a,b, desc, field) {
			if ((desc && a.getData(field) <b.getData(field)) || (!desc && a.getData(field) >b.getData(field))){
				return 1;
			} else {
				return -1;
			}
		}

		this.buildDataRequestURL = function(requestName, dataRequestId, paramString, useGetList){
			if(KD.utils.Action.sdrErrors == null){
				KD.utils.Action.sdrErrors = new KD.utils.Hash();
						}
						if(paramString && paramString != "" && paramString.indexOf("&") != 0){
							paramString ="&"+paramString;
						}
						dataRequestId=encodeURIComponent(dataRequestId);
						requestName=encodeURIComponent(requestName);
						var sessionId=encodeURIComponent(KD.utils.ClientManager.sessionId);
						var now = new Date();
						var entryParam="";
						if(useGetList == true){
							entryParam="&useGetList=true"
						}
						var path = "SimpleDataRequest?requestName="+ requestName +"&dataRequestId="+ dataRequestId +"&sessionId="+sessionId +"&format="+ paramString+entryParam+"&noCache="+now.getTime();
			return path;
		}

		// sample
		this.myCustomFormatter = function(elLiner, oRecord, oColumn, oData) {
			if(oColumn.getKey()=="image") {
				elLiner.innerHTML = ' <img src="'+oRecord.getData('image')+'">';
			}
		}

		this.loadTable = function() {	
			// Add the custom formatter to the shortcuts 
			if (myCustomFormatter) {
				YAHOO.widget.DataTable.Formatter.myCustom = myCustomFormatter;
			}
			var myColumnDefs = getPrimaryTableDefs(this.referenceID);
			var myOptions = getPrimaryOptions(this.referenceID);
			
			var dynTextLayer = YAHOO.util.Dom.get(this.primaryDataRequestID).parentNode;
			var sdrId = KD.utils.Util.getIDPart(dynTextLayer.id);
			var clientAction = KD.utils.ClientManager.customEvents.getItem(sdrId)[0];					

			var path = this.buildDataRequestURL('getPrimaryData', clientAction.actionId, '', true);
			var myDataSource = new YAHOO.util.DataSource(path);
			myDataSource.responseType = YAHOO.util.DataSource.TYPE_XML;
			myDataSource.useXPath = true;
			myDataSource.responseSchema = {
				metaFields: {},
				resultNode: 'record',
			fields: getPrimaryTableFields(this.referenceID)
			};
			
			this.primaryTable= new YAHOO.widget.ScrollingDataTable(this.primaryTableID, myColumnDefs, myDataSource, myOptions);
			// Store the reference to the KINETIC.table.TwoTable instance
			// This is to allow the callback functions to have access to this instance
			this.primaryTable.containerObj = this;
			
			// Subscribe to events for row selection
			this.primaryTable.subscribe("rowMouseoverEvent", this.primaryTable.onEventHighlightRow);
			this.primaryTable.subscribe("rowMouseoutEvent", this.primaryTable.onEventUnhighlightRow);
			this.primaryTable.subscribe("rowClickEvent", this.primaryTable.onEventSelectRow);
			this.primaryTable.subscribe("rowClickEvent", rowSelected);
			this.primaryTable.hideTableMessage();
		}	
	
    }
};

