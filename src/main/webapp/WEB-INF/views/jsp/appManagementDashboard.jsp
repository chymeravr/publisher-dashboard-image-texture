<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ include file="/WEB-INF/views/includes/taglibs.jsp"%>
<tiles:insertDefinition name="advertiser_dashboard">
	<tiles:putAttribute name="sidebar">
		<div id="sidebar-wrapper">
			<div id="allApps" class="list-heading pointer-on-hover">All
				Apps</div>
			<ul class="sidebar-nav">
				<c:forEach var="app" items="${appTree}">
					<li class="sidebar pointer-on-hover"
						id="app_${app.appId}">${app.name}</li>
				</c:forEach>
				<!-- 				<li class="sidebar-brand sidebar"><a href="#">Home</a></li> -->
			</ul>
		</div>
	</tiles:putAttribute>
	<tiles:putAttribute name="maincontent">
		<h2>Bordered Table</h2>
		<div class="btn btn-success" id="addButton">+ App</div>
		<div class="main-table-container">
			<p></p>
			<table id="dataTable" class="table table-bordered table-striped">
				<thead>
					<tr>
						<th class="campaign">Campaign</th>
						<th class="budget">Budget</th>
						<th class="impr">Impr</th>
						<th class="interactions">Interactions</th>
						<th class="interaction-rate">Interaction rate</th>
						<th class="avg-cost">Avg. Cost</th>
						<th class="cost">Cost</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td class="campaign">Campaign</td>
						<td class="budget">100</td>
						<td class="impr">1000</td>
						<td class="interactions">0.6</td>
						<td class="interaction-rate">13</td>
						<td class="avg-cost">13</td>
						<td class="cost">300</td>
					</tr>
					<tr>
						<td class="campaign">Campaign</td>
						<td class="budget">100</td>
						<td class="impr">1000</td>
						<td class="interactions">0.6</td>
						<td class="interaction-rate">13</td>
						<td class="avg-cost">13</td>
						<td class="cost">300</td>
					</tr>
					<tr>
						<td class="campaign">Campaign</td>
						<td class="budget">100</td>
						<td class="impr">1000</td>
						<td class="interactions">0.6</td>
						<td class="interaction-rate">13</td>
						<td class="avg-cost">13</td>
						<td class="cost">300</td>
					</tr>
				</tbody>
			</table>
		</div>
	</tiles:putAttribute>
	<tiles:putAttribute name="css">
		<style>
ul.sidebar-sub-nav {
	margin-left: 10px;
}
</style>
	</tiles:putAttribute>
	<tiles:putAttribute name="js">
		<script type="text/javascript">
			var sidebarState = "app";
			var selectedAppId;
			var wrapperPadding = $("div#wrapper").css("padding-left");
			var actionUrl = "/publisher/dashboard/am/ui/_ac";
			var dataUrl = "/publisher/dashboard/am/data/_ac";
			$(document).ready(function(){
				function getAndDisplayData(){
					function fail(){
						
					}
					if(topbarState === "campaign"){
						var url = dataUrl + "/gcd";
						$.ajax({
							url: url,
							success: campaignSuccess,
							fail: fail,
							method: "GET"
						});
						function campaignSuccess(data){
							var html="";
							html += 
								"<thead>" +
									"<tr>" +
										"<th>Campaign</th>" +
										"<th>Budget</th>" +
										"<th>Interactions</th>" +
										"<th>Interaction rate</th>"+
										"<th>Avg. Cost</th>"+
										"<th>Cost</th>"+
									"</tr>"+
								"</thead>";
							html += "<tbody>";
							for(var i=0; i<data.length; i++){
								var dto = data[i];
								var id=dto.cid;
								html +=
									"<tr>" +
										"<td><a class='campaign' href='#' id='" + id + "'>" + dto.campaignName + "</a></td>" +
										"<td>"+ dto.budget + "</td>" +
										"<td>" + dto.interaction + "</td>" +
										"<td>" + dto.interactionRate + "</td>" +
										"<td>" + dto.avgCost + "</td>" +
										"<td>" + dto.cost + "</td>"
									"</tr>";
							}
							html += "</tbody>";
							$("table#dataTable").html(html);
						}
					}
					else if(topbarState === "adgroup"){
						var url = dataUrl + "/gagd";
						if(sidebarState === "adgroup")
							url += "?cid="+selectedCampaignId;
						$.ajax({
							url: url,
							success: adGroupSuccess,
							fail: fail,
							method: "GET"
						});
						function adGroupSuccess(data){
							var html="";
							var campaignHeader = "";								
							if(sidebarState === "campaign")
								campaignHeader = "<th>Campaign</th>";	
							html += 
								"<thead>" +
									"<tr>" +
										"<th>AdGroup</th>" +
										campaignHeader +
										"<th>Bid</th>" +
										"<th>Interactions</th>" +
										"<th>Interaction rate</th>"+
										"<th>Avg. Cost</th>"+
										"<th>Cost</th>"+
									"</tr>"+
								"</thead>";
							html += "<tbody>";
							for(var i=0; i<data.length; i++){
								var dto = data[i];
								var cid = dto.cid;
								var agid = dto.agid;
								var campaignData = "";								
								if(sidebarState === "campaign")
									campaignData = "<td><a class='campaign' href='#' id='" + cid + "'>" + dto.campaignName + "</a></td>";	
								html +=
									"<tr>" +
										"<td><a class='adgroup' href='#' id='" + agid + "'>" + dto.adGroupName + "</a></td>" +
										campaignData +
										"<td>"+ dto.bid + "</td>" +
										"<td>" + dto.interaction + "</td>" +
										"<td>" + dto.interactionRate + "</td>" +
										"<td>" + dto.avgCost + "</td>" +
										"<td>" + dto.cost + "</td>"
									"</tr>";
							}
							html += "</tbody>";
							$("table#dataTable").html(html);
						}
					}
					else if(topbarState === "ad"){
						var url = dataUrl + "/gaad";
						if(sidebarState === "ad")
							url += "?agid="+selectedAdGroupId;
						else if(sidebarState === "adgroup")
							url += "?cid="+selectedCampaignId;
						$.ajax({
							url: url,
							success: adSuccess,
							fail: fail,
							method: "GET"
						});
						function adSuccess(data){
							var html="";
							var campaignHeader = "";
							var adGroupHeader = "";								
							if(sidebarState === "campaign"){
								campaignHeader = "<th>Campaign</th>";
								adGroupHeader = "<th>Ad Group</th>";
							}
							if(sidebarState === "adgroup")
								adGroupHeader = "<th>Ad Group</th>";
							html += 
								"<thead>" +
									"<tr>" +
										"<th>Ad</th>" +
										adGroupHeader +
										campaignHeader +
										"<th>Interactions</th>" +
										"<th>Interaction rate</th>"+
										"<th>Avg. Cost</th>"+
										"<th>Cost</th>"+
									"</tr>"+
								"</thead>";
							html += "<tbody>";
							for(var i=0; i<data.length; i++){
								var dto = data[i];
								var cid = dto.cid;
								var agid = dto.agid;
								var campaignData = "";
								var adGroupData = "";								
								if(sidebarState === "campaign"){
									campaignData = "<td><a class='campaign' href='#' id='" + cid + "'>" + dto.campaignName + "</a></td>";
									adGroupData = "<td><a class='adgroup' href='#' id='" + agid + "' >" + dto.adGroupName + "</a></td>";
								}
								if(sidebarState === "adgroup")
									adGroupData = "<td><a class='adgroup' href='#' id='" + agid + "' >" + dto.adGroupName + "</a></td>";
								html +=
									"<tr>" +
										"<td><h4>" + dto.adName + "</h4><img style='width:100px'  src='" + dto.adImageUrl + "' /></td>" +
										campaignData +
										adGroupData +
										"<td>" + dto.interaction + "</td>" +
										"<td>" + dto.interactionRate + "</td>" +
										"<td>" + dto.avgCost + "</td>" +
										"<td>" + dto.cost + "</td>"
									"</tr>";
							}
							html += "</tbody>";
							$("table#dataTable").html(html);
						}
					}
				}
				$("#addButton").click(function(event){
					var url = "";
					if(sidebarState === "app"){
						var url = actionUrl + "/gapf";
						window.location.href = url;
					}
					else if(sidebarState === "adUnit"){
						var url = actionUrl + "/gauf";
						url += "?aid="+selectedAppId;
						window.location.href = url;
					}
				});
				$("li.sidebar").click(function(event){
					$(this).addClass("active");
					sidebarState = "adUnit";
					$("#addButton").html("+ AdUnit");
					selectedAppId = $(this).attr("id").split("_")[1];
					getAndDisplayData();
				});
				$("div#allApps").click(function(event){
					sidebarState = "app";
					getAndDisplayData();
				});
				getAndDisplayData();
			});
		</script>
	</tiles:putAttribute>
</tiles:insertDefinition>