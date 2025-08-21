<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="java.time.LocalDate"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.io.ByteArrayOutputStream,java.io.ObjectOutputStream"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<style type="text/css">
label{
font-weight: bold;
  font-size: 15px;
}
body{
background-color: #f2edfa;
overflow-x: hidden; 
}
h6{
	text-decoration: none !important;
}

.table tr th, .center 
{
	text-align: center;
}

</style>

</head>
 
<body>
<%
  FormatConverter fc=new FormatConverter(); 
  SimpleDateFormat rdf=fc.getRegularDateFormat();
  SimpleDateFormat sdf=fc.getSqlDateFormat();
  
  List<Object[]> ProjectsList=(List<Object[]>)request.getAttribute("ProjectsList");
  List<Object[]> ActionsList=(List<Object[]>)request.getAttribute("ActionsList");
  
  String projectid=(String)request.getAttribute("projectid");
  String status=(String)request.getAttribute("status");
  
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

    <br/>


<div class="container-fluid" style="margin-top: -25px;">
				<div class="card">
					<div class="card-header ">  
	
						<div class="row">
							<h3 class="col-md-7" style="margin-top: -9px;">Action Reports</h3>  
								<div class="col-md-5" style="float: right;">
						   			<form method="post" action="ActionMonitoring.htm" >
						   				<table style="margin-top: -9px;width: 100%;" >
						   					<tr>
						   						<td>
						   							<label class="control-label">Project : </label>
						   						</td>
						   						<td style="text-align: left;">
	                                            	<select class="form-control selectdee " name="projectid" required="required"  data-live-search="true" >
	                                                 	<% for(Object[] obj:ProjectsList){ %>
															<option value="<%=obj[0] %>" <%if(projectid.equalsIgnoreCase(obj[0].toString())){ %> selected="selected" <%} %>><%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()):" - " %></option>	
														<%} %>
													</select>	       
												</td>
						   					
						   						<td>
						   							<label class="control-label" >Status :</label>
						   						</td>
						   						<td style="text-align: left;">
													<select class="form-control selectdee " name="status"  required="required"  data-live-search="true" >
														<option value="A" <%if(status.equalsIgnoreCase("A")){ %> selected="selected" <%} %>>Assigned</option>
														<option value="P" <%if(status.equalsIgnoreCase("P")){ %> selected="selected" <%} %>>In Progress</option>
														<option value="C" <%if(status.equalsIgnoreCase("C")){ %> selected="selected" <%} %>>Completed</option>	
													</select>	
												</td>
												<td >
						   							<label class="control-label" style="font-size: 14px; margin-bottom: .0rem;"> </label>
						   						</td>
						   						<td style="max-width: 300px; padding-right: 50px">
						   				
						   					    <td>
						   						<td>
						   							<input type="submit" value="SUBMIT" class="btn  btn-sm submit	 "/>
						   						</td>			
						   					</tr>   					   				
						   				</table>
						   				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
						   			</form>
			   					</div>
			   				</div>	   							

					</div>
						
					<div class="card-body" style="height: 85vh;">
    						<div class="data-table-area mg-b-15">
							<div class="container-fluid">
								<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
									<div class="sparkline13-list">
										<div class="sparkline13-graph">
											<div class="datatable-dashv1-list custom-datatable-overright">
												<div id="toolbar">
													
												</div>
												<table id="table" class="table" data-toggle="table" data-pagination="true"
													data-search="true" data-show-columns="true"
													data-show-pagination-switch="true" data-show-refresh="true"
													data-key-events="true" data-show-toggle="true"
													data-resizable="true" data-cookie="true"
													data-cookie-id-table="saveId" data-show-export="true"
													data-click-to-select="true" data-toolbar="#toolbar">
													<thead>

														<tr>
															<th style="width : 5%;">SN</th>
															<th style="width : 30%;">Action No</th>	
															<%if(status.equalsIgnoreCase("C")){ %>
															<th style="width : 7%;">PDC</th>
															<th style="width : 7%;">PDC</th>
															<%}else{ %>
															<th style="width : 14%;">PDC</th>
															<%} %>																					
														 	<th style="width : 18%;">Assignee</th>					 	
														 	<th style="width : 18%;">Assignor</th>
														 	<th style="width : 10%;">Progress</th>
														 	<th style="width : 5%;">Details</th>
														</tr>
													</thead>
													<tbody>
													<%  int count =1;
														for (Object[] action :ActionsList) 
												   		{ %>
														<tr>	
															<td class="center"><%=count %>	</td>
															<td><%=action[2]!=null?StringEscapeUtils.escapeHtml4(action[2].toString()):" - " %></td>
															<td class="center">
																<%
																	LocalDate pdc = LocalDate.parse(action[5].toString());
																	LocalDate today =LocalDate.now();
																%>
																<%if(!status.equalsIgnoreCase("C")){
																	if(!pdc.isBefore(today)){ %>
																		<span style="color: red;font-weight: 600; "><%=rdf.format(sdf.parse(pdc.toString())) %></span>
																	<%}else{%>
																		<span style="c"><%=rdf.format(sdf.parse(pdc.toString())) %></span>
																	<%} %>
																<%} else { 
																	LocalDate closedate = action[17]!=null? LocalDate.parse(action[17].toString()) : LocalDate.now();
																	if(pdc.isBefore(closedate)){ %>
																		<span style="color: #FC7300; "><%=rdf.format(sdf.parse(pdc.toString())) %></span>
																	<%}else{%>
																		<span style="color: green;"><%=rdf.format(sdf.parse(pdc.toString())) %></span>
																	<%} %>
																<%} %>
															</td>
															
															<%if(status.equalsIgnoreCase("C")){ %>
																<td  class="center"> <%if(action[17]!=null){ %><%=rdf.format(sdf.parse(action[17].toString())) %> <%}else{ %> - <%} %>
															<%} %>
															
															<td><%=action[13]!=null?StringEscapeUtils.escapeHtml4(action[13].toString()):" - " %>, <%=action[14]!=null?StringEscapeUtils.escapeHtml4(action[14].toString()):" - " %></td>
															<td><%=action[15]!=null?StringEscapeUtils.escapeHtml4(action[15].toString()):" - " %>, <%=action[16]!=null?StringEscapeUtils.escapeHtml4(action[16].toString()):" - " %></td>
															<td>
																<%if(action[12]==null || Integer.parseInt(action[12].toString())==0){ %>
																<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
															        <div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  ">
															           Not Yet Started .
															        </div>
															     </div>
															     <%} else if(action[12]!=null || Integer.parseInt(action[12].toString())>0){ %>
															     <div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;">
															     	<div class="progress-bar progress-bar-striped" role="progressbar" style=" width: <%=action[12]%>%;  " aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">
															            <%=action[12]!=null?StringEscapeUtils.escapeHtml4(action[12].toString()):" - "%>
															        </div> 
															     </div>
																<%} %>
															</td>
															<td class="center">
																<button type="button" class="btn btn-sm" onclick="ActionDetails(<%=action[0]%>)" data-toggle="tooltip" data-placement="bottom" title="Action Details" ><i class="fa fa-info-circle " style="font-size: 1.3rem;color:#145374 " aria-hidden="true"></i></button>
															</td>
														</tr>	
												   		<% count++;}%>
																	
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


<!-- -------------------------------------------------------------- action modal ----------------------------------------------------- -->

	<div class=" modal bd-example-modal-lg" tabindex="-1" role="dialog" id="action_modal">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header" style="background-color: #FFE0AD; ">
					<div class="row w-100"  >
						<div class="col-md-12" >
							<h5 class="modal-title" id="modal_action_no" style="font-weight:700; color: #A30808;"></h5>
						</div>
					</div>
					
					 <button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body" align="center">
					<form action="#" method="post" autocomplete="off"  >
						<table style="width: 100%;">
							<tr>
								<td style="width:20%;padding: 5px;border :0;font-weight: bold;"> Action Item :</td>
								<td class="tabledata" style="width:80%;padding: 5px;word-wrap:break-word;border :0;" colspan="3" id="modal_action_item"></td>
							</tr>
							<tr>
								<td style="padding: 5px;border :0;font-weight: bold;" >Assign Date :</td>
								<td style="padding: 5px;border :0;" id="modal_action_date"></td>
								<td style="padding: 5px;border :0;font-weight: bold;" >PDC :</td>
								<td style="padding: 5px;border :0;" id="modal_action_PDC"></td>
							</tr>
							<tr>
								<td style="padding: 5px;border :0;font-weight: bold;" >Assignor :</td>
								<td style="padding: 5px;border :0;" class="tabledata" id="modal_action_assignor"></td>
								<td style="padding: 5px;border :0;font-weight: bold;" >Assignee :</td>
								<td style="padding: 5px;border :0;" class="tabledata" id="modal_action_assignee"></td>
							</tr>
							<tr>
								<td style="padding: 5px;border :0;font-weight: bold;" >Final Progress :</td>
								<td style="padding: 5px;border :0;" id="modal_action_progress"></td>
								<td style="padding: 5px;border :0;font-weight: bold;" > Type :</td>
								<td style="padding: 5px;font-weight: bold;color:#A30808 ;border :0;" id="modal_action_type"></td>
							</tr>
							
						</table>
						</form>
						<hr>
						<form action="#" method="get">
						
						<table class="table table-bordered table-hover table-striped table-condensed " id="" style="width: 100%">
							<thead> 
								<tr style="background-color: #055C9D; color: white;">
									<th style="text-align: center;width:5% !important;">SN</th>
									<th style="text-align: center;width:15% !important;">Progress Date</th>
									<th style="text-align: center;width:15% !important;"> Progress</th>
									<th style="width:60% !important;">Remarks</th>
									<th style="text-align: center;width:5% !important;">Download</th>
								</tr>
							</thead>
							<tbody id="modal_progress_table_body">
								
							</tbody>
						</table>
						</form>
					
				</div>
				
			</div>
		</div>
	</div>

<!-- -------------------------------------------------------------- action modal ----------------------------------------------------- -->


<script type="text/javascript">

function ActionDetails(InAssignId)
{
		$("#modal_progress_table").DataTable().destroy();
		
		$.ajax({		
			type : "GET",
			url : "ActionAssignDataAjax.htm",
			data : {
				ActionAssignid : InAssignId
			},
			datatype : 'json',
			success : function(result) {
				var result = JSON.parse(result);
				
				$('#modal_action_item').html(result[1]);
				$('#modal_action_no').html(result[2]);
				$('#modal_action_date').html(moment(new Date(result[5]) ).format('DD-MM-YYYY'));
				$('#modal_action_PDC').html(moment(new Date(result[6]) ).format('DD-MM-YYYY'));
				$('#modal_action_assignor').html(result[8]);
				$('#modal_action_assignee').html(result[9]);
				
				var InActionType = result[9];
				var ActionType = 'Action';
				
				if(InActionType==='A')
				{
					ActionType = 'Action';
				}
				else if(InActionType==='I')
				{
					ActionType = 'Issue';
				}
				else if(InActionType==='D')
				{
					ActionType = 'Decision';
				}
				else if(InActionType==='R')
				{
					ActionType = 'Recommendation';
				}
				else if(InActionType==='C')
				{
					ActionType = 'Comment';
				}
				else if(InActionType==='K')
				{
					ActionType = 'Risk';
				}
				
				$('#modal_action_type').html(ActionType);
				
				var InProgress = '0'
				if(result[4]!=null){
					InProgress=result[4]+'';
				}
				
				
				if(InProgress.trim() === '0')
				{
					var progressBar ='<div class="progress" style="width: 80%;background-color:#cdd0cb !important;height: 1.5rem !important;">'; 
					progressBar += 		'<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >';
					progressBar +=		'Not Started'
					progressBar +=		'</div>'; 
					progressBar += '</div>'; 
				}
				else
				{
					var progressBar ='<div class="progress" style="width: 80%;background-color:#cdd0cb !important;height:1.5rem !important; ">'; 
					progressBar += 		'<div class="progress-bar progress-bar-striped" role="progressbar" style=" width: '+InProgress+'%;  " aria-valuemin="0" aria-valuemax="100" >';
					progressBar +=		InProgress
					progressBar +=		'</div>'; 
					progressBar += '</div>'; 
				}
				$('#modal_action_progress').html(progressBar);
			}
		});
		
		
		
		
		
		$.ajax({		
			type : "GET",
			url : "ActionSubListAjax.htm",
			data : {
				ActionAssignid : InAssignId
			},
			datatype : 'json',
			success : function(result) {
				var result = JSON.parse(result);
				
				
				var htmlStr='';
				if(result.length> 0){
					for(var v=0;v<result.length;v++)
					{	
						htmlStr += '<tr>';
						
						htmlStr += '<td class="tabledata" style="text-align: center;" >'+ (v+1) + '</td>';
						htmlStr += '<td class="tabledata" style="text-align: center;" >'+ moment(new Date(result[v][3]) ).format('DD-MM-YYYY') + '</td>';
						htmlStr += '<td class="tabledata" style="text-align: center;" >'+ result[v][2] + ' %</td>';
						htmlStr += '<td class="tabledata" >'+ result[v][4] + '</td>';
						
						if(result[v][5]=== null)
						{
							htmlStr += '<td class="tabledata" style="text-align: center;">-</td>';
						}
						else
						{
							htmlStr += '<td class="tabledata" style="text-align: center;"><button type="submit" class="btn btn-sm" name="ActionSubId" value="'+ result[v][5] + '" target="blank" formaction="ActionDataAttachDownload.htm" ><i class="fa fa-download"></i></button></td>';
						}
						htmlStr += '</tr>';
					}
				}
				else
				{
					htmlStr += '<tr>';
					
					htmlStr += '<td colspan="5" style="text-align: center;"> Progress Not Updated </td>';
					
					htmlStr += '</tr>';
				}
				$('#modal_progress_table_body').html(htmlStr);
				
					
				$('#action_modal').modal('toggle');
			}
		});
	}
	

</script>

</body>
</html>