<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
    
    <%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

<title>GROUP MASTER ADD</title>
<style type="text/css">

label{
font-weight: bold;
  font-size: 13px;
}

.table thead tr th {
	/* background-color: aliceblue; */
	text-align: left;
	width:30%;
}

.table thead tr td {

	text-align: left;
}

label{
	font-size: 15px;
}


table{
	box-shadow: 0 4px 6px -2px gray;
}


 .resubmitted{
	color:green;
}

	.fa{
		font-size: 1.20rem;
	}


</style>
</head>
<body>

<%

List<Object[]> groupheadlist=(List<Object[]>)request.getAttribute("groupheadlist");
List<Object[]> tdaddlist=(List<Object[]>)request.getAttribute("tdaddlist");

%>

<%String ses=(String)request.getParameter("result"); 
 String ses1=(String)request.getParameter("resultfail");
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
	
 <div class="col-sm-8"  style="top: 10px;">
<div class="card shadow-nohover"  >
<div class="card-header" style=" background-color: #055C9D;margin-top: ">
                    <h3 class="text-white">Group Add </h3>
        		</div>
        		
		<div class="card-body">
        			
        		 <form name="myfrm" action="GroupMasterAddSubmit.htm" id="groupAdd" method="POST"  >						
               	 <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                   <div class="row"> 
                		<!-- <div class="col-md-1"></div> -->
                    		<div class="col-md-2">
                        		<div class="form-group">
                            		<label class="control-label">Group Code</label><span class="mandatory">*</span>
                              		<input  class="form-control alphanum-only"  type="text" name="gCode" id="groupCode"  required="required" maxlength="3" style="font-size: 15px;"> 
                        		</div>
                    		</div>
         					<div class="col-md-3">
                        		<div class="form-group">
                            		<label class="control-label">Group Name</label><span class="mandatory">*</span>
                            		<input  class="form-control alphanum-no-leading-space"  type="text" name="gName" id="groupName"  required="required" maxlength="100" style=" font-size: 15px;text-transform: capitalize; width: 95%;" > 
                        		</div>
                    		</div>
                    		<div class="col-md-4">
                        		<div class="form-group">
                            		<label class="control-label">Group Head Name</label><span class="mandatory">*</span>
                              		<select class="custom-select" id="ghempid" required="required" name="ghempid">
													<option disabled  selected value="">---Select---</option>
													
													<% for (  Object[] obj : groupheadlist){ %>
											
													<option value=<%=obj[0]%>><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()):"-"%>, <%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()):"-"%></option>
												
													<%} %>
									</select>
                        		</div>
                    		</div>
                    	<div class="col-md-3">
                        	<div class="form-group">
                            	<label class="control-label">TD Name</label><span class="mandatory">*</span>
                            	<select class="custom-select" id="tdId" required="required" name="tdId">
								     <option selected value="">Choose...</option>
								
								      <% for (  Object[] obj : tdaddlist){ %>
						
								     <option value=<%=obj[0]%>><%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()):"-"%></option>
							
								     <%} %>
				              </select> 
                        	</div>
                    	</div>
                    		        		
                        </div>   
                        
                        <div align="center">
							<button type="button" class="btn btn-sm submit" style="align-self: center;" onclick="return groupcheck('groupAdd');">SUBMIT</button>
							<a class="btn  btn-sm  back"    href="GroupMaster.htm">BACK</a>
						</div>
                        
                        
                        </form>      
	 		      <br>
	  	</div>
	
	  
	  
	  
	  
	  
	  </div>
	  </div>
	 <div class="col-sm-2"></div> 
	  </div>
</div>	
	
				
					
<script type='text/javascript'> 
$(document).ready(function() {
   $('#ghempid').select2();
   $('#tdId').select2();
});
</script>
</body>

<script type="text/javascript">


function groupcheck(frmid){
	var count=0;
	var groupCode=$('#groupCode').val() || '';
	var groupName=$('#groupName').val() || '';
	var ghempid=$('#ghempid').val() || '';
	var tdId=$('#tdId').val() || '';
	
	groupCode = groupCode.trim();
	groupName = groupName.trim();
	ghempid = ghempid.trim();
	tdId = tdId.trim();
	
   if (!groupCode) {
        alert('Group Code is required.');
        return; 
    }
    if (!groupName) {
        alert('Group Name is required.');
        return; 
    }
    if (!ghempid) {
        alert('GH Head Name is required.');
        return; 
    }
    if (!tdId) {
        alert('TD Name is required.');
        return; 
    }
	
	$.ajax({

		type : "GET",
		url : "groupAddCheck.htm",
		data : {
			
			gcode:groupCode.trim()
			
		},
		datatype : 'json',
		success : function(result) {
			var ajaxresult = JSON.parse(result);
			
			if(ajaxresult[0]>=1){
				alert('Group Code Already Exists');
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