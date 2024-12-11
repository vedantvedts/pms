<%@page import="com.vts.pfms.requirements.model.TestPlanMaster"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html>
<head>
<meta charset="ISO-8859-1">

<jsp:include page="../static/header.jsp"></jsp:include>
<spring:url value="/resources/js/excel.js" var="excel" />
<spring:url value="/resources/summernote-lite.js" var="SummernoteJs" />
<spring:url value="/resources/summernote-lite.css" var="SummernoteCss" />



<script src="${SummernoteJs}"></script>
<link href="${SummernoteCss}" rel="stylesheet" />
<style>
label {
	font-weight: bold;
	font-size: 14px;
}

.table thead tr, tbody tr {
	font-size: 14px;
}

body {
	background-color: #f2edfa;
	overflow-x: hidden !important;
}

#scrollButton {
	display: none; /* Hide the button by default */
	position: fixed;
	/* Fixed position to appear in the same place regardless of scrolling */
	bottom: 20px;
	right: 30px;
	z-index: 99; /* Ensure it appears above other elements */
	font-size: 18px;
	border: none;
	outline: none;
	background-color: #007bff;
	color: white;
	cursor: pointer;
	padding: 15px;
	border-radius: 4px;
}

h6 {
	text-decoration: none !important;
}

.multiselect-view>li>a>label {
	padding: 4px 20px 3px 20px;
}

.width {
	width: 210px !important;
}

.bootstrap-select {
	width: 400px !important;
}

#projectname {
	display: flex;
	align-items: center;
	justify-content: flex-start;
}

#div1 {
	display: flex;
	align-items: center;
	justify-content: center;
}

select:-webkit-scrollbar { /*For WebKit Browsers*/
	width: 0;
	height: 0;
}

.requirementid {
	border-radius: 5px;
	box-shadow: 10px 10px 5px lightgrey;
	margin: 1% 0% 3% 2%;
	padding: 5px;
	padding-bottom: 10px;
	display: inline-grid;
	width: 15%;
	background-color: antiquewhite;
	float: left;
	align-items: center;
	justify-content: center;
	overflow: auto;
	position: stickey;
}

.requirementid::-webkit-scrollbar {
	display: none;
}

.requirementid:hover {
	padding: 13px;
}

.viewbtn {
	width: 100%;
	margin-top: 4%;
	background: #055C9D;
	font-size: 13px;
	font-family: font-family : 'Muli';
}

/* .viewbtn:hover {
	cursor: pointer !important;
	background-color: #22c8e5 !important;
	border: none !important;
	box-shadow: 0 12px 16px 0 rgba(0, 0, 0, 0.24), 0 17px 50px 0
		rgba(0, 0, 0, 0.19) !important;
} */
.viewbtn1 {
	width: 100%;
	margin-top: 4%;
	background: #055C9D;
	font-size: 13px;
	font-family: font-family : 'Muli';
}

.viewbtn1:hover {
	background: green;
}

#view {
	background-color: white;
	display: inline-block;
	margin-left: 2%;
	margin-top: 1%;
	box-shadow: 8px 8px 5px lightgrey;
	max-width: 85%;
}

hr {
	margin-left: 0px !important;
	margin-bottom: 0px;
	!
	important;
}

.note-editing-area {
	
}

#scrollButton {
	display: none; /* Hide the button by default */
	position: fixed;
	/* Fixed position to appear in the same place regardless of scrolling */
	bottom: 20px;
	right: 30px;
	z-index: 99; /* Ensure it appears above other elements */
	font-size: 18px;
	border: none;
	outline: none;
	background-color: #007bff;
	color: white;
	cursor: pointer;
	padding: 15px;
	border-radius: 4px;
}

.addreq {
	margin-left: -20%;
	margin-top: 5%;
}

#modalreqheader {
	background: #145374;
	height: 44px;
	display: flex;
	font-family: 'Muli';
	align-items: center;
	color: white;
}

#code {
	padding: 0px;
	width: 64%;
	font-size: 12px;
	margin-left: 2%;
	margin-bottom: 7%;
}

#addReqButton {
	display: flex;
	align-items: center;
	justify-content: end;
}

#modaal-A {
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 20px;
	font-family: sans-serif;
}

#editreq {
	margin-bottom: 5px;
	display: flex;
	align-items: center;
	justify-content: flex-end;
}

#reqbtns {
	box-shadow: 2px 2px 2px;
	font-size: 15px;
	font-weight: 500;
}

#attachadd, #viewattach {
	margin-left: 1%;
	box-shadow: 2px 2px 2px black;
	font-size: 15px;
	font-weight: 500;
}

#reqName {
	font-size: 20px;
	background: #f5f5dc;
	font-family: inherit;
	color: darkslategrey;
	font-weight: 500;
	display: flex;
	border-radius: 8px;
	align-items: center;
	box-shadow: 4px 4px 4px gray;
}

#reqName1 {
	font-size: 20px;
	background: #f5f5dc;
	font-family: inherit;
	color: darkslategrey;
	font-weight: 500;
	display: flex;
	border-radius: 8px;
	align-items: center;
	box-shadow: 4px 4px 4px gray;
	margin-bottom: 20px;
}

@
keyframes blinker { 20% {
	opacity: 0.65;
}

}
#attachmentadd, #attachmentaddedit {
	display: flex;
	margin-top: 2%;
}

#download, #deletedownload {
	box-shadow: 2px 2px 2px grey;
	margin-left: 1%;
	margin-top: 1%;
	margin-right: 1%;
}

#headerid, #headeridedit {
	margin-top: 1%;
	display: flex;
	align-items: center;
	justify-content: center;
	margin-right: 1%;
}

#reqdiv:hover {
	
}

#scrollclass::-webkit-scrollbar {
	width: 7px;
}

#scrollclass::-webkit-scrollbar-track {
	-webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.3);
	border-radius: 5px;
}

#scrollclass::-webkit-scrollbar-thumb {
	border-radius: 5px;
	/*   -webkit-box-shadow: inset 0 0 6px black;  */
	background-color: gray;
}

#scrollclass::-webkit-scrollbar-thumb:hover {
	-webkit-box-shadow: inset 0 0 6px black;
	transition: 0.5s;
}

#scrollclass::-webkit-scrollbar {
	width: 7px;
}

#scrollclass::-webkit-scrollbar-track {
	-webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.3);
	border-radius: 5px;
}

#scrollclass::-webkit-scrollbar-thumb {
	border-radius: 5px;
	/*   -webkit-box-shadow: inset 0 0 6px black;  */
	background-color: gray;
}

#scrollclass::-webkit-scrollbar-thumb:hover {
	-webkit-box-shadow: inset 0 0 6px black;
	transition: 0.5s;
}

.multiselect {
	padding: 4px 90px;
	background-color: white;
	border: 1px solid #ced4da;
	height: calc(2.25rem + 2px);
}

.modal-dialog-jump-pop {
	animation: jumpIn .5s ease;
}

.modal-dialog-jump {
	animation: jumpIn 1.5s ease;
}

@
keyframes jumpIn { 0% {
	transform: scale(0.3);
	opacity: 0;
}

70
%
{
transform
:
scale(
1
);
}
100
%
{
transform
:
scale(
1
);
opacity
:
1;
}
}
#container {
	background-color: white;
	display: inline-block;
	margin-left: 2%;
	margin-top: 1%;
}

.note-editing-area {
	
}
</style>
</head>
<body>
</head>
<body>
	<% TestPlanMaster tp = (TestPlanMaster)request.getAttribute("TestPlanMaster");
	List<Object[]>StagesApplicable=(List<Object[]>)request.getAttribute("StagesApplicable");

%>

	<div class="container" id="container" style="max-width: 95%">
		<form action="TestMasterAddSubmit.htm" method="POST">
			<div class="row" id="row1">

				<div class="col-md-12" id="reqdiv" style="background: white;">
					<div class="card-body" id="cardbody">
						<div class="row">
							<div class="col-md-1">
								<label
									style="font-size: 17px; margin-left: 0.1rem; color: #07689f">Test
									Name<span class="mandatory" style="color: red;">*</span>
								</label>
							</div>
							<div class="col-md-5">
								<input type="text" name="name" class="form-control" id="NameAdd"
									maxlength="255" required="required"
									placeholder="Maximum 250 Chararcters" value="<%if(tp.getName()!=null){%><%=tp.getName() %> <%}%>">
							</div>

							<div class="col-md-1">
								<label
									style="font-size: 17px; margin-left: 0.1rem; color: #07689f">Objective<span
									class="mandatory" style="color: red;">*</span>
								</label>
							</div>
							<div class="col-md-5">
								<input type="text" name="Objective" class="form-control"
									id="ObjectiveAdd" maxlength="255" required="required"
									placeholder="Maximum 250 Chararcters"
									style="line-height: 3rem !important" value="<%if(tp.getObjective()!=null){%><%=tp.getObjective() %> <%}%>">
							</div>
						</div>

						<div class="row"></div>

						<div class="form-group row mt-2">
							<div class="col-md-6">
								<div class="row">
									<div class="col-md-2">
										<label style="font-size: 17px; color: #07689f; width: 120%;">
											Methodology <span class="mandatory" style="color: red;">*</span>
										</label>
									</div>
									<div class="col-md-10" style="">
										<input class="form-control" name="Methodology"
											id="MethodologyAdd" required  value="<%if(tp.getMethodology()!=null){%><%=tp.getMethodology() %> <%}%>">
									</div>
								</div>
							</div>

							<div class="col-md-6">
								<div class="row">
									<div class="col-md-2">
										<label style="font-size: 17px; color: #07689f;">
											Test-Setup <span class="mandatory" style="color: red;">*</span>
										</label>
									</div>
									<div class="col-md-10">
										<input class="form-control" name="ToolsSetup" style=""
											required="required"  value="<%if(tp.getToolsSetup()!=null){%><%=tp.getToolsSetup() %> <%}%>">

									</div>
								</div>
							</div>
						</div>

						<div class="form-group row mt-2">
							<div class="col-md-6">
								<div class="row">
									<div class="col-md-2">
										<label style="font-size: 17px; color: #07689f;">
											Constraints <span class="mandatory" style="color: red;">*</span>
										</label>
									</div>
									<div class="col-md-10" style="">
										<input type="text" name="Constraints" class="form-control"
											id="ConstraintsAdd" maxlength="255" required
											placeholder="Maximum 250 Chararcters" value="<%if(tp.getConstraints()!=null){%><%=tp.getConstraints() %> <%}%>">
									</div>
								</div>
							</div>

							<div class="col-md-6">
								<div class="row">
									<div class="col-md-2">
										<label style="font-size: 17px; color: #07689f;"> Est
											Time <span class="mandatory" style="color: red;">*</span>
										</label>
									</div>
									<div class="col-md-2" style="">
										<input type="text" name="EstimatedTimeIteration"
											class="form-control" id="EstimatedTimeIterationAdd"
											min="1" required="required" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
											 value="<%if(tp.getEstimatedTimeIteration()!=null){%><%=Integer.parseInt(tp.getEstimatedTimeIteration()) %><%}%>">
									</div>
									<div class="col-md-2">
									<select class="form-control" required="required" name="TimeType">
									<option value="" selected  disabled="disabled">SELECT</option>
									<option value="D" <%if(tp.getTimeType()!=null && tp.getTimeType().equalsIgnoreCase("D")) {%> selected="selected" <%} %>>DAYS</option>
									<option value="H" <%if(tp.getTimeType()!=null && tp.getTimeType().equalsIgnoreCase("H")) {%> selected="selected" <%} %>>HOURS</option>
									<option value="M" <%if(tp.getTimeType()!=null && tp.getTimeType().equalsIgnoreCase("M")) {%> selected="selected" <%} %>>MINUTES</option>
									</select>
									</div>
								</div>
							</div>
						</div>

						<div class="form-group row">
							<div class="col-md-6">
								<div class="row">
									<div class="col-md-2">
										<label style="font-size: 17px; color: #07689f;">
											Iterations <span class="mandatory" style="color: red;">*</span>
										</label>
									</div>
									<div class="col-md-10" style="">
										<input type="text" name="Iterations" class="form-control"
											id="IterationsAdd" maxlength="255" required="required"
											placeholder="Maximum 250 Chararcters"  value="<%if(tp.getIterations()!=null){%><%=tp.getIterations() %> <%}%>">
									</div>
								</div>
							</div>

							<div class="col-md-6">
								<div class="row">
									<div class="col-md-2">
										<label style="font-size: 17px; color: #07689f;">
											Schedule <span class="mandatory" style="color: red;">*</span>
										</label>
									</div>
									<div class="col-md-10" style="">
										<input type="text" name="Schedule" class="form-control"
											id="ScheduleAdd" min="1" required="required"
											value="<%if(tp.getSchedule()!=null){%><%=tp.getSchedule()%> <%}%>">
									</div>
								
								</div>
							</div>
						</div>

						<div class="form-group row mt-2">
							<div class="col-md-6">
								<div class="row">
									<div class="col-md-2">
										<label style="font-size: 17px; color: #07689f;">
											Criteria <span class="mandatory" style="color: red;">*</span>
										</label>
									</div>
									<div class="col-md-10" style="">
										<input type="text" name="PassFailCriteria"
											class="form-control" id="PassFailCriteriaAdd" maxlength="255"
											required="required" placeholder="Maximum 250 Chararcters" value="<%if(tp.getPass_Fail_Criteria()!=null){%><%=tp.getPass_Fail_Criteria()%> <%}%>">
									</div>
								</div>
							</div>

							<div class="col-md-6">
								<div class="row">
									<div class="col-md-2">
										<label style="font-size: 17px; color: #07689f;"> Stage
											<span class="mandatory" style="color: red;">*</span>
										</label>
									</div>
									<div class="col-md-10" style="">

										<%if(!StagesApplicable.isEmpty()){ %>
										<select required="required" class="form-control selectdee"
											name="StageApplicable" id="StageApplicable" data-width="100%"
											data-live-search="true" data-placeholder="Choose">
											<%for(Object[] obj:StagesApplicable){ %>
											<option value="<%=obj[3]%>"  <%if(tp.getStageApplicable()!=null && tp.getStageApplicable().equalsIgnoreCase(obj[3].toString())) {%>  selected<%} %>><%=obj[3]%></option>
											<%}%>
										</select>
										<%} else{%>
										<input class="form-control" readonly name="StageApplicable"
											id="StageApplicable" placeholder="No files found">
										<%} %>

									</div>
								</div>
							</div>
						</div>


						<div class="form-group row mt-2">
							<div class="col-md-6">
								<label style="font-size: 17px; color: #07689f"> Pre
									Conditions <span class="mandatory" style="color: red;">*</span>
								</label>

								<div id="EditorPreConditions" class="center"> <%if(tp.getPreConditions()!=null){%><%=tp.getPreConditions()%> <%}%></div>
								<textarea name="PreConditions" id="PreConditionsAdd"
									style="display: none"></textarea>
							</div>

							<div class="col-md-6" id="textarea" style="">
								<label style="font-size: 17px; color: #07689f"> Post
									Conditions <span class="mandatory" style="color: red;">*</span>
								</label>
								<div id="EditorPostConditions" class="center">  <%if(tp.getPostConditions()!=null){%><%=tp.getPostConditions()%> <%}%></div>
								<textarea name="PostConditions" id="PostConditionsAdd"
									style="display: none;"></textarea>
							</div>
						</div>

						<div class="form-group row mt-2">
							<div class="col-md-6">
								<label style="font-size: 17px; color: #07689f;"> Safety
									Requirements <span class="mandatory" style="color: red;">*</span>
								</label>

								<div id="EditorSafetyReq" class="center">  <%if(tp.getSafetyRequirements()!=null){%><%=tp.getSafetyRequirements()%> <%}%></div>
								<textarea name="SafetyReq" id="SafetyReqAdd"
									style="display: none;"></textarea>
							</div>

							<div class="col-md-6">
								<label style="font-size: 17px; color: #07689f;">
									Personnel Resources <span class="mandatory" style="color: red;">*</span>
								</label>

								<div id="EditorPersonnelResources" class="center">  <%if(tp.getPersonnelResources()!=null){%><%=tp.getPersonnelResources()%> <%}%></div>
								<textarea name="PersonnelResources" id="PersonnelResourcesAdd"
									style="display: none;"></textarea>

							</div>
						</div>

						<div class="form-group row mt-2">
						<div class="col-md-6">
								<label style="font-size: 17px; color: #07689f;">
									Description <span class="mandatory" style="color: red;">*</span>
								</label>
								<div id="descriptioneditor" class="center"><%if(tp.getDescription()!=null){%><%=tp.getDescription()%> <%}%>
							</div>
								<textarea name="Description"  id="DescriptionAdd" style="display: none;"></textarea>
							</div>
							<div class="col-md-6">
								<label style="font-size: 17px; color: #07689f;">
											Remarks <span class="mandatory" style="color: red;">*</span>
										</label>
									<div  style="">
										<textarea  name="remarks" class="form-control"
											id="remarksAdd" maxlength="255" required="required"
											placeholder="Maximum 250 Chararcters" ><%if(tp.getRemarks()!=null){%><%=tp.getRemarks()%> <%}%></textarea>
									</div>
								
							</div>
							<div class="col-md-6"></div>
						</div>
						<div align="center" class="mt-2">
							<%if(tp.getTestMasterId()!=null){ %>
							<button id="editbtn" type="submit" class="btn btn-sm edit"
								onclick="submitData()" name="action" value="update">UPDATE
							</button>
							<input type="hidden" name="TestMasterId"
								value="<%=tp.getTestMasterId()%>">
							<%}else{ %>
							<button id="submitbtn" type="submit" class="btn btn-sm submit"
								onclick="submitData()" name="action" value="add">SUBMIT
							</button>
							<%} %>
							<a class="btn btn-info btn-sm back"
								href="TestPlanMaster.htm">Back</a>
						</div>
						<input type="hidden" name="${_csrf.parameterName}"
							value="${_csrf.token}" />
					</div>
				</div>
			</div>
		</form>
	</div>
	<Script>
	$(document).ready(function() {


		$('#EditorPreConditions').summernote({
			 toolbar: [
		         // Adding default toolbar buttons plus custom superscript and subscript
		         ['style', ['bold', 'italic', 'underline', 'clear']],
		         ['font', ['strikethrough', 'superscript', 'subscript']],
		         ['insert', ['picture', 'table']],
		         ['para', ['ul', 'ol', 'paragraph']],
		         ['height', ['height']]
		     ],
		     buttons: {
		         // Custom superscript and subscript buttons
		         superscript: function() {
		             return $.summernote.ui.button({
		                 contents: '<sup>S</sup>',
		                 tooltip: 'Superscript',
		                 click: function() {
		                     document.execCommand('superscript');
		                 }
		             }).render();
		         },
		         subscript: function() {
		             return $.summernote.ui.button({
		                 contents: '<sub>S</sub>',
		                 tooltip: 'Subscript',
		                 click: function() {
		                     document.execCommand('subscript');
		                 }
		             }).render();
		         }
		     },
		     height: 200
		   });


		$('#EditorPostConditions').summernote({
		    
			 toolbar: [
		         // Adding default toolbar buttons plus custom superscript and subscript
		         ['style', ['bold', 'italic', 'underline', 'clear']],
		         ['font', ['strikethrough', 'superscript', 'subscript']],
		         ['insert', ['picture', 'table']],
		         ['para', ['ul', 'ol', 'paragraph']],
		         ['height', ['height']]
		     ],
		     buttons: {
		         // Custom superscript and subscript buttons
		         superscript: function() {
		             return $.summernote.ui.button({
		                 contents: '<sup>S</sup>',
		                 tooltip: 'Superscript',
		                 click: function() {
		                     document.execCommand('superscript');
		                 }
		             }).render();
		         },
		         subscript: function() {
		             return $.summernote.ui.button({
		                 contents: '<sub>S</sub>',
		                 tooltip: 'Subscript',
		                 click: function() {
		                     document.execCommand('subscript');
		                 }
		             }).render();
		         }
		     },
		     height: 200
		   });
	

		$('#EditorSafetyReq').summernote({
		    
			 toolbar: [
		         // Adding default toolbar buttons plus custom superscript and subscript
		         ['style', ['bold', 'italic', 'underline', 'clear']],
		         ['font', ['strikethrough', 'superscript', 'subscript']],
		         ['insert', ['picture', 'table']],
		         ['para', ['ul', 'ol', 'paragraph']],
		         ['height', ['height']]
		     ],
		     buttons: {
		         // Custom superscript and subscript buttons
		         superscript: function() {
		             return $.summernote.ui.button({
		                 contents: '<sup>S</sup>',
		                 tooltip: 'Superscript',
		                 click: function() {
		                     document.execCommand('superscript');
		                 }
		             }).render();
		         },
		         subscript: function() {
		             return $.summernote.ui.button({
		                 contents: '<sub>S</sub>',
		                 tooltip: 'Subscript',
		                 click: function() {
		                     document.execCommand('subscript');
		                 }
		             }).render();
		         }
		     },
		     height: 200
		   });
	

		$('#EditorPersonnelResources').summernote({
		    
			 toolbar: [
		         // Adding default toolbar buttons plus custom superscript and subscript
		         ['style', ['bold', 'italic', 'underline', 'clear']],
		         ['font', ['strikethrough', 'superscript', 'subscript']],
		         ['insert', ['picture', 'table']],
		         ['para', ['ul', 'ol', 'paragraph']],
		         ['height', ['height']]
		     ],
		     buttons: {
		         // Custom superscript and subscript buttons
		         superscript: function() {
		             return $.summernote.ui.button({
		                 contents: '<sup>S</sup>',
		                 tooltip: 'Superscript',
		                 click: function() {
		                     document.execCommand('superscript');
		                 }
		             }).render();
		         },
		         subscript: function() {
		             return $.summernote.ui.button({
		                 contents: '<sub>S</sub>',
		                 tooltip: 'Subscript',
		                 click: function() {
		                     document.execCommand('subscript');
		                 }
		             }).render();
		         }
		     },
		     height: 200
		   });

		

		$('#descriptioneditor').summernote({
		   
			 toolbar: [
		         // Adding default toolbar buttons plus custom superscript and subscript
		         ['style', ['bold', 'italic', 'underline', 'clear']],
		         ['font', ['strikethrough', 'superscript', 'subscript']],
		         ['insert', ['picture', 'table']],
		         ['para', ['ul', 'ol', 'paragraph']],
		         ['height', ['height']]
		     ],
		     buttons: {
		         // Custom superscript and subscript buttons
		         superscript: function() {
		             return $.summernote.ui.button({
		                 contents: '<sup>S</sup>',
		                 tooltip: 'Superscript',
		                 click: function() {
		                     document.execCommand('superscript');
		                 }
		             }).render();
		         },
		         subscript: function() {
		             return $.summernote.ui.button({
		                 contents: '<sub>S</sub>',
		                 tooltip: 'Subscript',
		                 click: function() {
		                     document.execCommand('subscript');
		                 }
		             }).render();
		         }
		     },
		     height: 200

		  });
	

	
	
	
		});
	
	
	function submitData(){
		   $('textarea[name=Description]').val($('#descriptioneditor').summernote('code'));
		   $('textarea[name=PersonnelResources]').val($('#EditorPersonnelResources').summernote('code'));
		   $('textarea[name=SafetyReq]').val($('#EditorSafetyReq').summernote('code'));
		   $('textarea[name=PostConditions]').val($('#EditorPostConditions').summernote('code'));
		   $('textarea[name=PreConditions]').val($('#EditorPreConditions').summernote('code'));
		   if(confirm('Are you sure to submit?')){
			   
		   }else{
			   event.preventDefault();
			   return false;
		   }
	}
	</Script>
</body>
</html>