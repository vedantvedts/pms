<%@page import="java.util.ArrayList"%>
<%@page import="com.vts.pfms.roadmap.model.AnnualTargets"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="java.util.stream.Collector"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="com.vts.pfms.roadmap.model.RoadMapAnnualTargets"%>
<%@page import="com.vts.pfms.roadmap.model.RoadMap"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

<style type="text/css">

.input-group-text{
font-weight: bold;
}

label{
	font-weight: 800;
	font-size: 16px;
	color:#07689f;
} 

hr{
	margin-top: -2px;
	margin-bottom: 12px;
}

b{
	font-family: 'Lato',sans-serif;
}

.select2-container {
	width: 300px !important;
}
</style>
</head>
<body>
<%
List<Object[]> divisionList = (List<Object[]>)request.getAttribute("divisionList");

//List<String> annualTargetsList = Arrays.asList("Others","Hiring Consultant","Proof of Concept","Lab Setup","Creation of Infrastructure","Creation of Test Facility","Literature Survey",
//											   "Market Survey","Research & Exploration","Concept Development","Concept Refinment & Detailing","Feasibility Study",
//											   "Prelim Design of Sub-Systems/ Systems","Detailed Design of Sub-Systems/ Systems","PRC/PDR Completion","CDR Completion","Project Planning",
//											   "Project Santion","Selection of DCPP/DP/LSI","Signing La TOT","IV & V","Sub-System Realisation","Sub-System Testing","SOFT Qualification",
//											   "System Integration","System Calibration","System Validation","System Installation at Site","Internal Evacuation","Technical Demo",
//											   "User Trials","PVT","Acceptance by User","MET Trials","Availability of All CRUS","Availability of All ....","Approval of QA Plan",
//											   "Modelling & Simulation","Platform Modification","HILS Test","Open Range Test","EW Qualification","SOI","Documentation"
//											   );


List<AnnualTargets> annualTargetsList = (List<AnnualTargets>)request.getAttribute("annualTargetsList");

List<String> referencesList = Arrays.asList("FYP","DVD","QR","USER","LRC","FTG","Others");

RoadMap roadMap = (RoadMap)request.getAttribute("roadMapDetails");
List<RoadMapAnnualTargets> roadMapAnnualTargetDetails = null;
if(roadMap!=null) {
	roadMapAnnualTargetDetails = roadMap.getRoadMapAnnualTargets().stream().filter(e-> e.getIsActive()==1).collect(Collectors.toList());
}
//List<RoadMapAnnualTargets> roadMapAnnualTargetDetails = (List<RoadMapAnnualTargets>)request.getAttribute("roadMapAnnualTargetDetails");
String aspFlag = (String)request.getAttribute("aspFlag");

FormatConverter fc = new FormatConverter();
%>
<% String ses=(String)request.getParameter("result");
 	String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null){
	%>
	<div align="center">
		<div class="alert alert-danger" role="alert">
	    <%=ses1 %>
	    </div>
	</div>
	<%}if(ses!=null){ %>
	<div align="center">
		<div class="alert alert-success" role="alert" >
	    	<%=ses %>
		</div>
	</div>
<%} %>

	<div class="container-fluid">
		<div class="row">
			<!-- <div class="col-md-2"></div> -->
			<div class="col-md-12">
				<div class="card shadow-nohover">
	  				<div class="card-header" style=" background-color: #055C9D;margin-top: ">
	                    <h3 class="text-white">Road Map <%if(roadMap!=null) {%>Edit<%} else{%>Add<%} %></h3>
	        		</div>
	
					<div class="card-body">
						<form action="RoadMapDetailSubmit.htm" method="post">
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							<div class="row">
								<div class="col-md-12">
									<table class="table table-bordered table-hover table-striped table-condensed " style="border: 1px solid black !important;background-color:white;font-family: 'Montserrat', sans-serif; width: 50%;" >
										<tr>
											<th >
												<label style="margin-bottom: -10px;">Road Map For </label><span class="mandatory" style="color: red;">*</span>
											</th>
											 <td >
												<select class="form-control" required="required" id="roadMapType" name="roadMapType" onchange="validateRoadMapType('Add')" style="width: 60%;">
													<option value="N" <%if(roadMap!=null && roadMap.getRoadMapType()!=null && roadMap.getRoadMapType().equalsIgnoreCase("N")) {%>selected<%} %> >New Project</option>
													<option value="E" <%if(roadMap!=null && roadMap.getRoadMapType()!=null && roadMap.getRoadMapType().equalsIgnoreCase("E")) {%>selected<%} %>>Existing Project</option>
													<option value="P" <%if(roadMap!=null && roadMap.getRoadMapType()!=null && roadMap.getRoadMapType().equalsIgnoreCase("P")) {%>selected<%} %>>Pre-Project</option>
												</select>
											</td>
											<th id="existingprojectth" >
												<label style="margin-bottom: -10px;">Existing Project </label><span class="mandatory" style="color: red;">*</span>
											</th>
											<td id="existingprojecttd" >
												<select class="form-control selectdee existing" id="projectId" name="projectId" onchange="getProjectDetails()" data-live-search="true">
				  									<option disabled="disabled" value="0" selected="selected">--Select--</option>
				  								</select>
											</td>
											<th id="preprojectth" >
												<label style="margin-bottom: -10px;">Pre-Project </label><span class="mandatory" style="color: red;">*</span>
											</th>
											<td id="preprojecttd" >
												<select class="form-control selectdee" id="initiationId" name="initiationId" onchange="getProjectDetails()" data-live-search="true">
				  									<option disabled="disabled" value="0" selected="selected">--Select--</option>
				  								</select>
											</td>
										</tr>
									</table>
								</div>
							</div>
							
							<div class="row">
								<div class="col-md-12">
									<div class="tables">
	  									<div class="table-responsive">
	   										<table class="table table-bordered table-hover table-striped table-condensed " style="border: 1px solid black !important;background-color:white;font-family: 'Montserrat', sans-serif;" >
												<thead>
													<tr>
														<th>
															<label class="control-label">Title</label><span class="mandatory" style="color: red;">*</span>
														</th>
														<td style="width: 30%;">
															<input class="form-control" type="text" name="projectTitle" id="projectTitle" maxlength="2000" placeholder="Enter Maximum 2000 Characters"
															<%if(roadMap!=null && roadMap.getProjectTitle()!=null) {%>value="<%=roadMap.getProjectTitle() %>"<%} %> required>	
														</td>
														<th style="width: 8%;" id="divisionth">
															<label class="control-label">Division</label><span class="mandatory" style="color: red;">*</span>
														</th>
														<td style="width: 12%;" id="divisiontd">
															<select class="form-control selectdee" id="divisionId" name="divisionId" data-live-search="true">
					   											<option value="" disabled="disabled" selected="selected">--Select--</option>
					   											<% for (Object[] obj : divisionList) {%>
																	<option value="<%=obj[0]%>" <%if(roadMap!=null && roadMap.getDivisionId()!=null && roadMap.getDivisionId()==Long.parseLong(obj[0].toString())) {%>selected<%} %> ><%=obj[2]%></option>
																<%} %>
					  										</select>
														</td>
														<th>
															<label class="control-label">Start Date</label><span class="mandatory" style="color: red;">*</span>
														</th>
														<td style="width: 10%;">
															<input class="form-control" type="text" name="startDate" id="startDate"required readonly style="background: #fff;"
															<%if(roadMap!=null && roadMap.getStartDate()!=null) {%>value="<%=fc.SqlToRegularDate(roadMap.getStartDate()) %>"<%} %> >	
														</td>
														<th>
															<label class="control-label">End Date</label><span class="mandatory" style="color: red;">*</span>
														</th>
														<td style="width: 10%;">
															<input class="form-control" type="text" name="endDate" id="endDate" required readonly style="background: #fff;"
															<%if(roadMap!=null && roadMap.getEndDate()!=null) {%>value="<%=fc.SqlToRegularDate(roadMap.getEndDate()) %>"<%} %>>
														</td>
													</tr>
													<tr>
														<th colspan="1" style="vertical-align: top;">
															<label class="control-label">Aim & Objects</label><span class="mandatory" style="color: red;">*</span>
														</th>
														<td colspan="7">
															<textarea class="form-control" name="aimObjectives" id="aimObjectives" maxlength="5000" rows="2" cols="75" placeholder="Enter Maximum 5000 characters" required><%if(roadMap!=null && roadMap.getAimObjectives()!=null) {%><%=roadMap.getAimObjectives() %><%} %></textarea>
														</td>
													</tr>
													<tr>
														<th colspan="1">
															<label class="control-label">Scope</label><span class="mandatory" style="color: red;">*</span>
														</th>
														<td colspan="7">
															<input class="form-control" type="text" name="scope" id="scope" maxlength="1000" placeholder="Enter Maximum 1000 characters"
															<%if(roadMap!=null && roadMap.getScope()!=null) {%>value="<%=roadMap.getScope() %>"<%} %> required >	
														</td>
														
													</tr>
													<tr>
														<th colspan="1">
															<label class="control-label">Reference</label><span class="mandatory" style="color: red;">*</span>
														</th>
														<td colspan="1">
															<select class="form-control selectdee" id="references" name="references" data-live-search="true" required style="width: 50%;" onchange="otherReferenceHandle()">
					   											<option value="" disabled="disabled" selected="selected">--Select--</option>
					   											<% for (String ref : referencesList) {%>
																	<option value="<%=ref%>" <%if(roadMap!=null && roadMap.getReference()!=null && roadMap.getReference().equalsIgnoreCase(ref)) {%>selected<%} %> ><%=ref%></option>
																<%} %>
					  										</select>
														</td>
														<th colspan="1" class="othersreftd">
															<label class="control-label">Others</label><span class="mandatory" style="color: red;">*</span>
														</th>
														<td colspan="1" class="othersreftd">
															<input class="form-control" type="text" name="otherReference" id="otherReference" maxlength="1000" placeholder="Enter Other Reference"
															<%if(roadMap!=null && roadMap.getOtherReference()!=null) {%>value="<%=roadMap.getOtherReference() %>"<%} %> >
														</td>
														<th colspan="1">
															<label class="control-label">Cost</label><span class="mandatory" style="color: red;">*</span>
														</th>
														<td colspan="1">
															<input class="form-control" type="text" name="projectCost" id="projectCost" maxlength="15" placeholder="Enter Cost in rupees"
															<%if(roadMap!=null && roadMap.getProjectCost()!=null) {%>value="<%=roadMap.getProjectCost() %>"<%} %> required >	
														</td>
														<td colspan="5"></td>
													</tr>
												</thead>
											</table>
										</div>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-md-6">
									<div class="tables">
	  									<div class="table-responsive">
	   										<table class="table table-bordered table-hover table-striped table-condensed " style="border: 1px solid black !important;background-color:white;font-family: 'Montserrat', sans-serif;width: 100% !important;" >
												<thead style="text-align: center;">
													<tr>
														<th style="">Annual Year</th>
														<th >Annual Targets</th>
													</tr>
												</thead>
												<tbody id="annualTargetrows">
													<%if(roadMapAnnualTargetDetails!=null) { 
														int OrigAnnualYear=0,TempAnnualYear=0;
													 	for(RoadMapAnnualTargets target :roadMapAnnualTargetDetails) {
													 		
													 		OrigAnnualYear=Integer.parseInt(target.getAnnualYear());
													 		List<Long> idsList =  roadMapAnnualTargetDetails.stream()
													 						      .filter(e-> e.getAnnualYear().equalsIgnoreCase(target.getAnnualYear()))
													 						      .map(e -> e.getAnnualTargets().getAnnualTargetId())
													 						      .collect(Collectors.toList());
													 		
													%>
													<%if(OrigAnnualYear!=TempAnnualYear){ %>
														<tr>
															<td style="text-align: center;">
																<input type="text" class="form-control" name="annualYear" value="<%=target.getAnnualYear() %>" required readonly style="text-align: center;">
															</td>
															<td>
																<select class="form-control selectdee annualTargets" id="annualTargets<%=target.getAnnualYear() %>" name="annualTargets<%=target.getAnnualYear() %>" data-live-search="true" onchange="othersCheckHandle(<%=target.getAnnualYear() %>)" multiple="multiple" required>
																		<option value="Others">Others</option>
																		<% for(AnnualTargets annualTarget : annualTargetsList) {%>
																			
																			<%if(!idsList.contains(annualTarget.getAnnualTargetId())) {%>
            																	<option value="<%=annualTarget.getAnnualTargetId() %>" ><%=annualTarget.getAnnualTarget()%></option>
            																<%} %>
            															<%}%>
            															<%for(Long id : idsList) {%>
            																	<option value="<%=id %>" selected >
            																	<%
            																		List<RoadMapAnnualTargets> roadMapAT =	roadMapAnnualTargetDetails.stream()
            																												.filter(e->e.getAnnualTargets().getAnnualTargetId()==id)
            																												.collect(Collectors.toList());
            																	%>
            																	<%=roadMapAT.get(0).getAnnualTargets().getAnnualTarget() %>
            																	</option>
            															<%} %>
																</select>
															</td>
            												
														</tr>
														<%} %>
													<%TempAnnualYear=OrigAnnualYear;} } %>
												</tbody>
											</table>
										</div>
									</div>
								</div>
								<div class="col-md-3" id="othersdiv">
									<div class="card" style="border-color: #00DADA;">
										<h5 class="heading ml-4 mt-3" id="" style="font-weight: 500; color: #31708f;">Add Others</h5>
										<hr>
										<div class="card-body bg-light mt-1">
											<table style="width:100%;" id="otherstable">
												<thead style = "background-color: #055C9D; color: white;text-align: center;">
													<tr>
												    	<th style="padding: 0px 5px 0px 5px;">Others</th>
												    	
														<td style="width: 5%;">
															<button form="otherform" type="button" class=" btn btn_add_others "> <i class="btn btn-sm fa fa-plus" style="color: green; padding: 0px  0px  0px  0px;"></i></button>
														</td>
													</tr>
												</thead>
									 			<tbody>
									 					
													<tr class="tr_clone_others">
														<td style="padding: 10px 5px 0px 5px;" >
															<input type="text" form="otherform" class="form-control item" name="otherdata" id="otherdata" placeholder="Enter Maximum 1000 characters" maxlength="1000" required="required">
														</td>	
														
														<td style="width: 5% ; ">
															<button form="otherform" type="button" class=" btn btn_rem_others" > <i class="btn btn-sm fa fa-minus" style="color: red; padding: 0px  0px  0px  0px;"></i></button>
														</td>									
													</tr>
														
												</tbody> 
											</table>
											<div align="center" style="margin-top: 15px;">
													<button form="otherform" type="button" class="btn btn-sm add" name="submit" onclick="addOthers()">ADD</button>
													<input form="otherform" type="hidden" id="othersforyear">
													<input form="otherform" type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
											</div>
										</div>
									</div>
								</div>
							</div>
							<br>
	               			<div align="center">
								<%if(roadMap!=null){ %>
								    <input type="hidden" name="roadMapId" value="<%=roadMap.getRoadMapId()%>">
									<button type="submit" class="btn btn-sm btn-warning edit" name="Action" value="Edit" onclick="return confirm('Are you sure to update?')" >UPDATE</button>
								<%}else{ %>
									<button type="submit" class="btn btn-sm btn-success submit" name="Action" value="Add" onclick="return confirm('Are you sure to submit?')" >SUBMIT</button>
								<%} %>
								
								<a class="btn btn-primary btn-sm back"
								<%if(aspFlag!=null && aspFlag.equalsIgnoreCase("Y")) {%>
               						href="RoadMapASPList.htm" 
               					<%} else{%>
									 href="RoadMapList.htm"
								<%} %>
								>Back</a>
							</div>
						</form>
						<form action="#" method="GET" id="otherform"></form>
					</div>
				</div>
			</div>
			<!-- <div class="col-md-2"></div> -->
		</div>
	</div>

<script type="text/javascript">

function validateRoadMapType(action){
	var roadMapType = $('#roadMapType').val();

	if(roadMapType=='E'){
		$('#existingprojectth').show();
		$('#existingprojecttd').show();
		$('#preprojectth').hide();
		$('#preprojecttd').hide();
		$('#divisionth').hide();
		$('#divisiontd').hide();
		$('#divisionId').prop('required', false);
		
		$.ajax({
			Type:'GET',
			url:'GetProjectListForRoadMap.htm',
			datatype:'json',
			data:{
				roadMapType : roadMapType,
			},
			success:function(result){
				var values = JSON.parse(result);
				for (var i = 0; i < values.length; i++) {
                    var data = values[i];
                    var optionValue = data[0];
                    var optionText = data[1] + "(" + data[2]+")"; 
                    var option = $("<option></option>").attr("value", optionValue).text(optionText);
                    $('#projectId').append(option); 
                }
				
				if(action=='Edit'){
					<% if(roadMap!=null) {%>
						$('#projectId').val('<%=roadMap.getProjectId()%>');
					<%}%>
					$('#projectId').select2();
				}
			}
		});
		
		
		
	}else if(roadMapType=='P'){
		$('#existingprojectth').hide();
		$('#existingprojecttd').hide();
		$('#preprojectth').show();
		$('#preprojecttd').show();
		$('#divisionth').hide();
		$('#divisiontd').hide();
		$('#divisionId').prop('required', false);
		
		$.ajax({
			Type:'GET',
			url:'GetProjectListForRoadMap.htm',
			datatype:'json',
			data:{
				roadMapType : roadMapType,
			},
			success:function(result){
				var values = JSON.parse(result);
				for (var i = 0; i < values.length; i++) {
                    var data = values[i];
                    var optionValue = data[0];
                    var optionText = data[1] + "(" + data[2]+")"; 
                    var option = $("<option></option>").attr("value", optionValue).text(optionText);
                    $('#initiationId').append(option); 
                }
            
				if(action=='Edit'){
					<% if(roadMap!=null) {%>
						$('#initiationId').val('<%=roadMap.getInitiationId()%>');
					<%}%>
					$('#projectId').select2();
				}
				
			}
		});
		
		
	}else{
		$('#existingprojectth').hide();
		$('#existingprojecttd').hide();
		$('#preprojectth').hide();
		$('#preprojecttd').hide();
		$('#divisionth').show();
		$('#divisiontd').show();
		$('#divisionId').prop('required',true);
		
		if(action=='Add'){
			$('#projectTitle').val('');
			$('#divisionId').val('');
			$('#aimObjectives').val('');
			$('#scope').val('');
			$('#references').val('');
			
			$('#divisionId').select2();
			$('#references').select2();
		}
		
	}
	
}

</script>

<script type="text/javascript">

function getProjectDetails(){
	var roadMapType = $('#roadMapType').val();
	var projectId = $('#projectId').val();
	var initiationId = $('#initiationId').val();
	$.ajax({
		Type:'GET',
		url:'GetProjectDetailsForRoadMap.htm',
		datatype:'json',
		data:{
			roadMapType : roadMapType,
			projectId : projectId,
			initiationId : initiationId
		},
		success:function(result){
			var values = JSON.parse(result);
			$('#projectTitle').val(values[3]);
			$('#divisionId').val(values[4]);
			$('#aimObjectives').val(values[7]);
			$('#scope').val(values[8]);
			/* $('#references').val(values[9]); */
			$('#projectCost').val(values[10]);
			$('#divisionId').select2();
			/* $('#references').select2(); */
			
		}
	});
}

</script>

<script type="text/javascript">

$(document).ready(function() {

	otherReferenceHandle();
	
	<%if(roadMap==null) {%>
		validateRoadMapType('Add');
	<%} else{%>
		validateRoadMapType('Edit');
	<%} %>
	
$('#startDate').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,	
	"cancelClass" : "btn-default",
	/* "minDate" : tomorrow, */
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});

$('#endDate').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	"minDate" :$('#startDate').val(),
	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});

<%if(roadMap==null) {%>
	populateAnnualTargets();
<%}%>

$('#othersdiv').hide();
});

$( "#startDate" ).change(function() {
	
	$('#endDate').daterangepicker({
		"singleDatePicker" : true,
		"linkedCalendars" : false,
		"showCustomRangeLabel" : true,
		"minDate" : $('#startDate').val(), 
		/* "startDate" : new Date(), */
		"cancelClass" : "btn-default",
		showDropdowns : true,
		locale : {
			format : 'DD-MM-YYYY'
		}
	});
	
	populateAnnualTargets();
});

$( "#endDate").change(function() { 
	
	populateAnnualTargets();
	
});

</script>	

<script type="text/javascript">

function populateAnnualTargets() {
    var startYear = parseInt($('#startDate').val().substring(6, 10));
    var endYear = parseInt($('#endDate').val().substring(6, 10));
    var currentStartYear = parseInt($('#annualTargetrows tr:first-child').find('input[name="annualYear"]').val());
    
    var existingRows = {}; // Store existing rows

    // Loop through existing rows and store their years
    $('#annualTargetrows tr').each(function() {
        var year = parseInt($(this).find('input[name="annualYear"]').val());
        existingRows[year] = true;
    });

    var rows = '';
    for (var i = startYear; i <= endYear; i++) {
        // Check if row for this year already exists
        if (!existingRows[i]) {
            // Row does not exist, create new row
            rows += '<tr>';
            rows += '<td style="text-align: center;"><input type="text" class="form-control" name="annualYear" value="' + i + '" required readonly style="text-align: center;"></td>';
            rows += '<td><select class="form-control selectdee annualTargets" id="annualTargets' + i + '" name="annualTargets' + i + '" data-live-search="true" onchange="othersCheckHandle('+i+')" multiple required><option value="Others">Others</option>';
            // Append options
            <% for(AnnualTargets annualTarget : annualTargetsList) {%>
            rows += '<option value="<%=annualTarget.getAnnualTargetId() %>" ><%=annualTarget.getAnnualTarget()%></option>';
            <%}%>
            rows += '</select></td>';
           /*  rows += '<td class="otherstd" style="display: none;"><input type="text" class="form-control others" name="others" id="others' + i + '" style="display: none;" placeholder="Enter Maximum 1000 characters"></td>'; */
            rows += '</tr>';
        }
    }

    // Remove rows for years that are no longer within the selected date range
    $('#annualTargetrows tr').each(function() {
        var year = parseInt($(this).find('input[name="annualYear"]').val());
        if (year < startYear || year > endYear) {
            $(this).remove();
        }
    });

    // Check if the selected start year is before the current start year
    if (startYear < currentStartYear) {
        // If yes, prepend new rows to table
        $('#annualTargetrows').prepend(rows);
    } else {
        // If no, append new rows to table
        $('#annualTargetrows').append(rows);
    }

    $('.selectdee').select2(); // Initialize select2
    
    othersCheckHandle(startYear);
}

</script>

<script type="text/javascript">

function othersCheckHandle(annualYear) {
    var selectedValues = $('#annualTargets'+annualYear).val() || []; // Get selected values or an empty array if nothing is selected
    var othersRequired = selectedValues.includes('Others'); // Check if 'Others' is among the selected values
    
    if(othersRequired) {
        $('#othersdiv').show();
        $('#othersforyear').val(annualYear);
        // Remove all rows except the first one
        $('.tr_clone_others:gt(0)').remove();
        // Clear the input value of the first row
        $('.tr_clone_others:first input').val('');
    } else {
        $('#othersdiv').hide();
        $('#othersforyear').val('0');
    }
}


</script>

<script type="text/javascript">
/* Cloning (Adding) the table body rows for Deliverables2 */
	$("#otherstable").on('click','.btn_add_others' ,function() {
		
		var $tr = $('.tr_clone_others').last('.tr_clone_others');
		var $clone = $tr.clone();
		$tr.after($clone);
		
		$clone.find("input").val("").end();
		
	});


	/* Cloning (Removing) the table body rows for Deliverables2 */
	$("#otherstable").on('click','.btn_rem_others' ,function() {
		
	var cl=$('.tr_clone_others').length;
		
	if(cl>1){
	   var $tr = $(this).closest('.tr_clone_others');
	  
	   var $clone = $tr.remove();
	   $tr.after($clone);
	   
	}
	   
	}); 
</script>

<script type="text/javascript">
	function addOthers() {
		if(confirm('Are you sure to Add?')){
			var x='';
			var others = [];
			 $("input[name='otherdata']").each(function() {
				 others.push($(this).val());
			 });
			
			 var o = others.toString();
			 
			 if(o.length<=0){
				 alert('Please fill data..!');
				 return false;
			 }

			 var othersforyear = $('#othersforyear').val();
			 
			$.ajax({
				Type:'GET',
				url:'AddOtherAnnualTargets.htm',
				datatype:'json',
				data:{
					others : o,
				},
				success:function(result){
					var values = JSON.parse(result);
				
					x=x+''
					for(i = 0; i < values.length; i++){
						 x=x+"<option value="+values[i][0]+" selected='selected' >"+ values[i][1]+ "</option>"; 
					}
					$('#annualTargets'+othersforyear+' option[value="Others"]').prop('selected', false);
					$('#annualTargets'+othersforyear).append(x);
					 
			        $('#othersdiv').hide();
			        $('#othersforyear').val('0');
					    
				}
			});
			return true;
		}else{
			event.PreventDefault();
			return false;
		}
		
	}
</script>
<script type="text/javascript">
function otherReferenceHandle(){
	var references = $('#references').val();

	if(references==='Others'){
		$('.othersreftd').show();
		$('#otherReference').prop('required',true);
	}else{
		$('.othersreftd').hide();
		$('#otherReference').prop('required',false);
	}
}
</script>
</body>
</html>