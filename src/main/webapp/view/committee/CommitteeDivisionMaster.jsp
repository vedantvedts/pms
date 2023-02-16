<%@page import="java.time.LocalTime"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
	
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">

<jsp:include page="../static/header.jsp"></jsp:include>


<style>
.card-body{
	padding: 0px !important;
}
.control-label{
	font-weight: bold !important;
}


.table thead th{
	
	vertical-align: middle !important;
}

.header{
        position:sticky;
        top: 0 ;
        background-color: #346691;
    }

</style>

</head>
<body>


<%

String divisionid=(String)request.getAttribute("divisionid");
String initiationid=(String)request.getAttribute("initiationid");
String projectid=(String)request.getAttribute("projectid");
List<Object[]> divisionlist=(List<Object[]>) request.getAttribute("divisionlist");
List<Object[]> CommitteedivisionAssigned=(List<Object[]>) request.getAttribute("CommitteedivisionAssigned");
List<Object[]> CommitteedivisionNotAssigned=(List<Object[]>) request.getAttribute("CommitteedivisionNotAssigned");
List<Object[]> CommitteeFormationCheckList=(List<Object[]>) request.getAttribute("CommitteeFormationCheckList");
String divisionname=null;
%>

<%String ses=(String)request.getParameter("result"); 
String ses1=(String)request.getParameter("resultfail");
if(ses1!=null){
%>
	<center>
	
		<div class="alert alert-danger" role="alert">
			<%=ses1 %>
		</div>
	</center>
	<%}if(ses!=null){ %>
	<center>
		<div class="alert alert-success" role="alert">
			<%=ses %>
		</div>

	</center>
	<%} %>



<div class="container-fluid">
	<div class="row">
		<div class="col-md-12">	
			<div class="card shadow-nohover">
				<div class="card-header">
					<div class="row">
						<div class="col-md-6" style="margin-top: -8px;">	
							<form class="form-inline" method="post" action="DivisionCommitteeMaster.htm" id="myform">
									<h4 class="control-label" > Division : </h4> &nbsp;&nbsp;&nbsp;
									 <select class="form-control" id="divisionid" required="required"  name="divisionid" onchange='submitForm();' >
					   						<% for (Object[] obj : divisionlist) {%>
											<option value="<%=obj[0]%>" <%if(obj[0].toString().equals(divisionid)){ %>selected<% divisionname=obj[2].toString(); } %> ><%=obj[2]%><%-- (<%=obj[2]%>) --%></option>
											<%} %>
					  				</select>
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />	
							</form>
						</div>
						<div class="col-md-6">	
							<%if(CommitteedivisionAssigned  !=null && CommitteedivisionAssigned.size()>0){ %>						 	
								<form method="post" action="DivCommitteeAutoSchedule.htm" id="form" >
									<button type="submit"  class="btn btn-sm preview" style="float:right" >MEETING SCHEDULE</button>
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
									<input type="hidden" name="projectid" value="<%=projectid%>"/>	
									<input type="hidden" name="divisionid" value="<%=divisionid%>"/>
									<input type="hidden" name="initiationid" value="<%=initiationid%>"/>		
								</form>
							<%} %> 
						</div>	
					</div>
				</div>
				<!-- card header -->
				
			<!-- checkboxes start -->	
				
				<div class="card-body">
				
					<div class="row">
					
							<!-- /////add Committees -->
							
							 <div class="col-sm-6">
								<div class="card" style="margin: 5px">
									<div class="card-header cardpad ">
										<h5 style="margin-bottom: -2px">List of Division Committees</h5>

									</div>
	
									<div style="margin: 5px">
							
										<form name="myfrm" action="DivisionCommitteeAdd.htm" method="POST">
										<div class="table-responsive-sm" style="height: 400px;overflow: auto;">
											<table	class=" scrolltable datatablex table table-bordered table-hover table-striped table-condensed table-sm ">
												<thead>
													<tr style="background-color: #346691; color: #fff;">
														<th class="header" scope="col"> &nbsp;<input type="checkbox" id="selectall1">&nbsp; All </th>
														<th class="header" scope="col" style="text-align: left;">Committee Name</th>
														<th class="header" scope="col" style="text-align: left;">Duration</th>
													</tr>
												</thead>
												<tbody>
													<%
														ArrayList<Object> check=new ArrayList<Object>();
														if (CommitteedivisionNotAssigned != null && CommitteedivisionNotAssigned.size()>0) {
															for (Object[] obj : CommitteedivisionNotAssigned) {
																if(obj[4].toString().equals("N")){
																	check.add(obj[4]);
													%>
													<tr>
														<td style="text-align: center;"><input type="checkbox" class="checkboxall1" name="committeeid"
															value=<%=obj[0]%>></td>
														<td style="text-align: left;"><%=obj[2]%>(<%=obj[1]%>)</td>
														<td style="text-align: left;"><%if(obj[6].toString().equalsIgnoreCase("P")){ %><%=obj[7] %> day(s)<%} else{%>Non-Periodic<%} %> </td>
													</tr>
													<%
														}
														}	
														}
													%>
													<%
														if (CommitteedivisionNotAssigned.size()>0 && CommitteedivisionNotAssigned != null && check.size()>0 ) {%>
														
													<%} else{%>
													<tr>
														<td style="text-align: center;" colspan="4"><br><br> <i class="fa fa-exclamation-triangle" aria-hidden="true"></i>&nbsp;&nbsp; No Committees <br><br></td>
													
													</tr>
													<%} %>
												</tbody>
											</table>
											</div>
											
											<div align="center">
												<input type="submit" class="btn btn-primary btn-sm add" onclick="return submitChecked()" value="ADD" style="margin-bottom: 2%"/>
											</div>
											
											<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
											<input type="hidden" name="divisionid" value="<%=divisionid%>"/>
											<input type="hidden" name="initiationid" value="<%=initiationid%>"/>
											<input type="hidden" name="projectid" value="<%=projectid%>"/>	
										</form>
										
									</div>
								</div>
							</div>
					

					
							<div class="col-sm-6">
								<div class="card" style="margin: 5px">
	
									<div class="card-header cardpad ">
										<h5 style="margin-bottom: -2px; ">Committees Added for <%=divisionname %></h5>
									</div>
	
									<div style="margin: 5px">
	
	
										<form name="myfrm" action="DivisionCommitteeDelete.htm"	method="POST">
										<div class="table-responsive-sm" style="height: 400px;overflow: auto;">
											<table
												class="scrolltable datatablex table table-bordered table-hover table-striped table-condensed table-sm  ">
												<thead>
													<tr style="background-color: #346691; color: #fff;">
														<th class="header" scope="col"> &nbsp;<input type="checkbox" id="selectall">&nbsp; All </th>
														<th class="header" scope="col" style="text-align: left;">Committee Name</th>
														<th class="header" scope="col">Periodic Duration</th>
														<th class="header" scope="col">Scheduled</th>
														<th class="header" scope="col">Constitute</th>
													</tr>
												</thead>
												<tbody>
													<% if(CommitteedivisionAssigned!=null && CommitteedivisionAssigned.size()>0){
														for (Object[] obj : CommitteedivisionAssigned) {
													%>
													<tr>
														<td style="text-align: center;">
														
														<% int checkcount=0;
														 for(Object[] checklist : CommitteeFormationCheckList){															
															if(obj[3].toString().equalsIgnoreCase(checklist[0].toString()) && checklist[1]==null){
																checkcount++;
																break;
															}
														} 
														
														if(obj[6].toString().equalsIgnoreCase("N") && checkcount >0) {	%>
														
															<input type="checkbox" class="checkboxall" name="committeedivisionid" value="<%=obj[3]%>">
																	
																
														<%} else{ %>
															<input type="checkbox" disabled >
														<%} %>
														
														
														
														</td>
														<td style="text-align: left;"><%=obj[0]%> (<%=obj[1]%>)</td>
														<td style="text-align: left;"><%if(obj[4].toString().equalsIgnoreCase("P")){ %><%=obj[5] %> days<%} else{%>Non-Periodic<%} %> </td>
														<td style="text-align: center;"><%if(obj[6].toString().equalsIgnoreCase("Y")) {%><img src="view/images/check.png"/><%}else{ %><img src="view/images/cancel.png"/><%} %></td>
															
														<td>
															<%if(checkcount>0){ %>
																<button type="submit" value="<%=obj[2] %>" name="sub" class="btn btn-sm view" style="background-color: maroon !important; font-size: 12px;">Constitute</button>
															<%}else{ %>
																<button type="submit" value="<%=obj[2] %>" name="sub" class="btn btn-sm view" style="background-color: green !important; font-size: 12px;" >Constitute</button>
															<%} %>
														</td>
													</tr>
													
													
													
													<%
														}}else{
													%>
													<tr>
															
															<td colspan="4" align="center"><br><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>&nbsp;&nbsp; No Committees Added<br><br></td>
													</tr>
													<%} %>
													
												</tbody>
											</table>
											</div>
										
											<div align="center">
												<button type="submit" value="remove" name="sub" class="btn btn-danger btn-sm delete" onclick="return deleteConfirm()" style="margin-bottom: 2%">Remove</button>
											</div>
																					
											<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
											<input type="hidden" name="divisionid" value="<%=divisionid%>"/>
											<input type="hidden" name="initiationid" value="<%=initiationid%>"/>
											<input type="hidden" name="projectid" value="<%=projectid%>"/>
										</form>
									</div>
								</div>
							</div>
							<!--second col -6  --> 
							
							
							
						</div>	<!-- checkboxes end -->	
				
				
				
				</div> <!-- card-body end -->

			</div> <!-- card end -->
			
			

			
		</div>
	</div>
	
</div>




<script type='text/javascript'> 
function submitForm()
{ 
  document.getElementById('myform').submit(); 
} 
</script>


	
<script type="text/javascript">   
/* 
$('.scrolltable').dataTable({
	"scrollY" : "290px",
	"scrollCollapse" : true,
	"paging" : false,
	fixedHeader : true,
	"ordering" : false,
	columnDefs : [ {
		width : 50,
		targets : 0
	},

	],
	fixedColumns : false
});
 */
</script>

<script type="text/javascript">

$(document).ready(function(){
	$("#selectall").click(function(){
	        if(this.checked){
	            $('.checkboxall').each(function(){
	                $(".checkboxall").prop('checked', true);
	            })
	        }else{
	            $('.checkboxall').each(function(){
	                $(".checkboxall").prop('checked', false);
	            })
	        }
	    });
	});
</script>

<script type="text/javascript">

$(document).ready(function(){
	$("#selectall1").click(function(){
	        if(this.checked){
	            $('.checkboxall1').each(function(){
	                $(".checkboxall1").prop('checked', true);
	            })
	        }else{
	            $('.checkboxall1').each(function(){
	                $(".checkboxall1").prop('checked', false);
	            })
	        }
	    });
	});
</script>

<script>
function deleteConfirm() {
var checkedValue=$("input[name='committeedivisionid']:checked").val();	

  if(checkedValue>0){
	  var txt;
	  var r = confirm("Are You Sure To Remove ?");
	  if (r == true) {
	    return true;
	  } else {
	    return false;
	  }  
  }else{
	  alert("Please Select Checkbox");
	  return false;
  }
  
}


function submitChecked() {
	var checkedValue=$("input[name='committeeid']:checked").val();	
	  if(checkedValue>0){
		  var txt;
		  var r = confirm("Are You Sure To Add !");
		  if (r == true) {
		    return true;
		  } else {
		    return false;
		  } 
		  
		 
	  }else{
		  alert("Please Select Checkbox");
		  return false;
	  }
	  
	}


</script>



<script type="text/javascript">
$('#divisionid').select2();
function Add(myfrm1){
	
	event.preventDefault();
	
	var date=$("#startdate").val();
	var time=$("#starttime").val();
	
	bootbox.confirm({ 
 		
	    size: "large",
		message: "<center></i>&nbsp;&nbsp;&nbsp;&nbsp;<b class='editbox'>Are You Sure To Add Schedule on "+date+" &nbsp;("+ time +") ?</b></center>",
	    buttons: {
	        confirm: {
	            label: 'Yes',
	            className: 'btn-success'
	        },
	        cancel: {
	            label: 'No',
	            className: 'btn-danger'
	        }
	    },
	    callback: function(result){ 
	 
	    	if(result){
	    	
	    		$("sub").value;
	         $("#myfrm1").submit(); 
	    	}
	    	else{
	    		event.preventDefault();
	    	}
	    } 
	}) 
	
	
}	
   
</script>


</body>
</html>