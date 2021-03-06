<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ include file="/WEB-INF/views/includes/taglibs.jsp"%>
<c:url var="post_url" value="/dashboard/am/addAdUnit" />
<c:url var="static_url" value="/static" />
<c:url var="cancel_url" value="/dashboard/am/ui/_ac/gamt" />

<tiles:insertDefinition name="publisher_dashboard">
	<tiles:putAttribute name="maincontent">
		<form role="form" method="POST" action="${post_url}"
			class="creation-form" id="adUnitForm">
			<div class="row">
				<div class="col-md-3">
					<h3>Create Ad Unit:</h3>
				</div>
			</div>
			<hr class="medium" />
			<c:choose>
				<c:when test="${empty appId}">
					<div class="row">
						<div class="col-md-2 right-align">
							<label for="app">Select App</label>
						</div>
						<div class="col-md-3">
							<select class="form-control" name="app.appId"
								id="app">
								<c:forEach var="item" items="${apps}" varStatus="loop">
									<option value="${item.appId}">${item.name}</option>
								</c:forEach>
							</select>
						</div>
					</div>
				</c:when>
				<c:otherwise>
					<input name="app.appId" type="hidden" value="${appId}" />
				</c:otherwise>
			</c:choose>
			<div class="row">
				<div class="col-md-2 right-align">
					<label for="adUnitName">Ad Unit Name</label>
				</div>
				<div class="col-md-3">
					<input class="form-control" name="name" id="adUnitName"
						type="text" placeholder="Ad Unit #1" />
				</div>
			</div>
			<div class="row">
				<div class="col-md-2 right-align">
					<label for="adType">Ad Unit Type</label>
				</div>
				<div class="col-md-3">
					<select class="form-control" name="adType" id="adType">
						<c:forEach var="item" items="${adTypeNames}" varStatus="loop">
							<option value="${item}">${item}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			<div class="row">
				<div class="col-md-2 right-align">
					<label for="resolution">Image Resolution</label>
				</div>
				<div class="col-md-3">
					<select class="form-control" name="resolution" id="resolution">
						<c:forEach var="item" items="${textureImageFormats}">
							<option value="${item.width}x${item.height}">${item.width} x ${item.height}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			<input type="hidden" name="resolutionWidth" id="resolutionWidth" value="" />
			<input type="hidden" name="resolutionHeight" id="resolutionHeight" value="" />
			<div class="row">
				<div class="col-md-1">
					<input type="submit" class="btn btn-md btn-primary btn-block"
						id="adUnitSave" value="Save" />
				</div>
				<div class="col-md-1">
					<div class="btn btn-md btn-warning btn-block" id="cancelButton">Cancel</div>
				</div>
			</div>
		</form>
	</tiles:putAttribute>
	<tiles:putAttribute name="js">
		<script type="text/javascript">
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
			$('#adUnitSave').click(function(event) {
				event.preventDefault();
				$("span.error").remove();
				$(".error").toggleClass("error");
	
				var elem;
				var errors = 0;
				if (isEmpty(elem = $('#adUnitName'))) {
					displayError(elem,
							"Please give a name to your new ad unit");
					errors++;
				}
				//fill resolution data
				var resolutionData = $("select#resolution").val();
				resolutionWidth = resolutionData.split("x")[0];
				resolutionHeight = resolutionData.split("x")[1];
				$("input#resolutionWidth").val(resolutionWidth);
				$("input#resolutionHeight").val(resolutionHeight);
				if (errors == 0) {
					$('#adUnitForm').submit();
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