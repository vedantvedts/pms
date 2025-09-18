<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="java.time.LocalTime"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<spring:url value="/resources/css/committeeModule/CommitteeSubSchedule.css" var="CommitteeSubSchedule" />
<link href="${CommitteeSubSchedule}" rel="stylesheet" />
<title>COMMITTEE MAIN MODIFY</title>
</head>
<body>
<%

SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");

String scheduleid=(String)request.getAttribute("scheduleid");

List<Object[]> subschedulelist=(List<Object[]>)request.getAttribute("subschedulelist");
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

<!-- -------------------------------card start-------------------------- -->

<div class="container-fluid">
	
	<div class="row">
	
		<div class="col-md-1"></div>
		
			<div class="col-md-10">  
			
        <!-- New Card -->
        
        	<div class="card shadow-nohover" >
        	
				<div class="card-header cardHeaderStyle">
                    <b class="text-white">Sub Schedule</b>
                    
                    
                </div>
        
        		<div class="card-body">
        			<form action="CommitteeSubScheduleSubmit.htm" method="POST" name="myfrm" id="myfrm" >
               
               		<div class="row">
                	
                		<div class="col-md-3 "></div>
                	
                    	<div class="col-md-3 ">
                        	<div class="form-group">
                            	<label class="control-label">Sub Schedule Date</label>
       							<input  class="form-control form-control"  data-date-format="dd/mm/yyyy" id="startdate" name="subscheduledate"  required="required"  >
                        	</div>
                    	</div>
                    	
                    	<div class="col-md-3 ">
                        	<div class="form-group">
                            	<label class="control-label">Sub Schedule  	Time</label>
       							<input  class="form-control" type="text" id="starttime" name="starttime"  required="required" value="<%=LocalTime.now() %>"  >
                        	</div>
                    	</div>
                       
							<input type="hidden" name="scheduleid" value="<%=scheduleid%>">
                      </div>
               
               <hr>
               
               <br>
                       
        			  <div class="form-group" align="center" >

						 <input type="submit" class="btn  btn-sm submit " onclick="Add(myfrm)" value="SUBMIT"> 
						 
						

					  </div>

					  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
 	
 					</form>
        
  			 </div> <!-- card-body-end -->   
        

			<div class="card-footer footerStyle">
         		<b class="text-white"></b>
       
        	</div>
        
        </div>
        
        <br>
		
				
	</div>

</div> 
	
</div>	
	
	
	
	
<script type="text/javascript">

function myconfirm(sel){


	var text=sel.options[sel.selectedIndex].text;
	
	var message='Are you sure to ' + text ;
	
	 bootbox.confirm({ 
	 		
		    size: "medium",
 			
 			message: "<center>&nbsp;&nbsp;&nbsp;&nbsp;<b class='editbox'>"+message+"</b></center>" ,
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
		    	
		         $("#myfrm1").submit(); 
		    	}
		    	else{
		    		event.preventDefault();
		    	}
		    } 
		}) 
	
	
}



</script>

<script>


 
 



$('#startdate').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	"minDate" :new Date(),
	"startDate" : new Date(),

	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});
var aYearFromNow = new Date();
aYearFromNow.setFullYear(aYearFromNow.getFullYear() + 1);
 
$('#enddate').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	"minDate" :new Date(),
	"startDate" :aYearFromNow,

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





</body>
</html>