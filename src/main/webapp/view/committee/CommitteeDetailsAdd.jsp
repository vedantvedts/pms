<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<spring:url value="/resources/css/committeeModule/committeeDetailsAdd.css" var="committeeDetailsAdd" />
<link href="${committeeDetailsAdd}" rel="stylesheet" />
<title> CONSTITUTE COMMITTEE</title>
<%
String ses=(String)request.getParameter("result"); 
String ses1=(String)request.getParameter("resultfail");
String noactive=(String)request.getParameter("noactive");
if(noactive!=null && noactive.equals("true")){%>

<script type="text/javascript">
alert('<%=StringEscapeUtils.escapeHtml4(ses1)%>');
</script>
<%} %>

</head>
<body>

<%
List<Object[]> EmployeeList=(List<Object[]>) request.getAttribute("employeelist");
Object[] committeedata=(Object[]) request.getAttribute("committeedata");
List<Object[]> projectlist=(List<Object[]>) request.getAttribute("projectlist");
List<Object[]> AllLabsList=(List<Object[]>) request.getAttribute("AllLabsList");
String committeemainid1 = (String)request.getAttribute("committeemainid");
List<Object[]> divisionslist=(List<Object[]>) request.getAttribute("divisionslist");
List<Object[]> committeereplist=(List<Object[]>) request.getAttribute("committeereplist");
Object[] initiationdata=(Object[]) request.getAttribute("initiationdata");
String divisionid = (String)request.getAttribute("divisionid");
String projectid = (String)request.getAttribute("projectid");
String initiationid = (String)request.getAttribute("initiationid");
String carsInitiationId = (String)request.getAttribute("carsInitiationId");
String LabCode = (String)request.getAttribute("LabCode");

%>

<% 

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
	<div class="row">
		<div class="col-md-12">
 			<div class="card shadow-nohover" >
				<div class="card-header headerBgColor">
					<h3 class="text-white">Constitute Committee</h3>
				</div>
        		<div class="card-body">
        		<form action="CommitteeDetailsSubmit.htm" method="POST" name="myfrm" id="myfrm">
                	<div class="row">
						<div class="col-md-4 ">
	                        <div class="form-group">
	                            <label class="control-label">Committee<span class="mandatory text-danger">*</span></label>
	                              <select class="custom-select selectdee mt-n5" id="committeeid" required="required" name="committeeid"> 
									    	
										<option  selected value="<%=committeedata[0]%>"><%=committeedata[2]!=null?StringEscapeUtils.escapeHtml4(committeedata[2].toString()): " - "%> (<%=committeedata[1]!=null?StringEscapeUtils.escapeHtml4(committeedata[1].toString()): " - " %>) </option>
												
	  							   </select>
	                        </div> 
										
	                    </div>
<!-- 	 --------------------------------------------------------------------------------------------- -->
	                    <%if(projectid!=null && Long.parseLong(projectid)>0){ %>
		                    <div class="col-md-4">
		                        <div class="form-group">
		                            <label class="control-label">Project<span class="mandatory text-danger">*</span></label>
		                              <%if(Long.parseLong(projectid)>0){ %>
									<select class="form-control selectdee" id="projectid" required="required" name="projectid" >							
										<% for (Object[] obj : projectlist) {
											if(projectid.equals(obj[0].toString())) {%>						    				 	
											<option value="<%=obj[0]%>" selected><%=obj[3]!=null?StringEscapeUtils.escapeHtml4(obj[3].toString()): " - "%> (<%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - "%>)</option>
										<%} 
										}%>					
									</select>
									<input type="hidden" name="divisionid" value="<%=divisionid%>"/>
									<input type="hidden" name="initiationid" value="<%=initiationid%>"/>
								</div>
		                    </div>
						<%} %> 
	                     
					<%}else if (divisionid!=null && Long.parseLong(divisionid)>0){ %>
							 <div class="col-md-4">
		                        <div class="form-group">
		                            <label class="control-label">Division<span class="mandatory text-danger">*</span></label>
		                             
									<select class="form-control selectdee" id="divisionid" required="required" name="divisionid"  >							
										<% for (Object[] obj : divisionslist) {
											if(divisionid.equals(obj[0].toString())) {%>						    				 	
											<option value="<%=obj[0]%>" selected><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - "%> </option>
										<%}
											}%>					
									</select>
									<input type="hidden" name="projectid" value="<%=projectid %>"/>
									<input type="hidden" name="initiationid" value="<%=initiationid%>"/>
								</div>
		                    </div>
					<%} else if (initiationid!=null && Long.parseLong(initiationid)>0){ %>
							 <div class="col-md-4">
		                        <div class="form-group">
		                            <label class="control-label">Initiated project<span class="mandatory text-danger">*</span></label>
		                             
									<select class="form-control selectdee" id="initiationid" required="required" name="initiationid"  >							
											<option value="<%=initiationdata[0]%>" selected><%=initiationdata[2]!=null?StringEscapeUtils.escapeHtml4(initiationdata[2].toString()): " - "%> </option>
									</select> 
									<input type="hidden" name="projectid" value="<%=projectid %>"/>
									<input type="hidden" name="divisionid" value="<%=divisionid%>"/>
								</div>
		                    </div>
					
		                              
		            <%}else if(Long.parseLong(divisionid)==0 && projectid!=null && Long.parseLong(projectid)==0){	%>
		            	<input type="hidden" name="projectid" value="<%=projectid %>"/>
		            	<input type="hidden" name="divisionid" value="<%=divisionid%>"/>
		            	<input type="hidden" name="initiationid" value="<%=initiationid%>"/>
	
		            <%} %>
		            
		            <%if(carsInitiationId!=null) {%>
		            	<input type="hidden" name="projectid" value="<%=projectid %>"/>
		            	<input type="hidden" name="divisionid" value="<%=divisionid%>"/>
		            	<input type="hidden" name="initiationid" value="<%=initiationid%>"/>
		            	<input type="hidden" name="carsInitiationId" value="<%=carsInitiationId %>"/>
		            <%} %>
<!-- 	 --------------------------------------------------------------------------------------------- -->
						   <div class="col-md-4 d-none">
	                        <div class="form-group">
	                            <label class="control-label">From Date<span class="mandatory text-danger">*</span></label>
	       							<input  class="form-control form-control mt-n5 mt-n10"  data-date-format="dd/mm/yyyy" id="startdate" name="Fromdate">
	                        </div>
	                    </div>
	                    
	                    
					</div>
					
					<div class="row">	
	                    <div class="col-md-10 ">
	                    	<table class="w-100">
	                        <tr>
								<td class="tdWidth">
									<div id="cplab-col" >
									<label class="control-label chairPerson">Lab<span class="mandatory text-danger">*</span></label>
									<div class="input select" >
										 	
										<select class=" form-control selectdee mt-n5" name="CpLabCode" id="CpLabCode" required="required" onchange="ChaippersonEmpList()" >
											<option disabled="disabled"  selected value="" >Choose...</option>
											<%	for (Object[] obj  : AllLabsList) {%>
										     	<option value="<%=obj[3]%>" <%if(LabCode.equalsIgnoreCase(obj[3].toString())){ %>selected <%} %> ><%=obj[3]!=null?StringEscapeUtils.escapeHtml4(obj[3].toString()): " - " %> </option>
											<% } %>
											<option value="@EXP"> Expert</option>
										</select>			
										</div>	
									</div>
								</td>
								<td>&nbsp;</td>		<td>&nbsp;</td>	<td>&nbsp;</td>	<td>&nbsp;</td>	<td>&nbsp;</td>	<td>&nbsp;</td>									
								<td class="border-0">
								<div class="input select">
									<label class="control-label chairPerson">Chairperson<span class="mandatory text-danger">*</span></label><br>
										<select class="form-control selectdee" name="chairperson" id="chairperson" data-live-search="true"   data-placeholder="Select Member" required="required" >
								             
										</select>															
									</div>					
								</td>						
							</tr>
							</table>
	                    </div>

            
				        
				     </div>
				     <div class="row">
				     	
				     	                  <div class="col-md-10 ">
	                    	<table class="w-100">
	                        <tr>
								<td class="tdWidth border-0">
									<div id="cplab-col" >
									<label class="control-label chairPerson">Lab<span class="mandatory text-danger">*</span></label>
									<div class="input select" >
										 	
										<select class=" form-control selectdee mt-n5" name="msLabCode" id="msLabCode" required="required" onchange="msEmpList()" >
											<option disabled="disabled"  selected value="" >Choose...</option>
											<%	for (Object[] obj  : AllLabsList) {%>
										     	<option value="<%=obj[3]%>" <%if(LabCode.equalsIgnoreCase(obj[3].toString())){ %>selected <%} %> ><%=obj[3]!=null?StringEscapeUtils.escapeHtml4(obj[3].toString()): " - " %> </option>
											<% } %>
											<option value="@EXP"> Expert</option>
										</select>			
										</div>	
									</div>
								</td>
								<td>&nbsp;</td>		<td>&nbsp;</td>	<td>&nbsp;</td>	<td>&nbsp;</td>	<td>&nbsp;</td>	<td>&nbsp;</td>									
								<td class="border-0">
								<div class="input select">
									<label class="control-label chairPerson">Member Secretary<span class="mandatory text-danger">*</span></label>
										<select class="form-control selectdee" name="Secretary" id="secretary" data-live-search="true"   data-placeholder="Select Member" required="required" >
								             
										</select>															
									</div>					
								</td>						
							</tr>
							</table>
	                    </div>
				     </div>
				     
				     <div class="row">
				                   <div class="col-md-10 ">
	                    	<table class="w-100">
	                        <tr>
								<td class="tdWidth border-0">
									<div id="cplab-col" >
									<label class="control-label chairPerson">Lab</label>
									<div class="input select" >
										 	
										<select class=" form-control selectdee mt-n5" name="ccplabocode" id="ccplabocode" onchange="ccpEmpList()" >
											<option disabled="disabled"  selected value="" >Choose...</option>
											<%	for (Object[] obj  : AllLabsList) {%>
										     	<option value="<%=obj[3]%>" <%if(LabCode.equalsIgnoreCase(obj[3].toString())){ %>selected <%} %> ><%=obj[3]!=null?StringEscapeUtils.escapeHtml4(obj[3].toString()): " - " %> </option>
											<% } %>
											<option value="@EXP"> Expert</option>
										</select>			
										</div>	
									</div>
								</td>
								<td>&nbsp;</td>		<td>&nbsp;</td>	<td>&nbsp;</td>	<td>&nbsp;</td>	<td>&nbsp;</td>	<td>&nbsp;</td>									
								<td class="border-0">
								<div class="input select">
									<label class="control-label chairPerson">Co-Chairperson</label>
										<select class="form-control selectdee" name="cochairperson" id="cochairperson" data-live-search="true"   data-placeholder="Select Member"  >
								             
										</select>															
									</div>					
								</td>						
							</tr>
							</table>
	                    </div>
				     </div>
				     
                       <div class="row"> 
                       
                         <div class="col-md-4">
				         	<div class="form-group">
				            	<label class="control-label chairPerson">Proxy Member Secretary</label>
				    				
				  					<select class=" form-control selectdee mt-n5" id="proxysecretary" name="proxysecretary">
										<option  selected value="0">Choose...</option>
										<%	for (Object[] obj  : EmployeeList) {%>
									     	<option value="<%=obj[0]%>" ><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - "%>, <%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - " %> </option>
										<% } %>
									</select>			  		
				        	</div>
				     	</div>         
	                 
	                 		<div class="col-md-4">
				         	<div class="form-group">
				            	<label class="control-label chairPerson">Formation Date</label>
				  				<input  class="form-control mb-n10 mt-n5"  data-date-format="dd/mm/yyyy" id="Formationdate" name="Formationdates">
				        	</div>
				        </div>
	                 
	                 
                	</div>
                	
                	<div class="row">
                		
                		 <div class="col-md-4">
				         	<div class="form-group">
				            	<label class="control-label chairPerson">Representatives </label>
				    				
				  					<select class="form-control selectdee mt-n5" id="repids" name="repids" data-placeholder="Select Rep Types" multiple="multiple" >
										<option  disabled="disabled" value="0">Choose...</option>
										<%	for (Object[] obj  : committeereplist) {%>
									     	<option value="<%=obj[0]%>" ><%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - "%>  </option>
										<% } %>
									</select>			  					
				        	</div>
				     	</div> 
                		
                		<div class="col-md-4">
				         	<div class="form-group">
				            	<label class="control-label chairPerson">Is Pre-Approved<span class="mandatory text-danger">*</span></label>
				  				<select class="form-control selectdee mt-n5"  name="preApproved">
									<option   value="Y" selected >Yes</option>
									<option   value="N">No</option>
								</select>			  					
				        	</div>
				        </div>
				        <div class="col-md-4">
				         	<div class="form-group">
				            	<label class="control-label chairPerson">Reference No.</label>
				  				 <input type="text" class="form-control" name="refNo">					
				        	</div>
				        </div>
                	
                	</div>
                
                	</div>
				       <div class="form-group" align="center">
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							<%if(Long.parseLong(projectid)>0){ %>
								<input type="hidden" name="id" value="P">
							<%}else{ %>
								<input type="hidden" name="id" value="N">
							<%} %>	
				 			<button type="submit" class="btn btn-primary btn-sm submit " onclick="Add('myfrm')" >SUBMIT</button>
				 			<button type="button" class="btn btn-primary btn-sm back" onclick="submitForm('backfrm');">BACK</button>	
				       </div>
			      </form> 
	    				
	    				<%if(Long.parseLong(divisionid)==0 && Long.parseLong(projectid)==0 && Long.parseLong(initiationid)==0 && Long.parseLong(carsInitiationId)==0){ %>
							<form method="post" action="CommitteeList.htm" name="backfrm" id="backfrm">
									<input type="hidden" name="projectid" value="<%=projectid %>">
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />									
									<input type="hidden" name="projectappliacble" value="N">
							</form>		
						<%}else if(Long.parseLong(projectid)>0){ %>
							<form method="post" action="ProjectMaster.htm" name="backfrm" id="backfrm">
								<input type="hidden" name="projectid" value="<%=projectid %>">
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
								<input type="hidden" name="projectappliacble" value="P">
							</form>	
						<%} else if( Long.parseLong(divisionid)>0){ %>
							<form method="post" action="DivisionCommitteeMaster.htm" name="backfrm" id="backfrm">
								<input type="hidden" name="divisionid" value="<%=divisionid %>">
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />									
							</form>		
						<%} else if( Long.parseLong(initiationid)>0){ %>
							<form method="post" action="InitiationCommitteeMaster.htm" name="backfrm" id="backfrm">
								<input type="hidden" name="initiationid" value="<%=initiationid %>">
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />									
							</form>		
						<%} else if(Long.parseLong(carsInitiationId)>0){ %>
							<form method="post" action="CARSInitiationList.htm" name="backfrm" id="backfrm">
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />									
							</form>		
						<%} %>
									
     		</div>   <!-- card-body end -->
        

			<div class="card-footer footerBg"></div>
			
        	</div>
		</div>
	</div>
</div>
</body>



<script type="text/javascript">

 $(document).ready(function(){	
	 
	 ChaippersonEmpList();
	 msEmpList();
	 ccpEmpList();
}); 	
 
 
 
 
		function ChaippersonEmpList(){
		
			$('#chairperson').val("");
			
				var $LabCode = $('#CpLabCode').val();
						if($LabCode!=""){
				
									$.ajax({
		
										type : "GET",
										url : "ChairpersonEmployeeListFormation.htm",
										data : {
											CpLabCode : $LabCode,
											committeemainid : '0'
											   },
										datatype : 'json',
										success : function(result) {
		
										var result = JSON.parse(result);
								
										var values = Object.keys(result).map(function(e) {
									 				 return result[e]
									  
														});
								
											var s = '';
											s += '<option value="">Choose ...</option>';
											if($LabCode == '@EXP'){
												
											}
											for (i = 0; i < values.length; i++) 
											{
												
												s += '<option value="'+values[i][0]+'">'+values[i][1] + ', ' +values[i][3]+ '</option>';
											} 
											 
											$('#chairperson').html(s);
											
											
											
											
										}
									});
		
		}
	}
		
	function ccpEmpList(){
		$('#cochairperson').val("");
		
		var $LabCode = $('#ccplabocode').val();
				if($LabCode!=""){
		
							$.ajax({

								type : "GET",
								url : "ChairpersonEmployeeListFormation.htm",
								data : {
									CpLabCode : $LabCode,
									committeemainid : '0'
									   },
								datatype : 'json',
								success : function(result) {

								var result = JSON.parse(result);
						
								var values = Object.keys(result).map(function(e) {
							 				 return result[e]
							  
												});
						
									var s = '';
									s += '<option value="">Choose ...</option>';
									if($LabCode == '@EXP'){
										
									}
									for (i = 0; i < values.length; i++) 
									{
										
										s += '<option value="'+values[i][0]+'">'+values[i][1] + ', ' +values[i][3]+ '</option>';
									} 
									 
									$('#cochairperson').html(s);
									
									
									
									
								}
							});

}
	}
		
		function msEmpList(){
			$('#secretary').val("");
			
			var $LabCode = $('#msLabCode').val();
		
			console.log( $LabCode );
					if($LabCode!=""){
			
								$.ajax({
	
									type : "GET",
									url : "ChairpersonEmployeeListFormation.htm",
									data : {
										CpLabCode : $LabCode,
										committeemainid : '0'
										   },
									datatype : 'json',
									success : function(result) {
	
									var result = JSON.parse(result);
							
									var values = Object.keys(result).map(function(e) {
								 				 return result[e]
								  
													});
							
										var s = '';
										s += '<option value="">Choose ...</option>';
										if($LabCode == '@EXP'){
											
										}
										for (i = 0; i < values.length; i++) 
										{
											
											s += '<option value="'+values[i][0]+'">'+values[i][1] + ', ' +values[i][3]+ '</option>';
										} 
										 
										$('#secretary').html(s);
									}
								});
	}}
		

</script>

  
<script type='text/javascript'> 


/* $('.items').select2(); */
function submitForm(frmid)
{ 
  document.getElementById(frmid).submit(); 
} 
 
function Add(myfrm){

    
    var fieldvalues = $("select[name='Member']").map(function(){return $(this).val();}).get();
    
    var $chairperson = $("#chairperson").val();
    var $cplabCode = $('#CpLabCode').val();
    var $LabCode = '<%=LabCode%>';
    var msLabCode=$('#msLabCode').val();
    
    var $cochairperson = $("#cochairperson").val();
    var $secretary = $("#secretary").val();
    var $proxysecretary=$("#proxysecretary").val();
	var $ccplabocode = $('#ccplabocode').val();
    
 
    
    
    if( $LabCode === $cplabCode)
    {
    	if($cplabCode===msLabCode){
		if($chairperson==$secretary){
			 alert("Chairperson and Member Secretary Should Not Be The Same Person ");	   
			 event.preventDefault();
				return false;
		}
    	}
    	if($cplabCode===$ccplabocode){
		if($cochairperson == $chairperson)
		{
			alert("Chairperson and Co-Chairperson Should Not Be The Same Person ");	   
			 event.preventDefault();
				return false;
		}
    	}
		
		
		if($proxysecretary==$chairperson)
		{
			alert("Chairperson and Proxy Member Secretary Should Not Be The Same Person ");	   
			 event.preventDefault();
				return false;
		}
	}
    
    if(msLabCode===$LabCode){
    	if($msLabCode===$ccplabocode){
    if($secretary==$cochairperson)
	{
		alert("Member Secretary and Co-Chairperson Should Not Be The Same Person ");	   
		 event.preventDefault();
			return false;
	}
    	}
	if($secretary == $proxysecretary)
	{
		alert("Member Secretary and Proxy Member Secretary Should Not Be The Same Person ");	   
		 event.preventDefault();
			return false;
	}
    
	/* if($cochairperson!=='0' && $proxysecretary!=='0' && $cochairperson == $proxysecretary)
	{
		alert("Co-Chairperson and Proxy Member Secretary Should Not Be The Same Person ");	   
		 event.preventDefault();
			return false;
	} */
    }
	
    for (var i = 0; i < fieldvalues.length; i++) {
    	
    	if($chairperson==fieldvalues[i]){
    		 alert("Chairperson Should Not Be A Member ");	   
    		 event.preventDefault();
    			return false;
    	}
    	
    	if($secretary==fieldvalues[i]){
   		 alert("Member Secretary Should Not Be A Member ");	   
   		 event.preventDefault();
   			return false;
 	  	}
    	
    	if($proxysecretary==fieldvalues[i]){
      		 alert("Proxy Member Secretary Should Not Be A Member ");	   
      		 event.preventDefault();
      			return false;
    	  	}
    	
   } 
    
 
    
    var ret= confirm('Are you Sure to Constitute this Committee?');
	if(ret){
		/*  $("#"+myfrm).submit(); */
		return true;
	}else{
		event.preventDefault();
	}

  return true;
}

 
 
 
 
$('#startdate').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	/* "minDate" :new Date(), */
	"startDate" : new Date(),

	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});

$('#Formationdate').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	/* "minDate" :new Date(), */
	"startDate" : new Date(),

	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});



var aYearFromNow = new Date();
aYearFromNow.setFullYear(aYearFromNow.getFullYear() + 1);
 
$('#enddate').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	/* "minDate" :new Date(), */
	"startDate" :aYearFromNow,

	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});
 
 
$('#startdate').change(function () {
    var startDate = document.getElementById("startdate").value;

   var dateMomentObject = moment(startDate, "DD-MM-YYYY"); // 1st argument - string, 2nd argument - format
   var dateObject = dateMomentObject.toDate();
  
   var newdateMomentObject =moment(startDate, "DD-MM-YYYY");
   
   var newdateObject = newdateMomentObject.toDate();
    newdateObject = newdateObject.setFullYear(newdateObject.getFullYear() + 1)

});
 

</script>




</html>