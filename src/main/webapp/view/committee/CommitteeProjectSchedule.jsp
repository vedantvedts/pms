<%@page import="java.util.stream.Collectors"%>
<%@page import="java.util.stream.Collector"%>
<%@page import="java.time.LocalTime"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.time.LocalDate"%>
	
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<META HTTP-EQUIV="Refresh" CONTENT="60">

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
	background-color: gray;
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
	background-color: gray;
}

#scrollclass::-webkit-scrollbar-thumb:hover {
	-webkit-box-shadow: inset 0 0 6px black;
	transition: 0.5s;
}
 .meetingsp:hover{
padding:10px;
padding-bottom:13px;
background: #f7be16;
color:black;
border-radius: 5px;
box-shadow: 0px 0px 1px 1px gray;
}
.meetingsp a:hover{
color:black;
}

.meetingsp{
position: relative;
font-size: 18px;
font-weight: 500;
color:#fff;
text-align: center;
}
	
</style>

</head>
<body>


<%
SimpleDateFormat sdf1=new SimpleDateFormat("dd-MM-yyyy");
SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
FormatConverter fc=new FormatConverter(); 
SimpleDateFormat sdf2=fc.getRegularDateFormat();
SimpleDateFormat sdf3=fc.getSqlDateFormat();
List<Object[]> ProjectsList=(List<Object[]>) request.getAttribute("ProjectsList");
List<Object[]>  Projectschedulelist=(List<Object[]>)request.getAttribute("Projectschedulelist");
List<Object[]>  projapplicommitteelist=(List<Object[]>)request.getAttribute("projapplicommitteelist");
Object[] committeedetails=(Object[])request.getAttribute("committeedetails");
String projectid=(String)request.getAttribute("projectid");
String committeeid=(String)request.getAttribute("committeeid");

List<Object[]>meetingList= new ArrayList<>();

if(!Projectschedulelist.isEmpty()){
	if(committeeid.equalsIgnoreCase("all")){
		meetingList=Projectschedulelist;
	}else{
		meetingList=Projectschedulelist.stream().filter(i -> i[1].toString().equalsIgnoreCase(committeeid)).collect(Collectors.toList());
	}
}
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



	<%Object[] Projectdetails=(Object[])request.getAttribute("Projectdetails");%>

<div class="container-fluid">
		
		<div class="row">
			<div class="col-md-12">	
				
				<div class="card shadow-nohover">
					<div class="card-header">
					
					<div class="row">
					
					<div class="col" style="margin-top: -8px;">	
			
						
						<form class="form-inline " method="post" action="ProjectBasedSchedule.htm" id="myform" style="width: 108% !important">
						  
						  <div class="form-group">    
						    <label class="control-label">Project : </label>   
						    <div class="col-sm-2">
						    	 <select class="form-control selectdee" id="projectid" required="required" name="projectid" onchange='submitForm1();' >
										 <% for (Object[] obj : ProjectsList) {
											 String projectshortName=(obj[17]!=null)?" ( "+obj[17].toString()+" ) ":"";			 
										 %>
												<option value="<%=obj[0]%>" <%if(obj[0].toString().equals(projectid)){ %>selected<%} %> ><%=obj[4]+projectshortName%></option>
										<%} %>
								</select>
						    </div>    
						 </div>  

						<div class="form-group">        
						    <label class="control-label">Committee : </label>	   
						    <div class="col-sm-2">
						    	<select class="form-control selectdee" id="committeeid" required="required" name="committeeid" onchange='submitForm();' >
							   				<option value="all"  <%if(committeeid.equals("all")){ %>selected <%} %> >All</option>
							   				<% for (Object[] obj : projapplicommitteelist) {%>
											<option value="<%=obj[0]%>"  <%if(obj[0].toString().equals(committeeid)){ %>selected<%} %> ><%=obj[3]%></option>
											<%} %>   
							  	</select>
						    </div> 
						</div>
  
 						 <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />	
 
					</form>
						
						
						
					</div>
					
					<div class="col" style="margin-top: -8px;">		
					
					<%if(!committeeid.equals("all") && Long.parseLong(committeeid)>0 ){ %>
					 <form class="form-check-inline" action="CommitteeScheduleAddSubmit.htm" method="POST" name="myfrm1" id="myfrm1" > 
					
						
								<input type="hidden" name="committeename" value="<%=committeedetails[2] %>">
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
		                    	<input type="hidden" name="divisionid" value="0" /> 
		                    	<input type="hidden" name="initiationid" value="0" /> 
		                    	<input type="hidden" name="projectid" value="<%=projectid %>" /> 
		                    	<input type="hidden" name="committeeid" value="<%=committeeid%>" /> 
		                    	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
		                    	<input type="button" class="btn  btn-sm add " style="float: right" onclick="Add1('myfrm1')" value="ADD SCHEDULE" > 	
	                    	</div>                   	
                  		</form> <%} %>
						
					</div>
					
					</div>
					
					
					</div>
					<div class="card-body" style="display: flex;justify-content: space-around;">
						<div id="calendar" style="width:80%;float:left"></div>
						<div id="meetings" style="background-color: #216583;;width:20%">
						<div  style="font-size: 22px;font-weight: 600;color: white;text-align: center;">Earlier Meetings</div>
						<div class="mt-4" id="scrollclass" style="height:520px;overflow: auto">
						<%if(!meetingList.isEmpty()){
							for(Object[]obj:meetingList){
							%>
						 <p class="meetingsp ml-3 mr-3"><a id="tag" style="color:white;text-decoration: none;" href="CommitteeScheduleView.htm?scheduleid=<%=obj[0].toString() %>&membertype=undefined"><%=obj[6].toString()%>
						&nbsp;&nbsp; Date: <%= sdf2.format(sdf3.parse(obj[3].toString())) %>
							</a></p> 
						<%}}else{ %>
						<p class="meetingsp ml-3 mr-3"> No Meetings Listed !</p>
						<%} %>
						</div>
						</div>
					</div>
					
				</div>
			</div>
		</div>
</div>


<script type='text/javascript'> 
function submitForm()
{ 
  document.getElementById('myform').submit(); 
} 

function submitForm1()
{ 
	$("#committeeid").val("all").change();
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


<script type="text/javascript">


<%if(committeeid!=null &&  projectid!=null )
{%>
myEvents = [
	<%	
	for(Object obj[] :Projectschedulelist) {%>
	 { 
	    id: "required-id-1",
	    name: "Meeting Details",
	    scheduleid: "<%if(obj[0]!=null){%><%=obj[0].toString()%><%}%>",
	    time: "<%=obj[4].toString()%>",
	    ComCode : "<%=obj[6]%>" ,
	    date: "<%=obj[3].toString()%>", 
	    url: "CommitteeScheduleView.htm",
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

function Add1(myfrm1){
	event.preventDefault();
		
		var date=$("#startdate").val();
		var time=$("#starttime").val();
		var result=confirm("Are You Sure To Add Schedule on "+date+"  ("+ time +") ?");
		if(result){
	    	
			$("sub").value;
	     $("#"+myfrm1).submit(); 
		}
		else{
			event.preventDefault();
		}
		
		
		}
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