<%@page import="com.vts.pfms.requirements.model.TestSetupMaster"%>
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

<spring:url value="/resources/pdfmake/pdfmake.min.js" var="pdfmake" />
<script src="${pdfmake}"></script>
<spring:url value="/resources/pdfmake/vfs_fonts.js" var="pdfmakefont" />
<script src="${pdfmakefont}"></script>
<spring:url value="/resources/pdfmake/htmltopdf.js" var="htmltopdf" />
<script src="${htmltopdf}"></script>

<spring:url value="/resources/css/sweetalert2.min.css" var="sweetalertCss" />
<spring:url value="/resources/js/sweetalert2.min.js" var="sweetalertJs" />
<link href="${sweetalertCss}" rel="stylesheet" />
<script src="${sweetalertJs}"></script>

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
}


h6 {
	text-decoration: none !important;
}

/* .multiselect-view>li>a>label {
	padding: 4px 20px 3px 20px;
} */
/* .multiselect {
	padding: 4px 90px;
	background-color: white;
	border: 1px solid #ced4da;
	height: calc(2.25rem + 2px);
} */

.multiselect-view>li>a>label {
	padding: 4px 20px 3px 20px;
}

.select2-selection__choice{
	margin-bottom: 5px;
}

</style>
</head>
<body>
</head>
<body>
	<% TestPlanMaster tp = (TestPlanMaster)request.getAttribute("TestPlanMaster");
	List<Object[]>StagesApplicable=(List<Object[]>)request.getAttribute("StagesApplicable");
	List<TestSetupMaster>master = (List<TestSetupMaster>)request.getAttribute("testSetupMasterMaster");
	List<Object[]> specificarionMasterList = (List<Object[]>) request.getAttribute("specificarionMasterList");
	
	List<String>specId = new ArrayList<>();
	
	List<String>stage = new ArrayList<>();
	
	List<String>testTool = new ArrayList<>();
	
	if(tp.getLinkedSpecids()!=null){
		specId = Arrays.asList(tp.getLinkedSpecids().split(", "));
	}
	
	if(tp.getStageApplicable()!=null){
		stage= Arrays.asList(tp.getStageApplicable().split(", "));
	}
	
	if(tp.getToolsSetup()!=null){
		testTool=Arrays.asList(tp.getToolsSetup().split(", "));
	}
	
	String htmlContent = (String)request.getAttribute("htmlContent");
	
%>
<%
List<String>stages =tp.getStageApplicable()!=null && tp.getStageApplicable().length()>0 ? Arrays.asList(tp.getStageApplicable().split(", ")):new ArrayList<>(); 
List<String>rows = tp.getNumberofRows()!=null?Arrays.asList(tp.getNumberofRows().split(", ")):new ArrayList<>(); 
List<String>cycles =tp.getNumberofCycles()!=null? Arrays.asList(tp.getNumberofCycles().split(", ")):new ArrayList<>(); 
%>

	<div class="container" id="container" style="max-width: 95%">
		<form action="TestMasterAddSubmit.htm" method="POST">
			<div class="row" id="row1">

				<div class="col-md-12" id="reqdiv" style="background: white;">
					<div class="card-body" id="cardbody">
					
					<div class="row mb-2">
							<div class="col-md-6">
							<div class="form-group">
								<label
									style="font-size: 17px; margin-left: 0.1rem; color: #07689f">Linked
									Specification<span class="mandatory" style="color: red;">*</span>
								</label>
							
							
										

										<%if( specificarionMasterList!=null && !specificarionMasterList.isEmpty()){ %>
										<select required="required" class="form-control selectdee"
											name="linkedSpec" id="linkedSpec" data-width="80%"
											data-live-search="true" data-placeholder="Choose" multiple>
											<%for(Object[] obj:specificarionMasterList){ %>
											<option value="<%=obj[0]%>"  <%if(specId.contains(obj[0].toString())) {%> selected <%} %>><%=obj[5]%></option>
											<%}%>
										</select>
										<%} else{%>
										<input class="form-control" readonly name="StageApplicable"
											id="StageApplicable" placeholder="No files found">
										<%} %>

									</div>
							</div>
							<%-- <%if(stages.size()>0){ %>
							<div class="col-md-6">
								<button class="btn btn-sm" style="float: right" type="button" onclick="downloadTestStage()"><img alt="" src="view/images/pdf.png" style="width:25px"></button>
							</div>
							<%} %> --%>
							
							
							</div>
							
					
						<div class="row">
							<div class="col-md-6">
							<div class="form-group">
								<label style="font-size: 17px; margin-left: 0.1rem; color: #07689f">Test
								Name<span class="mandatory" style="color: red;">*</span>
								</label>
						
								<input type="text" name="name" class="form-control" id="NameAdd"
									maxlength="255" required="required"
									placeholder="Maximum 250 Chararcters" value="<%if(tp.getName()!=null){%><%=tp.getName() %> <%}%>">
							</div></div>

							<div class="col-md-6">
								<div class="form-group">
								<label
									style="font-size: 17px; margin-left: 0.1rem; color: #07689f">Objective<span
									class="mandatory" style="color: red;">*</span>
								</label>
						
								<input type="text" name="Objective" class="form-control"
									id="ObjectiveAdd" maxlength="255" required="required"
									placeholder="Maximum 250 Chararcters"
								 value="<%if(tp.getObjective()!=null){%><%=tp.getObjective() %> <%}%>">
							</div></div>
						</div>

						<div class="row"></div>

						<div class="row mt-2">
							<div class="col-md-6">
								
									<div class="form-group">
										<label style="font-size: 17px; color: #07689f; ">
											Methodology <span class="mandatory" style="color: red;">*</span>
										</label>
								
									<%-- 	<input class="form-control" name="Methodology"
											id="MethodologyAdd" required  value="<%if(tp.getMethodology()!=null){%><%=tp.getMethodology() %> <%}%>">
									
									 --%>
									 
									 <select class="form-control selectdee" name="Methodology" id="MethodologyAdd" data-width="100%" data-live-search="true"   data-placeholder="Choose" required="required">
										<option value="" disabled="disabled" selected="selected">SELECT</option>
										<option value="D" <%if(tp.getMethodology()!=null && tp.getMethodology().equalsIgnoreCase("D")){%> selected<%} %>>Demonstration</option>
										<option value="T" <%if(tp.getMethodology()!=null && tp.getMethodology().equalsIgnoreCase("T")){%> selected<%} %>>Test</option>
										<option value="A" <%if(tp.getMethodology()!=null && tp.getMethodology().equalsIgnoreCase("A")){%> selected<%} %>>Analysis/Design</option>
										<option value="I" <%if(tp.getMethodology()!=null && tp.getMethodology().equalsIgnoreCase("I")){%> selected<%} %>>Inspection</option>
										<option value="S" <%if(tp.getMethodology()!=null && tp.getMethodology().equalsIgnoreCase("S")){%> selected<%} %>>Special Verification Methods </option>
										</select>
									</div>
								
							</div>

							<div class="col-md-6">
							
									<div class="form-group">
										<label style="font-size: 17px; color: #07689f;">
											Test-Setup <span class="mandatory" style="color: red;">*</span>
										</label>
								
										<%-- <input class="form-control" name="ToolsSetup" style=""
											required="required"  value="<%if(tp.getToolsSetup()!=null){%><%=tp.getToolsSetup() %> <%}%>"> --%>
									<select class="form-control selectdee" name="ToolsSetup" id="ToolsSetup" data-width="100%" data-live-search="true"   data-placeholder="Choose"">
										<option value="" selected  disabled="disabled">SELECT</option>
									<%for (TestSetupMaster t :master) {%><option value="<%=t.getSetupId()%>"   <%if(testTool.contains(t.getSetupId()+"")){ %> selected <%} %>><%=t.getTestSetUpId() %></option>
													<%} %>
												</select>
									</div>
							</div>
						</div>

						<div class="form-group row mt-2">
							<div class="col-md-6">
								<div class="row">
									<div class="col-md-3">
										<label style="font-size: 17px; color: #07689f;">
											Constraints <span class="mandatory" style="color: red;">*</span>
										</label>
									</div>
									<div class="col-md-12" style="">
										<input type="text" name="Constraints" class="form-control"
											id="ConstraintsAdd" maxlength="255" required
											placeholder="Maximum 250 Chararcters" value="<%if(tp.getConstraints()!=null){%><%=tp.getConstraints() %> <%}%>">
									</div>
								</div>
							</div>

							<div class="col-md-6">
								<div class="row">
									<div class="col-md-12">
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

						<div class="row">
							<div class="col-md-6">
							
									<div class="form-group">
										<label style="font-size: 17px; color: #07689f;">
											Iterations <span class="mandatory" style="color: red;">*</span>
										</label>
									
								
										<input type="text" name="Iterations" class="form-control"
											id="IterationsAdd" maxlength="255" required="required"
											placeholder="Maximum 250 Chararcters"  value="<%if(tp.getIterations()!=null){%><%=tp.getIterations() %> <%}%>">
									</div>
								
							</div>

							<div class="col-md-6">
							
									<div class="form-group">
										<label style="font-size: 17px; color: #07689f;">
											Schedule <span class="mandatory" style="color: red;">*</span>
										</label>
									
										<input type="text" name="Schedule" class="form-control"
											id="ScheduleAdd" min="1" required="required"
											value="<%if(tp.getSchedule()!=null){%><%=tp.getSchedule()%> <%}%>">
									</div>
								
								
							</div>
						</div>

						<div class="row mt-2">
							<div class="col-md-6">
							
									<div class="form-group">
										<label style="font-size: 17px; color: #07689f;">
											Criteria <span class="mandatory" style="color: red;">*</span>
										</label>
								
										<input type="text" name="PassFailCriteria"
											class="form-control" id="PassFailCriteriaAdd" maxlength="255"
											required="required" placeholder="Maximum 250 Chararcters" value="<%if(tp.getPass_Fail_Criteria()!=null){%><%=tp.getPass_Fail_Criteria()%> <%}%>">
									</div>
							
							</div>

							<div class="col-md-6">
								
								<%-- 	<div class="form-group">
										<label style="font-size: 17px; color: #07689f;"> Stage
											<span class="mandatory" style="color: red;">*</span>
										</label>
									

										<%if(!StagesApplicable.isEmpty()){ %>
										<select required="required" class="form-control selectdee"
											name="StageApplicable" id="StageApplicable" data-width="100%"
											data-live-search="true" data-placeholder="Choose" multiple>
											<%for(Object[] obj:StagesApplicable){ %>
											<option value="<%=obj[3]%>"  <%if(stage.contains(obj[3].toString())) {%>  selected<%} %>><%=obj[3]%></option>
											<%}%>
										</select>
										<%} else{%>
										<input class="form-control" readonly name="StageApplicable"
											id="StageApplicable" placeholder="No files found">
										<%} %>

									</div> --%>
								
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
								<%if(tp!=null && tp.getStageApplicable()!=null && tp.getStageApplicable().length()>0 ){ %>
								<table class="table table-bordered">
								<thead style=" background: #055C9D; color: white;">
										<tr>
											<th>Stage</th>
											<th>Number of rows</th>
											<th>Number of cycles</th>
											<th>
											<%if(tp.getTestMasterId()!=null){ %>
											<button type="button" onclick="deleteStages('<%=tp.getTestMasterId()%>')" class="btn bg-transparent">
											<i class="fa fa-trash" aria-hidden="true" style="color:red;"></i></button>
											<%} %>
											</th>
										</tr>
									</thead>
							
									<tbody>
									<%for(int i=0;i<stages.size();i++){
										if(stages.get(i).length()>0){
										%>
									<tr><td><%=stages.get(i) %></td>
									<td><%if(rows!=null && stages!=null && rows.size()==stages.size()) {%>
									 <%=rows.get(i) %> <%}else {%>  0 <%} %></td>
										<td colspan="2"> <%if(cycles!=null && stages!=null && cycles.size()==stages.size()) {%>
									 <%=cycles.get(i) %> <%}else {%>  0 <%} %></td>
									</tr>
									<%}} %>
								</tbody>
								</table>

								<%} %>
								<table class="table table-bordered">
									<thead style=" background: #055C9D; color: white;">
										<tr>
											<th>Stage</th>
											<th>Number of rows</th>
											<th>Number of cycles</th>
											<th>Action</th>
											
										</tr>
									</thead>
									<tbody id="specificationTable">
										<tr>
											<td><select required="required"
												class="form-control selectItem StageApplicable" name="StageApplicable"
												id="StageApplicable_1" data-width="100%"
												data-live-search="true" data-placeholder="Choose">
													<option val="" selected disabled>Choose...</option>
													<%
													for (Object[] obj : StagesApplicable) {
													if(stage!=null  && !stage.contains(obj[3].toString()))	{
													%>
													<option value="<%=obj[3]%>"><%=obj[3]%></option>
													<%
													}}
													%>
											</select></td>
											<td style="width: 30%;"><input type="number" name="rows"
												class="form-control" maxlength="5" required
												placeholder="Max 5 Characters" value="0"></td>
											<td><input type="number" name="cycle" class="form-control"
												maxlength="250" required placeholder="Max 250 Characters" value="0"></td>
											<td><button type="button" class="btn btn-sm"
													id="plusbutton">
													<i class="fa fa-plus" aria-hidden="true"></i>
												</button></td>
										</tr>
									</tbody>
								</table>
							</div>
							
					
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
	
	<div class="modal" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Modal title</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        ${htmlContent}
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
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
	
	
	function initializeSelect2ForAll() {
	    // Clean up and reinitialize all select2
	    $('.StageApplicable').each(function () {
	        // Destroy existing Select2 if initialized
	        if ($(this).hasClass("select2-hidden-accessible")) {
	            $(this).select2('destroy');
	        }
	        // Reinitialize
	        $(this).select2({ width: '100%' });
	    });
	}
	
	$(document).ready(function () {
	    // Initialize all existing selects
	    initializeSelect2ForAll();
	});    
	// Delegate event for dynamically added buttons
    var count = 1;
    $('#specificationTable').on('click', '.btn', function () {
    	
    	let $button = $(this);
        
        // If button is plus
        if ($button.find('i').hasClass('fa-plus')) {
            let $row = $button.closest('tr').clone();
			++count;

		    // Clean up old select2 from clone
		    $row.find('.select2-container').remove();
		    $row.find('.StageApplicable')
		        .removeClass('select2-hidden-accessible')
		        .removeAttr('data-select2-id')
		        .removeAttr('aria-hidden')
		        .removeAttr('tabindex');
		    
            // Change the button to minus
            $row.find('i').removeClass('fa-plus').addClass('fa-minus');
            $row.find('.btn').removeAttr('id'); // Remove ID from cloned row's button
            $row.find('.StageApplicable').val('').attr("id", "StageApplicable_"+count);
            
            // Clear inputs
            $row.find('input').val('');

            $('#specificationTable').append($row);
            
            initializeSelect2ForAll();
        }
        // If button is minus
        else if ($button.find('i').hasClass('fa-minus')) {
            $button.closest('tr').remove();
        }
    });
    
    
    function getVisibleTableHtml() {
    	  // Clone the table and remove hidden rows
    	  var visibleTableHtml = $(".htmlTable").html()
    	   

    	  return visibleTableHtml;
    	}
    
    
	function downloadTestStage(){

		
		/*   var maxRows = 11; // how many rows to show
		    $(".htmlTable tr").each(function (index) {
		      if (index >= maxRows) {
		        $(this).hide();
		      }
		    }); */
		    
		    var visibleTableHtml = $(".htmlTable").html()
		 /*  console.log(visibleTableHtml) */
		 /*    var cleanedHtml = setImagesWidth(visibleTableHtml, 500);
		    var pdfContent = { stack: [htmlToPdfmake(setImagesWidth(visibleTableHtml, 500))], colSpan: 2 }; */
		
		var chapterCount = 0;
	    var mainContentCount = 0;
		<%-- var leftSideNote = '<%if(DocTempAtrr!=null && DocTempAtrr[12]!=null) {%><%=DocTempAtrr[12].toString().replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", "") %> <%} else{%>-<%}%>'; --%>
		
		var docDefinition = {
	            content: [
	                // Cover Page with Project Name and Logo
	                {
	                    text: htmlToPdfmake('<h4 class="heading-color ">Test Stage Document for <br> <br> '+'<%if(tp.getName()!=null){%><%=tp.getName().trim() %> <%}%>' +' </h4>'),
	                    style: 'DocumentName',
	                    alignment: 'center',
	                    fontSize: 18,
	                    margin: [0, 200, 0, 20]
	                },
	              <%--   <% if (lablogo != null) { %>
	                {
	                    image: 'data:image/png;base64,<%= lablogo %>',
	                    width: 95,
	                    height: 95,
	                    alignment: 'center',
	                    margin: [0, 20, 0, 30]
	                },
	                <% } %>
	                
	                {
	                    text: htmlToPdfmake('<h5><% if (LabList != null && LabList[1] != null) { %> <%= LabList[1].toString().replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", "") + "(" + LabList[0].toString().replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", "") + ")" %> <% } else { %> '-' <% } %></h5>'),
	                    alignment: 'center',
	                    fontSize: 16,
	                    bold: true,
	                    margin: [0, 20, 0, 20]
	                },
	                {
	                    text: htmlToPdfmake('<h6>Government of India, Ministry of Defence<br>Defence Research & Development Organization </h6>'),
	                    alignment: 'center',
	                    fontSize: 14,
	                    bold: true,
	                    margin: [0, 10, 0, 10]
	                },
	                {
	                    text: htmlToPdfmake('<h6><%if(LabList!=null && LabList[2]!=null && LabList[3]!=null && LabList[5]!=null){ %><%=LabList[2]+" , "+LabList[3].toString()+", PIN-"+LabList[5].toString() %><%}else{ %>-<%} %></h6>'),
	                    alignment: 'center',
	                    fontSize: 14,
	                    bold: true,
	                    margin: [0, 10, 0, 10]
	                }, --%>
	                // Table of Contents
	                {
	                    toc: {
	                        title: { text: 'INDEX', style: 'header', pageBreak: 'before' }
	                    }
	                
	                },
	                {
	                    text: '',
	                    pageBreak: 'before'
	                },
	             <% if(stages!=null && !stages.isEmpty()){
		                
		                int speccount=0;
		                
		                for(int i=0;i<stages.size();i++){
		                	int snCount=0;
		                	int rowCount = 0;
		                	if(stages.size()==rows.size() && rows.get(i).length()>0){
		                		rowCount= Integer.parseInt(rows.get(i)) ;
		                	}
		                	if(rowCount>0){
		                %>
		                
		            	{
	            		    text: [
	            		        {
	            		            text: '<%=++speccount %>. <%=stages.get(i)  %> ',
	            		            tocItem: true ,// Only this text goes to TOC
	            		            margin: [0, 40, 0, 10]
	            		        },
	            		       
	            		    ],
	            		    style: 'chapterSubHeader',
	            		    id: 'chapter-<%=speccount %>',
	            		    tocMargin: [10, 20, 0, 0],
	            		  
	            		},
	            		 { stack: [htmlToPdfmake(setImagesWidth('<table>'+ visibleTableHtml +'</table>', 500))], colSpan: 2 },
	   					{
           				table : {
           					headerRows : 1,
           					widths: ['5%', '15%', '20%','20%','20%','20%'],
   	                        body: [
   	                            // Table header
   	                            [
   	                                { text: 'SN', style: 'tableHeader' },
   	                                { text: 'Frequency', style: 'tableHeader' },
   	                                { text: 'Measure Power Level', style: 'tableHeader' },
   	                                { text: 'Cable', style: 'tableHeader' },
   	                                { text: 'Calculated Power Level', style: 'tableHeader' },
   	                                { text: 'Remarks', style: 'tableHeader' },
   	                            ],
   	                            
   	                            <%for(int j=0;j<rowCount;j++) { %>
   	                             [
   	                                { text: '<%=j+1 %>.', style: 'tableData', alignment: 'center' },
   	                                { text: '', style: 'tableData' },
   	                                { text: '', style: 'tableData' },
   	                                { text: '', style: 'tableData' },
   	                                { text: '', style: 'tableData' },
   	                                { text: '', style: 'tableData' },
   	                            ],
   	                         
   	                        
   	                        <%}%>
   	                        ],
   	                    },
   	                    layout: {

   	                        hLineWidth: function(i, node) {
   	                            return (i === 0 || i === node.table.body.length) ? 1 : 0.5;
   	                        },
   	                        vLineWidth: function(i) {
   	                            return 0.5;
   	                        },
   	                        hLineColor: function(i) {
   	                            return '#aaaaaa';
   	                        },
   	                        vLineColor: function(i) {
   	                            return '#aaaaaa';
   	                        }
   	                    }
   					}, 
   					
   					<%if(i!=stages.size()-1){%>
   					
   				 	{
	                    text: '',
	                    pageBreak: 'before'
	                },
	                
	                <%}%>
   					{ text: '\n',},
		                
		                <%}}}%> 
	      
	                ],
				
				/* last */
	            styles: {
	                DocumentName: { fontSize: 18, bold: true, margin: [0, 0, 0, 10] },
	                chapterHeader: { fontSize: 16, bold: true, margin: [0, 0, 0, 10] },
	                chapterNote: { fontSize: 13, bold: true, margin: [0, 10, 0, 10]},
	                chapterSubHeader: { fontSize: 13, bold: true, margin: [10, 10, 0, 10]},
	                tableHeader: { fontSize: 10, bold: true, fillColor: '#f0f0f0', alignment: 'center', margin: [10, 5, 10, 5], fontWeight: 'bold' },
	                tableData: { fontSize: 11.5, margin: [0, 5, 0, 5] },
	                chapterSubSubHeader: { fontSize: 12, bold: true, margin: [15, 10, 10, 10] },
	                subChapterNote: { margin: [15, 15, 0, 10] },
	                header: { alignment: 'center', bold: true},
	                chapterContent: {fontSize: 11.5, margin: [0, 5, 0, 5] },
	            },
	            info: {
	                title: 'Test SetUp Document', // Set document title here
	                author: 'LRDE', // Optional metadata
	                subject: 'Subject of the PDF',       // Optional metadata
	                keywords: 'keyword1, keyword2',     // Optional metadata
	            },
	            footer: function(currentPage, pageCount) {
	                if (currentPage > 2) {
	                    return {
	                        stack: [
	                        	{
	                                canvas: [{ type: 'line', x1: 30, y1: 0, x2: 565, y2: 0, lineWidth: 1 }]
	                            },
	                            {
	                                columns: [
	                                    { text: currentPage.toString() + ' of ' + pageCount, alignment: 'right', margin: [0, 0, 30, 0], fontSize: 8 }
	                                ]
	                            },
	                            { text: 'Restricted', alignment: 'center', fontSize: 8, margin: [0, 5, 0, 0], bold: true }
	                        ]
	                    };
	                }
	                return '';
	            },
	            header: function (currentPage) {
	                return {
	                    stack: [
	                        
	                        {
	                            columns: [
	                            /*     {
	                                    // Left: Lab logo
	                                   
	                                    width: 30,
	                                    height: 30,
	                                    alignment: 'left',
	                                    margin: [35, 10, 0, 10]
	                                }, */
	                                {
	                                    // Center: Text
	                                    text: 'Restricted',
	                                    alignment: 'center',
	                                    fontSize: 10,
	                                    bold: true,
	                                    margin: [0, 10, 0, 0]
	                                }
	                              /*   {
	                                    // Right: DRDO logo
	                                   
	                                    width: 30,
	                                    height: 30,
	                                    alignment: 'right',
	                                    margin: [0, 10, 20, 10]
	                                } */
	                            ]
	                        },
	                        
	                    ]
	                };
	            },
				pageMargins: [50, 50, 30, 40],
	            
	       /*      background: function(currentPage) {
	                return [
	                    {
	                        image: generateRotatedTextImage(leftSideNote),
	                        width: 100, // Adjust as necessary for your content
	                        absolutePosition: { x: -10, y: 50 }, // Position as needed 
	                    }
	                ];
	            }, */
	            watermark: { text: 'DRAFT', opacity: 0.1, bold: true, italics: false, fontSize: 80,  },
	           
	            defaultStyle: { fontSize: 12, color: 'black', }
	        };
			
		 pdfMake.createPdf(docDefinition).getBlob((blob) => {
	         // Create a URL for the blob
	         const url = URL.createObjectURL(blob);

	         // Open the PDF in a new tab
	         window.open(url, '_blank');

	         // Hide the loading spinner
	          /*  document.getElementById('loadingOverlay').style.display='none';
	           window.close(); */
	     });
	}

	const setImagesWidth = (htmlString, width) => {
	    const container = document.createElement('div');
	    container.innerHTML = htmlString;
	  
	    const images = container.querySelectorAll('img');
	    images.forEach(img => {
	      img.style.width = width + 'px';
	      img.style.textAlign = 'center';
	    });
	  
	    const textElements = container.querySelectorAll('p, h1, h2, h3, h4, h5, h6, span, div, td, th, table, figure, hr, ul, li, a');
	    textElements.forEach(element => {
	      if (element.style) {
	        element.style.fontFamily = '';
	        element.style.margin = '';
	        element.style.marginTop = '';
	        element.style.marginRight = '';
	        element.style.marginBottom = '';
	        element.style.marginLeft = '';
	        element.style.lineHeight = '';
	        element.style.height = '';
	        element.style.width = '';
	        element.style.padding = '';
	        element.style.paddingTop = '';
	        element.style.paddingRight = '';
	        element.style.paddingBottom = '';
	        element.style.paddingLeft = '';
	        element.style.fontSize = '';
	        element.id = '';
	        
	        const elementColor = element.style.color;
	        if (elementColor && elementColor.startsWith("var")) {
	            // Replace `var(...)` with a fallback or remove it
	            element.style.color = 'black'; // Default color
	        }
	        
	        const elementbackgroundColor = element.style.backgroundColor;
	        if (elementbackgroundColor && elementbackgroundColor.startsWith("var")) {
	            // Replace `var(...)` with a fallback or remove it
	            element.style.backgroundColor = 'transparent'; // Set a default or fallback background color
	        }
	        
	      }
	    });
	  
	    const tables = container.querySelectorAll('table');
	    tables.forEach(table => {
	      if (table.style) {
	        table.style.borderCollapse = 'collapse';
	        table.style.width = '100%';
	      }
	  
	      const cells = table.querySelectorAll('th, td');
	      cells.forEach(cell => {
	        if (cell.style) {
	          cell.style.border = '1px solid black';
	  
	          if (cell.tagName.toLowerCase() === 'th') {
	            cell.style.textAlign = 'center';
	          }
	        }
	      });
	    });
	  
	    return container.innerHTML;
	}; 
		
	function splitTextIntoLines(text, maxLength) {
		const lines = [];
	  	let currentLine = '';

		for (const word of text.split(' ')) {
			if ((currentLine + word).length > maxLength) {
		    	lines.push(currentLine.trim());
		    	currentLine = word + ' ';
			} else {
			  currentLine += word + ' ';
			}
		}
	  	lines.push(currentLine.trim());
	  	return lines;
	}

	// Generate rotated text image with line-wrapped text
	function generateRotatedTextImage(text) {
		const maxLength = 260;
		const lines = splitTextIntoLines(text, maxLength);
		
		const canvas = document.createElement('canvas');
		const ctx = canvas.getContext('2d');
		
		// Set canvas dimensions based on anticipated text size and rotation
		canvas.width = 200;
		canvas.height = 1560;
		
		// Set text styling
		ctx.font = '14px Roboto';
		ctx.fillStyle = 'rgba(128, 128, 128, 1)'; // Gray color for watermark
		
		// Position and rotate canvas
		ctx.translate(80, 1480); // Adjust position as needed
		ctx.rotate(-Math.PI / 2); // Rotate 270 degrees
		
		// Draw each line with a fixed vertical gap
		const lineHeight = 20; // Adjust line height if needed
		lines.forEach((line, index) => {
		  ctx.fillText(line, 0, index * lineHeight); // Position each line below the previous
		});
		
		return canvas.toDataURL();
	}

	function deleteStages(a){
		
	      Swal.fire({
	            title: 'Kindly Note it will delete all the stages?Are you sure to delete Stages?',
	            icon: 'question',
	            showCancelButton: true,
	            confirmButtonColor: 'green',
	            cancelButtonColor: '#d33',
	            confirmButtonText: 'Yes'
	        }).then((result) => {
	            if (result.isConfirmed) {
		$.ajax({
		
			type:'GET',
			url:'deleteSatagesForTestPlan.htm',
			data:{
				id:a
			},
			datatype:'json',
			  success: function(response) {
	            	
            	  Swal.fire({
		    	       	title: "Success",
		                text: "Stages deleted Successfully",
		                icon: "success",
		                allowOutsideClick :false
		         		});
            	 
            	  $('.swal2-confirm').click(function (){
      	                location.reload();
      	        	})
            },
            error: function(xhr, status, error) {
            	  Swal.fire({
                      icon: 'error',
                      title: 'Error',
                      text: 'An error occurred while deleting the Stages'
                  });
                  console.log(xhr.responseText);
             }
			
		})
	            }
	        });
	            
	}
	
	
	 $(document).ready(function () {
		    var maxRows = 10; // how many rows to show
		    $(".htmlTable tr").each(function (index) {
		      if (index >= maxRows) {
		        $(this).hide();
		      }
		    });
		  });
	</Script>
</body>
</html>