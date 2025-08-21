<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="com.vts.pfms.committee.model.CommitteeSchedule"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

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

.table button{
	background-color: white !important;
	border: 3px solid #17a2b8;
	padding: .275rem .5rem !important;
}

.table button:hover {
	color: black !important;
}

#table tbody tr td {
	padding: 4px 3px !important;
}
</style>

</head>
<body>
	
	<%
		List<CommitteeSchedule> ccmScheduleList = (List<CommitteeSchedule>)request.getAttribute("ccmScheduleList");
		List<Object[]> meetingActionList = (List<Object[]>)request.getAttribute("meetingActionList");
		String committeeId = (String)request.getAttribute("committeeId");
		String scheduleId = (String)request.getAttribute("scheduleId");
		
		int meettingcount = 1;
		
		FormatConverter fc = new FormatConverter();
		
	%>
	<div class="container-fluid mb-3">
		<div class="card shadow-nohover">
 			<div class="card-header" style="background-color: transparent;height: 3.8rem;">
 				<div class="row">
 					<div class="col-md-3">
 						<h3 class="text-dark" style="font-weight: bold;">CCM Action Report
 							<a class="btn btn-info btn-sm shadow-nohover back mb-2" href="CCMModules.htm">
	 							<i class="fa fa-home" aria-hidden="true" style="font-size: 1rem;"></i> 
	 							CCM
 							</a> 
 						</h3>
 					</div>
 					<div class="col-md-6"></div>
 					<div class="col-md-3">
 						<form method="post" action="CCMActionReport.htm" name="dateform" id="myform" style="float: right;">
					   		<table>
					   			<tr>
					   				<td>
					   					<label class="control-label" style="font-size: 17px; margin-bottom: .0rem;">Meeting: </label>
					   				</td>
					   				<td>
                                    	<select class="form-control selectdee" id="scheduleId" required="required" name="scheduleId" onchange="this.form.submit()">
					   			        	<% if(ccmScheduleList!=null && ccmScheduleList.size()>0){
					   			        	 for (CommitteeSchedule ccm : ccmScheduleList) {%>
									         <option value="<%=ccm.getScheduleId()%>" <%if(ccm.getScheduleId()==Long.parseLong(scheduleId)){ %>selected<%} %>><%=ccm.getMeetingId()!=null?StringEscapeUtils.escapeHtml4(ccm.getMeetingId()): " - "%></option>
									        <%meettingcount++;} }%>   
							  	        </select>				   						
									</td> 	   									
					   			</tr>   					   				
					   		</table>
					   		<input type="hidden" name="committeeId" value="<%=committeeId%>">
					   		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
					   	</form>
 					</div>
 				</div>
       		</div>
       		<div class="card-body">
       			<div class="data-table-area mg-b-15">
					<div class="container-fluid">
						<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
							<div class="sparkline13-list">
								<div class="sparkline13-graph">
									<div class="datatable-dashv1-list custom-datatable-overright">
										<div id="toolbar"></div>
										<table id="table" data-toggle="table" data-pagination="true"
											data-search="true" data-show-columns="true"
											data-show-pagination-switch="true" data-show-refresh="true"
											data-key-events="true" data-show-toggle="true"
											data-resizable="true" data-cookie="true"
											data-cookie-id-table="saveId" data-show-export="true"
											data-click-to-select="true" data-toolbar="#toolbar">
											<thead>
												<tr>
													<th>SN</th>
													<th>Action Id</th>	
													<th class="width-110px" style="width: 7.1%;">PDC</th>
													<th >Action Item</th>																								
												 	<th >Assignee</th>					 	
												 	<th >Assigner</th>
												 	<th class="width-115px">Progress</th>
												</tr>
											</thead>
											<tbody>
												<%
												int count=1;
											  	if(meetingActionList!=null && meetingActionList.size()>0) {
											   		for (Object[] obj :meetingActionList) { %>
														<tr>
															<td><%=count++ %></td>
															<td>
															    <form action="ActionDetails.htm" method="POST" >
																	<button  type="submit" class="btn btn-outline-info"   ><%=obj[0]!=null?StringEscapeUtils.escapeHtml4(obj[0].toString()): " - " %></button>
																   <input type="hidden" name="ActionLinkId" value="<%=obj[13]%>"/>
														           <input type="hidden" name="Assignee" value="<%=obj[1]%>,<%=obj[2]%>"/>
														           <input type="hidden" name="ActionMainId" value="<%=obj[10]%>"/>
														           <input type="hidden" name="ActionAssignId" value="<%=obj[12]%>"/>
														           <input type="hidden" name="ActionNo" value="<%=obj[0]%>"/>
														           <input type="hidden" name="text" value="C">
														           <input type="hidden" name="projectid" value="0">
														           <input type="hidden" name="committeeid" value="<%=committeeId%>">
														           <input type="hidden" name="meettingid" value="<%=scheduleId%>">
																	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
																
																</form> 
															</td>
															<td><%=obj[6]!=null?fc.sdfTordf(obj[6].toString()):" - "%></td>
															<td>
												               <%if(obj[7]!=null && obj[7].toString().length()>100){ %>
												               <%=StringEscapeUtils.escapeHtml4(obj[7].toString()).substring(0, 100) %>
											                   <input type="hidden" value='"<%=obj[7].toString()%>"' id="td<%=obj[10].toString()%>">
											                   <span style="text-decoration: underline;font-size:13px;color: #145374;cursor: pointer;font-weight: bolder" onclick="showAction('<%=obj[10].toString()%>','<%=obj[0].toString()%>')">show more..</span>
												               <%}else{ %>
												               <%=obj[7]!=null?StringEscapeUtils.escapeHtml4(obj[7].toString()): " - "%>
												               <%} %>
												            </td>																				
															<td><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - "%>, <%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - "%></td>
														  	<td><%=obj[3]!=null?StringEscapeUtils.escapeHtml4(obj[3].toString()): " - "%>, <%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()): " - "%></td>
															<td style="width:8% !important; ">
																<%if(obj[11]!=null){ %>
																	<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;width: 140px;">
																		<div class="progress-bar progress-bar-striped" role="progressbar" style=" width: <%=obj[11]%>%;  " aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
																			<%=StringEscapeUtils.escapeHtml4(obj[11].toString())%>
																		</div> 
																	</div> 
																<%}else{ %>
																	<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;width: 140px;">
																		<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >
																			Not Yet Started .
																		</div>
																	</div> 
																<%} %>
															</td>			
														</tr>
												<% }}%>
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
	
	<!-- Modal for action -->
	<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  		<div class="modal-dialog modal-dialog-centered" role="document">
    		<div class="modal-content">
      			<div class="modal-header" style="height:50px;">
        			<h5 class="modal-title" id="exampleModalLongTitle">Action</h5>
        			<button type="button" class="close" data-dismiss="modal" aria-label="Close" style="color:red;">
          				<span aria-hidden="true">&times;</span>
        			</button>
      			</div>
      			<div class="modal-body" id="modalbody">
     
      			</div>
      			<div align="right" id="header" class="p-2"></div>
    		</div>
  		</div>
	</div>
					
<script type="text/javascript">


function showAction(a,b){
	/* var y=JSON.stringify(a); */
	var y=$('#td'+a).val();
	console.log(a);
	$('#modalbody').html(y);
	$('#header').html(b);
	$('#exampleModalCenter').modal('show');
}

</script>
 		
</body>
</html>