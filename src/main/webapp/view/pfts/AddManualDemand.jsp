<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="java.text.Format"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.math.BigDecimal"%> 
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.time.LocalDate"%>
    
   
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<title>Add Manual Demand</title>
<style type="text/css">
label{
	font-weight: 800;
	font-size: 16px;
	color:#07689f;
} 

.form-group {
    margin-top: 0.5rem;
    margin-bottom: 1rem;
}
.input-group-text{
font-weight: bold;
}

</style>
</head>
<body>
  <%
  List<Object[]> ProjectList=(List<Object[]>)request.getAttribute("projectslist");
  String ProjectId=(String)request.getAttribute("projectId");
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
	<div class="card shadow-nohover" style="margin-top:0px;width: 70%;margin-left: 14%;">		
		<div class="row card-header">
			<div class="col-md-6">
				<h4>ADD DEMAND DETAILS</h4>
			</div>
        </div>
        <div class="card-body" style="width: 109%;">
             <form action="AddManualDemandSubmit.htm" method="post">
                   <div class="row">
		                 <div class="col-md-2">
		                      <label class="control-label">Project</label>
		                      <span class="mandatory" style="color: #cd0a0a;">*</span>
		                   </div>
		                    <div class="col-md-3">
			                      <select class="form-control selectdee" id="ProjectId" required="required" name="ProjectId">
											<% for (Object[] obj : ProjectList) {
											String projectshortName=(obj[17]!=null)?" ( "+obj[17].toString()+" ) ":"";
											%>
											<%if(ProjectId!=null && ProjectId.equalsIgnoreCase(obj[0].toString())){ %>
											<option value="<%=obj[0]%>"><%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()):"-" %> <%= projectshortName!=null?StringEscapeUtils.escapeHtml4(projectshortName):"-"%></option>
											<%}} %> 
  								  </select>
		                   </div>
		                   
		                    <div class="col-md-3">
		                      <label class="control-label">Demand No.</label>
		                      <span class="mandatory" style="color: #cd0a0a;">*</span>
		                   </div>
		                    <div class="col-md-4" style="margin-left: -10%;">
			                    <input  class="form-control alphanum-only"  name="demandNo" id="demandNo"  required="required"  placeholder="Enter Demand Number">
		                        <span id="demandMessage"></span>
		                    </div>
		             </div>
		             <br>
		             <div class="row">
		                  <div class="col-md-2">
		                      <label class="control-label">Demand Date</label>
		                      <span class="mandatory" style="color: #cd0a0a;">*</span>
		                   </div>
		                    <div class="col-md-3">
			                     <input  class="form-control form-control date"  data-date-format="dd-mm-yyyy" id="datepicker1" name="demanddate"  required="required">
		                    </div>
		                    
		                    <div class="col-md-3">
		                      <label class="control-label">Estimated Cost (&#8377;)</label>
		                      <span class="mandatory" style="color: #cd0a0a;">*</span>
		                   </div>
		                    <div class="col-md-4" style="margin-left: -10%;">
			                    <input type="number" class="form-control numeric-only"  name="estimatedcost" id="estimatedcost"  required="required"  placeholder="Enter Cost in Rupees">		
		                    </div>
		             </div>
		             <br>
		             <div class="row">
		                 <div class="col-md-3">
		                      <label class="control-label">Item Name</label>
		                      <span class="mandatory" style="color: #cd0a0a;">*</span>
		                   </div>
		                    <div class="col-md-9" style="margin-left: -9%;">
			                    <input type="text" class="form-control "  name="itemname" id="itemname"  required="required"  placeholder="Enter Item Name" style="width: 99%">		
		                   </div>
		             </div>
		             
		          <br>
		        <div class="form-group" align="center" >
					 <button type="submit" class="btn btn-primary btn-sm submit "  value="SUBMIT" id="manualAddBtn" onclick ="return confirm('Are you sure to submit?')" style="margin-left: -11%;">SUBMIT </button>
					 	<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
					 <input type="hidden" name="demandType" value="M">
					 <a class="btn btn-info btn-sm  shadow-nohover back" href="ProcurementStatus.htm?projectid=<%=ProjectId%>">Back</a>
				</div>
			 </form>
         </div>
     </div>
</div>

<script type="text/javascript">
$('#datepicker1').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	"startDate" : new Date(),
	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});

$(document).ready(function() {
	
	// Initially disable the submit button
    $('#manualAddBtn').prop('disabled', true);
	
    $('#demandNo').on('input', function() {
        var demandno = $(this).val();
        if (demandno.trim() === '') {
            $('#demandMessage').text("Please Enter a Demand Number").css('color', 'blue');
            // Disable the submit button if input is empty
            $('#manualAddBtn').prop('disabled', true);
            return; // Exit function if input is empty
        }
        
        $.ajax({
            type: 'GET',
            url: 'checkManualDemandNo.htm',
            success: function(data) {
                var demandNumbers = JSON.parse(data);
                var isDuplicate = demandNumbers.includes(demandno.trim());
                if (isDuplicate) {
                    $('#demandMessage').text("Demand Number Already Exists !").css('color', 'red');
                    // Disable the submit button if Demand Number Already Exists
                    $('#manualAddBtn').prop('disabled', true);
                } else {
                    $('#demandMessage').text("Demand Number is valid").css('color', 'green');
                    // Enable the submit button if Demand Number is valid
                    $('#manualAddBtn').prop('disabled', false);
                }
            },
            error: function(xhr, status, error) {
                console.error(xhr.responseText);
            }
        });
    });
});


</script>
</body>
</html>