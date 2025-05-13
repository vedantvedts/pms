<%@page import="com.vts.pfms.FormatConverter"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<%-- <jsp:include page="../static/sidebar.jsp"></jsp:include> --%>
<title>PROJECT INT  EDIT</title>
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
<%SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
List<Object[]> ProjectTypeList=(List<Object[]>) request.getAttribute("ProjectTypeList");
List<Object[]> PfmsCategoryList=(List<Object[]>) request.getAttribute("PfmsCategoryList");
List<Object[]> PfmsDeliverableList=(List<Object[]>) request.getAttribute("PfmsDeliverableList");
Object[] ProjectEditData=(Object[]) request.getAttribute("ProjectEditData");
List<Object[]> NodalLabList=(List<Object[]>) request.getAttribute("NodalLabList");
List<Object[]> EmployeeList=(List<Object[]>) request.getAttribute("EmployeeList");
String LoginType = (String) session.getAttribute("LoginType");

FormatConverter fc = new FormatConverter();
%>



<%String ses=(String)request.getParameter("result"); 
 String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null){
	%><center>
	<div class="alert alert-danger" role="alert">
                     <%=ses1 %>
                    </div></center>
	<%}if(ses!=null){ %>
	<center>
	<div class="alert alert-success" role="alert" >
                     <%=ses %>
                   </div></center>
                    <%} %>


<div class="container">
	
	<div class="row" style="">
		<div class="col-md-12">

 			<div class="card shadow-nohover" >
				
				<div class="card-header" style=" /* background: linear-gradient(to right, #334d50, #cbcaa5); */ /* background-color:rgba(6,103,200,1); */ background-color: #055C9D;margin-top: ">
                    <b class="text-white">SECTION I: PROJECT INITIATION EDIT</b> 
                    <span class="text-white" style="float:right;font-weight: 600"><%if(ProjectEditData[17].toString().equalsIgnoreCase("N")){ %> Main Project : <%=ProjectEditData[18] %> <%} %> </span>
        		</div>
        
        		<div class="card-body">
        
        			<form action="ProjectIntiationEditSubmit.htm" method="POST" name="myfrm" id="myfrm"  >
                
                		<div class="row">
		                    
		                    <div class="col-md-3 ">
		                        <div class="form-group">
		                            <label class="control-label">Project/Programme</label>
		                            <select class="custom-select" id="ProjectProgramme" required="required" name="ProjectProgramme" <%if(ProjectEditData[17].toString().equalsIgnoreCase("N")){ %> disabled  <%} %>>
									    <option disabled="true"  selected value="">Choose...</option>
									    <option value="PGM" <%if(ProjectEditData[3].toString().equalsIgnoreCase("PGM")){ %> selected="selected" <%} %>>Programme</option>
									    <option value="PRJ" <%if(ProjectEditData[3].toString().equalsIgnoreCase("PRJ")){ %> selected="selected" <%} %>>Project</option>
		  							</select>
		                        </div>
		                    </div>
		                    
		                    <div class="col-md-3 ">
					        	<div class="form-group">
					            	<label class="control-label">Category</label>
									    <select class="custom-select" id="ProjectType" required="required" name="ProjectType" <%if(ProjectEditData[17].toString().equalsIgnoreCase("N")){ %> disabled  <%} %>>
										    <option disabled="true"  selected value="">Choose...</option>
										    <% for (Object[] obj : PfmsCategoryList) {%>
											<option value="<%=obj[0]%>" <%if(ProjectEditData[4].toString().equalsIgnoreCase(obj[0].toString())){ %> selected="selected" <%} %>><%=obj[1]%></option>
											<%} %>
									  </select>
					            </div>
					        </div>
		                    
		                    <div class="col-md-3">
		                        <div class="form-group">
		                            <label class="control-label">Security Classification</label>
		                              <select class="custom-select" id="Category" required="required" name="Category" <%if(ProjectEditData[17].toString().equalsIgnoreCase("N")){ %> disabled="true"  <%} %> >
										    <option disabled="true"  selected value="">Choose...</option>
										    	<% for (Object[] obj : ProjectTypeList) {%>
											<option value="<%=obj[0]%>" <%if(ProjectEditData[5].toString().equalsIgnoreCase(obj[0].toString())){ %> selected="selected" <%} %>><%=obj[1]%></option>
												<%} %>
		  								</select>
		                        </div>
		                    </div>
                                       
                    		<div class="col-md-3 ">
		                   		<div class="form-group">
		                            <label class="control-label">Nodal Lab</label>
		                            <span class="mandatory" style="color: #cd0a0a;">*</span>
		  							<select class="custom-select selectdee" id="NodalLab" required="required" name="NodalLab" <%if(ProjectEditData[17].toString().equalsIgnoreCase("N")){ %> disabled  <%} %> >
											    <option disabled="true"  selected value="">Choose...</option>
											   	<% for (Object[] obj : NodalLabList) {%>
												<option value="<%=obj[0]%>" <%if(ProjectEditData[15]!=null && ProjectEditData[15].toString().equalsIgnoreCase(obj[0].toString())){ %> selected="selected" <%} %>><%=obj[3]%></option>
												<%} %>
									</select>
		                        </div>
	                    	</div>
                    	
                		</div>
                		
						<hr>

		                <div class="row">
		                   
		                   <div class="col-md-2 ">
		                        <div class="form-group">
		                            <label class="control-label">Short Name</label>
		  								<input type="text" class="form-control alphanum-symbols-no-leading-space"  aria-describedby="inputGroup-sizing-sm" id="ShortName" name="ShortName" readonly value="<%=ProjectEditData[6]%>">
		                        </div>
		                    </div>
		                    
		                	<div class="col-md-8 ">
		                        <div class="form-group">
		                            <label class="control-label">Project Title</label>
		  								<input type="text" class="form-control alphanum-symbols-no-leading-space" required="required" aria-describedby="inputGroup-sizing-sm" id="ProjectTitle" name="ProjectTitle" value="<%=ProjectEditData[7]%>">
		                        </div>
		                    </div>       
		                    
		                     <div class="col-md-2 ">
		                        <div class="form-group">
		                            <label class="control-label">IsMultiLab</label>
									   <select class="custom-select" id="IsMultiLab" name="IsMultiLab" required="required">
									    <option disabled="true"  selected value="">--Select--</option>
									    <option value="Y" <%if(ProjectEditData[11]!=null && ProjectEditData[11].toString().equalsIgnoreCase("Y")){ %> selected="selected" <%} %>>Yes</option>
									    <option value="N" <%if(ProjectEditData[11]!=null && ProjectEditData[11].toString().equalsIgnoreCase("N")){ %> selected="selected" <%} %>>No</option>
									  </select>
		                        </div>
		                    </div> 
	
		                </div>
						<hr>
						
                		<div class="row">
                     
		                     <div class="col-md-4 ">
		                        <div class="form-group">
		                            <label class="control-label">Deliverable</label>
										<input type="text" class="form-control"  aria-describedby="inputGroup-sizing-sm" id="Deliverable" name="Deliverable" placeholder="max 255 characters"  <% if (ProjectEditData[12]!=null){ %>  value="<%=ProjectEditData[12]%>" <%}else {%> value="" <%} %>maxlength="250" >
		                        </div>
		                    </div> 
		                    
		                    <div class="col-md-2 ">
		                        <div class="form-group">
		                            <label class="control-label">IsPlanned</label>
										 <select class="custom-select" id="IsPlanned"  name="IsPlanned" required="required">
										    <option disabled="true"  selected value="">Choose...</option>
										    <option value="P" <%if(ProjectEditData[10].toString().equalsIgnoreCase("P")){ %> selected="selected" <%} %>>Plan</option>
										    <option value="N" <%if(ProjectEditData[10].toString().equalsIgnoreCase("N")){ %> selected="selected" <%} %>>Non-Plan</option>
										  </select> 
	                       		</div>
		                    </div> 
		                    
		                    <div class="col-md-4 ">
	                        	<div class="form-group" id="Remarks" style="display:none;">
		                            <label class="control-label">Remarks</label>
		                            <span class="mandatory" style="color: #cd0a0a;">*</span>
		  							<input type="text" class="form-control" aria-describedby="inputGroup-sizing-sm" id="Remarks" name="Remarks" <%if(ProjectEditData[16]!=null) {%>value="<%=ProjectEditData[16]%>" <%} %> maxlength="255" placeholder="Enter Remark" >
		                        </div>
	       					</div> 

                		</div>
                		
                		<hr>
						
                		<div class="row">
                     	
                     		<div class="col-md-3 ">
					        	<div class="form-group">
					            	<label class="control-label">PDD</label>
									    <select class="custom-select" id="PDD" name="PDD" <%if( !LoginType.equalsIgnoreCase("Z") && !LoginType.equalsIgnoreCase("A") && !LoginType.equalsIgnoreCase("E") || !LoginType.equalsIgnoreCase("C")|| !LoginType.equalsIgnoreCase("I")   ) {%> disabled <%} %>  >
										    <option disabled="true"  selected value="">Choose...</option>
										    <% for (Object[] obj : EmployeeList) {%>
											<option value="<%=obj[0]%>" <%if(ProjectEditData[1].toString().equalsIgnoreCase(obj[0].toString())){ %> selected="selected" <%} %>><%=obj[1]%>, <%=obj[2] %> </option>
											<%} %>
									  </select>
									  
									  
									  
					            </div>
					        </div>
			
					         <div class="col-md-3 ">
		                        <div class="form-group">
		                            <label class="control-label">Indicative Duration (Months)</label>
		  								<input type="text" class="form-control numeric-only"  aria-describedby="inputGroup-sizing-sm" id="PCDuration" name="PCDuration"  <%if( !LoginType.equalsIgnoreCase("Z") && !LoginType.equalsIgnoreCase("A") && !LoginType.equalsIgnoreCase("E") || !LoginType.equalsIgnoreCase("C")|| !LoginType.equalsIgnoreCase("I")  ) {%> readonly <%} %>  <% if (ProjectEditData[19]!=null){ %>  value="<%=ProjectEditData[19]%>" <%}else{ %> value="" <%} %>required>
		                        </div>
		                    </div>
                     
                     		<div class="col-md-3 ">
		                        <div class="form-group">
		                            <label class="control-label">Indicative Cost (&#8377;)</label>
		  								<input type="text" class="form-control decimal-format"  aria-describedby="inputGroup-sizing-sm" id="IndicativeCost" name="IndicativeCost" <%if( !LoginType.equalsIgnoreCase("Z") && !LoginType.equalsIgnoreCase("A") && !LoginType.equalsIgnoreCase("E") || !LoginType.equalsIgnoreCase("C")|| !LoginType.equalsIgnoreCase("I")  ) {%> readonly<%} %> <% if (ProjectEditData[20]!=null){ %>  value="<%=ProjectEditData[20]%>" <%}else{ %> value="" <%} %>>
		                        </div>
		                    </div>
                     
		                     <div class="col-md-3 ">
		                        <div class="form-group">
		                            <label class="control-label">P&C Remarks</label>
										<input type="text" class="form-control" required="required" aria-describedby="inputGroup-sizing-sm" id="PCRemarks" name="PCRemarks" <%if( !LoginType.equalsIgnoreCase("Z") && !LoginType.equalsIgnoreCase("A") && !LoginType.equalsIgnoreCase("E") || !LoginType.equalsIgnoreCase("C")|| !LoginType.equalsIgnoreCase("I")  ) {%> readonly <%} %> <% if (ProjectEditData[21]!=null){ %>  value="<%=ProjectEditData[21]%>" <%}else{ %> value="" <%} %> required>
		                        </div>
		                    </div> 
		                    
		                    
		                    
		                   

                		</div>
          
		        		<hr>
		         		
		         		<div class="row">
		         			<div class="col-md-3">
		         				<div class="form-group">
			                    	<label class="control-label">Probable Start Date</label><span class="mandatory" style="color: #cd0a0a;">*</span>
									<input type="text" class="form-control" required="required" id="startDate" name="startDate" <% if (ProjectEditData[22]!=null){ %>  value="<%=fc.SqlToRegularDate(ProjectEditData[22].toString())%>" <%} %>>
			                    </div>
		         			</div>
		         		</div>
         				<hr>
         
        				<div class="form-group" align="center">
								<!--  <input type="submit" class="btn btn-primary btn-sm "  value="SUBMIT"> 
								 <a class="btn btn-info btn-sm  shadow-nohover back" href="ProjectIntiationList.htm" >Back</a> -->
								 
								 <button type="submit" class="btn btn-primary btn-sm submit"  value="SUBMIT"  name="sub" onclick="return confirm('Are you sure you want to submit this form?')" >SUBMIT</button>
								 <input type="submit" class="btn btn-primary btn-sm submit back" formnovalidate="formnovalidate"  value="BACK"   name="sub" >
						</div>

						<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
				
						<input type="hidden" name="IntiationId" value="<%=ProjectEditData[0]%>" /> 
						<input type="hidden" name="ismain" value="<%=ProjectEditData[17]%>" />
						
						<%if(ProjectEditData[17].toString().equalsIgnoreCase("N")){ %>
						
							<input type="hidden" name="NodalLab" value="<%=ProjectEditData[15]%>" />
							<input type="hidden" name="ProjectType" value="<%=ProjectEditData[4]%>" />
							<input type="hidden" name="Category" value="<%=ProjectEditData[5]%>" />
							<input type="hidden" name="ProjectProgramme" value="<%=ProjectEditData[3]%>" />
						
						<%} %>
									
 				</form>
        
     			</div>   

        	</div>
     	</div>
	</div>
</div>

  

	
<script type="text/javascript">




$(document).ready(function(){

	var plannonplan = '<%=ProjectEditData[10]%>';
	
	if(plannonplan=='N'){
		
		$('#Remarks').css('display','block');
	}
	
})

$('#IsPlanned').on('change',function(){

	var value=$('#IsPlanned').val();
	
	if(value=='N'){
		$('#Remarks').css('display','block');
		$('#Remarks').attr('required', true);
	}else if(value=='P'){
		
		$('#Remarks').css('display','none');
		$('#Remarks').attr('required', false);
		
		
	}
	
})

$('#myfrm').on('submit', function() {
    $('#PDD').prop('disabled', false);
});


$('#startDate').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,	
	"cancelClass" : "btn-default",
	/* "minDate" : tomorrow, */
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});

</script>
</body>
</html>