<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ include file="/WEB-INF/views/includes/taglibs.jsp"%>
<c:url var="post_url" value="/dashboard/am/addapp" />
<c:url var="static_url" value="/static" />
<c:url var="cancel_url" value="/dashboard/am/ui/_ac/gamt" />
<tiles:insertDefinition name="publisher_dashboard">
	<tiles:putAttribute name="css">
		<link rel="stylesheet" href="${static_url}/css/jquery.datetimepicker.css" />
	</tiles:putAttribute>
	<tiles:putAttribute name="maincontent">
		<form role="form" method="POST" action="${post_url}"
			class="creation-form" id="appForm">
			<div class="row">
				<div class="col-md-3">
					<h3>Create App:</h3>
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
		<script type="text/javascript">
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
			$('#appSave').click(function(event) {
				event.preventDefault();
				$("span.error").remove();
				$(".error").toggleClass("error");
				var elem;
				var errors = 0;
				if (isEmpty(elem = $('#appName'))) {
					displayError(elem,
							"Please give a name to your new app");
					errors++;
				}
				if (errors == 0) {
					$('#appForm').submit();
				}
			});
			$('#cancelButton').click(function(event){
				window.location.href = "${cancel_url}";
			});
			$(document).ready(function(){
				$("div#wrapper").css("padding-left", "0px");
			});
		</script>
	</tiles:putAttribute>
</tiles:insertDefinition>