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


%>

<%String ses=(String)request.getParameter("result"); 
 String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null){
	%>
	
	
	<center>
	
	<div class="alert alert-danger" role="alert">
                     <%=ses1 %>
                    </div></center>
	<%}if(ses!=null){ %>
	<center>
	<div class="alert alert-success" role="alert" >
                     <%=ses %>
            </div>
            
    </center>
    
    
                    <%} %>


	
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
                		<div class="col-md-1"></div>
                    		<div class="col-md-3">
                        		<div class="form-group">
                            		<label class="control-label">Group Code</label><span class="mandatory">*</span>
                              		<input  class="form-control form-control"  type="text" name="gCode" id="groupCode" required="required" maxlength="3" style="font-size: 15px;"> 
                        		</div>
                    		</div>
         					<div class="col-md-3">
                        		<div class="form-group">
                            		<label class="control-label">Group Name</label><span class="mandatory">*</span>
                            		<input  class="form-control form-control"  type="text" name="gName" id="groupName" required="required" maxlength="100" style=" font-size: 15px;text-transform: capitalize; width: 80%;" > 
                        		</div>
                    		</div>
                    		<div class="col-md-5">
                        		<div class="form-group">
                            		<label class="control-label">Group Head Name</label><span class="mandatory">*</span>
                              		<select class="custom-select" id="ghempid" required="required" name="ghempid">
													<option disabled  selected value="">---Select---</option>
													
													<% for (  Object[] obj : groupheadlist){ %>
											
													<option value=<%=obj[0]%>><%=obj[1]%>, <%=obj[2]%></option>
												
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
	
<div class="modal" id="loader">
					<!-- Place at bottom of page -->
				</div>
				
					
<script type='text/javascript'> 
$(document).ready(function() {
   $('#ghempid').select2();
});
</script>
</body>

<script type="text/javascript">


function groupcheck(frmid){
	var count=0;
	var groupCode=$('#groupCode').val();
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