<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="com.vts.pfms.model.FinanceChanges"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@page import="java.math.BigDecimal"%> 
<%@page import="java.text.Format"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
	<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<spring:url value="/resources/css/admin/ChangesRecord.css" var="changesRecord" />
<link href="${changesRecord.css}" rel="stylesheet" />
<title>Changes</title>
</head>
<body>

<%
SimpleDateFormat sdf1=new SimpleDateFormat("dd-MM-yyyy");
SimpleDateFormat sdf2=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
Format format = com.ibm.icu.text.NumberFormat.getCurrencyInstance(new Locale("en", "in"));

List<Object[]> ProjectList = (List<Object[]>)request.getAttribute("ProjectList");
Object[] ChangesTotalData =(Object[])request.getAttribute("changestotalcount");
List<Object[]> meetingchangesdata = (List<Object[]>)request.getAttribute("meetingchangesdata");
List<Object[]> milestonechangesdata = (List<Object[]>)request.getAttribute("milestonechangesdata"); 
List<Object[]> actionchangesdata = (List<Object[]>)request.getAttribute("actionchangesdata");
List<Object[]> riskchangesdata = (List<Object[]>)request.getAttribute("riskchangesdata");
//List<Object[]> financedataparta = (List<Object[]>)request.getAttribute("financedataparta");
String Interval = (String)request.getAttribute("interval");
String projectid = (String)request.getAttribute("projectid");
String activetab = (String)request.getAttribute("activetab");
List<Object[]> alldatacombinedlist = (List<Object[]>)request.getAttribute("alldatacombinedlist");
List<FinanceChanges> financechangesdata = (List<FinanceChanges>)request.getAttribute("financechangesdata");
List<Object[]> labmasterlist =(List<Object[]>)request.getAttribute("labmasterlist");
String IsDG= (String)request.getAttribute("IsDG");
String labcode = (String)request.getAttribute("labcode");

  %>

 <!-- ----------------------------------message ------------------------- -->

	
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
<!-- ----------------------------------message ------------------------- -->

<div class="container-fluid">
	<div class="card shadow-nohover">
		<div class="card-header">	
		
			<form method="post" action="ChangesinProject.htm" name="changesform" id="changesform">
			<div class="row">
				<div class="col-md-6">
					<h4>
						Changes Record &nbsp;&nbsp;&nbsp;	 
						
					</h4>
				</div>
				 
				<div class="col-md-3  nav-term" >
					<label>Term : </label>
					<select class="form-control selectdee w-150" id="interval" required="required" name="interval" onchange="submitform()" >
						<option value="T"  <%if("T".equalsIgnoreCase(Interval)){ %> selected="selected" <%} %> class="text-left" >Today</option>
						<option value="W"  <%if("W".equalsIgnoreCase(Interval)){ %> selected="selected" <%} %> class="text-left" >Weekly</option>
						<option value="M"  <%if("M".equalsIgnoreCase(Interval)){ %> selected="selected" <%} %> class="text-left" >Monthly</option>
					</select>
				</div>
				
				<div class="col-md-3 nav-term" >
				
				<%if(IsDG.equalsIgnoreCase("No")) {%>

					<label>Project : </label>
					<select class="form-control selectdee w-200" id="projectid" required="required" name="projectid" onchange="submitform()" >
																
									<option value="A" <%if("A".equalsIgnoreCase(projectid)){ %> selected="selected" <%} %> selected="selected" hidden="true">All</option>
											<%	for (Object[] obj2 : ProjectList) { %>
											
													<option value="<%=obj2[0]%>" <%if(obj2[0].toString().equalsIgnoreCase(projectid)){ %> selected="selected" <%} %> class="text-left" ><%=obj2[4]!=null?StringEscapeUtils.escapeHtml4(obj2[4].toString()): " - "%></option>
													
											<%} %>
					</select>
	
				<%} else if(IsDG.equalsIgnoreCase("Yes")) {%>
				
				
					<label>LabCode : </label>
					<select class="form-control selectdee w-200" id="labcode" required="required" name="labcode" onchange="submitform()"   >
																
									<option value="A" <%if("A".equalsIgnoreCase(projectid)){ %> selected="selected" <%} %> selected="selected" hidden="true">All</option>
											<%	for (Object[] obj : labmasterlist) { %>
											
													<option value="<%=obj[1]%>" <%if(obj[1].toString().equalsIgnoreCase(labcode)){ %> selected="selected" <%} %> class="text-left"  ><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - "%></option>
													
											<%} %>
					</select>
	
				<%} %>
				</div>
			</div>
			
			<input type="hidden" name="activetab" id="activetab" />
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
			</form>
		</div>
		
		<div class="card-body">
				
			<div class=" ">

				  <div class=" bg-white rounded shadow mb-5">
				    <!-- Bordered tabs-->
				    <ul id="myTab1" role="tablist" class="tabs nav nav-tabs nav-pills with-arrow flex-column flex-sm-row text-center">
				      <li class="nav-item flex-sm-fill">
				        <a id="all-tab" data-toggle="tab" href="#alltab" role="tab" aria-controls="alltab" aria-selected="true" class="nav-link  font-weight-bold mr-sm-3 rounded-0 border  ">
				        	All <span class="badge badge-success"><%=alldatacombinedlist.size() %></span>
				        </a>
				      </li>
				      <li class="nav-item flex-sm-fill">
				        <a id="meeting-tab" data-toggle="tab" href="#meetingtab" role="tab" aria-controls="meetingtab" aria-selected="false" class="nav-link  font-weight-bold mr-sm-3 rounded-0 border ">
				        	Meeting <span class="badge badge-success"><%=meetingchangesdata.size() %></span>
				        </a>
				      </li>
				      <li class="nav-item flex-sm-fill">
				        <a id="milestone-tab" data-toggle="tab" href="#milestonetab" role="tab" aria-controls="milestonetab" aria-selected="false" class="nav-link  font-weight-bold mr-sm-3 rounded-0 border">
				        	Milestone <span class="badge badge-success"><%=milestonechangesdata.size() %></span>
				        </a>
				      </li>
				      <li class="nav-item flex-sm-fill">
				        <a id="action-tab" data-toggle="tab" href="#actiontab" role="tab" aria-controls="actiontab" aria-selected="false" class="nav-link  font-weight-bold mr-sm-3 rounded-0 border">
				        	Action <span class="badge badge-success"><%=actionchangesdata.size() %></span>
				        </a>
				      </li>
				      <li class="nav-item flex-sm-fill">
				        <a id="risks-tab" data-toggle="tab" href="#risktab" role="tab" aria-controls="risktab" aria-selected="false" class="nav-link  font-weight-bold mr-sm-3 rounded-0 border">
				        	Risks <span class="badge badge-success"><%=riskchangesdata.size() %></span>
				        </a>
				      </li>
				      
				      <%if(!IsDG.equalsIgnoreCase("Yes")){ %>
				      
				      <li class="nav-item flex-sm-fill">
				        <a id="finance-tab" data-toggle="tab" href="#financetab" role="tab" aria-controls="financetab" aria-selected="false" class="nav-link  font-weight-bold mr-sm-3 rounded-0 border">
				        	Finance <span class="badge badge-success"><%if(financechangesdata!=null){ %> <%=financechangesdata.size() %> <%}else{ %> - <%} %></span>
				        </a>
				      </li>
				      
				      <%} %>
				      
				    </ul>
				    
				    <div id="myTab1Content" class="tab-content">
				    
				    	<div id="alltab" role="tabpanel" class="tab-pane fade px-4 py-2 ">
				      	
				   		<%if(alldatacombinedlist.size()>0){ %>
				      	
				      	<table class="table table-bordered table-hover table-striped table-condensed dataTable "  id="myTable6"> 
			            	<thead>
			                	<tr>
			                		<th class="w-18" >SN</th>
			                		<th>Lab</th>
			                    	<th>Type</th>
			                        <th>Identity</th>
			                        <th>Done By</th>
			                        <th>Created Date</th>
			                  	</tr>
			                </thead>
			                <tbody>
			                	 <%int n=1;for (Object[] obj : alldatacombinedlist){  %>
								<tr>
									<td><%=n %>.</td>
									<td><%=obj[5]!=null?StringEscapeUtils.escapeHtml4(obj[5].toString()): " - " %></td>
									<td><%=obj[0]!=null?StringEscapeUtils.escapeHtml4(obj[0].toString()): " - "%></td>
									<td><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - "%></td>
									<td><%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - "%> (<%=obj[3]!=null?StringEscapeUtils.escapeHtml4(obj[3].toString()): " - " %>)</td>
									
									<td><%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()): " - "%></td>
								</tr>
								<% n++;} %>	 			  
							</tbody>
							
						
				    
			          	</table>
			          	
			          	<%}else{ %>
			          		
			          		<div align="center">
			          			<br>
			          			<h4>No Changes...!!!</h4>
			          		</div>
			          		
			          	
			          	<%} %>
				   		
				   		
		
				      </div>	
				    
				    
				    
				      <div id="meetingtab" role="tabpanel" class="tab-pane fade px-4 py-2  ">
				      	
				      	<%if(meetingchangesdata.size()>0){ %>
				      	
				      	<table class="table table-bordered table-hover table-striped table-condensed dataTable "  id="myTable"> 
			            	<thead>
			                	<tr>
			                		<th>SN</th>
			                		<th>Lab</th>
			                    	<th >Meeting Id</th>
			                        <th>Schedule</th>
			                        <th>Status</th>
			                        <th class="w-170" >Done By</th>
			                        <th>Created Date</th>
			                  	</tr>
			                </thead>
			                <tbody>
			                	<%int i=1;for (Object[] obj : meetingchangesdata){ %>
								<tr>
									<td><%=i %>.</td>
									<td><%=obj[13]!=null?StringEscapeUtils.escapeHtml4(obj[13].toString()): " - " %></td>
									<td><%=obj[12]!=null?StringEscapeUtils.escapeHtml4(obj[12].toString()): " - " %></td>
									<td><%=obj[4]!=null?sdf1.format(obj[4]):" - " %> &nbsp;-&nbsp; <%=obj[5]!=null?StringEscapeUtils.escapeHtml4(obj[5].toString()): " - " %></td>
									<td><%=obj[7]!=null?StringEscapeUtils.escapeHtml4(obj[7].toString()): " - " %></td>
									<td><%=obj[8]!=null?StringEscapeUtils.escapeHtml4(obj[8].toString()): " - " %> (<%=obj[9]!=null?StringEscapeUtils.escapeHtml4(obj[9].toString()): " - " %>)</td>
									<td class="text-center"  ><%if(obj[6].toString().equalsIgnoreCase("MSC")){%> <%=obj[10]!=null?sdf1.format(obj[10]):" - "%> <%}else{ %><%=obj[11]!=null?sdf1.format(obj[11]) :" - "%> <%} %></td>
								</tr>
								<% i++;} %>				  
							</tbody>
				    
			          	</table>
			          	
			          	<%}else{ %>
			          		
			          		<div align="center">
			          			<br>
			          			<h4>No Changes in Meeting...!!!</h4>
			          		</div>
			          		
			          	
			          	<%} %>
		
				      </div>	
				      
				      			      
				      <div id="milestonetab" role="tabpanel"  class="tab-pane fade px-4 py-2">
				      	
				      	<%if(milestonechangesdata.size()>0){ %>
				      	
				      	<table class="table table-bordered table-hover table-striped table-condensed dataTable "   id="myTable2"> 
			            	<thead>
			                	<tr>
			                		<th >SN</th>
			                		<th>Lab</th>
			                    	<th class="w-100" >Main Activity</th>
			                        <th>Sub Activity</th>
			                        <th>Progress</th>
			                        <th>Remarks</th>
			                        <th class="w-100">Done By</th>
			                        <th>Created Date</th>
			                  	</tr>
			                </thead>
			                <tbody>
			                	<%int j=1;for (Object[] obj : milestonechangesdata){ %>
								<tr>
									<td><%=j %>.</td>
									<td><%=obj[10]!=null?StringEscapeUtils.escapeHtml4(obj[10].toString()): " - " %></td>
									<td><%=obj[0]!=null?StringEscapeUtils.escapeHtml4(obj[0].toString()): " - " %></td>
									<td><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - " %></td>
									<td class="text-center" ><%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - " %>%</td>
									<td><%=obj[5]!=null?StringEscapeUtils.escapeHtml4(obj[5].toString()): " - " %></td>
									<td><%=obj[7]!=null?StringEscapeUtils.escapeHtml4(obj[7].toString()): " - " %> (<%=obj[8]!=null?StringEscapeUtils.escapeHtml4(obj[8].toString()): " - " %>)</td>
									<td class="text-center" ><%=obj[9]!=null?sdf1.format(obj[9]):" - " %></td>
								</tr>
								<% j++;} %>				  
							</tbody>
				    
			          	</table>
				      	
				      		<%}else{ %>
			          		
			          		<div align="center">
			          			<br>
			          			<h4>No Changes in Milestone...!!!</h4>
			          		</div>
			          		
			          	<%} %>
				      	
				      </div>
				      <div id="actiontab" role="tabpanel"  class="tab-pane fade px-4 py-2">
				      	
				      	<%if(actionchangesdata.size()>0){ %>
				      	
				      	<table class="table table-bordered table-hover table-striped table-condensed dataTable "  id="myTable3"> 
			            	<thead>
			                	<tr>
			                		<th>SN</th>
			                		<th>Lab</th>
			                    	<th>Action No</th>
			                        <th>Action Item</th>
			                        <th>Progress</th>
			                        <th>Remarks</th>
			                        <th class="w-120">Done By</th>
			                        <th>Created Date</th>
			                  	</tr>
			                </thead>
			                <tbody>
			                	<%int k=1;for (Object[] obj : actionchangesdata){ %>
								<tr>
									<td><%=k %>.</td>
									<td><%=obj[10]!=null?StringEscapeUtils.escapeHtml4(obj[10].toString()): " - " %></td>
									<td><%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - " %></td>
									<td class="w-320"><%=obj[3]!=null?StringEscapeUtils.escapeHtml4(obj[3].toString()): " - " %></td>
									<td class="text-center" ><%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()): " - " %>%</td>
									<td><%=obj[6] !=null?StringEscapeUtils.escapeHtml4(obj[6].toString()): " - "%></td>
									<td><%=obj[7]!=null?StringEscapeUtils.escapeHtml4(obj[7].toString()): " - "%> (<%=obj[9]!=null?StringEscapeUtils.escapeHtml4(obj[9].toString()): " - " %>)</td>
									<td class="text-center" ><%=obj[8]!=null?sdf1.format(obj[8]):" - "%></td>
								</tr>
								<% k++;} %>				  
							</tbody>
				    
			          	</table>
			          	
			          	<%}else{ %>
			          		
			          		<div align="center">
			          			<br>
			          			<h4>No Changes in Action...!!!</h4>
			          		</div>
			          		
			          	<%} %>
			          	
			          	
			          	
				      </div>
				      <div id="risktab" role="tabpanel"  class="tab-pane fade px-4 py-2">
				      	
				      	<%if(riskchangesdata.size()>0){ %>
				      	
				      		<table class="table table-bordered table-hover table-striped table-condensed dataTable "  id="myTable4"> 
			            	<thead>
			                	<tr>
			                		<th>SN</th>
			                		<th>Lab</th>
			                    	<th class="w-170">Action No</th>
			                        <th class="w-340">Description</th>
			                        <th>Severity</th>
			                        <th>Probability</th>
			                        <th>Mitigation </th>
			                        <th class="w-50" >Rev No</th>
			                        <th class="w-120">Done By</th>
			                        <th class="w-80" >Created Date</th>
			                  	</tr>
			                </thead>
			                <tbody>
			                	<%int l=1;for (Object[] obj : riskchangesdata){ %>
								<tr>
									<td><%=l %>.</td>
									<td><%=obj[11]!=null?StringEscapeUtils.escapeHtml4(obj[11].toString()): " - " %></td>
									<td><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - " %></td>
									<td><%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - " %></td>
									<td><%=obj[3]!=null?StringEscapeUtils.escapeHtml4(obj[3].toString()): " - " %></td>
									<td><%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()): " - " %></td>
									<td><%=obj[5]!=null?StringEscapeUtils.escapeHtml4(obj[5].toString()): " - " %></td>
									<td class="text-center" ><%=obj[6]!=null?StringEscapeUtils.escapeHtml4(obj[6].toString()): " - " %></td>
									<td><%=obj[9]!=null?StringEscapeUtils.escapeHtml4(obj[9].toString()): " - " %> (<%=obj[10]!=null?StringEscapeUtils.escapeHtml4(obj[10].toString()): " - " %>)</td>
									<td class="text-center" ><%=obj[8]!=null?sdf1.format(obj[8]):" - " %></td>
								</tr>
								<% l++;} %>				  
							</tbody>
							
							</table>
							
							<%}else{ %>
			          		
			          		<div align="center">
			          			<br>
			          			<h4>No Changes in Risks...!!!</h4>
			          		</div>
			          		
			          	<%} %>
			          	
				    
			          	
				      	
				      </div>
				      <div id="financetab" role="tabpanel"  class="tab-pane fade px-4 py-2">
				      			
			          	<% if(financechangesdata != null) { if(financechangesdata.size()>0){ %>
				      	
				      		<table class="table table-bordered table-hover table-striped table-condensed dataTable "  id="myTable5"> 
			            	<thead>
			                	<tr>
			                		<th>SN</th>
			                    	<th >Type</th>
			                        <th>Ref-No</th>
			                        <th class="w-230" >Item</th>
			                        <th>Cost</th>
			                        <th>CreatedBy</th>
			                        <th>Created Date</th>
			                        
			                  	</tr>
			                </thead>
			                <tbody>
			                	<%int m=1;for (FinanceChanges obj : financechangesdata){ %>
								<tr>
									<td><%=m %>.</td>
									<td><%=obj.getType()!=null?StringEscapeUtils.escapeHtml4(obj.getType()): " - " %></td>
									<td><%=obj.getRefNo()!=null?StringEscapeUtils.escapeHtml4(obj.getRefNo()): " - " %></td>
									<td><%=obj.getItemFor()!=null?StringEscapeUtils.escapeHtml4(obj.getItemFor()): " - " %></td>
									<td class="text-right" >
									<%if(obj.getCost()!=null) {%>
									<%=format.format(new BigDecimal(obj.getCost().toString())).substring(1)%>
									<%}else{ %>--<%} %>
									</td>
                                     <td><%=obj.getFirstName()!=null?StringEscapeUtils.escapeHtml4(obj.getFirstName()): " - " %> <%=obj.getLastName()!=null?StringEscapeUtils.escapeHtml4(obj.getLastName()): " - " %></td>
									<td class="text-center" ><%= obj.getCreatedDate()!=null?sdf1.format(sdf2.parse(obj.getCreatedDate().toString())):" - "%></td>
								</tr>
								<% m++;} %>				  
							</tbody>
							
							</table>
							
							<%}  else{ %>
			          		
			          		<div align="center">
			          			<br>
			          			<h4>No Changes in Finance !!!</h4>
			          		</div>
			          		
			          	<%} } else { %>
			          	
			          		<div align="center">
			          			<br>
			          			<h4>Ibas Server Not Responding</h4>
			          		</div>
			          	
			          	<%} %> 
			          	
				    
			          
	
				      </div>
				    </div>
				    <!-- End bordered tabs -->
				  </div>
			</div>
				
		</div>			
			
						
	</div>
</div>


<script>

function submitform(){
	
	$('#changesform').submit();
	
}






$(document).ready(function(){

	$('#collapseOne').addClass('show');
	
	var active = '<%=activetab%>';

	if(active!=null && active!=''){
		$('#'+active.split('_')[0]).addClass('active');
		$('#'+active.split('_')[1]).addClass('show active');
	}else{
		$('#all-tab').addClass('active');
		$('#alltabs').addClass('show active')
	}
	
	$('#activetab').val(active);
	
	
	 $("#myTable").DataTable({
		 "lengthMenu": [10,25, 50, 75, 100 ],
		 "pagingType": "simple",
		 "pageLength": 10
	});
	 
	 $("#myTable2").DataTable({
		 "lengthMenu": [10,25, 50, 75, 100 ],
		 "pagingType": "simple",
		 "pageLength": 10,
		
	});
	 
	 $("#myTable3").DataTable({
		 "lengthMenu": [10,25, 50, 75, 100 ],
		 "pagingType": "simple",
		 "pageLength": 10
	});
	 
	 $("#myTable4").DataTable({
		 "lengthMenu": [10,25, 50, 75, 100 ],
		 "pagingType": "simple",
		 "pageLength": 10
	});
	 
	 $("#myTable5").DataTable({
		 "lengthMenu": [10,25, 50, 75, 100 ],
		 "pagingType": "simple",
		 "pageLength": 10
	});
	 
	 $("#myTable6").DataTable({
		 "lengthMenu": [10,25, 50, 75, 100 ],
		 "pagingType": "simple",
		 "pageLength": 10
	});
	
	
})


$('#radioBtn a').on('click', function(){
    var sel = $(this).data('title');
    var tog = $(this).data('toggle');
    $('#'+tog).prop('value', sel);
    
	if(sel=='X'){
		$('#myTable5').hide();
		$('#myTable5_wrapper').hide();
		
	}
		
	if(sel=='Y'){	
		$('#myTable5_wrapper').show();
		$('#myTable5').show();
	}
    
    
    $('a[data-toggle="'+tog+'"]').not('[data-title="'+sel+'"]').removeClass('active').addClass('notActive');
    $('a[data-toggle="'+tog+'"][data-title="'+sel+'"]').removeClass('notActive').addClass('active');
})



$(".nav-link").click(function(e){
	  var id= $(this).attr("id");
	  var val='';
	  if(id=='all-tab'){
		  val=id+'_alltab';
	  }else if(id=='meeting-tab'){
		  val=id+'_meetingtab';
	  }else if(id=='milestone-tab'){
		  val=id+'_milestonetab';
	  }else if(id=='action-tab'){
		  val=id+'_actiontab';
	  }else if(id=='risks-tab'){
		  val=id+'_riskstab';
	  }else if(id=='finance-tab'){
		  val=id+'_financetab';
	  }

	  $('#activetab').val(val);	 	
})








</script>

</body>
</html>