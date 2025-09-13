
<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
	    <%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Milestone Activity Master</title>
<jsp:include page="../static/header.jsp"></jsp:include>


<spring:url value="/resources/css/master/MilestoneActivityType.css" var="MilestoneActivityType" />     
<link href="${MilestoneActivityType}" rel="stylesheet" />

</head>
<body>
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
	
	<br />
	<%
	List<Object[]> MilestoneActivityType = (List<Object[]>) request.getAttribute("activitylist");
	%>


	<div class="container-fluid">
		<div class="col-md-12">
			<div class="card">

				<div class="card-header">
					<div class="row">
						<div class="col-md-10">
							<h4>Activity Master</h4>
						</div>
						<div class="col-md-2">
							<a class="btn btn-info btn-sm  back"
								
								href="MainDashBoard.htm">Back</a>
						</div>
					</div>
				</div>

				<div class="row mainrow" >
					<div class="col-md-7">
						<div >
							<div class="card ">

								<div class="card-body shadow-nohover">
									<div class="row rowTop" >
										<div class="container-fluid">
											<div class="col-lg-12 col-md-10 col-sm-6 col-xs-6">
												<div class="sparkline13-list">
													<div class="sparkline13-graph">
														<div
															class="datatable-dashv1-list custom-datatable-overright">
															<form action="ActivityMaster.htm" method="POST" >
																<table
																	class="table table-bordered table-hover table-striped table-condensed "
																	id="myTable">
																	<thead>
																		<tr>
																			<th>Select</th>
																			<th>Activity Type</th>
																			<th>Activity Code</th>
																			<th>Is Time Sheet</th>
																		</tr>
																	</thead>
																	<tbody>
																		<%
																		for (Object[] obj : MilestoneActivityType) {
																		%>
																		<tr>
																			<td><input type="radio" name="Did" value=<%=obj[0]!=null?StringEscapeUtils.escapeHtml4(obj[0].toString()):""%>></td>
																				
																			<td id="<%=obj[0]%>"> 
																				<%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()):"-"%>
																				<input type="hidden" name="<%=obj[0]%>" value="<%=obj[1]%>" >
																			</td>
																			<td id="<%=obj[0]%>"> 
																				<%=obj[3]!=null?StringEscapeUtils.escapeHtml4(obj[3].toString()):"-"%>
																				<input type="hidden" name="<%=obj[0]%>" value="<%=obj[3]%>" >
																			</td>
																			<td id="<%=obj[0]%>">
																				<%=obj[2]!= null && obj[2].toString().equalsIgnoreCase("Y")? "Yes":"No"%>
																				<input type="hidden" name="<%=obj[0]%>" value="<%=obj[2]%>" >
																			</td>
																		</tr>
																		<% }%>
																	</tbody>
																</table>
															</form>

															<!-- Button trigger modal -->
															<div class='container modalbutton' >
															<div class="row" >
															<div class='col'>
															<button type="button" class="btn btn-warning btn-sm edit" 
																onclick="openEditModal()">Edit</button></div>
																<div class='col'>
															<button type="submit" class="btn btn-danger btn-sm delete" 
																onclick="DeleteActivityType()">Delete</button>
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
						</div>
					</div>
					<div class="col-md-5">
						<div >

							<div class="card ">

								<div class="card-body  shadow-nohover">
									<form action="ActivityAddSubmit.htm" method="POST"
										id="addcheck">
										<div class="row activityAdd" >
											<div class="col-md-12">
												<div class="table-responsive">
													<table
														class="table table-bordered table-hover table-striped table-condensed">
														<thead  class="activityTblThead">
															<tr>
																<th>Activity Type</th>
																<th>Activity Code</th>
																<th>Is Time Sheet</th>
															</tr>
														</thead>
														<tbody>
															<tr>
																<td>
																	<input class="form-control alphanum-no-leading-space" type="text" id="activitytype" name="activitytype" maxlength="255" required>
																</td>
																<td>
																	<input class="form-control alphanum-only" type="text" id="activityCode" name="activityCode" maxlength="10" required>
																</td>
																<td>
																	<select class="form-control" name="isTimeSheet" id="isTimeSheet" required>
																		<option value="0" selected>----select----</option>
																		<option value="Y">Yes</option>
																		<option value="N">No</option>
																	</select>
																</td>
															</tr>
														</tbody>
													</table>
												</div>
												<div class="btndiv" >
													<button type="button" class="btn btn-success btn-sm add " name="sub" value="edit" onclick="return AddActivityCheck('addcheck');">ADD</button>
												</div>
												<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
											</div>
										</div>
									</form>
								</div>
							</div>
						</div>
					</div>

				</div>
			</div>
		</div>
	</div>

	<script type='text/javascript'>
  
    $(document).ready(function(){
    	$('#LogInId').select2();
    	
    });
  
  </script>
	<script type="text/javascript">
   
   function AddActivityCheck(myfrm){
	   var count=0;
		var atype=$('#activitytype').val().trim();
		var acode=$('#activityCode').val().trim();
		var isTimeSheet=$('#isTimeSheet').val();
	    if(atype.length==0){
	    	alert("Please fill the Activity Type !");
	    	return false;
	    }else if(acode.length==0){
	    	alert("Please fill the Activity Code !");
	    	return false;
	    }else if(isTimeSheet=="0"){
	    	alert("Please Select Is Time Sheet !");
	    	return false;
	    }
	    else{
		
        $.ajax({
        	
         	   type:"GET",
         	   url:"AddActivityCheck.htm",
         	   
         	  data:{
         		    activitytype:atype.trim(),
         		    activityTypeId:0,
         	  },
         	datatype:'json',
         	success:function(result){
         	var ajaxresult = JSON.parse(result);
         		
	         if(ajaxresult[0]==1)
	         {
	        	 alert("Activity type already exists");
	        	 return false;
	         }
         		 
         		
         		if(ajaxresult[0]==0 && confirm('Are you Sure to Submit ?')){
         			
         			$('#'+myfrm).submit();
         			return true;
         			
         		}else{
         			return false;
         		}
         
         		
         	 }
        });  
	    }
   } 
</script>



	<!-- Modal -->
	<div class="modal fade" id="ActivityTypeEditModal" tabindex="-1"
		role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Edit Activity Type</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<form action="ActivityTypeEdit.htm" method="POST" id="EditActivityTypeForm" >
					<div class="modal-body">
						<div class="table-responsive">
							<table
								class="table table-bordered table-hover table-striped table-condensed">
								<thead  class="tableHead">
									<tr>
										<th>Activity Type</th>
										<th>Activity Code</th>
										<th>Is Time Sheet</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>
											<input class="form-control alphanum-no-leading-space" type="text" id="ToEditActivitytype" name="toActivity" maxlength="255" required>
										</td>
										<td>
											<input class="form-control alphanum-only" type="text" id="ToEditActivityCode" name="activityCode" maxlength="10" required>
										</td>
										<td>
											<select class="form-control" name="isTimeSheet" id="ToEditIsTimeSheet" required>
												<option value="0" selected disabled>----select----</option>
												<option value="Y">Yes</option>
												<option value="N">No</option>
											</select>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						<input type="hidden" name="ActivityID" id="ActivityID"> 
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					</div>
					<div class="modal-footer">
						<input type="button" onclick="return EditActivityCheck()" value="Edit"  class="btn btn-warning btn-sm edit footerbtn"
							 >
					</div>
				</form>
				<form action="ActivityTypeEdit.htm" method="POST" id="DeleteActivityTypeForm" >
					<input type="hidden" id="ActivityId" name="ActivityID">
					<input type="hidden" name="Delete">
					<input type="hidden" name="ActivityID" id="ActivityID"> 
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				</form>
			</div>
		</div>
	</div>


</body>
<script type="text/javascript">
$(document).ready(function(){
	  $("#myTable").DataTable({
	 "lengthMenu": [ 5, 10,25, 50, 75, 100 ],
	 "pagingType": "simple",
		 "pageLength": 5
});
	  });
  
  
function EditActivityCheck(){
		var atype=$('#ToEditActivitytype').val().trim();
		var activityid=$('#ActivityID').val();
     $.ajax({
      	   type:"GET",
      	   url:"AddActivityCheck.htm",
      	   
      	  data:{
      		    activitytype:atype.trim(),
      		    activityTypeId:activityid,
      	  },
      	datatype:'json',
      	success:function(result){
      	var ajaxresult = JSON.parse(result);

	         if(ajaxresult[0]==1)
	         {
				alert("Activity type already exists");
	        	 return false;
	         }
	         
	         if(ajaxresult[0]==0 && confirm("Are you sure to Edit?"))$('#EditActivityTypeForm').submit();
	         //console.log(confirm("are you sure to edit"));
      	}
     });  
	    
} 
  
  
  function openEditModal() {
	  
	var selectedindex=$('input[name="Did"]:checked').val();
	try{		
		var innertext1=document.getElementsByName(selectedindex)[0].value;
		var innertext2=document.getElementsByName(selectedindex)[1].value;
		var innertext3=document.getElementsByName(selectedindex)[2].value;
	}catch { 
		alert("Please select an Activity to Edit");return 0;
	}
	
	$('#ActivityTypeEditModal').modal('show');
	$('#ToEditActivitytype').val(innertext1);
	$('#ToEditActivityCode').val(innertext2);
	$('#ToEditIsTimeSheet').val(innertext3).trigger('change');
	$('#ActivityID').val(selectedindex);
	  
  }
  
  function DeleteActivityType()
  {
		var selectedindex=$('input[name="Did"]:checked').val();
		try{		
		var innertext=document.getElementsByName(selectedindex)[0].value;
		}
		catch { alert("Please select an Activity to Delete");return 0;
		}
		$('#ActivityId').val(selectedindex);
		if(confirm('Are you sure to Delete this Activity Type?'))
		$('#DeleteActivityTypeForm').submit();
		
  }
  

</script>
</html>