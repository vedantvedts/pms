<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.io.ByteArrayOutputStream,java.io.ObjectOutputStream"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<script src="./resources/js/multiselect.js"></script>
<link href="./resources/css/multiselect.css" rel="stylesheet"/>
 

<title>Milestone Schedule Add</title>
<style type="text/css">
label{
font-weight: bold;
  font-size: 13px;
}
body{
background-color: #f2edfa;
overflow-x:hidden !important; 
}
h6{
	text-decoration: none !important;
}
.multiselect-container>li>a>label {
  padding: 4px 20px 3px 20px;
}

</style>
</head>
 
<body>
  <%

  SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
  SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd");
  String ProjectId=(String)request.getAttribute("ProjectId");
  List<Object[]> ActivityTypeList=(List<Object[]>)request.getAttribute("ActivityTypeList");
  Object[] ProjectDetail=(Object[])request.getAttribute("ProjectDetails");
  
  
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

    <br />
    
  <div class="container">
	<div class="row" style="margin-top: -25px; margin-bottom: 5px;">

		<div class="col-md-12">

 			<div class="card shadow-nohover" >
				
				<div class="card-header" style=" background-color: #055C9D;font-size: 18px">
                    <span class="text-white" style="font-weight: 600">Milestone Schedule Add </span> 
                    <span class="text-white" style="float:right;font-weight: 600">( <%=ProjectDetail[2]!=null?StringEscapeUtils.escapeHtml4(ProjectDetail[2].toString()):" - " %> ( <%=ProjectDetail[1]!=null?StringEscapeUtils.escapeHtml4(ProjectDetail[1].toString()):" - " %> ) )</span>
        		</div>
        
        		<div class="card-body">
        	     	<form action="MilestoneScheduleAddSubmit.htm" method="POST" name="myfrm" id="myfrm">
                		
                		<div class="row">
                		
                        	<div class="col-sm-5" align="left"  >
                          		<div class="form-group">
                           			<label  >
                           				Milestone Activity : <span class="mandatory" style="color: red;" >*</span>
                           			</label><br>
                             		<input class="form-control " type="text"name="ActivityName" id="ActivityName"  style="width:100% " maxlength="1000" required="required">
                           		</div>
                           </div>
                           
                           <div class="col-sm-3" align="left"  >
                        		<div class="form-group">
                            		<label class="control-label">Activity Type  </label>
                              		<select class="form-control selectdee" id="ActivityType" required="required" name="ActivityType">
    									<option disabled="true"  selected value="">Choose...</option>
    										<% for (Object[] obj : ActivityTypeList) {%>
										<option value="<%=obj[0]%>"><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()):" - "%> </option>
											<%} %>
  									</select>
                        		</div>
                    		</div>
                          
	                        <div class="col-md-2">
	                        		<div class="form-group">
	                            		<label class="control-label">From</label>
	    					            <input class="form-control " name="ValidFrom" id="DateCompletion" required="required"  >
	                        		</div>
	                    	</div>
	                    	
	                    	<div class="col-md-2">
	                        		<div class="form-group">
	                            		<label class="control-label">To</label>
	    					            <input class="form-control " name="ValidTo" id="DateCompletion2" required="required"  >
	                        		</div>
	                    	</div>
                           
                        </div>

        				<div class="form-group" align="center" >
	 						<input type="submit" class="btn btn-primary btn-sm submit " id="sub" value="SUBMIT" name="sub"  onclick="return confirm('Are You Sure To Submit ?')" > 
		   					<a class="btn btn-primary btn-sm back "  href="MilestoneSchedulesList.htm">Back</a>
						</div>
      
      					<input type="hidden" name="ProjectId"	value="<%=ProjectId %>" /> 
						<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
 					</form>
     			</div>     

        	</div>
		</div>
	</div>
</div>  



<script>
	$('#DateCompletion').daterangepicker({
			"singleDatePicker" : true,
			"linkedCalendars" : false,
			"showCustomRangeLabel" : true,
			/* "minDate" : new Date(), */
			"cancelClass" : "btn-default",
			showDropdowns : true,
			locale : {
				format : 'DD-MM-YYYY'
			}
		});

	$('#DateCompletion2').daterangepicker({
		"singleDatePicker" : true,
		"linkedCalendars" : false,
		"showCustomRangeLabel" : true,
		/* "minDate" : new Date(), */
		"cancelClass" : "btn-default",
		showDropdowns : true,
		locale : {
			format : 'DD-MM-YYYY'
		}
	});
	
	</script>  


</body>
</html>