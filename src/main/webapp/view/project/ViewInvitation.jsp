<%@page import="java.time.LocalDate"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

<title>TCC INVITATION</title>
<style type="text/css">
.input-group-text {
	font-weight: bold;
}

label {
	font-weight: 800;
	font-size: 16px;
	color: #07689f;
}

hr {
	margin-top: -2px;
	margin-bottom: 12px;
}

b {
	font-family: 'Lato', sans-serif;
}

h5{
	color:#145374;
}

.card-header{
	background-color: #07689f;
	color:white;
}

.card{
	border-color: #07689f;
}


</style>
</head>
<body>
	<%
		SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
	String tccscheduleid=(String)request.getAttribute("tccscheduleid");
	
	List<Object[]> TccMemberList = (List<Object[]>) request.getAttribute("TccMemberList");
	
	Object[] TccData = (Object[]) request.getAttribute("TccData");
	
	List<Object[]> EmployeeList=(List<Object[]>) request.getAttribute("EmployeeList");
	List<Object[]> ExpertList=(List<Object[]>) request.getAttribute("ExpertList");
	List<Object[]> tccinvitedlist=(List<Object[]>)request.getAttribute("tccinvitedlist");
	List<Object[]> EmployeeList1=(List<Object[]>)request.getAttribute("EmployeeList1");
	Object[] tccscheduledata=(Object[])request.getAttribute("tccscheduledata");
	%>

	<%
		String ses = (String) request.getParameter("result");
	String ses1 = (String) request.getParameter("resultfail");
	if (ses1 != null) {
	%><center>
		<div class="alert alert-danger" role="alert">
			<%=ses1%>
		</div>
	</center>
	<%
		}
	if (ses != null) {
	%>
	<center>
		<div class="alert alert-success" role="alert">
			<%=ses%>
		</div>
	</center>
	<%
		}
	%>

	<div class="container-fluid">
		<div class="row">
		
	

			<div class="col-md-8">

				<div class="card shadow-nohover">
					<div class="card-header">
						<div class="row">
							<div class="col-md-12 ">
								<h4>Technology Council Committee Invitations</h4>
							</div>
						</div>
					</div>
				
					<div class="card-body">
					 
		
			 
				 <h5 align="center" style="color:green"><b>Invited Members</b></h5><hr><br>
			
				 
						<h5></h5>
					
						
						
						
						<div  class="col-md-12">
						 <table border='0'>

							<tbody>
								<tr>
									
									<td><label class="control-label">Chairperson </label></td><td>&emsp; : &emsp;</td>
									<td>
									
									<% for(Object[] tccinvited:tccinvitedlist )
										
									{%>
										
										<%if(tccinvited[3].toString().equals("CC"))
										{%>
											<%=tccinvited[6]%> (<%= tccinvited[7]%>)
										<%} 
									}%>
									</td>
									
									

								</tr>
								<tr>

									<td><label class="control-label">Member Secretary   </label></td><td>&emsp; : &emsp;</td>
									<td>
									
										
									<% for(Object[] tccinvited:tccinvitedlist )
										
									{%>
										
										<%if(tccinvited[3].toString().equals("CS"))
										{%>
											<%=tccinvited[6]%> (<%= tccinvited[7]%>)
										<%} 
									}%>
									
									
									</td>
								<%-- 	<input type="hidden" name="secretary" value="<%=TccData[7]%>,C"> --%>
									
								</tr>
								<%
									int count = 1;
									for (Object[] obj : tccinvitedlist ) {
										if(obj[3].toString().equals("C")){
									
								%>


								<tr>

									<td><label class="control-label">Member <%=count%></label></td><td>&emsp; :&emsp;</td> <td> <%=obj[6]%> (<%=obj[7]%>)</td>
									

								</tr>
								<%}	count++; }	%>
							</tbody>
						</table>
						
						
				<%int hint=Integer.parseInt(  request.getAttribute("hint").toString());
					if(hint>0){
				%>		<br>
						<h5>Additional Members</h5>
						<hr>
						
				<%} %>
				<div class="row">
				<!-- -----------------------Internal start------------------------------- -->
						
						
						
						<div class="col-md-6">
						
						<table border="0" style="margin-top: 20px;">
						
							<%int intcount=1; 
								for(int i=0;i<tccinvitedlist.size();i++)
								{
								
									if(tccinvitedlist.get(i)[3].toString().equals("I"))
									{%>								
										<tr >
										<td><label class="control-label">Internal <%=intcount%></label></td><td>&emsp; :&emsp;</td>
										<td><%=tccinvitedlist.get(i)[6]%> (<%=tccinvitedlist.get(i)[7]%>)</td>
										<td style="padding-left: 30px">
											<form action="TccInvitationDelete.htm" method="post">
												<input type="hidden" name="tccscheduleid" value="<%=tccscheduleid%>">
												<input type="hidden" name="tccinvitationid" value="<%=tccinvitedlist.get(i)[1]%>">
												<button type="submit" class="btn" onclick="return confirm('Are you sure To Remove this Member?')" > <i class="fa fa-trash" aria-hidden="true" ></i> </button>
											</form>
										</td>
										
										</tr>	
													
									<% intcount++;
									}
								}%>						
						</table>
						
					</div>	
						
				<!-- -----------------------Internal end------------------------------- -->
				
				
				<!-- ----------------------External start------------------------------ -->
						
						<div class="col-md-6">
						
						<table border="0" style="margin-top: 20px;">
						<% int extcount=1; 
							for(int i=0;i<tccinvitedlist.size();i++)
							{
							
								if(tccinvitedlist.get(i)[3].toString().equals("E"))
								{%>
										<tr>
										<td><label class="control-label">External &nbsp; <%=extcount%></label></td><td>&emsp; :&emsp;</td>
										<td><%=tccinvitedlist.get(i)[6]%> (<%=tccinvitedlist.get(i)[7]%>)</td>
										<td style="padding-left: 30px">
											<form action="TccInvitationDelete.htm" method="get">
												<input type="hidden" name="tccscheduleid" value="<%=tccscheduleid%>">
												<input type="hidden" name="tccinvitationid" value="<%=tccinvitedlist.get(i)[1]%>">
												<button type="submit" class="btn" onclick="return confirm('Are you sure To Remove this Member?')" > <i class="fa fa-trash" aria-hidden="true" ></i> </button>
											</form>
										</td>
										</tr>				
								<% extcount++;}
							}%>
					
						</table>
						
						</div>
					
				<!-- ----------------------External end------------------------------ -->
							</div>			
						</div>
						
						<br>
						
						
					 	<%
					 	LocalDate scheduledate=LocalDate.parse(tccscheduledata[2].toString());
					 	LocalDate todaydate=LocalDate.now();	%>				 	
					 
					 	
						<div align="center">
						<table>
				           <tr><td>	<%if(todaydate.isBefore(scheduledate)){ %>  <button type="submit" class="btn btn-sm submit" style="background-color: #2b580c"><i class="fa fa-envelope-o" aria-hidden="true" ></i>&nbsp;&nbsp; E-MAIL INVITATION </button>  <%} %>
	          				</td><td>
				            	<form method="post" action="TCCScheduleView.htm" id="backform111">
										<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
										<input type="hidden" name="scheduleid" value="<%=tccscheduleid %>">
										<button class="btn btn-info btn-sm  shadow-nohover back" onclick='$("#backform111").submit()'>Back</button>
									</form>
								 </td></tr>
						</table>
	          			</div>
						

					</div>
	
				</div>
	
				
				
		
			</div>	
				<!-- card end -->
<%if(todaydate.isBefore(scheduledate))
{ 	%>
			<div class="col-md-4">
			
				<!-- --CARDSTART-- -->
						
<form  action="TccInvitationCreate.htm" method="POST" name="myfrm1" id="myfrm1">

				
				<div class="card shadow-nohover">
					<div class="card-header">
						<h5 style="color:white">Invite Additional Members</h5>
					</div>
				<div class="card-body">

	          				<div class="row">
	          				
	          				<div class="col-md-12">
	          				
	          				<div class="col-md-4">
	          				
	          				<table class="table  table-bordered table-hover table-striped table-condensed  info shadow-nohover" id="myTable20" style="margin-top: 30px;">
								<thead>  
									<tr id="">
										
										<th>Internal Members</th>
										<th><i class="btn btn-sm fa fa-plus" style="color: green;"  onclick="MemberAdd()"></i></th>
									</tr>
																			
									<input type="hidden"  id="MemberAdd" value="0" />
									
									<tr id="Memberrow0">
									
										<td>
											<select class="form-control " name="internalmember" id="Member0" style=" font-weight: bold; text-align-last: left; width: 300px;" data-live-search="true" data-container="body">
																						
							          			<option disabled="true"  selected value="">Choose...</option>
									    				<% for (Object[] obj : EmployeeList) {%>
						     								<option value="<%=obj[0]%>,I"><%=obj[1]%> (<%=obj[2] %>)</option>
						    							<%} %>					
											</select>
										</td>
                                   							
										<td><i class="btn btn-sm fa fa-minus" style="color: red;" id="MemberMinus0" onclick="Memberremove(this)" ></i></td>								
									</tr>
								</thead>
							</table>
							
							</div>
							
							<div class="col-md-4">
							
							<table class="table  table-bordered table-hover table-striped table-condensed  info shadow-nohover" id="myTable21" style="margin-top: 30px;">
								<thead>  
									<tr id="">
										
										<th>External Members</th>
										<th><i class="btn btn-sm fa fa-plus" style="color: green;"  onclick="MemberAdd1()"></i></th>
									</tr>
																			
									<input type="hidden"  id="MemberAdd" value="0" />
									
									<tr id="Memberrow0">
									
										<td>
											<select class="form-control " name="externalmember" id="Member0" style=" font-weight: bold; text-align-last: left; width: 300px;" data-live-search="true" data-container="body">
																						
							          			<option disabled="true"  selected value="">Choose...</option>
									    				<% for (Object[] obj : ExpertList) {%>
						     								<option value="<%=obj[0]%>,E"><%=obj[1]%> (<%=obj[2] %>)</option>
						    							<%} %>					
											</select>
										</td>								
						         		                                      							
										<td><i class="btn btn-sm fa fa-minus" style="color: red;" id="MemberMinus0" onclick="Memberremove1(this)" ></i></td>								
									</tr>
								</thead>
							</table>
							</div>
						
						</div>
						
						</div>	
	          				<div  align="center">
	          					<table><tr><td>
	          					
				            		<%if(tccinvitedlist.size()==0)	{%> 
				            		<input type="submit" id="submit" class="btn  btn-sm submit" value="INVITE" onclick="submitforms()"/>
				            		<%} else{%>
				            		<input type="submit" id="submit" class="btn  btn-sm submit" value="INVITE"/>
				            		<%}
				            	%>
				            	
				            	
				            	<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
								 <input type="hidden" name="tccscheduleid" value= "<%=tccscheduleid %>">
								 </form>
								 </td></tr>
								 
				            	</table>
	          				</div>
	          				
	          				<%} %>
	          			
	          			
	          		
	        			</div>

					<br>
			
					</div>
					<!-- --CARDEND-- -->
						
				
			</div>
				
			
			</div>

</div>


	
	
<script type="text/javascript">


	function FormNameEdit(id){
	
	
	
   		 $	.ajax({

				type : "GET",
				url : "AttendanceToggle.htm",
				data : {
							invitationid : id
					   },
				datatype : 'json',
				success : function(result) {

				var result = JSON.parse(result);
		
				var values = Object.keys(result).map(function(e) {
			 				 return result[e]
			  
								});
					}
					   
				});
   	 

	
}

function MemberAdd(){
	
	var colnerow=$('#myTable20 tr:last').attr('id');
	  

	  var MemberRowId=colnerow.split("Memberrow");
	  var MemberId=Number(MemberRowId[1])+1
	  var row = $("#myTable20 tr").last().clone().find('textarea').val('').end();
	 
      row.attr('id', 'Memberrow'+MemberId );
      
     
      row.find('#Member' + MemberRowId[1]).attr('id', 'Member' +MemberId);
  
      row.find('#MemberMinus' + MemberRowId[1]).attr('id', 'MemberMinus' +MemberId);  
    
      $("#myTable20").append(row);
	
     
	
	 $("#MemberAdd").val(PaymentRowId); 
 }
 
 
function Memberremove(elem){
	 
	  var id = $(elem).attr("id");
	 
	  var Membersplitid=id.split("MemberMinus");
	  var Memberremoveid="#Memberrow"+Membersplitid[1];

	  if("#Memberrow0" != Memberremoveid){
		 $(Memberremoveid).remove();
	  }

			$('#Member' + Membersplitid[0]).prop("required", false);

	}
 
</script>


<script>
function MemberAdd1(){
	
	var colnerow=$('#myTable21 tr:last').attr('id');
	  

	  var MemberRowId=colnerow.split("Memberrow");
	  var MemberId=Number(MemberRowId[1])+15
	  var row = $("#myTable21 tr").last().clone().find('textarea').val('').end();
	 
      row.attr('id', 'Memberrow'+MemberId );
      
     
      row.find('#Member' + MemberRowId[1]).attr('id', 'Member' +MemberId);
  
      row.find('#MemberMinus' + MemberRowId[1]).attr('id', 'MemberMinus' +MemberId);  
    
      $("#myTable21").append(row);
	
     
	
	 $("#MemberAdd").val(PaymentRowId); 
 }
 
 
function Memberremove1(elem){
	 
	  var id = $(elem).attr("id");
	  var Membersplitid=id.split("MemberMinus");
	  var Memberremoveid="#Memberrow"+Membersplitid[1];


	  
		 $(Memberremoveid).remove();
		  

			$('#Member' + Membersplitid[0]).prop("required", false);

	}
	
	
function submitforms(){

	$("#myfrm1").submit();
	$("#myfrm2").submit();
}
 
</script>


	<div class="modal" id="loader">
		<!-- Place at bottom of page -->
	</div>
</body>
</html>