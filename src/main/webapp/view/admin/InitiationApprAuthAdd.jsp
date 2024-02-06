<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="com.vts.pfms.admin.model.PfmsRtmddo"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
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
List<Object[]> EmployeeList=(List<Object[]>) request.getAttribute("EmployeeList");
PfmsRtmddo appr = (PfmsRtmddo) request.getAttribute("ApprAuthData");

String fromdate = (String)request.getAttribute("fromdate");
String todate = (String)request.getAttribute("todate");

FormatConverter fc = new FormatConverter();
SimpleDateFormat sdtf = fc.getSqlDateAndTimeFormat();
SimpleDateFormat sdf = fc.getSqlDateFormat();
SimpleDateFormat rdf = fc.getRegularDateFormat();

String action = (String)request.getAttribute("action");

List<String> apprTypes = Arrays.asList("AD","DO-RTMD","GH-DP&C","AD-P&C","Chairman RPB","MMFD AG","GD DF&MM","Chairperson (CARS Committee)");
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

<br>
	
<div class="container">
	<div class="row" style="">
		<div class="col-md-12">
			<div class="card shadow-nohover" >
				<div class="card-header" style=" background-color: #055C9D;margin-top: ">
                    <b class="text-white">Approval Authority <%if(action!=null) {%><%=action %><%} %> </b>
        		</div>
        		<div class="card-body">
        			<%-- <div class="row " style=" background-color: #e4f9f5;margin-bottom: 10px; ">
						<div class="col-md-6 " ><br>
                    		<label class="control-label">Active RTMDDO : <%if(Rtmddo!=null){%> <%=Rtmddo[2] %>, <%=Rtmddo[3] %><%} %></label>
                        </div>
                        <div class="col-md-3 "><br>
                        	<label class="control-label">Valid From : <%if(Rtmddo!=null){%> <%=sdf.format(Rtmddo[4]) %><%} %></label>
                        </div>
                        <div class="col-md-3 "><br>
                        	<label class="control-label">Valid To : <%if(Rtmddo!=null){%> <%=sdf.format(Rtmddo[5]) %><%} %></label>
                        	<br><br>
                        </div>
                    </div> --%>
        			<form action="RtmddoSubmit.htm" method="POST" name="myfrm" id="myfrm">
                		<div class="row">
							<div class="col-md-4">
                        		<div class="form-group">
                            		<label class="control-label">Employee </label>
                              		<select class="form-control selectdee" id="EmpId" required="required" name="empId">
    									<option disabled="disabled" selected value="">Choose...</option>
    										<% for (Object[] obj : EmployeeList) {%>
										<option value="<%=obj[0]%>" <%if(appr!=null && appr.getEmpId()!=null && appr.getEmpId()==Long.parseLong(obj[0].toString())) {%>selected<%} %> ><%=obj[1]%>,  <%=obj[2] %> </option>
											<%} %>
  									</select>
                        		</div>
                    		</div>
                    		
							<div class="col-md-2">
                        		<div class="form-group">
                            		<label class="control-label">Admin Role </label>
                              		<select class="form-control selectdee" required="required" name="adminRole">
    									<option disabled="disabled" selected value="">Choose...</option>
    										<% for (String role : apprTypes) {%>
										<option value="<%=role%>" <%if(appr!=null && appr.getType()!=null && appr.getType().equalsIgnoreCase(role)) {%>selected<%} %> ><%=role%> </option>
											<%} %>
  									</select>
                        		</div>
                    		</div>
                   
         					<div class="col-md-3">
                        		<div class="form-group">
                            		<label class="control-label">Valid From</label>
    					            <input class="form-control" type="text" name="validFrom" id="DateCompletion" <%if(appr!=null && appr.getValidFrom()!=null) {%>value="<%=rdf.format(appr.getValidFrom()) %>"<%} %> required="required">
                        		</div>
                    		</div>
                    		<div class="col-md-3">
                        		<div class="form-group">
                            		<label class="control-label">Valid To</label>
    					            <input class="form-control" type="text" name="validTo" id="DateCompletion2" <%if(appr!=null && appr.getValidTo()!=null) {%>value="<%=rdf.format(appr.getValidTo()) %>"<%} %> required="required"  >
                        		</div>
                    		</div>
                		</div>
						<div class="form-group" align="center" >
	 						<button type="submit" class="btn btn-primary btn-sm submit" onclick="return confirm('Are You Sure To Submit ?')">SUBMIT</button>
	 						<a class="btn btn-info btn-sm  back" href="InitiationApprAuth.htm">Back</a>
						</div>
						<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
						<input type="hidden" name="action" value="<%=action %>">
						<input type="hidden" name="rtmddoId" value="<%if(appr!=null) {%><%=appr.getRtmddoId() %><%}%>">
 					</form>
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
	/* "minDate" :datearray,   */
	 "startDate" : new Date('<%=fromdate%>'), 
	 "minDate" :$("#DateCompletion").val(), 
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
		"startDate" : new Date('<%=todate%>'), 
		"minDate" :$("#DateCompletion2").val(),  
		"cancelClass" : "btn-default",
		showDropdowns : true,
		locale : {
			format : 'DD-MM-YYYY'
		}
	});



/* $('#DateCompletion').daterangepicker({
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
 */

  
/*      function onDate() {
        
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
 */
</script>
</body>
</html>