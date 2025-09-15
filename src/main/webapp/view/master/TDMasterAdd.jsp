<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
        <%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
    <%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

<title>TD MASTER ADD</title>

<spring:url value="/resources/css/master/TDMasterAdd.css" var="TDMasterAdd" />     
<link href="${TDMasterAdd}" rel="stylesheet" />


</head>
<body>

<%

List<Object[]> tdheadlist=(List<Object[]>)request.getAttribute("tdheadlist");


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
	
<div class="container-fluid">		
<div class="row"> 


<div class="col-sm-2"></div> 
	
 <div class="col-sm-8 topdiv"  >
<div class="card shadow-nohover"  >
<div class="card-header headerDiv" >
                    <h3 class="text-white">TD Add </h3>
        		</div>
        		
		<div class="card-body">
        			
        		 <form name="myfrm" action="TDMasterAddSubmit.htm" id="tdAdd" method="POST"  >						
               	 <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                   <div class="row"> 
                		<div class="col-md-1"></div>
                    		<div class="col-md-3">
                        		<div class="form-group">
                            		<label class="control-label">TD Code</label><span class="mandatory">*</span>
                              		<input  class="form-control form-control alphanum-only"  type="text" name="tCode" id="tdCode" required="required" maxlength="3" > 
                        		</div>
                    		</div>
         					<div class="col-md-3">
                        		<div class="form-group">
                            		<label class="control-label">TD Name</label><span class="mandatory">*</span>
                            		<input  class="form-control form-control alphanum-no-leading-space"  type="text" name="tName" id="tdName" required="required" maxlength="100"  > 
                        		</div>
                    		</div>
                    		<div class="col-md-5">
                        		<div class="form-group">
                            		<label class="control-label">TD Head Name</label><span class="mandatory">*</span>
                              		<select class="custom-select" id="tdempid" required="required" name="tdempid">
													<option disabled  selected value="">---Select---</option>
													
													<% for (  Object[] obj : tdheadlist){ %>
											
													<option value=<%=obj[0]%>><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()):"-"%>, <%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()):"-"%></option>
												
													<%} %>
									</select>
                        		</div>
                    		</div>
                    		
                    		        		
                        </div>   
                        
                        <div align="center">
							<button type="button" class="btn btn-sm submit btnSubmit" onclick="return tdcheck('tdAdd');">SUBMIT</button>
							<a class="btn  btn-sm  back"    href="TDMaster.htm">BACK</a>
						</div>
                        
                        
                        </form>      
	 		      <br>
	  	</div>
	
	  
	  
	  
	  
	  
	  </div>
	  </div>
	 <div class="col-sm-2"></div> 
	  </div>
</div>	
	
</body>

<script type='text/javascript'> 
$(document).ready(function() {
   $('#tdempid').select2();
});
</script>

<script type="text/javascript">

function tdcheck(frmid){
	 var count=0;
	 
	  var tdCode = $('#tdCode').val() || '';
	  var tdName = $('#tdName').val() || '';
	  var tdempid = $('#tdempid').val() || '';

	    tdCode = tdCode.trim();
	    tdName = tdName.trim();
	    tdempid = tdempid.trim();

	 
	   if (!tdCode) {
	        alert('TD Code is required.');
	        return; 
	    }
	    if (!tdName) {
	        alert('TD Name is required.');
	        return; 
	    }
	    if (!tdempid) {
	        alert('TD Head Name is required.');
	        return; 
	    }
	 
	$.ajax({

		type : "GET",
		url : "tdAddCheck.htm",
		data : {
			
			tcode:tdCode
			
		},
		datatype : 'json',
		success : function(result) {
			var ajaxresult = JSON.parse(result);
			
			if(ajaxresult[0]>=1){
				alert('TD Code Already Exists');
				count++;
			}
		
			
			if(count==0){
							
				var ret = confirm('Are you Sure To Submit ?');
				if(ret){
					$('#'+frmid).submit();
					}
			}		
		}
	});	
}

</script>

</html>