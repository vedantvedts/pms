<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="java.util.List"%>
<%@page import="com.vts.pfms.documents.model.IGIInterfaceContent"%>
<%@page import="com.vts.pfms.documents.model.IGIInterfaceTypes"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

<title>INTERFACE TYPE MASTER</title>
<style type="text/css">
</style>
</head>
<body>

	<%
	IGIInterfaceTypes InterfaceType = (IGIInterfaceTypes) request.getAttribute("interfaceType");
	List<IGIInterfaceContent> igiInterfaceContentList = (List<IGIInterfaceContent>) request.getAttribute("interfaceContentList");
	%>
	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-2"></div>
			<div class="col-sm-8" style="top: 10px;">
				<div class="card shadow-nohover">
					<div class="card-header"
						style="background-color: #055C9D; margin-top:">
						<%
						if (InterfaceType != null) {
						%>
						<b class="text-white">Interface Type Edit </b>
						<%
						} else {
						%>
						<b class="text-white">Interface Type Add </b>
						<%
						}
						%>
					</div>
					<div class="card-body">

						<form name="myfrm" action="InterfaceTypeSubmit.htm"
							id="interfaceAdd"
							onsubmit="return confirm('Are you sure you want to submit the form?')" 
							method="POST">

							<%
							if (InterfaceType != null) {
							%>
							<div class="row">

								<div class="col-md-3">
									<div class="form-group">
										<label>Interface Type Code:<span class="mandatory"
											style="color: red;">*</span></label> <input
											class="form-control form-control" type="text"
											name="interfaceTypeCode" id="interfaceTypeCode"
											placeholder="Enter Interface Type Code" required="required"
											onchange="handleInputChange(this.value, <%=InterfaceType.getInterfaceTypeId()%>)"
											<%=InterfaceType != null ? "value=\"" + InterfaceType.getInterfaceTypeCode() + "\"" : ""%>
											maxlength="3"
											style="font-size: 15px; text-transform: uppercase;">

									</div>
								</div>

								<div class="col-md-3">
									<div class="form-group">
										<label>Interface Type:<span class="mandatory"
											style="color: red;">*</span></label> <input
											class="form-control form-control" type="text"
											name="interfaceType" id="interfaceType"
											placeholder="Enter Interface Type" required="required"
											<%if (InterfaceType != null) {%>
											value="<%=InterfaceType.getInterfaceType()!=null?StringEscapeUtils.escapeHtml4(InterfaceType.getInterfaceType()): ""%>" <%}%>
											maxlength="100"
											style="font-size: 15px; text-transform: capitalize;">
									</div>
								</div>

							</div>
							<%
							} else {
							%>
							<div class="row">

								<div class="col-md-3">
									<div class="form-group">
										<label>Interface Type Code:<span class="mandatory"
											style="color: red;">*</span></label> <input
											class="form-control form-control" type="text"
											name="interfaceTypeCode" id="interfaceTypeCode"
											placeholder="Enter Interface Type Code" required="required"
											onchange="handleInputChange(this.value,0)" maxlength="3"
											style="font-size: 15px; text-transform: uppercase;">

									</div>
								</div>

								<div class="col-md-3">
									<div class="form-group">
										<label>Interface Type:<span class="mandatory"
											style="color: red;">*</span></label> <input
											class="form-control form-control" type="text"
											name="interfaceType" id="interfaceType"
											placeholder="Enter Interface Type" required="required"
											maxlength="100"
											style="font-size: 15px; text-transform: capitalize;">
									</div>
								</div>

							</div>
							<%
							}
							%>
							<table style="width: 100%;" id="contentTable">
								<thead
									style="background-color: #055C9D; color: white; text-align: center; border: none !important;">
									<tr>
										<th style="width:; padding: 10px 5px 0px 5px;">Interface
											Content Code</th>
										<th style="width:; padding: 10px 5px 0px 5px;">Interface
											Content</th>
										<th style="width:; padding: 10px 5px 0px 5px;">Is Data
											Carrying?</th>
										<td style="width: 5%;">
											<button type="button" class=" btn btn_add_subprojects ">
												<i class="btn btn-sm fa fa-plus"
													style="color: green; padding: 0px 0px 0px 0px;"></i>
											</button>
										</td>
									</tr>
								</thead>
								<tbody>
									<%
									if (igiInterfaceContentList.size() > 0) {
										int rowIndex = 1; // Initialize row index
										for (IGIInterfaceContent content : igiInterfaceContentList) {
									%>
									<tr class="tr_clone_contents">

										<td style="width:; padding: 10px 5px 0px 5px;"><input
											type="text" class="form-control interfaceContentCode"
											name="interfaceContentCode_<%=rowIndex%>"
											id="interfaceContentCode_<%=rowIndex%>"
											placeholder="Enter Interface Content Code"
											onchange="handleInputChangeCon(this, <%=content.getInterfaceContentId()%>)"
											value="<%if (content.getInterfaceContentCode() != null) {%><%=StringEscapeUtils.escapeHtml4(content.getInterfaceContentCode())%><%}%>"
											maxlength="10"
											style="font-size: 15px; text-transform: uppercase;"
											required="required"></td>
										<td style="width:; padding: 10px 5px 0px 5px;"><input
											type="text" class="form-control form-control"
											name="interfaceContent" placeholder="Enter Interface Content"
											value="<%if (content.getInterfaceContent() != null) {%><%=StringEscapeUtils.escapeHtml4(content.getInterfaceContent())%><%}%>"
											maxlength="100"
											style="font-size: 15px; text-transform: capitalize;"
											required="required"></td>

										<td
											style="width:; padding: 10px 5px 0px 5px; text-align: center;"><label
											class="radio-inline"> <input type="radio"
												name="isDataCarrying_<%=rowIndex%>" value="Y"
												<%if ("Y".equalsIgnoreCase(content.getIsDataCarrying())) {%>
												checked <%}%> required="required">Yes
										</label> <label class="radio-inline"> <input type="radio"
												name="isDataCarrying_<%=rowIndex%>" value="N"
												<%if ("N".equalsIgnoreCase(content.getIsDataCarrying())) {%>
												checked <%}%> required="required">No
										</label></td>
										<td style="width: 5%;">
											<button type="button" class=" btn btn_rem_subprojects"
												style="margin-left: 5px;">
												<i class="btn btn-sm fa fa-minus"
													style="color: red; padding: 0px 0px 0px 0px;"></i>
											</button>
										</td>
									</tr>
									<%
									rowIndex++;
									}
									} else {
									%>
									<tr class="tr_clone_contents">

										<td style="width:; padding: 10px 5px 0px 5px;"><input
											type="text" class="form-control interfaceContentCode"
											name="interfaceContentCode_1" id="interfaceContentCode_1"
											placeholder="Enter Interface Content Code" maxlength="10"
											onchange="handleInputChangeCon(this, 0)"
											style="font-size: 15px; text-transform: uppercase;"
											required="required"></td>
										<td style="width:; padding: 10px 5px 0px 5px;"><input
											type="text" class="form-control form-control"
											name="interfaceContent" placeholder="Enter Interface Content"
											maxlength="100" style="font-size: 15px;" required="required"></td>

										<td
											style="width:; padding: 10px 5px 0px 5px; text-align: center;"><label
											class="radio-inline"> <input type="radio"
												name="isDataCarrying_1" value="Y" required="required">Yes
										</label> <label class="radio-inline"> <input type="radio"
												name="isDataCarrying_1" value="N">No
										</label></td>
										<td style="width: 5%;">
											<button type="button" class=" btn btn_rem_subprojects"
												style="margin-left: 5px;">
												<i class="btn btn-sm fa fa-minus"
													style="color: red; padding: 0px 0px 0px 0px;"></i>
											</button>
										</td>
									</tr>
									<%
									}
									%>
								</tbody>
							</table>

							<div align="center" style="margin-top: 15px;">
								<%
								if (InterfaceType != null) {
								%>
								<button type="submit" class="btn btn-sm btn-warning edit"
									name="action" value="Edit" style="align-self: center;">UPDATE</button>
								<input type="hidden" name="interfaceTypeId"
									value="<%=InterfaceType.getInterfaceTypeId()!=null?StringEscapeUtils.escapeHtml4(InterfaceType.getInterfaceType()): ""%>" />
								<%
								} else {
								%>
								<button type="submit" class="btn btn-sm submit" name="action"
									value="Add" style="align-self: center;">SUBMIT</button>
								<%
								}
								%>

								<a class="btn  btn-sm  back" href="InterfaceTypeMaster.htm">BACK</a>
							</div>

							<input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}" />
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>

<script type="text/javascript">

$("#contentTable").on('click', '.btn_add_subprojects', function () {
    var $tr = $('.tr_clone_contents').last();
    var $clone = $tr.clone();

    // Clear all non-radio inputs
    $clone.find("input:not([type='radio'])").val("");

    // Count current rows
    var rowCount = $("#contentTable tbody .tr_clone_contents").length + 1;

    // Update radio button names
    $clone.find("input[type='radio']").each(function () {
        var baseName = $(this).attr('name').split('_')[0];
        $(this).attr('name', baseName + '_' + rowCount);
        $(this).prop('checked', false);
    });

    // Update interfaceContentCode name and/or id
    $clone.find(".interfaceContentCode").each(function () {
        $(this).attr('name', 'interfaceContentCode_' + rowCount);
        $(this).attr('id', 'interfaceContentCode_' + rowCount);       
    });

    // Insert cloned row after current
    $tr.after($clone);
});

	$("#contentTable").on('click', '.btn_rem_subprojects', function() {

		var cl = $('.tr_clone_contents').length;

		if (cl > 1) {
			var $tr = $(this).closest('.tr_clone_contents');
			$tr.remove();
		}
	});
	
	function handleInputChange(value,interfaceId) {
	    var uppercasedValue = value.trim().toUpperCase();
	    $('#interfaceTypeCode').val(uppercasedValue);

	    if (uppercasedValue.length ===3) {
	        $.ajax({
	            type: "GET",
	            url: "InterfaceAddCheck.htm",
	            data: {
	                interfaceTypeCode: uppercasedValue,
	                interfaceId: interfaceId
	            },
	            datatype: 'json',
	            success: function(result) {
	                var ajaxresult = JSON.parse(result); 

	                // Check if the group code already exists
	                if (ajaxresult[0] >= 1) {
	                	 $('#interfaceTypeCode').val('');
	                    alert('Interface Type Code Already Exists');
	                }
	               
	            },
	            error: function() {
	                alert('An error occurred while checking the group code.');
	            }
	        });
	    }
	}
	
	function handleInputChangeCon(inputElement,contentId) {
		
		 var input = $(inputElement);
	    var uppercasedValue = input.val().trim().toUpperCase();
	    input.val(uppercasedValue);
	    let duplicate = false;

	    $(".interfaceContentCode").each(function () {
	        let otherValue = $(this).val().trim().toUpperCase();

	        // Skip if it's the same input field
	        if (this !== inputElement && otherValue === uppercasedValue) {
	            duplicate = true;
	            return false; 
	        }
	    });

	    if (duplicate) {
	        alert("Duplicate Interface Content Code found. Each code must be unique.");
	        input.val('');
	        return;
	    }
	    
	    if (uppercasedValue.length >= 2) {
	        $.ajax({
	            type: "GET",
	            url: "InterfaceContentAddCheck.htm",
	            data: {
	            	interfaceContentCode: uppercasedValue,
	            	contentId: contentId
	            },
	            datatype: 'json',
	            success: function(result) {
	                var ajaxresult = JSON.parse(result); 

	                // Check if the group code already exists
	                if (ajaxresult[0] >= 1) {
	                	input.val(''); 
	                    alert('Interface Content Code Already Exists');
	                }
	            },
	            error: function() {
	                alert('An error occurred while checking the group code.');
	            }
	        });
	    }
	}
	
</script>
</html>

