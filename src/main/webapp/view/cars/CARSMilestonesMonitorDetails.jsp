<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<script src="./resources/js/multiselect.js"></script>
<link href="./resources/css/multiselect.css" rel="stylesheet"/>
<spring:url value="/resources/js/excel.js" var="excel" />
<script src="${excel}"></script>

<style type="text/css">
label{
	font-weight: bold;
	font-size: 13px;
}
body{
	background-color: #f2edfa;
	overflow-x:hidden !important; 
}
h6{
	text-decoration: none !important;
}
.cc-rockmenu {
	color: fff;
	padding: 0px 5px;
	font-family: 'Lato', sans-serif;
}

.cc-rockmenu .rolling {
	display: inline-block;
	cursor: pointer;
	width: 34px;
	height: 30px;
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
	width: 29px;
	height: 52px;
	box-sizing: border-box;
	margin: 0 5px 0 0;
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

.cc-rockmenu .rolling p {
	margin: 0;
}

.width {
	width: 270px !important;
}
.width1 {
	width: 220px !important;
}
a:hover {
	color: white;
}
.modal-xl{
	max-width: 1400px;
}
</style>
</head>
<body>
<%
	List<Object[]> assignedList = (List<Object[]>)request.getAttribute("assignedList");
	String carsInitiationId = (String)request.getAttribute("carsInitiationId");
	String carsSoCMilestoneId = (String)request.getAttribute("carsSoCMilestoneId");
	String presFlag = (String)request.getAttribute("presFlag");
	
	Long EmpId=(Long)session.getAttribute("EmpId");
			
	FormatConverter fc = new FormatConverter();
	SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
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
		<div class="container" style="margin-bottom:20px;">
			<div class="card" style=" ">
				<div class="card-header" style="background-color: #055C9D; height: 50px;">
					<div class="row"> 
					</div>
				</div>
				<div class="card-body">
					<form method="post" action="CARSMilestonesMonitorDetailsSubmit.htm">
						<div class="row"> 
							<div class="col-sm-6" align="left"  >
								<div class="form-group">
									<label  >Action Name: <span class="mandatory" style="color: red;" >*</span></label>
									<input class="form-control " type="text"name="activityName" id="activityName"  style="width:100% " maxlength="1000" required="required" placeholder="Enter Action Name">
								</div>
							</div>

							<div class="col-sm-2" align="left"  >
								<div class="form-group">
									<label  >PDC: <span class="mandatory" style="color: red;">*</span></label>
									<input class="form-control " name="pdc" id="pdc" required="required">
								</div>
							</div>
							
						</div>
						<div class="row" align="center">
							<div class="col-sm-12" align="center">
								<div class="form-group">
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
									<input type="hidden" name="carsInitiationId" value="<%=carsInitiationId %>" />
									<input type="hidden" name="carsSoCMilestoneId" value="<%=carsSoCMilestoneId %>" />
									<input type="hidden" name="Assignee" value="<%=EmpId %>" />
									<button type="submit" class="btn btn-sm btn-success submit " name="Action" value="Add" onclick="return confirm('Are you sure to submit?')" >SUBMIT</button>
									<button class="btn btn-primary btn-sm back" formaction="<%if(presFlag!=null && presFlag.equalsIgnoreCase("A")) {%>CARSReportPresentation.htm<%}else {%>CARSMilestonesMonitor.htm<%} %>" formnovalidate="formnovalidate" >BACK</button>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card shadow-nohover">
					<div class="card-header">
						<div class="row">
							<div class="col-md-3"><h4><b> Action Assigned List</b></h4></div>
						</div>
					</div>
					<div class="card-body">
						<div class="data-table-area mg-b-15">
							<div class="container-fluid">
								<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
									<div class="sparkline13-list">
										<div class="sparkline13-graph">
											<div class="datatable-dashv1-list custom-datatable-overright">
												<table id="table" data-toggle="table" data-pagination="true"
													data-search="true" data-show-columns="true"
													data-show-pagination-switch="true" data-show-refresh="true"
													data-key-events="true" data-show-toggle="true"
													data-resizable="true" data-cookie="true"
													data-cookie-id-table="saveId" data-show-export="true"
													data-click-to-select="true" data-toolbar="#toolbar">
													<thead style="text-align: center;">
														<tr>
															<th>SN</th>
															<th style="text-align: left;">Action Item</th>
															<th class="width-110px" >PDC</th>
															<th class="width-110px">Assigned Date</th>									
														 	<th>Assignee</th>	
														 	<th style="width: 100.5312px"> Progress</th>
														 	<th> Is Seen</th>
														 	<th> Action</th>
														</tr>
													</thead>
													<tbody>
														<%	int  count=1;
														 	if(assignedList!=null && assignedList.size()>0){
															for(Object[] obj: assignedList){ %>
															<tr>
																<td style="width:1% !important; " class="center"><%=count %></td>
																<td style="overflow-wrap: break-word !important; word-break: break-all !important; white-space: normal !important;max-width:20% !important;min-width:20% !important;"><%=obj[5] %></td>
																<td class="width-30px" ><%=sdf.format(obj[4])%></td>
																<td style="width:8% !important; "><%=sdf.format(obj[3])%></td>
																<td ><%=obj[1]%>, <%=obj[2]%></td>
																<td style="width:20% !important; ">
																	<%if(obj[7]!=null  && !obj[7].toString().equalsIgnoreCase("0")){ %>
																		<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
																			<div class="progress-bar progress-bar-striped" role="progressbar" style=" width: <%=obj[7]%>%;  " aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
																				<%=obj[7]%>
																			</div> 
																		</div>
																	<%}else{ %>
																		<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
																			<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >
																				0
																			</div>
																		</div>
																	<%} %>
																</td>
																<td class="talign" >
																	<%if(obj[8].toString().equals("1")){ %>
																		<p style="color: green;">Seen</p>																		
																	<%}else if(obj[8].toString().equals("0")){ %>
																		<p style="color: red; font-weight: bold;">UnSeen</p>
																	<%} %>
																</td>
																
																<td class="left width1">		
															 		<form action="CloseAction.htm" method="POST" name="myfrm"  style="display: inline">
																		<button  class="btn btn-sm editable-click" name="sub" value="C">  
																			<div class="cc-rockmenu">
														                      <div class="rolling">
														                        <figure class="rolling_icon"><img src="view/images/preview3.png"  ></figure>
														                        <span>Actions</span>
														                      </div>
														                     </div> 
																		</button>                 
																		<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
																	    <input type="hidden" name="ActionMainId" value="<%=obj[0]%>"/>
																	    <input type="hidden" name="ActionAssignId" value="<%=obj[9]%>"/>
																	    <input type="hidden" name="ActionPath" value="C">
																		<input type="hidden" name="carsInitiationId" value="<%=carsInitiationId %>" />
																		<input type="hidden" name="carsSoCMilestoneId" value="<%=carsSoCMilestoneId %>" />
																		
																		<%if(obj[7]!=null && "0".equals(obj[7].toString()) && "0".equals(obj[10].toString())){%>
																			<button class="btn btn-sm editable-click" type="button" onclick="Actioneditmodal('<%=obj[0]%>' , '<%=obj[9]%>'); ">
																				<div class="cc-rockmenu">
														                    	  <div class="rolling">
																					<figure class="rolling_icon"><img src="view/images/edit.png"></figure>
																					<span>Edit</span>
																				  </div>
																				</div>
																			</button>  
			                                                       		<%}%>
												         			</form> 
																</td>
															</tr>
														<% count++; } }else{%>
															<tr>
																<td colspan="6" style="text-align: center">No List Found</td>
															</tr>
														<%}%>
													</tbody>
												</table>
													
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>	
	<div class="modal fade  bd-example-modal-lg" tabindex="-1" role="dialog" id="newfilemodal">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Action Edit</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body" align="center">
					<form action="CARSMilestonesMonitorDetailsEditSubmit.htm" method="post" autocomplete="off" id="editform" >
						<table style="width: 100% ; padding: 15px;">
							<tr>
								<th style="padding: 10px 0px; width: 20% ;"> Action Item :</th>
								<td style="padding: 10px 0px; "> 
									<textarea name="activityName" class="form-control" id="modalactionitem" maxlength="500" required="required" rows="4" cols="60"></textarea>
								</td>
							</tr>
							<tr>
								<th style="padding: 10px 0px; width: 20% ;"> PDC  :</th>
								<td style="padding: 10px 0px;  width: 30% ; "  >
									<input type="text" name="newPDC" value="" class="form-control" id="modalipdc1"  readonly required >
									<input type="text" name="newPDC1" value="" class="form-control" id="modalipdc2"  readonly required onclick="alert('PDC Revision Limit Exceded !!');">
								</td>
							</tr>
						</table>
						<button type="submit" class="btn btn-sm submit" id="modalsubmitbtn"  >SUBMIT</button>
						<input type="hidden" name="actionmainid" id="modalactionmainid" value="">
						<input type="hidden" name="actionassigneid" id="modalactionassignid" value="">
						<input type="hidden" name="Assignee" id="modalassignee" value="">
						<input type="hidden" name="carsInitiationId" value="<%=carsInitiationId %>">
						<input type="hidden" name="carsSoCMilestoneId" value="<%=carsSoCMilestoneId %>">
						<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
					</form>
				</div>
			</div>
		</div>
	</div>		
</body>
<script type="text/javascript">
$(document).ready(function() {
$('#pdc').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,	
	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});

});

</script>

<script type="text/javascript">
function Actioneditmodal($actionid , $assignid)
{
	
	$.ajax({		
		type : "GET",
		url : "ActionDetailsAjax.htm",
		data : {
			actionid : $actionid,
			assignid : $assignid
		},
		datatype : 'json',
		success : function(result) {
			var result = JSON.parse(result);
			$('#modalactionitem').html(result[1]);
			$('#modalactionmainid').val(result[0]);
			$('#modalactionassignid').val(result[6]);
			$('#modelAssigneelabcode').val(result[5]).trigger('change');
			$('#modalassignee').val(''+result[2]).trigger('change');
			
			if(result[4]<1){
				$('#modalipdc1').show();
				$('#modalipdc2').hide();
				$('#modalipdc1').daterangepicker({
					
					"singleDatePicker" : true,
					"linkedCalendars" : false,
					"showCustomRangeLabel" : true,
					"startDate" : result[3],
					"cancelClass" : "btn-default",
					showDropdowns : true,
					locale : {
						format : 'DD-MM-YYYY'
					},
				});
			}else{
				$('#modalipdc1').hide();
				$('#modalipdc2').show();	
				$('#modalipdc2').val(result[3]);
			}
			$('#newfilemodal').modal('toggle');
		}
	});
	
	
}

</script>
</html>