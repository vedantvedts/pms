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
String rodNameId=(String)request.getAttribute("rodNameId");

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

<div class="container-fluid">
	<div class="row">
		<div class="col-md-12">	
			<div class="card shadow-nohover">
				<div class="card-header">
					<div class="row" >
						<div class="col" style="margin-top: -8px;">	
							<form class="form-inline " method="post" action="RecordofDiscussion.htm" id="myform" style="width: 108% !important">
						  		<div class="form-group">    
						    		<label class="control-label">Project : </label>   
									<div class="col-sm-2">
										<select class="form-control selectdee" id="projectId" required="required" name="projectId" onchange='submitForm1();' >
											<% for (Object[] obj : ProjectsList) {
												String projectshortName=(obj[17]!=null)?" ( "+obj[17].toString()+" ) ":"";			 
											%>
												<option value="<%=obj[0]%>" <%if(obj[0].toString().equals(projectId)){ %>selected<%} %> ><%=obj[4]+projectshortName%></option>
											<%} %>
										</select>
									</div>    
						 		</div>  

								<div class="form-group">        
								    <label class="control-label">ROD Name : </label>	   
								    <div class="col-sm-2">
								    	<select class="form-control selectdee" id="rodNameId" required="required" name="rodNameId" onchange="submitForm2();">
									   		<option value="addNew">Add New</option>
									   		<option value="all"  <%if(rodNameId.equals("all")){ %>selected <%} %> >All</option>
									   		<% for (Object[] obj : RODNameslist) {%>
												<option value="<%=obj[0]%>"  <%if(obj[0].toString().equals(rodNameId)){ %>selected<%} %> ><%=obj[1]%></option>
											<%} %>   
									  	</select>
								    </div> 
								</div>
								<div class="form-group" id="addNewFormdiv">
									<div class="col-sm-12">
										<div class="row">
											<div class="col-md-8">
												<input form="addNewForm" type="text" class="form-control" id="rodName" name="rodName" placeholder="Record of Discussion" required>
											</div>
											<div class="col-md-4 mt-1">
												<button form="addNewForm" type="submit" class="btn btn-sm btn-primary ml-2" onclick="return confirm('Are you sure to Add?')">ADD</button>
											</div>
										</div>
										
									</div>
								</div>
 						 		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />	
							</form>
							<form action="AddNewRODName.htm" method="post" id="addNewForm">
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
								<input type="hidden" name="projectId" value="<%=projectId %>" /> 
							</form>
		   						
						</div>
					
						<div class="col" style="margin-top: -8px;">		
							<%if(!rodNameId.equals("all") && Long.parseLong(rodNameId)>0 ){ %>
					 			<form class="form-check-inline" action="RODScheduleAddSubmit.htm" method="POST" name="myfrm1" id="myfrm1" > 
									<input type="hidden" name="rodName" value="<%=rodMasterDetails[1] %>">
									<div class="col ">
										<label class="control-label"> Date &nbsp;&nbsp; : </label>
									</div>
									<div class="col" style="margin-left:-8%;">
				                          <input style="width:135%"  class="form-control "  data-date-format="dd/mm/yyyy" id="startdate" name="startdate"  required="required"   readonly>	
				                    </div>
				                    <div class="col " style="text-align: right;">
				                    	<label class="control-label"> Time &nbsp;&nbsp; : </label>
				                    </div>
				                    <div class="col">
				       					<input  class="form-control" type="text" id="starttime" name="starttime"  required="required" value="<%=LocalTime.now() %>"  readonly>
				                    </div>
				                    <div class="col" align="right" >
				                    	<input type="hidden" name="divisionId" value="0" /> 
				                    	<input type="hidden" name="initiationId" value="0" /> 
				                    	<input type="hidden" name="committeeId" value="0" /> 
				                    	<input type="hidden" name="projectId" value="<%=projectId %>" /> 
				                    	<input type="hidden" name="rodNameId" value="<%=rodNameId%>" /> 
				                    	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
				                    	<input type="button" class="btn  btn-sm add " style="float: right" onclick="Add1('myfrm1')" value="ADD SCHEDULE" > 	
			                    	</div>                   	
                  				</form> 
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
	var rodNameId = $('#rodNameId').val();
	if (rodNameId == 'addNew') {
        $('#addNewFormdiv').slideDown();
    } else {
        $('#addNewFormdiv').slideUp();
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
	$('#addNewFormdiv').hide();
    
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


</body>
</html>