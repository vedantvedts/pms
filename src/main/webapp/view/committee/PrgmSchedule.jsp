<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="com.vts.pfms.committee.model.ProgrammeMaster"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="org.hibernate.internal.build.AllowSysOut"%>
<%@page import="java.time.LocalTime"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
	<%@page import="com.vts.pfms.FormatConverter"%>
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
	font-size: 18px;
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
</style>

</head>
<body>


	<%
		
		List<ProgrammeMaster> programmeList = (List<ProgrammeMaster>) request.getAttribute("programmeList");
		List<Object[]>  committeeschedulelist=(List<Object[]>)request.getAttribute("committeeschedulelist");
		String programmeId = (String)request.getAttribute("programmeId");
		String committeeId = (String)request.getAttribute("committeeId");
		String committeeMainId = (String)request.getAttribute("committeeMainId");
		
		FormatConverter fc=new FormatConverter(); 
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
						<div class="row" >
							<div class="col-md-6" style="margin-top: -8px;">	
								<form class="form-inline" method="post" action="PrgmSchedule.htm" id="myform">
						  			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					  				<div class="row">
					  					<div class="col-md-4">
					  						<label class="control-label">Programme: </label>  
					  					</div>
					  					<div class="col-md-8">
						    	 			<select class="form-control selectdee" id="programmeId" required="required" name="programmeId" onchange='this.form.submit();' >
	   											<option disabled selected value="">Choose...</option>
	   											<% for (ProgrammeMaster prgm : programmeList) {%>
													<option value="<%=prgm.getProgrammeId()%>" <%if(programmeId!=null && prgm.getProgrammeId()==Long.parseLong(programmeId)){ %>selected <%}%> >
														<%=prgm.getPrgmName()!=null?StringEscapeUtils.escapeHtml4(prgm.getPrgmName()): " - " %> (<%=prgm.getPrgmCode()!=null?StringEscapeUtils.escapeHtml4(prgm.getPrgmCode()): " - " %>)
													</option>
												<%} %>   
	  										</select>
					  					</div>
					  				</div>   
								</form>
							</div>
					
							<div class="col-md-6" style="margin-top: -8px;">		
					
								<%if(programmeId!=null){ %>
						 			<form class="form-check-inline" action="CommitteeScheduleAddSubmit.htm" method="POST" name="myfrm1" id="myfrm1" > 
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
					                    	<input type="hidden" name="projectid" value="0" /> 
					                    	<input type="hidden" name="committeeid" value="<%=committeeId%>" /> 
					                    	<input type="hidden" name="programmeId" value="<%=programmeId%>" /> 
					                    	<input type="hidden" name="committeeMainId" value="<%=committeeMainId%>" /> 
					                    	<input type="hidden" name="committeename" value="PMC" /> 
					                    	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
					                    	<input type="button" class="btn  btn-sm add " style="float: right" onclick="Add1('myfrm1')" value="ADD SCHEDULE" > 	
				                    	</div>                   	
	                  				</form> 
	                  			<%} %>
							</div>
						</div>
					</div>
					<div class="card-body">
						<div id="calendar" style="width:79%;float:left"></div>
						<div id="meetings" style="background-color: #216583;;width:20%;margin:5px;float: right">
						<div  style="font-size: 22px;font-weight: 600;color: white;text-align: center;">Meetings</div>
							<div class="mt-4" id="scrollclass" style="height:520px;overflow: auto">
								<%if(!committeeschedulelist.isEmpty()){
									for(Object[]obj:committeeschedulelist){ %>
				 						<a class="tag meetingsp" style="text-decoration: none;" href="CommitteeScheduleView.htm?scheduleid=<%=obj[0].toString() %>&membertype=undefined"><%=obj[6].toString()%>
											&nbsp;&nbsp; Date: <%=obj[3]!=null?fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(obj[3].toString())):" - " %>
										</a>
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


<%if(programmeId!=null)
{%>
myEvents = [
	<%	
	for(Object[] obj :committeeschedulelist) {%>
	 { 
	    id: "<%=obj[0]%>",
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


function Add(myfrm){
	
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
	         $("#myfrm").submit(); 
	    	}
	    	else{
	    		event.preventDefault();
	    	}
	    } 
	}) 
	
	
}	

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
   
</script>


</body>
</html>