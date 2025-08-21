<%@page import="org.apache.commons.text.StringEscapeUtils"%>
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
	SimpleDateFormat sdf1=new SimpleDateFormat("dd-MM-yyyy");
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
	List<Object[]>  committeelist=(List<Object[]>)request.getAttribute("committeelist");
	List<Object[]>  projectmasterlist=(List<Object[]>)request.getAttribute("projectmasterlist");
	List<Object[]> ProjectsList=(List<Object[]>) request.getAttribute("ProjectsList");
	List<Object[]> ProjectFormationCheckList=(List<Object[]>) request.getAttribute("ProjectCommitteeFormationCheckList");
	

List<Object[]>  Projectschedulelist=(List<Object[]>)request.getAttribute("Projectschedulelist");
Object[] committeedetails=(Object[])request.getAttribute("committeedetails");
String projectid=(String)request.getAttribute("projectid");
String divisionid=(String)request.getAttribute("divisionid");
String initiationid=(String)request.getAttribute("initiationid");
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


	<%Object[] Projectdetails=(Object[])request.getAttribute("Projectdetails");
	String Project=null;%>

<div class="container-fluid">
		
	<div class="row">
		<div class="col-md-12">	
				
			<div class="card shadow-nohover">
				<div class="card-header">
					<div class="row">
						<div class="col-md-6" style="margin-top:-0.5rem;">	
						<!-- 	<h4>Initiation Committees</h4> -->
						
						<%if(initiationid!=null && Long.parseLong(initiationid)>0){ %>
								<form class="form-inline" method="post" action="InitiationCommitteeMaster.htm" id="myform">
									
									<h4 class="control-label" > Project : </h4> &nbsp;&nbsp;&nbsp;
									
										 <select class="form-control" id="initiationid" required="required" name="initiationid" onchange='submitForm();' >
						   						<% for (Object[] obj : ProjectsList) {
						   						%>
												<option value="<%=obj[0]%>" <%if(obj[0].toString().equals(initiationid)){ %>selected<%  } %> ><%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()): " - "%></option>
												<%} %>
						  				</select>
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />	
	
								</form>
							<%}%>
						</div>
							
						<%-- <div class="col-md-6">	
							<%if(projectmasterlist!=null&&projectmasterlist.size()>0){ %>
								<%if(Long.parseLong(projectid)>0){ %>
								<form method="post" action="CommitteeAutoSchedule.htm" id="form" >
								<%}else if(Long.parseLong(initiationid)>0){ %>
								<form name="myfrm" action="DivCommitteeAutoSchedule.htm" method="POST">
								<%} %>
									<button type="submit" class="btn btn-sm preview" style="float:right" >MEETING SCHEDULE</button>
									<input type="hidden" name="divisionid" value="<%=divisionid%>"/>	
									<input type="hidden" name="projectname" value="<%=Project %>"/>
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
									<input type="hidden" name="projectid" value="<%=projectid%>"/>
									<input type="hidden" name="initiationid" value="<%=initiationid%>"/>		
								</form>
							<%} %>
						</div>	 --%>
					</div>
				</div><!-- card header -->
			<!-- checkboxes start -->	
				<div class="card-body">
					<div class="row">
							<!-- /////add Committees -->
							 <div class="col-sm-6">
								<div class="card" style="margin: 5px">
									<div class="card-header cardpad ">
										<table>
											<tr>
												<td width="50%"><h5 style="margin-bottom: -2px">List of Project Committees</h5></td>
												<td width="50%" align="right">
													<%if(Long.parseLong(projectid)>0){ %>
														<form method="post" action="CommitteeList.htm"  >
															<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
															<button type="submit" name="projectid" value="<%=projectid%>" class="btn btn-sm add" >LIST</button>
															<input type="hidden" name="projectappliacble" id="projectappliacble" value="P" />						
														</form>
													<%} %>
												</td>									
											</tr>
										</table>
									</div>
	
									<div style="margin: 5px">
										<%if(Long.parseLong(projectid)>0){ %>
										<form name="myfrm" action="ProjectCommitteeAdd.htm" method="POST">
										<%}else if(Long.parseLong(initiationid)>0){ %>
										<form name="myfrm" action="InitiationCommitteeAdd.htm" method="POST">
										<%} %>
										<div class="table-responsive-sm" style="height: 400px;overflow: auto ;">
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
														if (committeelist != null&&committeelist.size()>0) {
															for (Object[] obj : committeelist) {
																if(obj[4].toString().equals("P")){
																	check.add(obj[4]);
													%>
													<tr>
														<td style="text-align: center;"><input type="checkbox" class="checkboxall1" name="committeeid"
															value=<%=obj[0]%>></td>
														<td style="text-align: left;"><%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - "%>(<%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - "%>)</td>
														<td style="text-align: left;"><%if(obj[6].toString().equalsIgnoreCase("P")){ %><%=obj[7]!=null?StringEscapeUtils.escapeHtml4(obj[7].toString()): "" %> days<%} else{%>Non-Periodic<%} %> </td>
													</tr>
													<%
														}
														}	
														}
													%>
													<%
														if (committeelist.size()>0 && committeelist != null && check.size()>0 ) {%>
														
													<%} else{%>
													<tr>
														<td style="text-align: center;" colspan="4"><br><br> <i class="fa fa-exclamation-triangle" aria-hidden="true"></i>&nbsp;&nbsp; No Committees <br><br></td>
													</tr>
													<%} %>
												</tbody>
											</table>
											</div>
											
											<%if (committeelist.size()>0 && committeelist != null && check.size()>0 ) {%>
											<div align="center">
												<input type="submit" class="btn btn-primary btn-sm add" onclick="return submitChecked()" value="ADD" style="margin :15px; "/>
											</div>
											<%} %>
											
											<input type="hidden" name="initiationid" value="<%=initiationid%>"/>
											<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
											<input type="hidden" name="projectid" value="<%=projectid%>"/>
										</form>
										
									</div>
								</div>
							</div>
					

					
							<div class="col-sm-6">
								<div class="card" style="margin: 5px">
	
									<div class="card-header cardpad ">
										<%-- <h5 style="margin-bottom: -2px; ">Committees Added for <%=Project %></h5> --%>
										<h5 style="margin-bottom: -2px; ">Committees Added for Initiation</h5>
									</div>
	
									<div style="margin: 5px">
	
										<%if(Long.parseLong(projectid)>0){ %>
										<form name="myfrm" action="ProjectCommitteeDelete.htm"	method="POST">
										<%}else if(Long.parseLong(initiationid)>0){ %>
										<form name="myfrm" action="InitiationCommitteeDelete.htm" method="POST">
										<%} %>
										
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
													<% if(projectmasterlist!=null && projectmasterlist.size()>0){
														for (Object[] obj : projectmasterlist) {
													%>
													<tr>
														<td style="text-align: center;">
														
														<% int checkcount=0;
														for(Object[] checklist : ProjectFormationCheckList){															
															if(obj[3].toString().equalsIgnoreCase(checklist[0].toString()) && checklist[1]==null){
																checkcount++;
																break;
															}
														}
														
														if(obj[6].toString().equalsIgnoreCase("N") && checkcount >0) {	%>
														
															<input type="checkbox" class="checkboxall" name="committeeprojectid" value="<%=obj[3]%>">
																	
																
														<%} else{ %>
															<input type="checkbox" disabled >
														<%} %>
														
														
														
														</td>
														<td style="text-align: left;"><%=obj[0]!=null?StringEscapeUtils.escapeHtml4(obj[0].toString()): " - "%> (<%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - "%>)</td>
														<td style="text-align: left;"><%if(obj[4].toString().equalsIgnoreCase("P")){ %><%=obj[5]!=null?StringEscapeUtils.escapeHtml4(obj[5].toString()): "" %> days<%} else{%>Non-Periodic<%} %> </td>
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
										<% if(projectmasterlist!=null&&projectmasterlist.size()>0){%>
											<div align="center">
												<button type="submit" value="remove" name="sub" class="btn btn-danger btn-sm delete" onclick="return deleteConfirm()" style="margin-bottom: 2%">Remove</button>
											</div>
										<%}%>											
											<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
											<input type="hidden" name="projectid" value="<%=projectid%>"/>
											<input type="hidden" name="initiationid" value="<%=initiationid %>"/>
											<input type="hidden" name="divisionid" value="<%=divisionid%>"/>
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



<br>

	<div class="row m-1">
		<div class="col-md-12"
			style="text-align: center; width: 140px; height: 30px;color:green">
			<b>Committee Flow</b>
		</div>
	</div>
	
	<div class="row m-1"
		style="text-align: center; padding-top: 10px; padding-bottom: 15px;">

		<table align="center" style="border-spacing: 0 20px;">
			<tr>
				<td rowspan="2" class="trup" style="background: #c4ced3; width: 230px; height: 20px;" rowspan="2">
                  <b class="text-primary">Committee Formation</b>
                </td>
                <td rowspan="2" class="trup" style="width: 10px; height: 20px;"></td>
                <td rowspan="2"><b>---></b>
				
				</td>
				<td rowspan="2" class="trup" style="width: 10px; height: 20px;"></td>
				
				
				<td rowspan="2" class="trup" style="background: #c4ced3; width: 230px; height: 20px;">
					<b class="text-primary">Is PreApproved </b>
				</td>
				<td class="trup" style="width: 10px; height: 20px;"></td>
				<td ><b>---></b>
				
				</td>
				
				
				
				<td class="trup"style=" width: 40px; height: 5px; margin-left: 20px;">
					<b class="text-primary"> YES</b>
				</td>
				
				<td class="trup" style="width: 10px; height: 20px;"></td>
				
				<td><b>---</b></td>			
				<td class="trup" style="width: 10px; height: 20px;"><b>---------------</b></td>
				
				
				
				<td class="trup" style="width: 10px; height: 20px;"></td>
				 <td  ><b>---></b>
				
				 </i></td> 
				<td class="trup" style="width: 10px; height: 20px;"></td>
				
				
				<td rowspan="2" class="trup" style="background: #c4ced3; width: 230px; height: 20px;">
					<b class="text-primary">Committee Constitution</b>
				</td>
				<td rowspan="2" class="trup" style="width: 10px; height: 20px;"></td>
				<td rowspan="2" ><b>---></b>
				
				</td>
				<td rowspan="2" class="trup" style="width: 10px; height: 20px;"></td>
				
				<td rowspan="2" class="trup" style="background: #c4ced3; width: 230px; height: 20px;">
					<b class="text-primary">Schedule </b>
				</td>
				
			

			</tr>
			<tr >
			
			    <td class="trup" style="width: 10px; height: 20px;"></td>
				<td><b>---></b>
				
				</td>
			

				<td class="trup"style=" width: 40px; height: 5px; margin-left: 20px;">
					<b class="text-primary"> No</b>
				</td>
				<td class="trup" style="width: 10px; height: 20px;"></td>
				<td><b>---></b>
				
				</td>
				
				<td class="trup"style=" background: #c4ced3; width: 100px; height: 5px; margin-left: 20px;">
					<b class="text-primary">Approval</b>
				</td>
				<td class="trup" style="width: 10px; height: 20px;"></td>
				<td><b>---></b>
				
				</td>
				
				
				
				
				

			</tr>



		</table>



	</div>
	<br> 
	<br>
	<br>


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
var checkedValue=$("input[name='committeeprojectid']:checked").val();	

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
$('#initiationid').select2();
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
	    callback: function(result)
	    {
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
/* function submitForm()
{ 
  document.getElementById('myform').submit(); 
} */
</script>


</body>
</html>