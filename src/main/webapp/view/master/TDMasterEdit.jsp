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
<%-- <jsp:include page="../static/sidebar.jsp"></jsp:include> --%>
<title>TD MASTER EDIT</title>
<style type="text/css">

label{
font-weight: bold;
  font-size: 13px;
}

.table thead tr th {
	background-color: aliceblue;
	text-align: left;
	width:30%;
}

.table thead tr td {

	text-align: left;
}

label{
	font-size: 15px;
}




</style>
</head>
<body>

<%


List<Object[]> tdheadlist=(List<Object[]>)request.getAttribute("tdheadlist");


Object[] tdsdata=(Object[])request.getAttribute("tdsdata");

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


<div id="ajaxError" style="display: none;">
    <div align="center">
        <div class="alert-danger" id="ajaxErrorMessage" style="width: 65%; padding: 10px; margin: 5px 0; 
              border-radius: 4px;">
            <!-- Error message will appear here -->
        </div>
    </div>
</div>
	
<br>	
	
<div class="container-fluid">		
<div class="row"> 


<div class="col-sm-2"></div> 
	
 <div class="col-sm-8"  style="top: 10px;">
<div class="card shadow-nohover"  >
<div class="card-header" style=" background-color: #055C9D;margin-top: ">
                    <b class="text-white">TD Master Edit</b>
        		</div>
<div class="card-body">


<form name="myfrm" action="TDMasterEditSubmit.htm" id="editCheck" method="POST" >

 <div class="row"> 
                		
                    		<div class="col-md-3">
                        		<div class="form-group">
                            		<label class="control-label">TD Code</label><span class="mandatory">*</span>
                              		<input  class="form-control form-control alphanum-only"  type="text" name="tdcode" readonly="readonly" id="tdCode" value="<%=tdsdata[1]!=null? StringEscapeUtils.escapeHtml4(tdsdata[1].toString()):""%>" required="required" maxlength="3" style="font-size: 15px;"> 
                        		</div>
                    		</div>
         					<div class="col-md-3">
                        		<div class="form-group">
                            		<label class="control-label">TD Name</label><span class="mandatory">*</span>
                            		<input  class="form-control form-control alphanum-no-leading-space" value="<%=tdsdata[2]!=null? StringEscapeUtils.escapeHtml4(tdsdata[2].toString()):"" %>"  type="text" name="tdname" id="tdName" required="required" maxlength="100" style=" font-size: 15px;text-transform: capitalize; width: 80%;" > 
                        		</div>
                    		</div>
                    		<div class="col-md-4">
                        		<div class="form-group">
                            		<label class="control-label">TD Head Name</label><span class="mandatory">*</span>
                              		<select class="custom-select" name="tdempid"  required="required" id ="tdempid" style="font-size: 18px;">
													<option disabled="true"  selected value="">---Select---</option>
													
													<% for (  Object[] obj : tdheadlist){ %>
											
													<option value=<%=obj[0]%> <%if(obj[0].toString().equalsIgnoreCase(tdsdata[3].toString())) {%> selected="selected" <%} %>><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()):"-"%>, <%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()):"-"%> </option>
												
													<%} %>
									</select>
                        		</div>
                    		</div>
                    			<div class="col-md-2">
                        		<div class="form-group">
                            		<label class="control-label">isActive:</label><span class="mandatory">*</span>
                              		 
								<select id="isActive" class="custom-select"  name="isActive" required="required" maxlength="255" style="font-size: 18px;" onclick="return isActiveCheck()" >
                       
                       
                     <option value="1" <%if(tdsdata[6].toString().equalsIgnoreCase("1")) {%> selected="selected" <%} %> >YES</option>
                       
					 <option value="0" <%if(tdsdata[6].toString().equalsIgnoreCase("0")) {%> selected="selected" <%} %> >NO</option>
                      
    </select> 
                        		</div>
                    		</div>
                    		        		
                        </div>    
    

	<div align="center">
		<button type="submit" class="btn btn-sm submit" style="align-self: center;" onclick="return confirm('Are you Sure To Submit ?');" >SUBMIT</button>&nbsp;&nbsp;
		<a class="btn  btn-sm  back"    href="TDMaster.htm">BACK</a>
	</div>

	<input type="hidden" name="tdid"  value="<%=tdsdata[0] %>" />
	<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}"  />
	
	
</form>
	
	
	  </div>
	  </div>
	  </div>
	 
	 <div class="col-sm-2"></div> 
	 
	  </div>
	
</div>	
	
</body>
<script>



 $(document).ready(function() {
	   
	    $('select[name="isActive"]').change(function() {
	        var isActive = $(this).val();
	        var tdCode = $('#tdCode').val();
	        var tdid = $('input[name="tdid"]').val();
	        
	        
	        $('#ajaxError').hide();
	        $('#ajaxErrorMessage').text('');
	        
	        if(isActive === "0") {
	            $.ajax({
	                url: 'TDMasterEditSubmitCheck.htm',
	                type: 'POST',
	                data: {
	                    isActive: isActive,
	                    tdcode: tdCode,
	                    tdid: tdid,
	                    '${_csrf.parameterName}': '${_csrf.token}'
	                },
	                success: function(response) {
	                    if(response.valid) {
	                       
	                        console.log("Validation passed");
	                    } else {
	                        
	                        $('#ajaxErrorMessage').text(response.message);
	                        $('#ajaxError').show();
	                        
	                        $('select[name="isActive"]').val("1");
	                    }
	                },
	                error: function(xhr) {
	                    $('#ajaxErrorMessage').text("Error validating status");
	                    $('#ajaxError').show();
	                    $('select[name="isActive"]').val("1");
	                }
	            });
	        }
	    });
	});
</script>

  

</html>