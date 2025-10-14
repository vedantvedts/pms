<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
    <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<spring:url value="/resources/css/projectModule/projectIntiationAdd.css" var="projectIntiationAdd" />     
<link href="${projectIntiationAdd}" rel="stylesheet" />
<jsp:include page="../static/header.jsp"></jsp:include>

<title>PROJECT INT  ADD</title>

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



<div class="container">
	
	
	<form action="ProjectIntiationAdd.htm" method="POST" name="myfrm" id="myfrm" >
	
	<div class="row mt-n1p">
		
		<div class="col-md-3">
			<div class="form-group">
		    	<label class="control-label">Project</label>
		        <span class="mandatory text-danger">*</span>
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
		        	<span class="mandatory text-danger">*</span>
		            	<select class="custom-select selectdee" id="projectlist" required="required" name="initiationid">
							<option disabled="true"  selected value="">Choose...</option>
								<% for (Object[] obj : InitiatedProjectList) {%>
									<option value="<%=obj[0]%>"><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - "%></option>
								<%} %>
		  				</select>
		    </div>
		</div>
		
	</div>
	
	
	<div class="row" id="mainrow">
		<div class="col-md-12">

 			<div class="card shadow-nohover" >
					
				<div class="card-header cs-header">
                    <b class="text-white">SECTION I: PROJECT INITIATION</b>
        		</div>
        
        		<div class="card-body">
		                <div class="row"  id="mainfirstrow">
		                    
		                    <div class="col-md-3 ">
		                        <div class="form-group">
		                            <label class="control-label">Project/Programme</label>
		                            <span class="mandatory text-danger">*</span>
			                            <select class="form-control custom-select pdd" id="ProjectProgramme"  required="" name="ProjectProgramme" >
										    <option disabled="true"  selected value="">Choose...</option>
										    <option value="PGM">Programme</option>
										    <option value="PRJ">Project</option>
			  							</select>
			  							
		                        </div>
		                    </div>

		                    <div class="col-md-3 ">
		                        <div class="form-group">
		                            <label class="control-label">Category</label>
		                            <span class="mandatory text-danger">*</span>
		                            	<select class="custom-select pdd" id="ProjectType" required="required" name="ProjectType">
										    <option disabled="true"  selected value="">Choose...</option>
											 <% for (Object[] obj : PfmsCategoryList ) {%>
											<option value="<%=obj[0]%>"><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - "%></option>
											<%} %>
		  								</select>
		                        </div>
		                    </div>
		                   
		                   
		         			<div class="col-md-3 ">
		                        <div class="form-group">
		                            <label class="control-label">Security Classification</label>
		                            <span class="mandatory text-danger">*</span>
									    <select class="custom-select pdd" id="Category" required="required" name="Category">
										    <option disabled="true"  selected value="">Choose...</option>
										   	<% for (Object[] obj : ProjectTypeList) {%>
											<option value="<%=obj[0]%>"><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - "%></option>
											<%} %>
									  </select>
		                        </div>
		                    </div>
		                    
		                    <div class="col-md-3 ">
		                   		<div class="form-group">
		                            <label class="control-label">Nodal Lab</label>
		                            <span class="mandatory text-danger">*</span>
		  							<select class="custom-select selectdee pdd" id="NodalLab" required="required" name="NodalLab">
											    <option disabled="true"  selected value="">Choose...</option>
											   	<% for (Object[] obj : NodalLabList) {%>
												<option value="<%=obj[0]%>"><%=obj[3]!=null?StringEscapeUtils.escapeHtml4(obj[3].toString()): " - "%></option>
												<%} %>
									</select>
		                        </div>
	                    	</div> 
		            </div> 
		            
		                <div class="row" id="subfirstrow">
		                    
		                    <div class="col-md-3 ">
		                        <div class="form-group">
		                            <label class="control-label">Project/Programme</label>
		                            <span class="mandatory text-danger">*</span>
			                            <select class="form-control custom-select pdd" id="ProjectProgrammeSub"  required="" name="ProjectProgramme" >
										    <option disabled="true"  selected value="">Choose...</option>
										    <option value="PGM">Programme</option>
										    <option value="PRJ">Project</option>
			  							</select>
			  							
		                        </div>
		                    </div>

		                    <div class="col-md-3 ">
		                        <div class="form-group">
		                            <label class="control-label">Category</label>
		                            <span class="mandatory text-danger">*</span>
		                            	<select class="custom-select pdd" id="ProjectTypeSub" required="required" name="ProjectType">
										    <option disabled="true"  selected value="">Choose...</option>
											 <% for (Object[] obj : PfmsCategoryList ) {%>
											<option value="<%=obj[0]%>"><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - "%></option>
											<%} %>
		  								</select>
		                        </div>
		                    </div>
		                   
		                   
		         			<div class="col-md-3 ">
		                        <div class="form-group">
		                            <label class="control-label">Security Classification</label>
		                            <span class="mandatory text-danger">*</span>
									    <select class="custom-select pdd" id="CategorySub" required="required" name="Category">
										    <option disabled="true"  selected value="">Choose...</option>
										   	<% for (Object[] obj : ProjectTypeList) {%>
											<option value="<%=obj[0]%>"><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - "%></option>
											<%} %>
									  </select>
		                        </div>
		                    </div>
		                    
		                    <div class="col-md-3 ">
		                   		<div class="form-group">
		                            <label class="control-label">Nodal Lab</label>
		                            <span class="mandatory text-danger">*</span>
		  							<select class="custom-select selectdee pdd" id="NodalLabSub" required="required" name="NodalLab">
											    <option disabled="true"  selected value="">Choose...</option>
											   	<% for (Object[] obj : NodalLabList) {%>
												<option value="<%=obj[0]%>"><%=obj[3]!=null?StringEscapeUtils.escapeHtml4(obj[3].toString()): " - "%></option>
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
	                            	<span class="mandatory text-danger">*</span>
	  									<input type="text" class="form-control alphanum-symbols-no-leading-space"  aria-describedby="inputGroup-sizing-sm" id="ShortName" name="ShortName" placeholder="Enter Short Name" required>
	                        </div>
	                    </div>
	                    
	                	<div class="col-md-4">
	                        <div class="form-group">
	                            <label class="control-label">Project Title</label>
	                            <span class="mandatory text-danger">*</span>
	  								<input type="text" class="form-control alphanum-symbols-no-leading-space" required="required" aria-describedby="inputGroup-sizing-sm" id="ProjectTitle" name="ProjectTitle" placeholder="Enter Project Title" >
	                        </div>
	                    </div> 
	                    
	                    <div class="col-md-2 ">
                        	<div class="form-group">
	                            <label class="control-label">Is Planned</label>
	                            <span class="mandatory text-danger">*</span>
								 <select class="custom-select pdd" id="IsPlanned"  name="IsPlanned" required="required">
								    <option disabled="true"  selected value="">--Select--</option>
								     <option value="N">Non-Plan</option>
								    <option value="P">Plan</option>   
								  </select>                   
       						</div>
       					</div>

	                    <div class="col-md-4">
						<div class="form-group"> 
						<label class="control-label">Deliverable</label>
							<input type="text" class="form-control"  aria-describedby="inputGroup-sizing-sm" id="Deliverable" name="Deliverable" placeholder="Enter Deliverable"  maxlength="250" >
						</div>	                    
	                    </div> 
	                </div>
	                
					<hr>
                	
                	<div class="row">
	                    <div class="col-md-3 ">
		                   		<div class="form-group">
		                            <label class="control-label">PDD</label>
		                            <span class="mandatory text-danger">*</span>
		  							<select class="custom-select selectdee pdd" id="PDD" required="required" name="PDD">
											    <option disabled="true"  selected value="">--Select--</option>
											   	<% for (Object[] obj : EmployeeList) {%>
												<option value="<%=obj[0]%>"><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - "%>, <%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - " %> </option>
												<%} %>
									</select>
		                        </div>
	                    </div>
	                    
       					<div class="col-md-3 ">
		                        <div class="form-group">
		                            <label class="control-label">Indicative Duration(Mos)</label>
		                            	<span class="mandatory text-danger">*</span>
		  									<input type="text" class="form-control numeric-only "  aria-describedby="inputGroup-sizing-sm" id="PCDuration" name="PCDuration" placeholder="Enter No. of Months" required>
		                        </div>
	                    	</div> 
	                    
	                    <div class="col-md-3 ">
	                        <div class="form-group">
	                            <label class="control-label">Indicative Cost(Rs)</label>
	                            	<span class="mandatory text-danger">*</span>
	  									<input type="text" class="form-control decimal-format"  aria-describedby="inputGroup-sizing-sm" id="IndicativeCost" name="IndicativeCost" placeholder="Enter Indicative Months" required>
	                        </div>
	                    </div>  
	                    
	                     <div class="col-md-3">
	                        <div class="form-group">
	                            <label class="control-label">P&C DO Remarks</label>
	                            <span class="mandatory text-danger">*</span>
									<input type="text" class="form-control" required="required" aria-describedby="inputGroup-sizing-sm" id="PCRemarks" name="PCRemarks" placeholder="Enter Remarks" >
	                        </div>
	                    </div>
                      <input type="hidden" name="Deliverable" value="">
                  
                    

                </div>
          
        		<hr>
         		
         		<div class="row">
         			<div class="col-md-3">
         				<div class="form-group">
	                    	<label class="control-label">Probable Start Date</label><span class="mandatory text-danger">*</span>
							<input type="text" class="form-control" required="required" id="startDate" name="startDate" >
	                    </div>
         			</div>
         		</div>
         		
         		<hr>
         		
		        <div class="form-group" align="center" >
					 <button type="submit" class="btn btn-primary btn-sm submit " onclick="Add(myfrm)" value="SUBMIT">SUBMIT</button> 
					 <a class="btn btn-info btn-sm  shadow-nohover back" href="ProjectIntiationList.htm" >Back</a>
				</div>

 		
   </div>    
        

		<div class="card-footer cs-footer">   </div>
        
        </div>
	</div>
</div>

<input type="hidden" name="${_csrf.parameterName}"		value="${_csrf.token}" /> 

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
		$('#mainrow input').val('');
		$('.pdd').val('').trigger('change');
		$('#mainrow').show();
		$('#subfirstrow').hide();
		$('#mainfirstrow').show();
		$('#initiatedproject').hide();
		
	}
	else if(value=='N'){
		$('#mainrow input').val('');
		$('.pdd').val('').trigger('change');
		$('#mainrow').hide();
		$('#subfirstrow').show();
		$('#mainfirstrow').hide();
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
				
				 
				t+=  '<option value="'+values[0][4]+'">'
				+values[0][5]+ '</option>';
				
				$('#CategorySub').html(t);
				$('#ProjectTypeSub').html(s);
				
				
				var pgm='';
				
				if(values[0][1]=='PGM'){
					
					pgm='Programme';
					
				}else if(values[0][1]=='PRJ'){
					
					pgm='Project';
				}
				
				m+=  '<option value="'+values[0][1]+'">'
				+pgm+ '</option>';
				
				$('#ProjectProgrammeSub').html(m);
				
				
				/* n +=  '<option value="Y">Main</option><option value="N">Sub</option>';
				
				$('#ismain').html(n); */
				
				o+=  '<option value="'+values[0][6]+'">'
				+values[0][7]+ '</option>';
				
				$('#NodalLabSub').html(o);
				
				
				
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
	 var Category = $('#ismain').val() == 'Y' ? $("#Category").val() : $("#CategorySub").val();
	 var ProjectType = $('#ismain').val() == 'Y' ? $("#ProjectType").val() : $("#ProjectTypeSub").val();
	 var ProjectProgramme = $('#ismain').val() == 'Y' ? $("#ProjectProgramme").val() : $("#ProjectProgrammeSub").val();
	 var NodalLab = $('#ismain').val() == 'Y' ? $("#NodalLab").val() : $("#NodalLabSub").val();
	 var PCDuration = $("#PCDuration"). val();
	 var IndicativeCost = $("#IndicativeCost"). val();
	 var PCRemarks = $("#PCRemarks"). val();
	 var PDD = $("#PDD"). val();
	 
	 if(ShortName.length>18){
 		event.preventDefault();
		 alert("Short Name Too Long");
	 }		
	 

	if( ProjectProgramme==null || ProjectType==null || Category==null ||  NodalLab==null ||  IsPlanned==null  || ProjectTitle=="" || ShortName==""  || PCDuration=="" || PCRemarks=="" || IndicativeCost=="" ||  PDD==null ){
	    	 
		alert("Kindly Fill All The Mandatory Fields..!");
	   
	}
 
	/* 	 if( IsMultiLab.selectedIndex <=0 || IsPlanned.selectedIndex <=0 || ProjectProgramme.selectedIndex <=0 || Category.selectedIndex <=0  || ProjectType.selectedIndex <=0  )
	     {
	    	 alert("Kindly Fill All The Mandatory Fields..!");
	     } 
		    */


			else if(!ProjectTitle==""&&!ShortName==""&&!IsPlanned==""&&!Category==""&&!NodalLab==""&&!ProjectType==""&&!ProjectProgramme==""){


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
 $(document).ready(function() {
	  $("#dropdown-submit").click(function() {
	    var selectedOptions = [];
	    $("input[type=checkbox]:checked").each(function() {
	      selectedOptions.push($(this).val());
	    });
	    if (selectedOptions.length > 0) {
	      $("#dropdownMenuButton").text(selectedOptions.join(", "));
	    } else {
	      $("#dropdownMenuButton").text("Select options");
	    }
	  });
	});


/* $(document).ready(function() {
$('#DeliverablesOutput').multiselect({
includeSelectAllOption: true,
enableFiltering: true,
maxHeight: 200,
buttonWidth: '100%',
onChange: function(option, checked) {
  if(checked) {
    // Option selected
    console.log('Option selected: ' + $(option).val());
  } else {
    // Option deselected
    console.log('Option deselected: ' + $(option).val());
  }
}
});
}); */



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