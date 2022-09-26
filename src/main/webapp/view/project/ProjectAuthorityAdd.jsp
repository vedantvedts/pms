<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<%-- <jsp:include page="../static/sidebar.jsp"></jsp:include> --%>
<title>PROJECT REFERENCE  ADD</title>
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

b{
	font-family: 'Lato',sans-serif;
}

</style>
</head>
<body>
<%SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd");
String IntiationId=(String) request.getAttribute("IntiationId");
List<Object[]> EmployeeList= (List<Object[]>)request.getAttribute("EmployeeList");
Object[] ProjectDetailes=(Object[])request.getAttribute("ProjectDetailes");
Object[] ProjectAuthorityDetails=(Object[])request.getAttribute("ProjectAuthorityDetails");
String Option=(String) request.getAttribute("Option");

String filesize=(String) request.getAttribute("filesize");
%>



<%String ses=(String)request.getParameter("result"); 
 String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null){
%>
<div align="center">
	<div class="alert alert-danger" role="alert">
                     <%=ses1 %>
                    </div></div>
	<%}if(ses!=null){ %>
<div align="center">
	<div class="alert alert-success" role="alert" >
                     <%=ses %>
                   </div></div>
                    <%} %>



<div class="container">
	<div class="row" style="">

		<div class="col-md-12">

 			<div class="card shadow-nohover" >
	
				<div class="card-header">
					 <div class="row" >
					 	<div class="col-md-3">
					 		<h3>Reference</h3>
					 	</div>
					 	<div class="col-md-9 " style="">
							<b style="color: green;float: right;">Title :&nbsp;<%=ProjectDetailes[7] %> (<%=ProjectDetailes[6] %>)</b> 
					 	</div>
					 </div>
		  		</div>

		        <div class="card-body">
		  
		  			<%if(Option.equalsIgnoreCase("add")){ %>
		  
				      <form action="ProjectAuthorityAddSubmit.htm" method="POST" name="myfrm" id="myfrm" enctype="multipart/form-data">
				               
				             <div class="row">  
				             
				             	<div class="col-md-4 ">
						         	<div class="form-group">
						            	<label class="control-label">Reference Authority </label>
										<select class="form-control selectdee" id="authorityname" required="required" name="authorityname" >
					   						<option disabled="true"  selected value="">Choose...</option>
					   						<% for (Object[] obj : EmployeeList) {%>
					   						
											<option value="<%=obj[0]%>" %> <%=obj[1]%></option>
												
											<%} %>
					  					</select>			
					  				</div>
						         </div>
						         
						         <div class="col-md-4 ">
						         	<div class="form-group">
						            	<label class="control-label">Reference Number</label>
						  				<input type="text" class="form-control" required="required" aria-describedby="inputGroup-sizing-sm" id="letterno" name="letterno" >
						            </div>
						         </div>
						         
						         <div class="col-md-4 ">
						         	<div class="form-group">
						            	<label class="control-label">Reference Date</label>
		                         			<input  class="form-control "  data-date-format="dd/mm/yyyy" id="startdate" name="startdate"  required="required" readonly >	
						            </div>
						         </div>

				             </div> 
				               
				                
				      		<div class="row">                   
 
					            <div class="col-md-5 ">
					               <div class="form-group">
					               		<label class="control-label">Reference Attachment</label>
					  					<input type="file" class="form-control"  aria-describedby="inputGroup-sizing-sm" id="FileAttach" name="FileAttach" required="required"   >
					               </div>
					         	</div>                 
				            
					          	 
				 
				            </div>

							<div class="row">
							
								<div class="col-md-5 "></div>
							
								<div class="col-md-1 ">
									 <div class="form-group">
										<input type="submit" class="btn btn-primary btn-sm submit " onclick="Add(myfrm)" value="SUBMIT" name="sub" style="margin-top: 40px;"> 
									 </div>
								</div>   
				
				          		<div class="col-md-1 ">
									 <div class="form-group">
									 	<input type="submit" class="btn btn-secondary btn-sm back " formnovalidate="formnovalidate"  value="BACK"   name="sub" style="margin-top: 40px;" >
									</div>
								</div>
							
							
							</div>


							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
							<input type="hidden" name="IntiationId" value="<%=IntiationId %>" />
				        
				  	</form>  
				  	
				  	<%} %>
				  	
				  	<%if(Option.equalsIgnoreCase("edit")){ %>
				  	
				  	<form action="ProjectAuthorityEditSubmit.htm" method="POST" name="myfrm" id="myfrm" enctype="multipart/form-data">
				               
				             <div class="row">  
				             
				             	<div class="col-md-4 ">
						         	<div class="form-group">
						            	<label class="control-label">Reference Authority </label>
					  					 <select class="form-control selectdee"   id="authorityname" required="required" name="authorityname">
													<option disabled="true"  selected value="">Choose...</option>
													<% for (Object[] obj : EmployeeList) {%>
														<option value="<%=obj[0]%>" <% if(ProjectAuthorityDetails[2].toString().equals(obj[0].toString())) {%>selected <%} %>  ><%=obj[1]%></option>													
													<%} %>
											  </select>			
					  				</div>
						         </div>
						         
						         <div class="col-md-4 ">
						         	<div class="form-group">
						            	<label class="control-label">Reference Number</label>
						  				<input type="text" class="form-control" required="required" aria-describedby="inputGroup-sizing-sm" id="letterno" name="letterno" value="<%=ProjectAuthorityDetails[4] %>" >
						            </div>
						         </div>
						         
						         <div class="col-md-4 ">
						         	<div class="form-group">
						            	<label class="control-label">Reference Date</label>
						           			<input  class="form-control"  data-date-format="dd/mm/yyyy" id="startdate" name="startdate"  required="required"  value=" <%= sdf.format(sdf1.parse( ProjectAuthorityDetails[3] .toString()))%>">
						            </div>
						         </div>

				             </div> 
				               
				                
				      		<div class="row">                   
 
					            <div class="col-md-5 ">
					               <div class="form-group">
					               		<label class="control-label">Reference Attachment</label>
					  					<input type="file" class="form-control"  aria-describedby="inputGroup-sizing-sm" id="FileAttach1" name="FileAttach"  >
					               </div>
					         	</div>   
					         	
					         	<div class="col-md-3 ">
					         		<label class="control-label">Download</label><br>
				                    <a  href="ProjectAuthorityDownload.htm?AuthorityFileId=<%=ProjectAuthorityDetails[7] %>" target="_blank"><i class="fa fa-download fa-2x" style="padding: 0px 25px; margin-top: 5px"></i>
				                    </a>
				           		</div>               
				            
					          	 
				 
				            </div>

							<div class="row">
							
								<div class="col-md-5 "></div>
							
								<div class="col-md-1 ">
									 <div class="form-group">
										<input type="submit" class="btn btn-primary btn-sm submit " onclick="validate()" value="SUBMIT" name="sub" style="margin-top: 40px;"> 
									 </div>
								</div>   
				
				          		<div class="col-md-1 ">
									 <div class="form-group">
									 	<input type="submit" class="btn btn-secondary btn-sm back " formnovalidate="formnovalidate"  value="BACK"   name="sub" style="margin-top: 40px;" >
									</div>
								</div>
							
							
							</div>


							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
							<input type="hidden" name="IntiationId" value="<%=IntiationId %>" />
				        	<input type="hidden" name="attachmentid" value="<%=ProjectAuthorityDetails[7] %>" />
				        
				  	</form> 
				  	
				  	<%} %>
		    
		     	</div>     

        	</div>

		</div>
	</div>

</div>
  
<script type="text/javascript">
						
			    Filevalidation = (fileid) => 
			    {
			        const fi = $('#'+fileid )[0].files[0].size;							 	
			        const file = Math.round((fi / 1024/1024));
			        if (file >= <%=filesize%>) 
			        {
			        	alert("File too Big, please select a file less than <%=filesize%> mb");
			        } 
			    }
						
		</script>
	
<script type="text/javascript">

<%if(Option.equalsIgnoreCase("add")){ %>

$('#startdate').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	/* "minDate" :new Date(), */
	"startDate" : new Date(),
	"maxDate" :new Date(),

	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});

<%}%>

<%if(Option.equalsIgnoreCase("edit")){ %>

$('#startdate').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	"maxDate" :new Date(),
	
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});

<%}%>


function validate(){
	var oFile = document.getElementById("FileAttach").files[0]; 

	if (oFile.size > 2097152) 
	{
	    alert("File size must less than 2MB!");
	    event.preventDefault();
	    
	}

	
}

</script>

</body>
</html>