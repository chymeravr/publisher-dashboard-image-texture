<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ include file="/WEB-INF/views/includes/taglibs.jsp"%>
<c:url var="post_url" value="/dashboard/am/addApp" />
<c:url var="static_url" value="/static" />
<tiles:insertDefinition name="advertiser_dashboard">
	<tiles:putAttribute name="css">
		<link rel="stylesheet" href="${static_url}/css/jquery.datetimepicker.css" />
	</tiles:putAttribute>
	<tiles:putAttribute name="maincontent">
		<form role="form" method="POST" action="${post_url}"
			class="creation-form" id="appForm">
			<div class="row">
				<div class="col-md-3">
					<h3>Add app:</h3>
				</div>
			</div>
			<hr class="medium" />
			<div class="row">
				<div class="col-md-2 right-align">
					<label for="appName">App Name</label>
				</div>
				<div class="col-md-3">
					<input class="form-control" name="name" id="appName"
						type="text" placeholder="App#1" />
				</div>
			</div>
			<hr class="medium" />
			<div class="row">
				<div class="col-md-1">
					<input type="submit" class="btn btn-md btn-primary btn-block" id="appSave" value="Save" />
				</div>
				<div class="col-md-1">
					<div class="btn btn-md btn-warning btn-block" id="cancelButton">Cancel</div>
				</div>
			</div>
		</form>
	</tiles:putAttribute>
	<tiles:putAttribute name="js">			
		<script type="text/javascript"
			src="${static_url}/js/jquery.datetimepicker.full.min.js"
			charset="UTF-8"></script>
		<script type="text/javascript">
			$(document).ready(function(){
				/********* Calender Event Handling ***********/
				var dateLogic = function(currentDateTime) {
					if (currentDateTime && currentDateTime.getDay() == 6) {
						this.setOptions({
							minTime : '11:00'
						});
					} else
						this.setOptions({
							minTime : '8:00'
						});
				};
				/************** Form Checking ***************/
				function displayError(elem, errorMsg) {
					$("<span>" + errorMsg + "</span>").insertAfter(elem)
							.toggleClass("error");
					elem.addClass("error");
				}
				function isEmpty(elem) {
					if (!elem.val())
						return true;
					else
						return false;
				}
				function isPositiveDecimal(elem) {
					var number = elem.val();
					var pattern = /^[0-9]+([,.][0-9]+)?$/;
					var isnum = pattern.test(number);
					if (!isnum)
						return false;
					var floatnum = parseFloat(number);
					if (floatnum > 0)
						return true;
					else
						return false;
				}
				$('#campaignSave').click(function(event) {
					event.preventDefault();
					$("span.error").remove();
					$(".error").toggleClass("error");
	
					var elem;
					var errors = 0;
					if (isEmpty(elem = $('#campaignName'))) {
						displayError(elem,
								"Please give a name to your new campaign");
						errors++;
					}
					if (isEmpty(elem = $('#dailyBudget'))) {
						displayError(elem, "Budget cannot be empty");
						errors++;
					}
					if (!isPositiveDecimal(elem = $('#dailyBudget'))) {
						displayError(elem,
								"Please enter a valid non-zero amount");
						errors++;
					}
					if (isEmpty(elem = $('#startDate'))) {
						displayError(elem,
								"Please select a date and time");
						errors++;
					}
					if (isEmpty(elem = $('#endDate'))) {
						displayError(elem,
								"Please select a date and time");
						errors++;
					}
					if (errors == 0) {
						$('#campaignForm').submit();
					}
				});
				$('#cancelButton').click(function(event){
					window.location.href = "/advertiser/dashboard/cm/ui/_ac/gcmt";
				});
					$("div#wrapper").css("padding-left", "0px");
			});
		</script>
	</tiles:putAttribute>
</tiles:insertDefinition>