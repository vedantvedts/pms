<%@page import="java.sql.Date"%>
<%@page import="java.time.LocalDate"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
		pageEncoding="ISO-8859-1"
		import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.io.ByteArrayOutputStream,java.io.ObjectOutputStream"%>
	<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
	
	<!DOCTYPE html>
	<html>
	<head>
	<meta charset="ISO-8859-1">
	<jsp:include page="../static/header.jsp"></jsp:include>
	
	
	<title>COMMITTEE SCHEDULE VIEW</title>
	<style>
	h6 {
		color: black;
		font-family: 'Lato', sans-serif;
		font-weight: 800;
	}
	
	.card-header {
		background-color: #07689f;
		color: white;
	}
	
	.card {
		border: 1px solid black;
	}
	
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
	
	.form-group {
		margin-top: 0.5rem;
		margin-bottom: 1rem;
	}
	
	.mandatory {
		font-weight: 800;
	}
	
	b{
	font-family: 'Lato', sans-serif;
	}
	
	.form-block form{
		display: inline-block;
	}
	
	</style>
	
	</head>
	<body>
		

<%
	SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
	SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd");
	List<Object[]> agendalist=(List<Object[]>)request.getAttribute("agendalist");
	
	Object[] scheduledata=(Object[])request.getAttribute("scheduledata");
	List<Object[]> empscheduledata=(List<Object[]>)request.getAttribute("empscheduledata");
	
	String CommitteeName=scheduledata[8].toString();
	List<Object[]> invitedlist=(List<Object[]>)request.getAttribute("invitedlist");	
	
	List<Object[]> AgendaDocList=(List<Object[]>) request.getAttribute("AgendaDocList");
	%>
	
	
	
	
	
	
	
	<%String ses=(String)request.getParameter("result"); 
	 String ses1=(String)request.getParameter("resultfail");
		if(ses1!=null){
		%>
		<center>
		<div class="alert alert-danger" role="alert" >
	                     <%=ses1 %>
	                    </div>
		<%}if(ses!=null){ %>
		</center><center>
		<div class="alert alert-success" role="alert" >
	                     <%=ses %>
	                   </div>
	                    <%} %>
	</center>
	
	
	<div class="container-fluid">
			<div class="row" style="">
			
				<div class="col-md-12 ">
				
				<div class="card shadow-nohover" >
					<div class="card-header">
						 <div class="row" >
							<div class="col-md-3">
							 	<h4> <%=CommitteeName %> Meeting </h4> 	
							 </div>
							 <div class="col-md-9" >
							 	<h5 style="color:white!important;float: right;margin-top: 6px;">(Meeting Id : <%=scheduledata[11] %>) &nbsp;&nbsp; - &nbsp;&nbsp;(Meeting Date and Time : <%= sdf.format(sdf1.parse( scheduledata[2].toString()))%>  &  <%=scheduledata[3] %>)</h5> 	
							 </div>
						 </div>
					 </div>
					 
					 <div class="card-body">
					 
						<h5 style="color:#07689f">Agenda</h5>
						<hr>
						<br>
					
					 		<%if(!agendalist.isEmpty()){ %>
				
			         	<table  class="table table-bordered table-hover table-striped table-condensed ">
			            	<thead>
			               		<tr>
			                    	<th>Sn</th>
			                       	<th>Agenda Item</th> 
			                       	<th>Project</th>
			                       	<th>Remarks</th>
			                       	<th>Presenter</th>
			                       	<th>Duration <span >(Minutes)</span></th>
			                       	<th>Attachment</th>
			                    </tr>
			              	</thead> 
			              		<%	int count=0;
							for(Object[] 	obj:agendalist){ count++;%>  
							                     
				    		<tbody>
							
								<tr>
										
									<td><%=count%></td>
									<td><%=obj[3] %></td>
									<td><%=obj[4] %>  </td>									
									<td><%=obj[6] %></td>									
									<td><%=obj[10]%>(<%=obj[11] %>)  </td>
									<td><%=obj[12] %></td>
									<td>
										<table>
											<%for(Object[] doc : AgendaDocList) { 
											if(obj[0].toString().equalsIgnoreCase(doc[1].toString())){%>
												<tr>
													<td><%=doc[3] %></td>
													<td style="width:1% ;white-space: nowrap;" ><a href="AgendaDocLinkDownload.htm?filerepid=<%=doc[2]%>" target="blank"><i class="fa fa-download" style="color: green;" aria-hidden="true"></i></a></td>
												<tr>													
											<%} }%>
										</table>
						
									</td>
									
								</tr>
									
							</tbody>
				    		
								<%}} %>

			             </table>

<!-- Second Block -->

						<h5 style="color:#07689f">Decision</h5>
						<hr>
						<br>

						<form action="MeetingAgendaApprovalSubmit.htm" name="myfrm" id="myfrm" method="post">
						
						<div class="row">
							<div class="col-md-6">
							
								<textarea rows="2" style="display:block" type="text" class="form-control"  id="Remark" name="Remark"  placeholder="Enter Remarks to Return ..!!"></textarea>
								
							
							</div>
							<div class="col-md-6" align="center">
								<br>
								<button type="submit"  name="sub" value="approve" class="btn btn-success" style="font-weight: 600" onclick="return confirm('Are You Sure To Approve ?')"><i class="fa fa-check" aria-hidden="true" ></i> Approve</button>
								<button type="submit"  name="sub" value="return" class="btn btn-danger" onclick="remarks()" style="padding: 0.375rem 17px;font-weight: 600"><i class="fa fa-repeat" aria-hidden="true" ></i> Return</button>
								<button type="submit"  name="sub" value="back" class="btn btn-primary back"  style="padding: 0.375rem 17px;"> Back</button>
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
								<input type="hidden" name="scheduleid" value="<%=scheduledata[6] %>"/>
							
							</div>
						</div>
								
						
						<br>

						</form>	
<!-- Third Block -->

						<h4 style="color:#07689f">Committee Constitution</h4>
						<hr>
						<br>

						<div class="row">
      		
		      				<div class="col-md-6">
		      				
								<div class="table-responsive" style="overflow-x:hidden"> 
								
			    				<table class="table table-bordered table-hover table-striped table-condensed" id="myTable4" >
									
									<tbody>
										<%	
											for(Object[] obj:invitedlist){ %>
										
									
										<tr>
												
											<td> 
												<%  if(obj[3].toString().equalsIgnoreCase("CC")) {		 %>Chairperson<%}
													else if(obj[3].toString().equalsIgnoreCase("CS") ){	 %> Member Secretary<%}
													else if(obj[3].toString().equalsIgnoreCase("PS") ) { %>Member Secretary (Proxy) <%}
													else if(obj[3].toString().equalsIgnoreCase("CI")){   %> Internal<%}
													else if(obj[3].toString().equalsIgnoreCase("CW")){	 %> External(<%=obj[11] %>)<%}
													else if(obj[3].toString().equalsIgnoreCase("CO")){	 %> External(<%=obj[11]%>)<%}
													else if(obj[3].toString().equalsIgnoreCase("P") ){	 %>Presenter <%}
													else if(obj[3].toString().equalsIgnoreCase("I")){	 %> Addl. Internal<%}
													else if(obj[3].toString().equalsIgnoreCase("W") ){	 %> Addl. External(<%=obj[11] %>)<%}
													else if(obj[3].toString().equalsIgnoreCase("E") )    {%> Addl. External(<%=obj[11] %>)<%}
													else {%> <%=obj[3].toString()%> (<%=obj[11] %>)  <%}
												%>
												
											</td>
											<td><%=obj[6] %> (<%=obj[7]%>)</td>  
										</tr>
										<%}	%>
									
									
									</tbody>
								</table>
								
								</div>
							
							</div>
							<div class="col-md-6">
								
									<table class="table table-bordered table-hover table-striped table-condensed" id="myTable4" >
									<thead>
										<tr>
											<th colspan="4" style="text-align: center;">My Schedules on <%= sdf.format(sdf1.parse( scheduledata[2].toString()))%> </th>
										</tr>
										<tr>
											<th>SN</th>
											<th>Meeting Id</th>
											<th>Member Type</th>
											<th>Time</th>
										</tr>
									</thead>
									<tbody>
										<%long count=0;
										for(Object[] obj:empscheduledata){
											count++;%>
										<tr>
											<td><%=count %></td>
											<td><%=obj[1] %></td>
											<td> 
												<%  if(obj[3].toString().equalsIgnoreCase("CC")) {		 %>Chairperson<%}
													else if(obj[3].toString().equalsIgnoreCase("CS") ){	 %> Member Secretary<%}
													else if(obj[3].toString().equalsIgnoreCase("PS") ) { %>Member Secretary (Proxy) <%}
													else if(obj[3].toString().equalsIgnoreCase("CI")){   %> Internal<%}
													else if(obj[3].toString().equalsIgnoreCase("CW")){	 %> External(<%=obj[11] %>)<%}
													else if(obj[3].toString().equalsIgnoreCase("CO")){	 %> External(<%=obj[11]%>)<%}
													else if(obj[3].toString().equalsIgnoreCase("P") ){	 %>Presenter <%}
													else if(obj[3].toString().equalsIgnoreCase("I")){	 %> Addl. Internal<%}
													else if(obj[3].toString().equalsIgnoreCase("W") ){	 %> Addl. External(<%=obj[11] %>)<%}
													else if(obj[3].toString().equalsIgnoreCase("E") )    {%> Addl. External(<%=obj[11] %>)<%}
													else {%> <%=obj[3].toString()%> (<%=obj[11] %>)  <%}
												%>
											</td>
											<td><%=obj[5] %></td>
										</tr>
										<%}	%>
									
									
									</tbody>
								</table>
							</div>					
						</div>	
					</div>
				 </div>
			</div>
		</div>	
	</div>
	
	
	
	
	
	
<script>



function remarks(){
	
	 event.preventDefault();
	
	 if($("#Remark").val()==""){
		 alert('Kindly fill Remarks to Return !')
	 }
	 if($("#Remark").val()!=""){
		 
		 var r=confirm("Are you sure, You want to Return ?");
	
		 if(r==true){
		 var input= $("<input>").attr("type","hidden").attr("name","sub").val("return");
		 
		 $("#myfrm").append(input);
		 $("#myfrm").submit(); 
		 }
		 
	 }
	 
	

}

$('#startdate').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});

$('#readonlystartdate').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	/* "minDate":new Date(), */
	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});

 
$(function() {
	   $('#starttime').daterangepicker({
	            timePicker : true,
	            singleDatePicker:true,
	            timePicker24Hour : true,
	            timePickerIncrement : 1,
	            timePickerSeconds : false,
	            locale : {
	                format : 'HH:mm'
	            }
	        }).on('show.daterangepicker', function(ev, picker) {
	            picker.container.find(".calendar-table").hide();
	   });
	})
 
	
function Add(myfrm){
	
	event.preventDefault();
	
	var date=$("#readonlystartdate").val();
	var time=$("#starttime").val();
	
	bootbox.confirm({ 
 		
	    size: "large",
		message: "<center></i>&nbsp;&nbsp;&nbsp;&nbsp;<b class='editbox'>Are You Sure To Update Schedule to "+date+" &nbsp;("+ time +") ?</b></center>",
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
	         $("#editform").submit(); 
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