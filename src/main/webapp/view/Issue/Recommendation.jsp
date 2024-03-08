<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.io.ByteArrayOutputStream,java.io.ObjectOutputStream"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
 <jsp:include page="../static/header.jsp"></jsp:include>
<title>Recommendation</title>
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
List<Object[]> projectlist = (List<Object[]>)request.getAttribute("projectlist");
String projectid = (String)request.getAttribute("projectid");
String committeeid=(String)request.getAttribute("committeeid");
List<Object[]>  projapplicommitteelist=(List<Object[]>)request.getAttribute("projapplicommitteelist");
List<Object[]> recomlist = (List<Object[]>)request.getAttribute("recomendation");
String RecOrDecision = (String)request.getAttribute("recOrDecision");

Map<String,List<List<Object[]>>> actualdecisionsought = (Map<String,List<List<Object[]>>>)request.getAttribute("actualRecDecought");

%>

<%String ses=(String)request.getParameter("result"); 
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
		<div class="alert alert-success" role="alert">
			<%=ses %>
		</div>

	</div>
	<%} %>

<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card shadow-nohover">
					<div class="col-md-12">
						<form class="form-inline " method="post" action="Recommendation.htm" id="myform" >
						  
						<div class="row card-header" style="margin-left: -13px;width: 102%;">
				   			<div class="col-md-3">
				   			<%if(RecOrDecision!=null && RecOrDecision.equalsIgnoreCase("R")){%>
									<h4 style="font-size: 1.65rem;">Recommendation List</h4>
								<%}else if(RecOrDecision!=null && RecOrDecision.equalsIgnoreCase("D")){%> <h4>Decision List </h4><%}else if(RecOrDecision!=null && RecOrDecision.equalsIgnoreCase("S")){%> 
								<h4>Decision Sought </h4><%}else if(RecOrDecision!=null && RecOrDecision.equalsIgnoreCase("RS")){%> <h4>Recommendation Sought </h4> <%}%>
							</div>
										
							<div class="col-md-3 justify-content-end" style="margin-top: -8px;">
								<table>
									<tr>
										<td><h5>Proj:</h5></td>
										<td>
											<select class="form-control items" name="projectid" id="projectid"  required="required" style="width:200px;" data-live-search="true" data-container="body" onchange='submitForm1();' >
												<option disabled  selected value="">Choose...</option>
												<option <%if(projectid!=null && projectid.equals("0")) { %>selected <%} %>value="0" >General</option>
												<%for(Object[] obj : projectlist){
												 String projectshortName=(obj[17]!=null)?" ( "+obj[17].toString()+" ) ":"";
												%>
												<option <%if(projectid!=null && projectid.equals(obj[0].toString())) { %>selected <%} %>value="<%=obj[0]%>" ><%=obj[4]+projectshortName %></option>
												<%}%>
											</select>
										</td>
									</tr>	
								</table>							
							</div>
							<div class="col-md-3 justify-content-end" style="margin-top: -8px;" >
								<table >
							        <tr>
										<td><h5>Type:</h5></td>
										<td>
											<select class="form-control items" name="recOrDecision"  required="required" style="width:200px;" data-live-search="true" data-container="body" onchange='submitForm();' >
													<option disabled  selected value="">Choose...</option>
													<option value="D"  <%if(RecOrDecision!=null && RecOrDecision.equals("D")){ %>selected <%}%> >Decision</option>
									   				<option value="R"  <%if(RecOrDecision!=null && RecOrDecision.equals("R")){ %>selected <%}%> >Recommendation</option>
									   				<option value="S"  <%if(RecOrDecision!=null && RecOrDecision.equals("S")){ %>selected <%}%> >Decision Sought</option>
													<option value="RS"  <%if(RecOrDecision!=null && RecOrDecision.equals("RS")){ %>selected <%}%> >Recommendation Sought</option>									   				
											</select>	
										</td>
									</tr>
								</table>	
							</div>
							<div class="col-md-3 justify-content-end" style="margin-top: -8px;">
								<table >
							        <tr>
										<td><h5>Comm:</h5></td>
										<td>
											<select class="form-control items" name="committeeid" id="committeeid" required="required" style="width:200px;" data-live-search="true" data-container="body" onchange='submitForm();' >
													<option disabled  selected value="">Choose...</option>
													<option value="A"  <%if(committeeid!=null && committeeid.equals("A")){ %>selected <%} %> >All</option>
									   				<% for (Object[] obj : projapplicommitteelist) {%>
													<option value="<%=obj[0]%>"  <%if(committeeid!=null && obj[0].toString().equals(committeeid)){ %>selected<%} %> ><%=obj[3]%></option>
													<%} %>
											</select>	
										</td>
									</tr>
								</table>	
							</div>
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />	
 
						 </div>
						 </form>	
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
															
													<%int count=0; 
														if(!RecOrDecision.equalsIgnoreCase("S") && !RecOrDecision.equalsIgnoreCase("RS")){
															%>
															
													<thead>
														<tr>
															<th> SN</th>
															<th> Meeting Id</th>
															<th> <%if(RecOrDecision!=null && RecOrDecision.equalsIgnoreCase("R")){%>
																	Recommendation List
																<%}else if(RecOrDecision!=null && RecOrDecision.equalsIgnoreCase("D")){%>
																	Decision List 
																<%}else if(RecOrDecision!=null && RecOrDecision.equalsIgnoreCase("S")){%> Decision Sought<%}else if(RecOrDecision!=null && RecOrDecision.equalsIgnoreCase("RS")){%>Recommendation Sought <%}%>
															</th>
															<th><%if(RecOrDecision!=null && RecOrDecision.equalsIgnoreCase("S")){%>Reference<%}else{%>  Remarks <%}%></th>
														</tr>
													</thead>
															
															
															<tbody>
															<%if(recomlist!=null && recomlist.size()>0){ for(Object[] obj :recomlist){%>
																<tr>
																		<td style="text-align: center;"><%=++count %></td>
																		<td><form action="CommitteeMinutesNewDownload.htm" method="get" >
																				<button  type="submit" class="btn btn-outline-info" formtarget="_blank" ><%=obj[2]%></button>
																				<input type="hidden" name="committeescheduleid" value="<%=obj[1]%>" />
																				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
																		</form></td>
																		<td> <%=obj[3]%> </td>
																		<td> <%=obj[4]%> </td>
																</tr>
															<%}%>
															</tbody>
															<%}}else{%>
													<thead>
														<tr>
															<th> SN</th>
															<th> Meeting Id</th>
															<th> <%if(RecOrDecision!=null && RecOrDecision.equalsIgnoreCase("S")){%> Decision Sought<%}else{%> Recommendation  Sought <%}%>
															</th>
															<th><%if(RecOrDecision!=null && RecOrDecision.equalsIgnoreCase("S")){%>taken Decision  <%}else{%> taken Recomendation  <%}%></th>														</tr>
													</thead>
														<tbody>
																<% 
																if(actualdecisionsought!=null && actualdecisionsought.size()>0){
																	for (Map.Entry<String, List<List<Object[]>>> entry : actualdecisionsought.entrySet()) {
																		  String[] key = entry.getKey().split("//"); 
																		  List<List<Object[]>> value = entry.getValue();
																		  List<Object[]> actualsought =value.get(0);
																		  List<Object[]> sought = value.get(1);
															%>
															<tr>
																	<td style="text-align: center;"><%=++count %></td>
																	<td>
																		<form action="CommitteeMinutesNewDownload.htm" method="get" >
																						<button  type="submit" class="btn btn-outline-info" formtarget="_blank" > <%=key[0]%></button>
																						<input type="hidden" name="committeescheduleid" value="<%=key[1]%>" />
																						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
																		</form>
																	</td>
																	<td> 
																		<table style="border: 1px solid black; border-collapse: collapse;">
																		<% int i=0;for(Object[] obj : actualsought ){%>
																			<tr style="border: 1px solid black; border-collapse: collapse;">
																				<td style="border: 1px solid black; border-collapse: collapse;"><%=++i %></td>
																				<td style="border: 1px solid black; border-collapse: collapse;"><%=obj[1] %></td>
																			</tr>
																			<%}%>
																		</table>
																	</td>
																	<td> 
																		<table style="border: 1px solid black; border-collapse: collapse;">
																		<% int j=0;for(Object[] obj :sought){%>
																		<tr style="border: 1px solid black; border-collapse: collapse;">
																			<td style="border: 1px solid black; border-collapse: collapse;"><%=++j %></td>
																			<td style="border: 1px solid black; border-collapse: collapse;"><%=obj[0] %></td>
																		</tr>
																		<%}%>
																		</table>
																	 </td>
																</tr>
															<%}%>	
															</tbody> <% }}%>
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
<script type="text/javascript">

function submitForm(frmid)
{ 
  document.getElementById(frmid).submit(); 
} 
</script>


<script type="text/javascript">

$('.items').select2();


$(document).ready(function(){
	  $("#myTable").DataTable({
	 "lengthMenu": [  10,25, 50, 75, 100 ],
	 "pagingType": "simple"
	
	});
 });
  

</script>
<script type="text/javascript">

function submitForm()
{ 
  document.getElementById('myform').submit(); 
} 

function submitForm1()
{ 
	$("#committeeid").val("A").change();
} 
</script>



</body>
</html>