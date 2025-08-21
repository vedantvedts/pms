<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

<title>RTMDDO ADD</title>
<style type="text/css">

.input-group-text{
font-weight: bold;
}

label{
	font-weight: 800;
	font-size: 16px;
	color:#07689f;
} 

hr{
	margin-top: -2px;
	margin-bottom: 12px;
}
.card b{
	font-size: 20px;
}


</style>
</head>
<body>

<%
SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
List<Object[]> EmployeeList=(List<Object[]>) request.getAttribute("EmployeeList");
Object[] Rtmddo=(Object[]) request.getAttribute("Rtmddo");
NFormatConvertion nfc=new NFormatConvertion();
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

<br>
	
<div class="container">
	<div class="row" style="">

		<div class="col-md-12">

 			<div class="card shadow-nohover" >
				
				<div class="card-header" style=" background-color: #055C9D;margin-top: ">
                    <b class="text-white">RTMDDO Add</b>
        		</div>
        
        		<div class="card-body">
        		<div class="row " style=" background-color: #e4f9f5;margin-bottom: 10px; ">

                    		<div class="col-md-6 " ><br>
                    		<label class="control-label">Active RTMDDO : <%if(Rtmddo!=null){%> <%=Rtmddo[2]!=null?StringEscapeUtils.escapeHtml4(Rtmddo[2].toString()): " - " %>, <%=Rtmddo[3]!=null?StringEscapeUtils.escapeHtml4(Rtmddo[3].toString()): " - " %><%} %></label>
                        	</div>
                        	<div class="col-md-3 "><br>
                        	<label class="control-label">Valid From : <%if(Rtmddo!=null){%> <%=sdf.format(Rtmddo[4]) %><%} %></label>
                        	</div>
                        	<div class="col-md-3 "><br>
                        	<label class="control-label">Valid To : <%if(Rtmddo!=null){%> <%=sdf.format(Rtmddo[5]) %><%} %></label>
                        	<br><br>
                        	</div>
                    		</div>
        			<form action="RtmddoSubmit.htm" method="POST" name="myfrm" id="myfrm">
                		<div class="row">

                    		<div class="col-md-6 ">
                        		<div class="form-group">
                            		<label class="control-label">Employee </label>
                              		<select class="form-control selectdee" id="EmpId" required="required" name="EmpId">
    									<option disabled="true"  selected value="">Choose...</option>
    										<% for (Object[] obj : EmployeeList) {%>
										<option value="<%=obj[0]%>"><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - "%>,  <%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - " %> </option>
											<%} %>
  									</select>
                        		</div>
                    		</div>
                   
         					<div class="col-md-3">
                        		<div class="form-group">
                            		<label class="control-label">Valid From</label>
    					            <input class="form-control " name="ValidFrom" id="DateCompletion" required="required"  onchange="onDate()">
                        		</div>
                    		</div>
                    		<div class="col-md-3">
                        		<div class="form-group">
                            		<label class="control-label">Valid To</label>
    					            <input class="form-control " name="ValidTo" id="DateCompletion2" required="required"  >
                        		</div>
                    		</div>
                    
                    
                </div>

            
      	
         
        <div class="form-group" align="center" >
			
			
	 		<input type="submit" class="btn btn-primary btn-sm submit " id="sub" value="SUBMIT" name="sub"  onclick="return confirm('Are You Sure To Submit ?')" > 
			<!--  <a class="btn btn-info btn-sm  shadow-nohover back" href="ProjectIntiationList.htm"  >Back</a> -->
		
		</div>

	<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
 	</form>
        
     </div>`     
        




<div class="card-footer" style=" background: linear-gradient(to right, #334d50, #cbcaa5);padding: 25px ">
         
       
        </div>
        </div>
</div>
</div>
</div>	
	
	
<script type="text/javascript">
$('#DateCompletion').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	"minDate" : new Date(),
	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});


  
     function onDate() {
        
    	 var from = $("#DateCompletion").val().split("-")
    	 var year=Number(from[2])+5;
  		 var f = new Date(year, from[1] - 1, from[0]);

        $('#DateCompletion2').daterangepicker({
        	"singleDatePicker" : true,
        	"linkedCalendars" : false,
        	"showCustomRangeLabel" : true,
        	"cancelClass" : "btn-default",
        	"minDate" : f,
        	"maxDate" : f,
        	showDropdowns : true,
        	locale : {
        		format : 'DD-MM-YYYY'
        	}
        });
        
    }

</script>
</body>
</html>