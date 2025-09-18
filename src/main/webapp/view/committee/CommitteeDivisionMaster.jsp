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
<spring:url value="/resources/css/committeeModule/committeeDivisionMaster.css" var="committeeDivisionMaster" />
<link href="${committeeDivisionMaster}" rel="stylesheet" />
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
	<div class="row">
		<div class="col-md-12">	
			<div class="card shadow-nohover">
				<div class="card-header">
					<div class="row">
						<div class="col-md-6 mt-n8">
							<form class="form-inline" method="post" action="DivisionCommitteeMaster.htm" id="myform">
									<h4 class="control-label" > Division : </h4> &nbsp;&nbsp;&nbsp;
									 <select class="form-control" id="divisionid" required="required"  name="divisionid" onchange='submitForm();' >
					   						<% for (Object[] obj : divisionlist) {%>
											<option value="<%=obj[0]%>" <%if(obj[0].toString().equals(divisionid)){ %>selected<% divisionname=obj[2].toString(); } %> ><%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - "%><%-- (<%=obj[2]%>) --%></option>
											<%} %>
					  				</select>
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />	
							</form>
						</div>
						<div class="col-md-6">	
							<%if(CommitteedivisionAssigned  !=null && CommitteedivisionAssigned.size()>0){ %>						 	
								<form method="post" action="DivCommitteeAutoSchedule.htm" id="form" >
									<button type="submit"  class="btn btn-sm preview float-right">MEETING SCHEDULE</button>
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
								<div class="card m-1">
									<div class="card-header cardpad ">
										<h5>List of Division Committees</h5>

									</div>
	
									<div class="m-1">
							
										<form name="myfrm" action="DivisionCommitteeAdd.htm" method="POST">
										<div class="table-responsive-sm table-scroll">
											<table	class=" scrolltable datatablex table table-bordered table-hover table-striped table-condensed table-sm ">
												<thead>
													<tr class="text-white headerRowBgColor">
														<th class="header" scope="col"> &nbsp;<input type="checkbox" id="selectall1">&nbsp; All </th>
														<th class="header text-left" scope="col">Committee Name</th>
														<th class="header text-left" scope="col">Duration</th>
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
														<td class="text-center"><input type="checkbox" class="checkboxall1" name="committeeid"
															value=<%=obj[0]%>></td>
														<td class="text-left"><%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - "%>(<%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - "%>)</td>
														<td class="text-left"><%if(obj[6].toString().equalsIgnoreCase("P")){ %><%=obj[7]!=null?StringEscapeUtils.escapeHtml4(obj[7].toString()): " - " %> day(s)<%} else{%>Non-Periodic<%} %> </td>
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
														<td class="text-center" colspan="4"><br><br> <i class="fa fa-exclamation-triangle" aria-hidden="true"></i>&nbsp;&nbsp; No Committees <br><br></td>
													
													</tr>
													<%} %>
												</tbody>
											</table>
											</div>
											
											<div align="center">
												<input type="submit" class="btn btn-primary btn-sm add mb-2p" onclick="return submitChecked()" value="ADD"/>
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
								<div class="card m-1">
	
									<div class="card-header cardpad ">
										<h5 >Committees Added for <%=divisionname %></h5>
									</div>
	
									<div class="m-1">
	
	
										<form name="myfrm" action="DivisionCommitteeDelete.htm"	method="POST">
										<div class="table-responsive-sm table-scroll">
											<table
												class="scrolltable datatablex table table-bordered table-hover table-striped table-condensed table-sm  ">
												<thead>
													<tr class="text-white headerRowBgColor">
														<th class="header" scope="col"> &nbsp;<input type="checkbox" id="selectall">&nbsp; All </th>
														<th class="header text-left" scope="col">Committee Name</th>
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
														<td class="text-center">
														
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
														<td class="text-left"><%=obj[0]!=null?StringEscapeUtils.escapeHtml4(obj[0].toString()): " - "%> (<%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - "%>)</td>
														<td class="text-left"><%if(obj[4].toString().equalsIgnoreCase("P")){ %><%=obj[5]!=null?StringEscapeUtils.escapeHtml4(obj[5].toString()): " - " %> days<%} else{%>Non-Periodic<%} %> </td>
														<td class="text-center"><%if(obj[6].toString().equalsIgnoreCase("Y")) {%><img src="view/images/check.png"/><%}else{ %><img src="view/images/cancel.png"/><%} %></td>
															
														<td>
															<%if(checkcount>0){ %>
																<button type="submit" value="<%=obj[2] %>" name="sub" class="btn btn-sm view ConstitutePendingColor">Constitute</button>
															<%}else{ %>
																<button type="submit" value="<%=obj[2] %>" name="sub" class="btn btn-sm view ConstituteApproveColor">Constitute</button>
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
												<button type="submit" value="remove" name="sub" class="btn btn-danger btn-sm delete mb-2p" onclick="return deleteConfirm()">Remove</button>
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

<br>

	<div class="row m-1">
		<div class="col-md-12 text-center committeeFlow">
			<b>Committee Flow</b>
		</div>
	</div>
	
	<div class="row m-1 text-center pt-10 pb-15">

		<table align="center" class="formationBorder">
			<tr>
				<td rowspan="2" class="trup height-20 flowBackGround" rowspan="2">
                  <b class="text-primary">Committee Formation</b>
                </td>
                <td rowspan="2" class="trup height-20 width-10"></td>
                <td rowspan="2"><b>---></b>
				
				</td>
				<td rowspan="2" class="trup height-20 width-10"></td>
				
				
				<td rowspan="2" class="trup height-20 flowBackGround">
					<b class="text-primary">Is PreApproved </b>
				</td>
				<td class="trup height-20 width-10"></td>
				<td ><b>---></b>
				
				</td>
				
				
				
				<td class="trup yesFlow">
					<b class="text-primary"> YES</b>
				</td>
				
				<td class="trup height-20 width-10"></td>
				
				<td><b>---</b></td>			
				<td class="trup height-20 width-10"><b>---------------</b></td>
				
				
				
				<td class="trup height-20 width-10"></td>
				 <td  ><b>---></b>
				
				 </td> 
				<td class="trup height-20 width-10"></td>
				
				
				<td rowspan="2" class="trup height-20 flowBackGround">
					<b class="text-primary">Committee Constitution</b>
				</td>
				<td rowspan="2" class="trup height-20 width-10"></td>
				<td rowspan="2" ><b>---></b>
				
				</td>
				<td rowspan="2" class="trup height-20 width-10"></td>
				
				<td rowspan="2" class="trup height-20 flowBackGround">
					<b class="text-primary">Schedule </b>
				</td>
				
			

			</tr>
			<tr >
			
			    <td class="trup height-20 width-10"></td>
				<td><b>---></b>
				
				</td>
			

				<td class="trup yesFlow">
					<b class="text-primary"> No</b>
				</td>
				<td class="trup height-20 width-10"></td>
				<td><b>---></b>
				
				</td>
				
				<td class="trup approvalFlow">
					<b class="text-primary">Approval</b>
				</td>
				<td class="trup height-20 width-10"></td>
				<td><b>---></b>
				
				</td>
				
				
				
				
				

			</tr>



		</table>



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