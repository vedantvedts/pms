<%@page import="org.apache.commons.text.StringEscapeUtils"%>
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
<spring:url value="/resources/css/cars/CARSMilestonesMonitorDetails.css" var="carsmilestonesMonitorDetails" />
<link href="${carsmilestonesMonitorDetails}" rel="stylesheet" />
<spring:url value="/resources/css/cars/carscommon.css" var="carscommon8" />
<link href="${carscommon8}" rel="stylesheet" />




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

<% 
    String ses = (String) request.getParameter("result");
    String ses1 = (String) request.getParameter("resultfail");
    if (ses1 != null) { %>
    <div align="center">
        <div class="alert alert-danger" role="alert">
            <%=StringEscapeUtils.escapeHtml4(ses1) %>
        </div>
    </div>
<% }if (ses != null) { %>
    <div align="center">
        <div class="alert alert-success" role="alert">
            <%=StringEscapeUtils.escapeHtml4(ses) %>
        </div>
    </div>
<% } %>
	<div class="container-fluid">
		<div class="container mb-20">
			<div class="card">
				<div class="card-header card-header-bg">
					<div class="row"> 
					</div>
				</div>
				<div class="card-body">
					<form method="post" action="CARSMilestonesMonitorDetailsSubmit.htm">
						<div class="row"> 
							<div class="col-sm-6" align="left"  >
								<div class="form-group">
									<label  >Action Name: <span class="mandatory"  >*</span></label>
									<input class="form-control w-100" type="text"name="activityName" id="activityName" maxlength="1000" required="required" placeholder="Enter Action Name">
								</div>
							</div>

							<div class="col-sm-2" align="left"  >
								<div class="form-group">
									<label  >PDC: <span class="mandatory">*</span></label>
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
													<thead class="text-center">
														<tr>
															<th>SN</th>
															<th class="text-left">Action Item</th>
															<th class="w-110" >PDC</th>
															<th class="w-110">Assigned Date</th>								 	
														 	<th>Assignee</th>	
														 	<th class="w-100px"> Progress</th>
														 	<th> Is Seen</th>
														 	<th> Action</th>
														</tr>
													</thead>
													<tbody>
														<%	int  count=1;
														 	if(assignedList!=null && assignedList.size()>0){
															for(Object[] obj: assignedList){ %>
															<tr>
																<td class="center w-1"><%=count %></td>
																<td class="td-2"><%=obj[5]!=null?StringEscapeUtils.escapeHtml4(obj[5].toString()): " - " %></td>
																<td class="width-30px" ><%=obj[4]!=null?sdf.format(obj[4]):" - "%></td>
																<td class="w-8"><%=obj[3]!=null?sdf.format(obj[3]):" - "%></td>
																<td ><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - "%>, <%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - "%></td>
																<td class="w-20" >
																	<%if(obj[7]!=null  && !obj[7].toString().equalsIgnoreCase("0")){ %>
																		<div class="progress progress-bg">
																			<div class="progress-bar progress-bar-striped width-<%=obj[7].toString() %>" role="progressbar" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
																				<%=StringEscapeUtils.escapeHtml4(obj[7].toString())%>
																			</div> 
																		</div>
																	<%}else{ %>
																		<div class="progress progress-bg" >
																			<div class="progress-bar pro-bg" role="progressbar" >
																				0
																			</div>
																		</div>
																	<%} %>
																</td>
																<td class="talign" >
																	<%if(obj[8].toString().equals("1")){ %>
																		<p class="text-success">Seen</p>																		
																	<%}else if(obj[8].toString().equals("0")){ %>
																		<p class="mandatory fw-bold">UnSeen</p>
																	<%} %>
																</td>
																
																<td class="left width1">		
															 		<form action="CloseAction.htm" method="POST" name="myfrm"  class="d-inline">
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
																<td colspan="6" class="text-center">No List Found</td>
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
						<table class="w-100 p-3" >
							<tr>
								<th class="p-10 width-20" > Action Item :</th>
								<td class="p-10 " > 
									<textarea name="activityName" class="form-control" id="modalactionitem" maxlength="500" required="required" rows="4" cols="60"></textarea>
								</td>
							</tr>
							<tr>
								<th class="p-10 width-20"> PDC  :</th>
								<td class="p-10 width-30"  >
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