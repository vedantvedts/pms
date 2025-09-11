<%@page import="org.apache.commons.text.StringEscapeUtils"%>
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

 

<title>Action List</title>
<!-- <style type="text/css">
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

</style> -->

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
SimpleDateFormat sdf1=new SimpleDateFormat("dd-MM-yyyy");
SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
	
List<Object[]> ProjectsList=(List<Object[]>) request.getAttribute("ProjectsList");
List<Object[]>  projapplicommitteelist=(List<Object[]>)request.getAttribute("projapplicommitteelist");
List<Object[]> meetingcount=(List<Object[]>) request.getAttribute("meetingcount");
List<Object[]> meetinglist=(List<Object[]>) request.getAttribute("meetinglist");
int meettingcount=1;

String projectid=(String)request.getAttribute("projectid");
String committeeid=(String)request.getAttribute("committeeid");
String scheduleid =(String)request.getAttribute("scheduleid");
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
</body>
<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card shadow-nohover">
           <div class="card-header ">  
					<div class="row">
						<h4 class="col-md-4">Meeting Action Reports</h4>  
							<div class="col-md-8" style="float: right; margin-top: -8px;" >
					   			<form method="post" action="MeettingActionReports.htm" name="dateform" id="myform">
					   				<table>
					   					<tr>
					   						<td>
					   							<label class="control-label" style="font-size: 17px; margin-bottom: .0rem;">Project: </label>
					   						</td>
					   						<td style="max-width: 300px; padding-right: 50px">
                                               <select class="form-control selectdee" id="projectid" required="required" name="projectid" onchange='submitForm1();' >
										<% if(ProjectsList!=null && ProjectsList.size()>0){
										 for (Object[] obj : ProjectsList) {
											 String projectshortName=(obj[17]!=null)?" ( "+obj[17].toString()+" ) ":"";			 
										 %>
												<option value="<%=obj[0]%>" <%if(obj[0].toString().equals(projectid)){ %>selected<%} %> ><%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()):" - "%> <%= projectshortName!=null?StringEscapeUtils.escapeHtml4(projectshortName):" - " %></option>
										<%}} %>
								             </select>       
											</td>
											<td>
					   							<label class="control-label" style="font-size: 17px; margin-bottom: .0rem;">Committee: </label>
					   						</td>
					   						<td style="max-width: 300px; padding-right: 50px">
                                              <select class="form-control selectdee" id="committeeid" required="required" name="committeeid" onchange='submitForm();' >
							   			        	<%if(projapplicommitteelist!=null && projapplicommitteelist.size()>0){
							   			        	  for (Object[] obj : projapplicommitteelist) {%>
											     <option value="<%=obj[0]%>"  <%if(obj[0].toString().equals(committeeid)){ %>selected<%} %> ><%=obj[3]!=null?StringEscapeUtils.escapeHtml4(obj[3].toString()):" - "%></option>
											        <%}} %>   
							  	             </select>
											</td>
					   						 <td>
					   							<label class="control-label" style="font-size: 17px; margin-bottom: .0rem;">Meeting: </label>
					   						</td>
					   						<td style="max-width: 300px; padding-right: 50px">
                                                   <select class="form-control selectdee" id="meettingid" required="required" name="meettingid" onchange='submitForm();'>
							   			        	<% if(meetingcount!=null && meetingcount.size()>0){
							   			        	 for (Object[] obj : meetingcount) {%>
											         <option value="<%=obj[0]%>" <%if(obj[0].toString().equals(scheduleid)){ %>selected<%} %>><%=obj[3]!=null?StringEscapeUtils.escapeHtml4(obj[3].toString())+"-"+meettingcount:" - "%></option>
											        <%meettingcount++;} }%>   
							  	                  </select>				   						
											</td> 	   									
					   					</tr>   					   				
					   				</table>
					   				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
					   			</form>
		   					</div>
		   				</div>	   							
					</div>
					
						<div class="data-table-area mg-b-15">
							<div class="container-fluid">
								<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
									<div class="sparkline13-list">
										<div class="sparkline13-graph">
											<div class="datatable-dashv1-list custom-datatable-overright">
												<div id="toolbar">
													
												</div>
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
														<%int count=1;
															if(meetinglist!=null && meetinglist.size()>0)
															{
												   					for (Object[] obj :meetinglist) 
												   					{ %>
																	<tr>
																		<td><%=count++ %></td>
																		<td>
																		    <form action="ActionDetails.htm" method="POST" >
																				<button  type="submit" class="btn btn-outline-info"   ><%=obj[0]!=null?StringEscapeUtils.escapeHtml4(obj[0].toString()):" - " %></button>
																			   <input type="hidden" name="ActionLinkId" value="<%=obj[13]%>"/>
																	           <input type="hidden" name="Assignee" value="<%=obj[1]%>,<%=obj[2]%>"/>
																	           <input type="hidden" name="ActionMainId" value="<%=obj[10]%>"/>
																	           <input type="hidden" name="ActionAssignId" value="<%=obj[12]%>"/>
																	           <input type="hidden" name="ActionNo" value="<%=obj[0]%>"/>
																	           <input type="hidden" name="text" value="M">
																	           <input type="hidden" name="projectid" value="<%=projectid%>">
																	           <input type="hidden" name="committeeid" value="<%=committeeid%>">
																	           <input type="hidden" name="meettingid" value="<%=scheduleid%>">
 																			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
																			
																			</form> 
																		</td>
																		<td><%=sdf1.format(obj[6])%></td>
																		<td>
															               <%if(obj[7]!=null && obj[7].toString().length()>100){ %>
															               <%=StringEscapeUtils.escapeHtml4(obj[7].toString()).substring(0, 100) %>
														                   <input type="hidden" value='"<%=obj[7].toString()%>"' id="td<%=obj[10].toString()%>">
														                   <span style="text-decoration: underline;font-size:13px;color: #145374;cursor: pointer;font-weight: bolder" onclick="showAction('<%=obj[10].toString()%>','<%=obj[0].toString()%>')">show more..</span>
															               <%}else{ %>
															               <%=obj[7]!=null?StringEscapeUtils.escapeHtml4(obj[7].toString()):" - " %>
															               <%} %>
															            </td>																				
																		<td><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()):" - "%>, <%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()):" - "%></td>
																	  	<td><%=obj[3]!=null?StringEscapeUtils.escapeHtml4(obj[3].toString()):" - "%>, <%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()):" - "%></td>
																		<td style="width:8% !important; "><%if(obj[11]!=null){ %>
															<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;width: 140px;">
															<div class="progress-bar progress-bar-striped" role="progressbar" style=" width: <%=obj[11]%>%;  " aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >
															<%=obj[11]!=null?StringEscapeUtils.escapeHtml4(obj[11].toString()):" - "%>
															</div> 
															</div> <%}else{ %>
															<div class="progress" style="background-color:#cdd0cb !important;height: 1.4rem !important;width: 140px;">
															<div class="progress-bar" role="progressbar" style=" width: 100%; background-color:#cdd0cb !important;color:black;font-weight: bold;  "  >
															Not Yet Started .
															</div>
															</div> <%} %></td>			
																	</tr>
																<% 
																	}									   					
															}%>
													</tbody>
												</table>												
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						
					
						<br>
						<div class="card-footer" align="right">&nbsp;</div>
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
function submitForm()
{ 
  document.getElementById('myform').submit(); 
}
function submitForm1()
{ 
	$("#committeeid").val("all").change();
}
function showAction(a,b){
	/* var y=JSON.stringify(a); */
	var y=$('#td'+a).val();
	console.log(a);
	$('#modalbody').html(y);
	$('#header').html(b);
	$('#exampleModalCenter').modal('show');
}

</script>


</html>