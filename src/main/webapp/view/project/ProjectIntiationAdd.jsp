<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<%-- <jsp:include page="../static/sidebar.jsp"></jsp:include> --%>
<title>PROJECT INT  ADD</title>
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

.mandatory{
	font-weight: 800;
}

#initiatedproject .select2-container{
	width:38rem !important;
}


</style>
</head>
<body>
<%
SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
List<Object[]> ProjectTypeList=(List<Object[]>) request.getAttribute("ProjectTypeList");
List<Object[]> PfmsCategoryList=(List<Object[]>) request.getAttribute("PfmsCategoryList");
List<Object[]> PfmsDeliverableList=(List<Object[]>) request.getAttribute("PfmsDeliverableList");
List<Object[]> InitiatedProjectList=(List<Object[]>) request.getAttribute("InitiatedProjectList");
List<Object[]> NodalLabList=(List<Object[]>) request.getAttribute("NodalLabList");
List<Object[]> EmployeeList=(List<Object[]>) request.getAttribute("EmployeeList");

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
	
	
	<form action="ProjectIntiationAdd.htm" method="POST" name="myfrm" id="myfrm" >
	
	<div class="row" style="margin-top: -1%">
		
		<div class="col-md-3 ">
			<div class="form-group">
		    	<label class="control-label">Project</label>
		        <span class="mandatory" style="color: #cd0a0a;">*</span>
			    <select class="form-control custom-select " id="ismain"  required="" name="ismain" >
					<option disabled="true"  selected value="">Choose...</option>
					<option value="Y">Main</option>
					<option value="N">Sub</option>
			  	</select>
		    </div>
		</div>
		
		<div class="col-md-4 " id="initiatedproject" >
			<div class="form-group" >
		    	<label class="control-label">Pre-Project</label>
		        	<span class="mandatory" style="color: #cd0a0a;">*</span>
		            	<select class="custom-select selectdee" id="projectlist" required="required" name="initiationid">
							<option disabled="true"  selected value="">Choose...</option>
								<% for (Object[] obj : InitiatedProjectList) {%>
									<option value="<%=obj[0]%>"><%=obj[1]%></option>
								<%} %>
		  				</select>
		    </div>
		</div>
		
	</div>
	
	
	<div class="row" style="" id="mainrow">
		<div class="col-md-12">

 			<div class="card shadow-nohover" >
					
				<div class="card-header" style=" /* background: linear-gradient(to right, #334d50, #cbcaa5); */ /* background-color:rgba(6,103,200,1); */ background-color: #055C9D;margin-top: ">
                    <b class="text-white">SECTION I: PROJECT INITIATION</b>
        		</div>
        
        		<div class="card-body">
        
        			
                
		                <div class="row">
		                    
		                    <div class="col-md-3 ">
		                        <div class="form-group">
		                            <label class="control-label">Project/Programme</label>
		                            <span class="mandatory" style="color: #cd0a0a;">*</span>
			                            <select class="form-control custom-select " id="ProjectProgramme"  required="" name="ProjectProgramme" >
										    <option disabled="true"  selected value="">Choose...</option>
										    <option value="PGM">Programme</option>
										    <option value="PRJ">Project</option>
			  							</select>
			  							
		                        </div>
		                    </div>

		                    <div class="col-md-3 ">
		                        <div class="form-group">
		                            <label class="control-label">Category</label>
		                            <span class="mandatory" style="color: #cd0a0a;">*</span>
		                            	<select class="custom-select" id="ProjectType" required="required" name="ProjectType">
										    <option disabled="true"  selected value="">Choose...</option>
											 <% for (Object[] obj : PfmsCategoryList ) {%>
											<option value="<%=obj[0]%>"><%=obj[1]%></option>
											<%} %>
		  								</select>
		                        </div>
		                    </div>
		                   
		                   
		         			<div class="col-md-3 ">
		                        <div class="form-group">
		                            <label class="control-label">Security Classification</label>
		                            <span class="mandatory" style="color: #cd0a0a;">*</span>
									    <select class="custom-select" id="Category" required="required" name="Category">
										    <option disabled="true"  selected value="">Choose...</option>
										   	<% for (Object[] obj : ProjectTypeList) {%>
											<option value="<%=obj[0]%>"><%=obj[1]%></option>
											<%} %>
									  </select>
		                        </div>
		                    </div>
		                    
		                    <div class="col-md-3 ">
		                   		<div class="form-group">
		                            <label class="control-label">Nodal Lab</label>
		                            <span class="mandatory" style="color: #cd0a0a;">*</span>
		  							<select class="custom-select selectdee" id="NodalLab" required="required" name="NodalLab">
											    <option disabled="true"  selected value="">Choose...</option>
											   	<% for (Object[] obj : NodalLabList) {%>
												<option value="<%=obj[0]%>"><%=obj[3]%></option>
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
	                            	<span class="mandatory" style="color: #cd0a0a;">*</span>
	  									<input type="text" class="form-control"  aria-describedby="inputGroup-sizing-sm" id="ShortName" name="ShortName" required>
	                        </div>
	                    </div>
	                    
	                	<div class="col-md-5">
	                        <div class="form-group">
	                            <label class="control-label">Project Title</label>
	                            <span class="mandatory" style="color: #cd0a0a;">*</span>
	  								<input type="text" class="form-control" required="required" aria-describedby="inputGroup-sizing-sm" id="ProjectTitle" name="ProjectTitle" >
	                        </div>
	                    </div> 
	                    
	                    <div class="col-md-2 ">
                        	<div class="form-group">
	                            <label class="control-label">Is Planned</label>
	                            <span class="mandatory" style="color: #cd0a0a;">*</span>
								 <select class="custom-select" id="IsPlanned"  name="IsPlanned" required="required">
								    <option disabled="true"  selected value="">Choose...</option>
								     <option value="N">Non-Plan</option>
								    <option value="P">Plan</option>   
								  </select>                   
       						</div>
       					</div>
       					
       					<div class="col-md-3 ">
                        	<div class="form-group" id="Remarks" style="display:none;">
	                            <label class="control-label">Remarks</label>
	                            <span class="mandatory" style="color: #cd0a0a;">*</span>

	  							<input type="text" class="form-control" aria-describedby="inputGroup-sizing-sm" id="Remarks" name="Remarks" >

	                        </div>
	                      
       					</div>
	                    
	                    
	                    <!-- <div class="col-md-2 ">
	                        <div class="form-group">
	                            <label class="control-label">Is MultiLab</label>
	                            <span class="mandatory" style="color: #cd0a0a;">*</span>
								   <select class="custom-select" id="IsMultiLab" name="IsMultiLab" required>
								    <option disabled="true"  selected value="choose">Choose...</option>
								
								    <option value="Y">Yes</option>
								    <option value="N">No</option>
								  </select>
	                        </div>
	                    </div>  -->     

	                </div>
	                
					<hr>
                	
                	<div class="row">
                
	                     <!-- <div class="col-md-5 ">
	                        <div class="form-group">
	                            <label class="control-label">Deliverable</label>
	                            <span class="mandatory" style="color: #cd0a0a;">*</span>
									<input type="text" class="form-control" required="required" aria-describedby="inputGroup-sizing-sm" id="Deliverable" name="Deliverable" >
	                        </div>
	                    </div> -->  
	                    
	                    <div class="col-md-3 ">
		                   		<div class="form-group">
		                            <label class="control-label">PDD</label>
		                            <span class="mandatory" style="color: #cd0a0a;">*</span>
		  							<select class="custom-select selectdee" id="PDD" required="required" name="PDD">
											    <option disabled="true"  selected value="">Choose...</option>
											   	<% for (Object[] obj : EmployeeList) {%>
												<option value="<%=obj[0]%>"><%=obj[1]%> (<%=obj[2] %>) </option>
												<%} %>
									</select>
		                        </div>
	                    </div>
	                    
       					<div class="col-md-3 ">
		                        <div class="form-group">
		                            <label class="control-label">Indicative Duration(Months)</label>
		                            	<span class="mandatory" style="color: #cd0a0a;">*</span>
		  									<input type="number" class="form-control"  aria-describedby="inputGroup-sizing-sm" id="PCDuration" name="PCDuration" required>
		                        </div>
	                    	</div> 
	                    
	                    <div class="col-md-3 ">
	                        <div class="form-group">
	                            <label class="control-label">Indicative Cost(Rs)</label>
	                            	<span class="mandatory" style="color: #cd0a0a;">*</span>
	  									<input type="text" class="form-control"  aria-describedby="inputGroup-sizing-sm" id="IndicativeCost" name="IndicativeCost" required>
	                        </div>
	                    </div>  
	                    
	                     <div class="col-md-3">
	                        <div class="form-group">
	                            <label class="control-label">P&C DO Remarks</label>
	                            <span class="mandatory" style="color: #cd0a0a;">*</span>
									<input type="text" class="form-control" required="required" aria-describedby="inputGroup-sizing-sm" id="PCRemarks" name="PCRemarks" >
	                        </div>
	                    </div>
                      <input type="hidden" name="Deliverable" value="">
                  
                    

                </div>
          
        		<hr>
         
		        <div class="form-group" align="center" >
					 <input type="submit" class="btn btn-primary btn-sm submit " onclick="Add(myfrm)" value="SUBMIT"> 
					 <a class="btn btn-info btn-sm  shadow-nohover back" href="ProjectIntiationList.htm" >Back</a>
				</div>

				<input type="hidden" name="${_csrf.parameterName}"		value="${_csrf.token}" /> 
 		
   </div>    
        

		<div class="card-footer" style=" background: linear-gradient(to right, #334d50, #cbcaa5);padding: 20px ">   </div>
        
        </div>
	</div>
</div>


</form>


</div>
  


	
<script type="text/javascript">

$(document).ready(function(){
	$('#initiatedproject').hide();
	$('#mainrow').hide();
	
})

$('#ismain').on('change',function(){
	
	var value=$('#ismain').val();
	
	if(value=='Y'){
		$('#mainrow').show();
		$('#initiatedproject').hide();
		
	}
	else if(value=='N'){
		$('#mainrow').css('display','none');
		$('#initiatedproject').show();
	}
	
})


$("#projectlist").on('change',function(){

	$('#mainrow').show();
	$projectid=$('#projectlist').val();
	
	
	$
		
		.ajax({
		
			type:"GET",
			url:"InitiatedProjectDetails.htm",
			data : {
				
				ProjectId : $projectid
				
			},
			datatype : 'json',
			success : function(result) {

				var result = JSON.parse(result);
				var values = Object.values(result).map(function(key, value) {
					  return result[key,value]
					});
				var size = Object.keys(values).length;
				var s = '';
				var t= '';
				var m='';
				var n='';
				var o='';

				s += '<option value="'+values[0][2]+'">'
							+values[0][3]+ '</option>';
				
				$('#Category').html(s);
				 
				 
				t+=  '<option value="'+values[0][4]+'">'
				+values[0][5]+ '</option>';
				
				$('#ProjectType').html(t);
				
				
				var pgm='';
				
				if(values[0][1]=='PGM'){
					
					pgm='Programme';
					
				}else if(values[0][1]=='PRJ'){
					
					pgm='Project';
				}
				
				m+=  '<option value="'+values[0][1]+'">'
				+pgm+ '</option>';
				
				$('#ProjectProgramme').html(m);
				
				
				n+=  '<option value="'+'N'+'">'
				+'Sub'+ '</option>';
				
				$('#ismain').html(n);
				
				o+=  '<option value="'+values[0][6]+'">'
				+values[0][7]+ '</option>';
				
				$('#NodalLab').html(o);
				
				
				
				$('.selectdee').select2();
				 

		}
		
		})
		
	
	
});

	

function Add(myfrm){
	
	event.preventDefault();

	 var IsMultiLab =  $("#IsMultiLab"). val();
	 var Deliverable =  $("#Deliverable"). val();
	 var IsMultiLab = document.getElementById("IsMultiLab");
	 var Deliverable = document.getElementById("Deliverable");
	 var ProjectTitle = $("#ProjectTitle"). val();
	 var ShortName = $("#ShortName"). val();
	 var IsPlanned = $("#IsPlanned"). val();
	 var Category = $("#Category"). val();
	 var ProjectType = $("#ProjectType"). val();
	 var ProjectProgramme = $("#ProjectProgramme"). val();
	 var NodalLab = $("#NodalLab"). val();
	 var PCDuration = $("#PCDuration"). val();
	 var IndicativeCost = $("#IndicativeCost"). val();
	 var PCRemarks = $("#PCRemarks"). val();
	 var PDD = $("#PDD"). val();
	 
	 if(ShortName.length>18){
 		event.preventDefault();
		 alert("Short Name Too Long");
	 }		
	 

	if( ProjectProgramme==null || ProjectType==null || Category==null || IsPlanned==null  || ProjectTitle=="" || ShortName==""  || PCDuration=="" || PCRemarks=="" || IndicativeCost=="" ||  PDD==null ){
	    	 
		alert("Kindly Fill All The Mandatory Fields..!");
	   
	}
 
	/* 	 if( IsMultiLab.selectedIndex <=0 || IsPlanned.selectedIndex <=0 || ProjectProgramme.selectedIndex <=0 || Category.selectedIndex <=0  || ProjectType.selectedIndex <=0  )
	     {
	    	 alert("Kindly Fill All The Mandatory Fields..!");
	     } 
		    */


	else if(!ProjectTitle==""&&!ShortName==""&&!IsPlanned==""&&!Category==""&&!ProjectType==""&&!ProjectProgramme==""){


$
.ajax({

type : "GET",
url : "ProjectShortNameCount.htm",
data : {
	ProjectShortName : ShortName
},
datatype : 'json',
success : function(result) {

	var result = JSON.parse(result);
	var values = Object.keys(result).map(function(e) {
		  return result[e]
		});

	console.log(result);
	if(result>0){
		alert("Short Name Already Present")	

	}
	
	else{

	var confirmresult= confirm("Are you Sure to Submit this Initiation Details");
	

	if(confirmresult==true){
		
	
		 $("#myfrm").submit();
		 
	}
	else if(confirmresult==false){
		return false;
	}
	
}
	
}
}); 
}
	 
	
}

$('#IsPlanned').change(function(){
	
	var value=$('#IsPlanned').val();
	
	if(value==='N'){
		
		$('#Remarks').css('display','block');
		$('#Remarks').attr('required', true);

	}
	if(value==='P'){
		
		$('#Remarks').css('display','none');
		$('#Remarks').attr('required', false);
	}
	
})








</script>
</body>
</html>