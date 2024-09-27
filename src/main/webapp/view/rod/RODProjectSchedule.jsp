<%@page import="java.time.LocalTime"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Arrays"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
#scrollclass::-webkit-scrollbar {
	width: 7px;
}

#scrollclass::-webkit-scrollbar-track {
	-webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.3);
	border-radius: 5px;
}

#scrollclass::-webkit-scrollbar-thumb {
	border-radius: 5px; 
	/*   -webkit-box-shadow: inset 0 0 6px black;  */
	background-color: #fff;
} 

#scrollclass::-webkit-scrollbar-thumb:hover {
	-webkit-box-shadow: inset 0 0 6px black;
	transition: 0.5s;
}

#scrollclass::-webkit-scrollbar {
	width: 7px;
}

#scrollclass::-webkit-scrollbar-track {
	-webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.3);
	border-radius: 5px;
}

#scrollclass::-webkit-scrollbar-thumb {
	border-radius: 5px;
	/*   -webkit-box-shadow: inset 0 0 6px black;  */
	background-color: #fff;
}

#scrollclass::-webkit-scrollbar-thumb:hover {
	-webkit-box-shadow: inset 0 0 6px black;
	transition: 0.5s;
}


.meetingsp{
  width:75%;
  transition: background-color 3s ease;
  background-image: linear-gradient(to right, green 50%, #f8f9fa 50%);
  background-size: 200% 100%;
  background-position: 100% 0;
  transition: background-position 0.5s ease;
  color:black;
  padding:10px;
  border-radius: 8px;
  display: block;
  font-weight: 600;
  margin:1%;
  margin-left:12%;
}
.meetingsp:hover{
 	/*  background-color: green;
	 background-image: linear-gradient(to right, green, blue); */
	 color:white;
 background-position: 0 0;
 box-shadow: 3px 3px 3px gray;
	/* background-color:red; */
color:white;
font-weight: 600;	
}
#span{
background: blue;
}
#span1{
font-size: 10px;
margin-left:10px
}

#span2{
float:right;
font-size: 10px;
margin-right:10px
}

</style>
</head>
<body>
<%

List<Object[]> ProjectsList = (List<Object[]>) request.getAttribute("ProjectsList");
List<Object[]>  Projectschedulelist = (List<Object[]>)request.getAttribute("RODProjectschedulelist");
List<Object[]>  RODNameslist =(List<Object[]>)request.getAttribute("RODNameslist");

Object[] rodMasterDetails =(Object[])request.getAttribute("RODMasterDetails");
Object[] Projectdetails=(Object[])request.getAttribute("Projectdetails");

String projectId=(String)request.getAttribute("projectId");
String initiationId=(String)request.getAttribute("initiationId");
String rodNameId=(String)request.getAttribute("rodNameId");
String projectType=(String)request.getAttribute("projectType");

List<String>status= Arrays.asList("MKV","MMR","MMF","MMA","MMS");

String today=LocalDate.now().toString();
List<Object[]>PreviousmeetingList= new ArrayList<>();

if(!Projectschedulelist.isEmpty()){
	if(rodNameId.equalsIgnoreCase("all")){
		PreviousmeetingList=Projectschedulelist.stream().filter(i -> LocalDate.parse(i[3].toString()).isBefore(LocalDate.now())  ).collect(Collectors.toList());
		
	}else{
		PreviousmeetingList=Projectschedulelist.stream().filter(i -> i[1].toString().equalsIgnoreCase(rodNameId) &&  LocalDate.parse(i[3].toString()).isBefore(LocalDate.now())  ).collect(Collectors.toList());
	
	}
}

 if(projectType.equalsIgnoreCase("N")){

	Projectschedulelist=Projectschedulelist.stream().filter(i->i[9].toString().equalsIgnoreCase("0")).collect(Collectors.toList());
}
if(projectType.equalsIgnoreCase("I")){
	Projectschedulelist=Projectschedulelist.stream().filter(i->i[9].toString().equalsIgnoreCase(initiationId)).collect(Collectors.toList());
} 

SimpleDateFormat sdf1=new SimpleDateFormat("dd-MM-yyyy");
SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
FormatConverter fc=new FormatConverter(); 
SimpleDateFormat sdf2=fc.getRegularDateFormat();
SimpleDateFormat sdf3=fc.getSqlDateFormat();

%>

<% String ses=(String)request.getParameter("result"); 
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
		<div class="alert alert-success" role="alert" >
	    	<%=ses %>
		</div>
	</div>
<%} %>

<form method="post" action="RecordofDiscussion.htm" id="myformtype" style="">
<div class="row">
<div class="col-md-1" style="display: flex;justify-content: flex-end;">
Project Type:
</div>
<div class="col-md-2">
<select class="form-control" id="projectType" name="projectType" onchange="checKProjectType()">
<option value="P" <%if(projectType!=null && projectType.equalsIgnoreCase("P")) {%> selected<%} %>>Project</option>
<option value="I" <%if(projectType!=null && projectType.equalsIgnoreCase("I")) {%> selected<%} %>>Pre-Project</option>
<option value="N" <%if(projectType!=null && projectType.equalsIgnoreCase("N")) {%> selected<%} %>>Non-Project</option>
</select>
</div>
</div>
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
</form>
<div class="container-fluid">
	<div class="row">
		<div class="col-md-12">	
			<div class="card shadow-nohover">
				<div class="card-header">
					<div class="row" >
						<div class="col" style="margin-top: -8px;">	
							<form method="post" action="RecordofDiscussion.htm" id="myform" style="">
								<input type="hidden" name="projectType" value="<%=projectType%>">
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							</form>
							<form action="AddNewRODName.htm" method="post" id="addNewForm">
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
								<input type="hidden" name="projectId" value="<%=projectId %>" /> 
							</form>
							<form action="RODScheduleAddSubmit.htm" method="POST" name="myfrm1" id="myfrm1" >
								<input type="hidden" name="divisionId" value="0" /> 
		                    	<input type="hidden" name="initiationId" value="<%=initiationId %>" /> 
		                    	<input type="hidden" name="committeeId" value="0" /> 
		                    	<input type="hidden" name="projectId" value="<%=projectId %>" /> 
		                    	<input type="hidden" name="rodNameId" value="<%=rodNameId%>" /> 
		                    	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		                    	<input type="hidden" name="rodName" <%if(rodMasterDetails!=null) {%>value="<%=rodMasterDetails[1] %>"> <%}%>
							</form>
							
							<table style="width:100%;">
								<tr>
									<td style="width: 50%;">
										<table>
								  			<tr>
								  				<td>
								  				<%if(projectType.equalsIgnoreCase("p") || projectType.equalsIgnoreCase("i")) {%>	<label class="control-label">Project : </label><%} %>
								  				</td>
								  				<td>
								  				<%if(projectType.equalsIgnoreCase("p")) {%>
								  					<select form="myform" class="form-control selectdee" id="projectId" required="required" name="projectId" onchange='submitForm1();' >
														<% for (Object[] obj : ProjectsList) {
															String projectshortName=(obj[17]!=null)?" ( "+obj[17].toString()+" ) ":"";			 
														%>
															<option value="<%=obj[0]%>" <%if(obj[0].toString().equals(projectId)){ %>selected<%} %> ><%=obj[4]+projectshortName%></option>
														<%} %>
														
													</select>
													<%}else if(projectType.equalsIgnoreCase("I")){ %>
														<select form="myform" class="form-control selectdee" id="initiationId" required="required" name="initiationId" onchange='submitForm1();' >
														<% for (Object[] obj : ProjectsList) {
																	 
														%>
															<option value="<%=obj[0]%>" <%if(initiationId!=null && initiationId.equalsIgnoreCase(obj[0].toString())) {%> selected <%} %>><%=obj[4]%></option>
														<%} %>
														
													</select>
													
													
													<%} %>
								  				</td>
								  				<td>
								  					<label class="control-label">ROD Name : </label>
								  				</td>
								  				<td>
								  					<select form="myform" class="form-control selectdee" id="rodNameId" required="required" name="rodNameId" onchange="submitForm2();">
												   		<option value="addNew">Add New</option>
												   		<option value="all"  <%if(rodNameId.equals("all")){ %>selected <%} %> >All</option>
												   		<% for (Object[] obj : RODNameslist) {%>
															<option value="<%=obj[0]%>"  <%if(obj[0].toString().equals(rodNameId)){ %>selected<%} %> ><%=obj[1]%></option>
														<%} %>   
											  		</select>
								  				</td>
								  				
								  			</tr>
						  				</table>
									</td>
									<td id="addNewFormtd" style="width: 50%;">
										<table>
											<tr>
												<td>
													<label class="control-label">ROD Name : </label>	
												</td>
												<td>
								  					<input form="addNewForm" type="text" class="form-control" id="rodName" name="rodName" placeholder="Enter ROD Name" maxlength="2000" required oninput="preventLeadingSpace(this)">
								  				</td>
								  				<td>
													<label class="control-label">ROD Short Name : </label>	
												</td>
								  				<td>
								  					<input form="addNewForm" type="text" class="form-control" id="rodShortName" name="rodShortName" placeholder="Enter ROD Short Name" maxlength="200" required oninput="preventLeadingSpace(this)">
								  				</td>
								  				<td>&nbsp;</td>
								  				<td>
								  					<button form="addNewForm" type="submit" class="btn btn-sm btn-primary ml-2" onclick="return confirm('Are you sure to Add?')">ADD</button>
								  				</td>
											</tr>
										</table>
									</td>
									
									<td id="myform1td" style="width: 50%;">
										<table style="margin-left: 20%;">
											<tr>
												<td>
													<label class="control-label">Date : </label>	
												</td>
												<td>
													<input form="myfrm1" style=""  class="form-control "  data-date-format="dd/mm/yyyy" id="startdate" name="startdate"  required="required"   readonly>
												</td>
												<td>
													<label class="control-label"> Time : </label>
												</td>
												<td>
													<input form="myfrm1" class="form-control" type="text" id="starttime" name="starttime"  required="required" value="<%=LocalTime.now() %>"  readonly>
												</td>
												<td>&nbsp;</td>
												<td>
													<input form="myfrm1" type="button" class="btn  btn-sm add " style="float: right" onclick="Add1('myfrm1')" value="ADD SCHEDULE" >
												</td>
											</tr>
										</table>
									</td>
									
								</tr>
							</table>
						</div>
						
					</div>
				</div>
				
				<div class="card-body" style="display: flex;justify-content: space-around;">
					<div id="calendar" style="width:79%;float:left"></div>
					<div id="meetings" style="background-color: #216583;;width:20%;margin:5px;">
						<div  style="font-size: 22px;font-weight: 600;color: white;text-align: center;">
							Earlier Meetings
						</div>
						<div class="mt-2" id="scrollclass" style="height:520px;overflow: auto">
							<%if(!PreviousmeetingList.isEmpty()){
								int i=0;
								for(Object[]obj:PreviousmeetingList){
							%>
					 			<a class="tag meetingsp" style="text-decoration: none;" href="RODScheduleView.htm?scheduleid=<%=obj[0].toString() %>&membertype=undefined"><%=obj[8].toString()%>
									&nbsp;&nbsp;Date: <%= sdf2.format(sdf3.parse(obj[3].toString())) %>
								</a>
							<%}}else{ %>
								<p class="meetingsp ml-3 mr-3"> No Previous Meetings held !</p>
							<%} %>
						</div>
					</div>
				</div>
					
			</div>
		</div>
	</div>
</div>
<script type='text/javascript'> 
function submitForm2()
{ 
	console.log("Method enter");
	var rodNameId = $('#rodNameId').val();
	if (rodNameId == 'addNew') {

		$('#addNewFormtd').show();
		$('#myform1td').hide();
       /*  $('#addNewFormdiv').slideDown(); */
        
    } else {

    	$('#addNewFormtd').hide();
    	$('#myform1td').show();
        /* $('#addNewFormdiv').slideUp(); */
        document.getElementById('myform').submit(); 
    }
  
} 

function submitForm1()
{ 
	$("#rodNameId").val("all").change();
} 

function Add1(myfrm1){
	event.preventDefault();
		
	var date=$("#startdate").val();
	var time=$("#starttime").val();
	var result=confirm("Are You Sure To Add Schedule on "+date+"  ("+ time +") ?");
	if(result){
		$("sub").value;
     	$("#"+myfrm1).submit(); 
	}else{
		event.preventDefault();
	}
		
}
</script>
<script type="text/javascript">   

$('#startdate').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	/* "minDate" :new Date(), */
	"startDate" : new Date(),

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
 
 
</script>
<script>
$(document).ready(function() {
	<%if(!rodNameId.equals("all") && Long.parseLong(rodNameId)>0 ){ %>
		$('#addNewFormtd').hide();
		$('#myform1td').show();
	<%} else{%>
		$('#addNewFormtd').show();
		$('#myform1td').hide();
	<%}%>
	
	<%if(rodNameId.equals("all")) {%>
		$('#addNewFormtd').hide();
		$('#myform1td').hide();
	<%}%>
    
    // Handle form submission
   /* $('#addNewForm').submit(function(event) {
        event.preventDefault(); // Prevent default form submission
        
        // Get the value from the input field
        var rodName = $('#rodName').val();
        
         $.ajax({
    		type : "GET",
    		url : "AddNewRODName.htm",
    		data : {
    			rodName : rodName,
    		},
    		datatype : 'json',
    		success : function(result) {
    			var value = JSON.parse(result);
    			if(value!="0"){
    				console.log('Success');
    				// Optionally, you can reset the form
    		        $(this).trigger('reset');
    		        
    		        // Hide the form after submission
    		        $('#addNewFormdiv').slideUp();
    			}
    		}
    	}); 
    }); */
});
</script>

<script type="text/javascript">

<%if(rodNameId!=null &&  projectId!=null  )
{%>
myEvents = [
	<%	
	for(Object obj[] :Projectschedulelist) {%>
	 { 
	    id: "required-id-1",
	    name: "Meeting Details",
	    scheduleid: "<%if(obj[0]!=null){%><%=obj[0].toString()%><%}%>",
	    time: "<%=obj[4].toString()%>",
	    ComCode : "<%=obj[8]%>" ,
	    date: "<%=obj[3].toString()%>", 
	    url: "RODScheduleView.htm",
	    type: "event",  
	    color: "#0383F3",
	   type: "event"
	  },
	<%}%>
	]

<%}%>
	
$("#calendar").evoCalendar(
		{
			theme : 'Royal Navy',
			calendarEvents: myEvents,
			
		});
		
		function checKProjectType(){
			$('#myformtype').submit();
		}
		
		
		function preventLeadingSpace(input) {
		    // If the value starts with a space, trim it
		    if (input.value.startsWith(' ')) {
		        input.value = input.value.trimStart();
		    }
		}
</script>
</body>
</html>