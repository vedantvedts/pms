<%@page import="java.util.Arrays"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<style type="text/css">
label {
	font-weight: bold;
	font-size: 13px;
}

.table .font {
	font-family: 'Muli', sans-serif !important;
	font-style: normal;
	font-size: 13px;
	font-weight: 400 !important;
}

.card{
box-shadow: rgba(0, 0, 0, 0.25) 0px 4px 14px;
border-radius: 10px;
border: 0px;
}

.table button {
	background-color: Transparent !important;
	background-repeat: no-repeat;
	border: none;
	cursor: pointer;
	overflow: hidden;
	outline: none;
	text-align: left !important;
}

.table td {
	padding: 5px !important;
}

.resubmitted {
	color: green;
}

.fa-long-arrow-right {
	font-size: 2.20rem;
	padding: 0px 5px;
}

.datatable-dashv1-list table tbody tr td {
	padding: 8px 10px !important;
}

.card-deck{
display: grid;
  grid-template-columns: 1fr 1fr 1fr;
}

.pagin{
display: grid;
float:left;
  grid-template-columns: 1fr 1fr 1fr;
}

.table-project-n {
	color: #005086;
}

#table thead tr th {
	padding: 0px 0px !important;
}

#table tbody tr td {
	padding: 2px 3px !important;
}

/* icon styles */
.cc-rockmenu {
	color: fff;
	padding: 0px 5px;
	font-family: 'Lato', sans-serif;
	height: 28px;
}

.col-xl{
height: 28px;
}

.cc-rockmenu .rolling {
	display: inline-block;
	cursor: pointer;
	width: 34px;
	height: 28px;
	text-align: left;
	overflow: hidden;
	transition: all 0.3s ease-out;
	white-space: nowrap;
}

.cc-rockmenu .rolling:hover {
	width: 108px;
}

.cc-rockmenu .rolling .rolling_icon {
	float: left;
	z-index: 9;
	display: inline-block;
	width: 28px;
	height: 28px;
	box-sizing: border-box;
	margin: 0 5px 0 0;
}

.sameline{
display: inline-block;
}

.cc-rockmenu .rolling .rolling_icon:hover .rolling {
	width: 312px;
}

.cc-rockmenu .rolling i.fa {
	font-size: 20px;
	padding: 6px;
}

.cc-rockmenu .rolling span {
	display: block;
	font-weight: bold;
	padding: 2px 0;
	font-size: 14px;
	font-family: 'Muli', sans-serif;
}

.editable-click{
float: left;
z-index: 9;
white-space: nowrap;
height: 28px;
margin: 0 5px 0 0;
box-sizing: border-box;
display: inline-block;
}

.editable-clicko{
z-index: 9;
white-space: nowrap;
height: 28px;
margin: 0 5px 0 0;
box-sizing: border-box;
display: inline-block;
background: none;border-style: none;
}

.cc-rockmenu .rolling p {
	margin: 0;
}

.width {
	width: 270px !important;
}

.label {
	border-radius: 3px;
	color: white;
	padding: 1px 2px;
}

.label-primary {
	background-color: #D62AD0; /* D62AD0 */
}

.label-warning {
	background-color: #5C33F6;
}

.label-info {
	background-color: #006400;
}

.label-success {
	background-color: #4B0082;
}

.trup {
	padding: 5px 10px 0px 10px;
	border-top-left-radius: 5px;
	border-top-right-radius: 5px;
	font-size: 14px;
	font-weight: 600;
}

.trdown {
	padding: 0px 10px 5px 10px;
	border-bottom-left-radius: 5px;
	border-bottom-right-radius: 5px;
	font-size: 14px;
	font-weight: 600;
}

.btn-status {
  position: relative;
  z-index: 1; 
}

.btn-status:hover {
  transform: scale(1.05);
  z-index: 5;
  box-shadow: 0 0 20px rgba(0, 0, 0, 0.5);
}
</style>

</head>
<body>
<%
String projectType = (String)request.getAttribute("projectType");
String projectId =(String)request.getAttribute("projectId");
String initiationId =(String)request.getAttribute("initiationId");
String productTreeMainId =(String)request.getAttribute("productTreeMainId");
List<Object[]> ProjectList = (List<Object[]>) request.getAttribute("ProjectList");
List<Object[]> preProjectList = (List<Object[]>) request.getAttribute("preProjectList");
List<Object[]> productTreeList = (List<Object[]>) request.getAttribute("productTreeList");
List<Object[]> initiationSpecList = (List<Object[]>) request.getAttribute("initiationSpecList");
List<Object[]>  getSpecsPlanApprovalFlowData = (List<Object[]> ) request.getAttribute("getSpecsPlanApprovalFlowData");

Object[]tempflow=null;
if(getSpecsPlanApprovalFlowData!=null && getSpecsPlanApprovalFlowData.size()>0){
	tempflow=getSpecsPlanApprovalFlowData.get(0);
}
List<String> reqforwardstatus = Arrays.asList("RIN","RRR","RRA");

Object[] projectDetails = (Object[]) request.getAttribute("projectDetails");

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
			<div class="col-md-12">
				<div class="card shadow-nohover" style="margin-top: -0.6pc">
					<div class="row card-header" style="background: #C4DDFF; box-shadow: 2px 2px 2px grey;">
						<div <%if(projectType.equalsIgnoreCase("M")){ %> class="col-md-3" <%} else{%> class="col-md-4" <%} %> id="projecthead" align="left">
							<h5 id="text" style="margin-left: 1%; font-weight: 600">Project Specifications </h5>
						</div>
						<div class="col-md-2">
            				<label class="control-label ml-4" style="font-weight: bolder;font-size: 15px;float:right;color:#07689f;">Project Type</label>
        
    					</div>
					    <div class="col-md-2" style="margin-top:-4px;">
					    	<select class="form-control" id="projectType"  name="projectType" style=" margin-top:-6px">
					        	<option disabled="disabled" selected value="">Choose...</option>
					        	<option value="M" <%if(projectType.equalsIgnoreCase("M")){ %> selected="selected" <% }%>>Main Project</option>
					         	<option value="I" <%if(projectType.equalsIgnoreCase("I")){ %> selected="selected" <% }%>>Initiation Project</option>
					    	</select>
					    </div>
						<div class="col-md-2" >
							<form class="form-inline" method="POST" action="ProjectSpecification.htm">
								<div class="row W-100" style="width: 100%; margin-top: -3.5%;">
									<div class="col-md-4" id="div1">
										<label class="control-label mt-2" style="font-size: 15px; color: #07689f;"><b>Project:</b></label>
									</div>
									<div class="col-md-8" style="" id="projectname">
										<%if(projectType.equalsIgnoreCase("M")){ %>
										<select class="form-control selectdee" id="projectId" name="projectId" style="width: 200px;">
					
											<%
												if(ProjectList!=null && ProjectList.size()>0){
													for (Object[] obj : ProjectList) {
														String projectshortName1 = (obj[17] != null) ? " ( " + obj[17].toString() + " ) " : ""; %>
														<option value="<%=obj[0]%>"  <%if(obj[0].toString().equalsIgnoreCase(projectId)){ %> selected <%} %>>
															<%=obj[4]+projectshortName1 %>
														</option>
											<%} }%>
										</select>
										<%} else{%>
										<select class="form-control selectdee" id="initiationId" name="initiationId" style="width: 200px;">
					
											<%
												if(preProjectList!=null && preProjectList.size()>0){
													for (Object[] obj : preProjectList) {
														%>
														<option value="<%=obj[0]%>"  <%if(obj[0].toString().equalsIgnoreCase(initiationId)){ %> selected <%} %>>
															<%=obj[3]+"( "+obj[2]+" )" %>
														</option>
											<%} }%>
										</select>	
										<%} %>
									</div>
									<input type="hidden" name="${_csrf.parameterName}"value="${_csrf.token}" /> 
									<input id="submit" type="submit" name="submit" value="Submit" hidden="hidden">
									<input type="hidden" name="projectType" id="projectType3" value="<%=projectType %>">
								</div>
							</form>
						</div>
						<%if(projectType.equalsIgnoreCase("M")){ %>
						<div class="col-md-3">
							<form class="form-inline" method="POST" action="ProjectSpecification.htm">
								<div class="row W-100" style="width: 100%; margin-top: -1.5%;">
									<div class="col-md-4" id="div1">
										<label class="control-label mt-2" style="font-size: 15px; color: #07689f;"><b>System:</b></label>
									</div>
									<div class="col-md-8">
										<select class="form-control selectdee" id="productTreeMainId" name="productTreeMainId" onchange="this.form.submit()" style="width: 200px;">
											<%if(projectDetails!=null) {%>
												<option value="0"><%=projectDetails[1]+"( "+projectDetails[2]+")" %> </option>
											<%} %>
											<%
												if(productTreeList!=null && productTreeList.size()>0){
													for (Object[] obj : productTreeList) {
														 %>
														<option value="<%=obj[0]%>" <%if(obj[0].toString().equalsIgnoreCase(productTreeMainId)){ %> selected <%} %>>
															<%=obj[1]+" "+obj[2] %>
														</option>
											<%} }%>
										</select>
									</div>
									<input type="hidden" name="${_csrf.parameterName}"value="${_csrf.token}" /> 
									<input type="hidden" name="projectId" id="projectId2" value="<%=projectId %>">
									<%-- <input type="hidden" name="projectType"  value="<%=projectType %>"> --%>
									<!-- <input id="submit" type="submit" name="submit" value="Submit" hidden="hidden"> -->
								</div>
							</form>
						</div>
						<%} %>
					</div>
				</div>
				<div class="card">
					<div class="card-body">
						<div class="table-responsive">
							<table class="table table-bordered table-hover table-striped table-condensed "  id="myTable"> 
	                        	<thead style="text-align: center;">
	                            	<tr>
	                                	<th style="width: 5%;">SN</th>
	                                	<th style="width: 30%;">Initiated By</th>
	                                	<th style="width: 10%;">Initiated Date</th>
	                                	<th style="width: 10%;">Version</th>
	                               		<th style="width: 25%;">Status</th>
	                              		<th style="width: 20%;">Action</th>
	                                </tr>
	                         	</thead>
	                      		<tbody>
	                      			<%if(initiationSpecList!=null && initiationSpecList.size()>0) {
	                      				int slno=0;
	                      				for(Object[] obj:initiationSpecList) {%>
	                      			<tr>
	                      				<td align="center" ><%=++slno %> </td>
	                      				<td><%=obj[6]+", "+obj[7] %></td>
	                      				<td align="center"><%if(obj[5]!=null) {%><%=fc.SqlToRegularDate(obj[5].toString()) %><%} else{%><%} %></td>
	                      				<td align="center" >v<%=obj[8]%></td>
	                      				<td align="center" >
	                      					<form action="#">
				                            	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				                            	<input type="hidden" name="testPlanInitiationId" value="<%=obj[0] %>">
				                            	<input type="hidden" name="docType" value="S">
				                            	<button type="submit" class="btn btn-sm btn-link w-70 btn-status" formaction="ProjectDocTransStatus.htm" data-toggle="tooltip" data-placement="top" title="Transaction History" style=" color: <%=obj[11] %>; font-weight: 600;" formtarget="_blank">
											    	<%=obj[10] %> <i class="fa fa-telegram" aria-hidden="true" style="float: right;margin-top: 0.3rem;"></i>
												</button>
	                                        </form>
	                      				</td>
	                      				<td align="center" >
	                      					<form action="#" method="POST" name="myfrm" style="display: inline">
												
												<%if(obj[9]!=null && reqforwardstatus.contains(obj[9].toString()) ) {%>
													
													<button class="editable-clicko" formaction="ProjectSpecificationDetails.htm" >
														<div class="cc-rockmenu">
															<div class="rolling">
																<figure class="rolling_icon">
																	<img src="view/images/preview3.png">
																</figure>
																<span>Preview</span>
															</div>
														</div>
													</button>
													
												 	<button type="submit" class="editable-clicko" formaction="SpecificationApproval.htm" data-toggle="tooltip" data-placement="top" title="Forward" onclick="return confirm('Are You Sure To Forward this Requirement?');">
														<div class="cc-rockmenu">
															<div class="rolling">
																<figure class="rolling_icon">
																	<img src="view/images/forward1.png">
																</figure>
																<span>Forward</span>
															</div>
														</div>
													</button> 
													<input type="hidden" name="Action" value="A">
													
												<%} %>
													<%if(obj[9]!=null && "RFA".equalsIgnoreCase(obj[9].toString()) ) {%>
													<button type="button" class="editable-clicko" data-placement="top" title="Amend" data-toggle="modal" data-target="#myModal" onclick="setversiondata('<%=obj[8]%>','<%=obj[0]%>')">
														<div class="cc-rockmenu">
															<div class="rolling">
																<figure class="rolling_icon">
																	<img src="view/images/correction.png" style="width: 28px;">
																</figure>
																<span>Amend</span>
															</div>
														</div>
													</button>
												<%} %>
												<%if(obj[9]!=null && (!Arrays.asList("RFA","RAM").contains(obj[9].toString()))) {%>
												<button class="editable-clicko" formaction="SpecificationDocumentDownlod.htm" formtarget="blank" >
													<div class="cc-rockmenu">
														<div class="rolling">
															<figure class="rolling_icon">
																<img src="view/images/worddoc.png">
															</figure>
															<span>Document</span>
														</div>
													</div>
												</button>
												<%} %>
												<button class="editable-clicko" <%if(obj[9]!=null && ("RFA".equalsIgnoreCase(obj[9].toString()) ||  "RAM".equalsIgnoreCase(obj[9].toString()))) {%>formaction="SpecificationDownlodPdfFreeze.htm" <%}else {%> formaction="SpecificationdPdf.htm" <%} %>formtarget="blank" >
													<div class="cc-rockmenu">
														<div class="rolling">
															<figure class="rolling_icon">
																<img src="view/images/pdf.png" style="width: 25px;">
															</figure>
															<span>Document</span>
														</div>
													</div>
												</button>
													
												<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
												<input type="hidden" name="projectType" value="<%=projectType %>">
					                        	<input type="hidden" name="projectId" value="<%=obj[1] %>">
					                        	<input type="hidden" name="initiationId" value="<%=obj[2] %>">
					                        	<input type="hidden" name="productTreeMainId" value="<%=obj[3] %>">
					                        	<input type="hidden" name="SpecsInitiationId" value="<%=obj[0] %>">
											</form>
	                      				</td>
	                      			</tr>
	                      			<%} }%>
	                            </tbody>
	                       	</table>
	                    </div>
	                    <%if(initiationSpecList!=null && initiationSpecList.size()==0) {%>
	                    <div style="text-align: center;">
	                    	<form action="ProjectSpecificationDetails.htm" id="myform" method="post">
	                    		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	                        	<button class="btn btn-sm " type="submit" name="Action" id="addAction" value="Add" onclick="addRequirementCheck()" style="background-color: #428bca;border-color: #428bca;color: white;font-weight: bold;">Add Specification v1</button>
	                        	<input type="hidden" name="projectType" id="projectType11" value="<%=projectType %>">
	                        	<input type="hidden" name="projectId" id="projectId11" value="<%=projectId %>">
	                        	<input type="hidden" name="initiationId" id="initiationId11" value="<%=initiationId %>">
	                        	<input type="hidden" name="productTreeMainId" id="productTreeMainId11" value="<%=productTreeMainId %>">
	                        	<input type="hidden" name="SpecsInitiationId" value="0">
	                 		</form>
	                    </div>
	                    <%} %>
	                     
	              <div class="row">
		 					<div class="col-md-12" style="text-align: center;"><b>Approval Flow </b></div>
		 	    		</div>
		    			<div class="row"  style="text-align: center; padding-top: 10px; padding-bottom: 15px; " >
		           			<table align="center"  >
		        				<tr>
		        					<td class="trup" style="background: linear-gradient(to top, #3c96f7 10%, transparent 115%);">
		         						Prepared By - <%if(tempflow!=null) {%><%=tempflow[0] %> <%} else{%>Prepared By<%} %>
		         					</td>
		             		
		                    		<td rowspan="2">
		             					<i class="fa fa-long-arrow-right " aria-hidden="true" style="font-size: 20px;"></i>
		             				</td>
		             						
		        					<td class="trup" style="background: linear-gradient(to top, #eb76c3 10%, transparent 115%);">
		        						Reviewer - <%if(tempflow!=null) {%><%=tempflow[1] %> <%} else{%>Reviewer<%} %>
		        	    			</td>
		             	    				
		                    		<td rowspan="2">
		             					<i class="fa fa-long-arrow-right " aria-hidden="true" style="font-size: 20px;"></i>
		             				</td>
		             						
		             				<td class="trup" style="background: linear-gradient(to top, #9b999a 10%, transparent 115%);">
		             					Approver - <%if(tempflow!=null) {%><%=tempflow[2] %> <%} else{%>Approver<%} %>
		             	    		</td>
		            			</tr> 	
		            	    </table>			             
						</div> 
					</div>
				</div>
			</div>
		</div>
	</div>

	<form action="" id="form1">
		<input type="hidden" name="${_csrf.parameterName}"value="${_csrf.token}" /> 
	</form>
	
	<form action="ProjectSpecification.htm" id="form2">
		<input type="hidden" name="projectType" id="projectType2" value="<%=projectType %>">
		<input type="hidden" name="${_csrf.parameterName}"value="${_csrf.token}" /> 
	</form>
		
		
<script type="text/javascript">
$(document).ready(function() {
	$('#projectId').on('change', function() {
		var temp = $(this).children("option:selected").val();
		var projectId = $('#projectId').val();
		$('#projectId2').val(projectId);
		$('#submit').click();
	});
	$('#initiationId').on('change', function() {
		var temp = $(this).children("option:selected").val();
		$('#submit').click();
	});
	
	 $("#myTable").DataTable({
		 "lengthMenu": [  5,10,25, 50, 75, 100 ],
		 "pagingType": "simple"
		
	});
});


$("#projectType").on('change', function() {
    var projectType = $("#projectType").val();
    $("#projectType2,#projectType3").val(projectType);

    $("#form2").submit(); 
  /*  if(value==="M"){
	var form= $("#form2");
	form.submit();
	console.log(form);
   }else{
	   var form= $("#form1"); 
	   form.submit();
   } */
});

function addRequirementCheck(){
	var projectType = $('#projectType').val();
	var projectId = $('#projectId').val();
	var initiationId = $('#initiationId').val();
	var productTreeMainId = $('#productTreeMainId').val();
	
	$('#projectType11').val(projectType);
	$('#projectId11').val(projectId);
	$('#initiationId11').val(initiationId);
	$('#productTreeMainId11').val(productTreeMainId);
	
	if(projectType==="M"){
		if(productTreeMainId==null || productTreeMainId=="" || productTreeMainId =="null") {
			alert('Please Select a System..!');
			event.preventDefault();
			return false;
		}
	}else{
		return true;
	}
}
</script>	
</body>
</html>