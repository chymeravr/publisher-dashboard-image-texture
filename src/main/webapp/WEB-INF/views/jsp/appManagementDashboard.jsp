<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ include file="/WEB-INF/views/includes/taglibs.jsp"%>
<c:url var="static_url" value="/static" />
<tiles:insertDefinition name="publisher_dashboard">
	<tiles:putAttribute name="sidebar">
		<div id="sidebar-wrapper">
			<div id="allApps" class="list-heading pointer-on-hover">All
				Apps</div>
			<ul class="sidebar-nav">
				<c:forEach var="app" items="${appTree}">
					<li class="sidebar pointer-on-hover" id="app_${app.appId}">${app.name}</li>
				</c:forEach>
				<!-- 				<li class="sidebar-brand sidebar"><a href="#">Home</a></li> -->
			</ul>
		</div>
	</tiles:putAttribute>
	<tiles:putAttribute name="topbar">
		<ul id="topbar" class="nav nav-tabs">
			<li id="app" class="active topbar"><a href="#">App</a></li>
			<li id="adunit" class="topbar"><a href="#">Ad Unit</a></li>
			<li id="adinstance" class="topbar"><a href="#">Instance</a></li>
		</ul>
	</tiles:putAttribute>
	<tiles:putAttribute name="maincontent">
		<h2>Bordered Table</h2>
		<div class="table-action-list">
			<div class="btn btn-success table-action-button" id="addButton">+
				App</div>
			<div class="dropdown table-action-button">
				<button class="btn btn-default dropdown-toggle" type="button"
					id="rowActionDropdownMenu" data-toggle="dropdown"
					aria-haspopup="true" aria-expanded="true">
					Action <span class="caret"></span>
				</button>
				<ul class="dropdown-menu" aria-labelledby="rowActionDropdownMenu">
					<li><a href="#" id="rowActivate">Activate</a></li>
					<li><a href="#" id="rowDeactivate">Deactivate</a></li>
					<li><a href="#" id="rowDelete">Remove</a></li>
				</ul>
			</div>
		</div>
		<div class="main-table-container">
			<p></p>
			<table id="dataTable">
			</table>
		</div>
	</tiles:putAttribute>
	<tiles:putAttribute name="css">
		<link rel="stylesheet"
			href="${static_url}/bootstrap-table-master/dist/bootstrap-table.min.css" />
		<style>
ul.sidebar-sub-nav {
	margin-left: 10px;
}
</style>
	</tiles:putAttribute>
	<tiles:putAttribute name="js">
		<script
			src="${static_url}/bootstrap-table-master/dist/bootstrap-table.min.js"></script>
		<script src="${static_url}/js/common.functions.js"></script>
		<script type="text/javascript">
			var sidebarState = "app";
			var topbarState = "app";
			var selectedAppId;
			var selectedAdUnitId;
			var wrapperPadding = $("div#wrapper").css("padding-left");
			var advertiserId = "3234";
			var actionUrl = "/publisher/dashboard/am/ui/_ac";
			var dataUrl = "/publisher/dashboard/am/data/_ac";
			var rowActionUrl = "/publisher/dashboard/cm" + "/rowaction";//perform data row action
			function appNameFormatter(value, row) {
				return "<a class='app' href='#' id='" + row.appId + "'>"
						+ row.appName + "</a>";
			}
			function adUnitNameFormatter(value, row) {
				return "<a class='adunit' href='#' id='" + row.adUnitId + "'>"
						+ row.adUnitName + "</a>";
			}
			function adFormatter(value, row) {
				return "<h4 class='ad' id='"+row.adId+"'>"
						+ row.adName
						+ "</h4><img style='width:100px'  src='" + row.adImageUrl + "' />";
			}
			function getAndDisplayData() {
				if (topbarState === "app") {
					var url = dataUrl + "/gad";
					$('#dataTable').bootstrapTable('destroy').bootstrapTable({
						method : 'get',
						url : url,
						striped : false,
						pagination : false,
						pageSize : 50,
						pageList : [ 10, 25, 50, 100, 200 ],
						search : false,
						showColumns : false,
						showRefresh : false,
						minimumCountColumns : 2,
						columns : [ {
							field : 'apid',
							visible : false
						}, {
							field : 'state',
							checkbox : true
						}, {
							field : 'appName',
							title : 'App',
							align : 'left',
							valign : 'middle',
							formatter : appNameFormatter
						}, {
							field : 'impressions',
							title : 'Impressions',
							align : 'left',
							valign : 'middle'
						}, {
							field : 'effectiveImpressions',
							title : 'Effective Impressions',
							align : 'left',
							valign : 'middle'
						}, {
							field : 'earnings',
							title : 'Earnings',
							align : 'left',
							valign : 'middle'
						} ]
					});
				} else if (topbarState === "adunit") {
					var url = dataUrl + "/gaud";
					if (sidebarState === "adunit")
						url += "?appId=" + selectedAppId;
					var showApp = false;
					if (sidebarState === "app")
						showApp = true;
					$('#dataTable').bootstrapTable('destroy').bootstrapTable({
						method : 'get',
						url : url,
						striped : false,
						pagination : false,
						pageSize : 50,
						pageList : [ 10, 25, 50, 100, 200 ],
						search : false,
						showColumns : false,
						showRefresh : false,
						minimumCountColumns : 2,
						columns : [ {
							field : 'appId',
							visible : false
						}, {
							field : 'adUnitId',
							visible : false
						}, {
							field : 'state',
							checkbox : true
						}, {
							field : 'adUnitName',
							title : 'Ad Unit',
							align : 'left',
							valign : 'middle',
							formatter : adUnitNameFormatter
						}, {
							field : 'appName',
							title : 'App',
							align : 'left',
							valign : 'middle',
							formatter : appNameFormatter,
							visible : showApp
						}, {
							field : 'adUnitType',
							title : 'Ad Unit Type',
							align : 'left',
							valign : 'middle'
						}, {
							field : 'impressions',
							title : 'Impressions',
							align : 'left',
							valign : 'middle'
						}, {
							field : 'effectiveImpressions',
							title : 'E Impressions',
							align : 'left',
							valign : 'middle'
						}, {
							field : 'earnings',
							title : 'Earnings',
							align : 'left',
							valign : 'middle'
						} ]
					});

				} else if (topbarState === "ad") {
					var url = dataUrl + "/gaad";
					if (sidebarState === "ad")
						url += "?agid=" + selectedAdGroupId;
					else if (sidebarState === "adgroup")
						url += "?cid=" + selectedCampaignId;
					var showCampaign = false;
					var showAdGroup = false;
					if (sidebarState === "campaign") {
						showCampaign = true;
						showAdGroup = true;
					}
					if (sidebarState === "adgroup")
						showAdGroup = true;
					$('#dataTable').bootstrapTable('destroy').bootstrapTable({
						method : 'get',
						url : url,
						striped : false,
						pagination : false,
						pageSize : 50,
						pageList : [ 10, 25, 50, 100, 200 ],
						search : false,
						showColumns : false,
						showRefresh : false,
						minimumCountColumns : 2,
						columns : [ {
							field : 'cid',
							visible : false
						}, {
							field : 'agid',
							visible : false
						}, {
							field : 'adid',
							visible : false
						}, {
							field : 'state',
							checkbox : true
						}, {
							field : 'adName',
							title : 'Ad',
							align : 'left',
							valign : 'middle',
							formatter : adFormatter
						}, {
							field : 'adGroupName',
							title : 'AdGroup',
							align : 'left',
							valign : 'middle',
							formatter : adgroupNameFormatter,
							visible : showAdGroup
						}, {
							field : 'campaignName',
							title : 'Campaign',
							align : 'left',
							valign : 'middle',
							formatter : campaignNameFormatter,
							visible : showCampaign
						}, {
							field : 'interaction',
							title : 'Interaction',
							align : 'left',
							valign : 'middle'
						}, {
							field : 'interactionRate',
							title : 'Interaction Rate',
							align : 'left',
							valign : 'middle'
						}, {
							field : 'avgCost',
							title : 'Avg. Cost',
							align : 'left',
							valign : 'middle'
						}, {
							field : 'cost',
							title : 'cost',
							align : 'left',
							valign : 'middle'
						} ]
					});
				}
			}
			function rowAction(action){
				var ids = [];
				var target = "";
				var url = rowActionUrl;
				if(topbarState==="app"){/*determine the target for the action*/
					$("table#dataTable tbody input:checked").each(function(){
						ids.push($(this).parent().parent().find(".app").attr("id"));
					});
					target="app";
				}
				else if(topbarState==="adunit"){
					$("table#dataTable tbody input:checked").each(function(){
						ids.push($(this).parent().parent().find(".adunit").attr("id"));
					});	
					target="adunit";
				}
				else if(topbarState==="ad"){
					$("table#dataTable tbody input:checked").each(function(){
						ids.push($(this).parent().parent().find(".ad").attr("id"));
					});
					target="ad";
				}
				var jsonObj = new Object();
				jsonObj.action = action;
				jsonObj.target = target;
				jsonObj.idList = ids;
				$.ajax({
					url: url,
					success: rowActionSuccess,
					fail: rowActionFail,
					method: "POST",
					data: JSON.stringify(jsonObj),
					contentType: "application/json"
				});
				function rowActionSuccess(data){
					if(action === "delete")
						displayQuickNotification("Removed", 3000);
					if(action === "activate")
						displayQuickNotification("Action not supported currently", 3000);
					if(action === "deactivate")
						displayQuickNotification("Action no supported currently", 3000);
					getAndDisplayData();
				}
				function rowActionFail(){
					
				}
			}
			$(document).ready(
					function() {
						$("#addButton").click(function(event) {
							var url = "";
							/*function success(data){
								$("div#sidebar-wrapper").hide();
								$("ul#topbar").hide();
								$("div#wrapper").css("padding-left", "0px");
								$("div#maincontent").html(data);
								
							}
							function fail(){
								
							}*/
							if (topbarState === "app") {
								var url = actionUrl + "/gapf";
								window.location.href = url;
								/*$.ajax({
									url: url,
									success: success,
									fail: fail,
									method: "GET"
								});*/
							} else if (topbarState === "adunit") {
								var url = actionUrl + "/gauf";
								if (sidebarState === "adunit")
									url += "?appid=" + selectedAppId;
								window.location.href = url;
							} else if (topbarState === "instance") {
								var url = actionUrl + "/gaif";
								if (sidebarState === "instance")
									url += "?auid=" + selectedAdUnitId;
								else if (sidebarState === "adunit")
									url += "?appid=" + selectedAppId;
								window.location.href = url;
							}
						});
						$("li.sidebar").click(
								function(event) {
									$("li.topbar").removeClass("active");
									$("ul#topbar > li").show();
									$("li#app").hide();
									$("li#adunit").addClass("active");
									sidebarState = "adunit";
									topbarState = "adunit";
									$("#addButton").html("+ AdUnit");
									selectedAppId = $(this).attr("id")
											.split("_")[1];
									getAndDisplayData();
								});
						$("li.sidebar-sub").click(
								function(event) {
									$("li.topbar").removeClass("active");
									$("ul#topbar > li").show();
									$("li#app").hide();
									$("li#adunit").hide();
									$("li#instanc").addClass("active");
									sidebarState = "instance";
									topbarState = "instance";
									selectedAdUnitId = $(this).attr("id")
											.split("_")[1];
									getAndDisplayData();
								});
						$("div#allApps").click(function(event) {
							sidebarState = "app";
							$("ul#topbar > li").show();
							getAndDisplayData();
						})
						$("li#app").click(function(event) {
							$("li.topbar").removeClass("active");
							$(this).addClass("active");
							topbarState = "app";
							$("#addButton").html("+ App");
							getAndDisplayData();
						});
						$("li#adunit").click(function(event) {
							$("li.topbar").removeClass("active");
							$(this).addClass("active");
							topbarState = "adunit";
							$("#addButton").html("+ AdUnit");
							getAndDisplayData();
						});
						$("li#ad").click(function(event) {
							$("li.topbar").removeClass("active");
							$(this).addClass("active");
							topbarState = "instance";
							getAndDisplayData();
						});
						$("a#rowActivate").click(function(event){
							rowAction("activate");
						});
						$("a#rowDeactivate").click(function(event) {
							rowAction("deactivate");
						});
						$("a#rowDelete").click(function(event) {
							rowAction("delete");
						});
						$(document).on("click", "a.app", function(event) {
							event.preventDefault();
							$("li.topbar").removeClass("active");
							$("li#app").hide();
							$("li#adunit").addClass("active");
							topbarState = "adunit";
							sidebarState = "adunit";
							selectedAppId = $(this).attr("id");
							getAndDisplayData();
							$("#addButton").html("+ AdUnit");
						});
						$(document).on("click", "a.adunit", function(event) {
							return;
							event.preventDefault();
							$("li.topbar").removeClass("active");
							$("li#app").hide();
							$("li#adunit").hide();
							$("li#instance").addClass("active");
							topbarState = "instance";
							sidebarState = "instance";
							selectedAdUnitId = $(this).attr("id");
							getAndDisplayData();
						});
						getAndDisplayData();
					});
		</script>
	</tiles:putAttribute>
</tiles:insertDefinition>