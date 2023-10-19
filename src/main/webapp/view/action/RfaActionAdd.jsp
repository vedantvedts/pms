<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.io.ByteArrayOutputStream,java.io.ObjectOutputStream"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

<title>Rfa Action Add</title>

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

.form-group {
    margin-top: 0.5rem;
    margin-bottom: 1rem;
}

</style>

</head>
<body>

<%
List<Object[]> ProjectList=(List<Object[]>)request.getAttribute("ProjectList");
List<Object[]> ProjectTypeList=(List<Object[]>)request.getAttribute("ProjectTypeList");
List<Object[]> PriorityList=(List<Object[]>)request.getAttribute("PriorityList");
List<Object[]> EmployeeList=(List<Object[]>)request.getAttribute("EmployeeList");
String EmpId=(String)request.getAttribute("EmpId");

%>



<div class="container">
	<form action="#" method="POST" name="myfrm" id="myfrm" autocomplete="off">
	
	<div class="row" style="" id="mainrow">
		<div class="col-md-12">
 			<div class="card shadow-nohover" style="margin-top: 10px">		
				<div class="row card-header">
			   			<div class="col-md-6">
							<h4>RFA ADD</h4>
						</div>
						<div class="col-md-3">
							
						</div>						
						
					 </div>
        
        		<div class="card-body">
            <div class="row">
		                    <div class="col-md-2">
		                        <div class="form-group">
		                            <label class="control-label">Project</label>
		                            <span class="mandatory" style="color: #cd0a0a;">*</span>
			                            <select class="form-control selectdee " id="ProjectProgramme"  name="projectid" >
										    <option disabled="true"  selected value="">Select...</option>
										     <% for (Object[] obj : ProjectList) {%>
											<option value="<%=obj[0]%>"><%=obj[4]%></option>
											<%} %>
			  							</select>
			  							
		                        </div>
		                    </div>

		                    <div class="col-md-3">
		                        <div class="form-group">
		                            <label class="control-label">Priority</label>
		                            <span class="mandatory" style="color: #cd0a0a;">*</span>
		                            	<select class="custom-select"  required="required"name="priority" id="priority" >
										    <option disabled="true"  selected value="">Choose...</option>
											 <% for (Object[] obj : PriorityList) {%>
											<option value="<%=obj[0]%>"><%= "(" + obj[0] + ")" + obj[1]%></option>
											<%} %>
		  								</select>
		                        </div>
		                    </div>
		                    
		                    <div class="col-md-3">
		                        <div class="form-group">
		                            <label class="control-label">Date</label>
		                            <span class="mandatory" style="color: #cd0a0a;">*</span>
						  			<input  class="form-control form-control date"  data-date-format="dd-mm-yyyy" id="datepicker1" name="rfadate"  required="required"  style="width: 100%;" >						
		                        </div>
		                    </div>
		                    
		                  <div class="col-md-4">
		                     <div class="form-group">
		                            <label class="control-label">Assigned To</label>
		                            <span class="mandatory" style="color: #cd0a0a;">*</span>
		                      <select class="form-control selectdee" required="required" name="assignee" id="assignee">
		                         <option disabled="disabled" selected value="" >Choose...</option>                            
		                         <% for(Object[] obj : EmployeeList) { %>
		                         <option value=<%=obj[0]%>><%=obj[1]%> , <%=obj[2] %></option>
		                         <%} %>
		                      </select>
		                  </div>
		            </div> 
		            
		          </div>
		      
		            <div class="row">
		                  <div class="col-md-3" style="max-width: 18%">
		                      <label class="control-label"> Problem Satement</label>
		                      <span class="mandatory" style="color: #cd0a0a;">*</span>
		                  </div>
		                  <div class="col-md-10" style="max-width: 82%">
		                      <textarea class="form-control" rows="1" cols="30" placeholder="Max 200 Characters" name="statement" id="statement" maxlength="200"></textarea>
		                  </div>
		            </div>
		            
		            <br>
		            
		            <div class="row">
		                  <div class="col-md-3" style="max-width: 18%">
		                      <label class="control-label">Description</label>
		                      <span class="mandatory" style="color: #cd0a0a;">*</span>
		                  </div>
		                  <div class="col-md-10" style="max-width: 82%">
		                      <textarea class="form-control" rows="3" cols="30" placeholder="Max 500 Characters" name="description" id="description" maxlength="500"></textarea>
		                  </div>
		            </div>
		            
		            <br>
		            
		            <div class="row">
		                  <div class="col-md-3" style="max-width: 18%">
		                      <label class="control-label">References</label>
		                      <span class="mandatory" style="color: #cd0a0a;">*</span>
		                  </div>
		                  <div class="col-md-10" style="max-width: 82%">
		                      <input class="form-control" placeholder="Max 100 Characters" name="reference" id="reference" maxlength="100">
		                  </div>
		            </div>
		            
		           
		             <br>
		            
		        <div class="form-group" align="center" >
					 <input type="button" class="btn btn-primary btn-sm submit " onclick="return add()" value="SUBMIT" id="rfaAddSubBtn" formaction="RfaActionSubmit.htm" > 
					 <a class="btn btn-info btn-sm  shadow-nohover back" href="RfaAction.htm" >Back</a>
				</div>

				<input type="hidden" name="${_csrf.parameterName}"		value="${_csrf.token}" /> 
 		
   </div>    
        

        
        </div>
	</div>
</div>
<input type="hidden" value="<%=EmpId %>" name="EmpId">
</form>
</div>
  
  
  <script type="text/javascript">
  
  function add() {
	  
	  var ProjectProgramme=$('#ProjectProgramme').val();
	  var priority=$('#priority').val();
	  var assignee=$('#assignee').val();
	  var statement=$('#statement').val();
	  var description=$('#description').val();
	  var reference=$('#reference').val();
	  
		if(ProjectProgramme==""||ProjectProgramme==null ||ProjectProgramme=="null" ){
			   alert('Please Select ProjectProgramme');
			   return false;
		   }else if(priority==""||priority==null || priority=="null"){
				 alert('Please Select priority');
				   return false;
		   }else if(assignee==""||assignee==null || assignee=="null"){
				 alert('Please Select assignee');
				   return false;
		   }else if(statement==""||statement==null || statement=="null"){
				 alert('Please Enter statement');
				 document.getElementById("statement").style.boxShadow = "rgb(239, 7, 7) 0px 0px 1px 1px";
				   return false;
		   }else if(description==""||description==null || description=="null"){
				 alert('Please Enter description');
				 document.getElementById("description").style.boxShadow = "rgb(239, 7, 7) 0px 0px 1px 1px";
				   return false;
		   }else if(reference==""||reference==null || reference=="null"){
				 alert('Please Enter reference');
				 document.getElementById("reference").style.boxShadow = "rgb(239, 7, 7) 0px 0px 1px 1px";
				   return false;}
	  var confirmation = confirm('Are you sure you want to add the RFA?');
	  if(confirmation){
		  var form = document.getElementById("myfrm");
		   
          if (form) {
           var rfaAddSubBtn = document.getElementById("rfaAddSubBtn");
              if (rfaAddSubBtn) {
                  var formactionValue = rfaAddSubBtn.getAttribute("formaction");
                  
                   form.setAttribute("action", formactionValue);
                    form.submit();
                }
           }
	  } else{
    	  return false;
	  }
	
}
  $('#reference,#description,#statement').keyup(function (){
	  $('#reference,#description,#statement').css({'-webkit-box-shadow' : 'none', '-moz-box-shadow' : 'none','background-color' : 'none', 'box-shadow' : 'none'});
		  });
	  
  

	
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
	 $("input").on("keypress", function(e) {
		    if (e.which === 32 && !this.value.length)
		        e.preventDefault();
		});
	 
	 $("textarea").on("keypress", function(e) {
		    if (e.which === 32 && !this.value.length)
		        e.preventDefault();
		});

	</script> 
  
  
</body>
</html>