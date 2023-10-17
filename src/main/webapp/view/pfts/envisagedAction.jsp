<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.io.ByteArrayOutputStream,java.io.ObjectOutputStream"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

<title>Envisaged Action Add</title>

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

String projectId=(String)request.getAttribute("projectId");
String itemN=(String)request.getAttribute("itemN");
FormatConverter fc=new FormatConverter(); 
SimpleDateFormat sdf=fc.getRegularDateFormat();
String estimatedCost=(String)request.getAttribute("estimatedCost");

String PDOfInitiation=(String)request.getAttribute("PDOfInitiation");
String status=(String)request.getAttribute("status");
String remarks=(String)request.getAttribute("remarks");
String fileId=(String)request.getAttribute("fileId");
String value=(String)request.getAttribute("value");

%>



<div class="container" >
	<form action="#" method="POST" name="myfrm" id="myfrm" autocomplete="off">
	
	<div class="row" style="" id="mainrow">
		<div class="col-md-12" >
 			<div class="card shadow-nohover" style="margin-top: 10px">		
				<div class="row card-header">
			   			<div class="col-md-6">
							<h4>ENVISAGED ADD</h4>
						</div>
						<div class="col-md-3">
							
						</div>						
						
					 </div>
        
        		<div class="card-body">

		      
		            <div class="row">
		                  <div class="col-md-3" style="max-width: 25%">
		                      <label class="control-label">Item Nomenclature
		                      <span class="mandatory" style="color: #cd0a0a;">*</span></label>
		                  </div>
		                  <div class="col-md-10" style="max-width: 75%">
		                      <input class="form-control"  placeholder="Max 150 Characters" name="itemNomenclature" id="itemNomenclature" maxlength="150" type="text" <%if(itemN!=null){ %>value="<%=itemN %>" <%}%>>
		                  </div>
		                  </div><br>
		                  <div class="row">
		                    <div class="col-md-3" style="max-width: 25%">
		                      <label class="control-label">Estimated Cost
		                      <span class="mandatory" style="color: #cd0a0a;">*</span></label>
		                  </div>
		                  <div class="col-md-10" style="max-width: 75%">
		                      <input class="form-control"  placeholder="Max 13 Characters" name="estimatedCost" id="estimatedCost" type="number" onKeyPress="if(this.value.length==13) return false;" <%if(estimatedCost!=null){ %>value="<%=estimatedCost %>" <%} %>>
		                  </div>
		            </div>
		            
		            <br>
		            
		            <div class="row">
		                  <div class="col-md-3" style="max-width: 25%">
		                      <label class="control-label">Probable Date of Initiation
		                      <span class="mandatory" style="color: #cd0a0a;">*</span></label>
		                  </div>
		                  <div class="col-md-10" style="max-width: 75%">
		                    <input class="form-control"   name="intiDate" id="intiDate"  type="text" <%if(PDOfInitiation!=null){ %> value="<%=PDOfInitiation %>" <%} %>>
		                  </div>
		                  </div><br>
		 <%--                  <div class="row">
		                    <div class="col-md-3" style="max-width: 25%">
		                      <label class="control-label">Status
		                      <span class="mandatory" style="color: #cd0a0a;">*</span></label>
		                  </div>
		                  <div class="col-md-10" style="max-width: 75%">
		                    <input class="form-control"   name="status" id="status" placeholder="Max 50 Characters" maxlength="50"  type="text" <%if(status!=null){ %>value="<%=status %>" <%} %>>
		                  </div>
		            </div>
		            
		            <br> --%>
		            
		            <div class="row">
		                  <div class="col-md-3" style="max-width: 25%">
		                      <label class="control-label">Remarks
		                      <span class="mandatory" style="color: #cd0a0a;">*</span></label>
		                  </div>
		                  <div class="col-md-10" style="max-width: 75%">
		                   <textarea class="form-control" rows="2" cols="30" placeholder="Max 150 Characters" name="remarks" id="remarks" maxlength="150" ><%if(remarks!=null){ %> <%=remarks %> <%} %></textarea>
		                     <!--  <input class="form-control" placeholder="Max 100 Characters" name="reference" id="reference" maxlength="100"> -->
		                  </div>
		            </div>
		            
		           
		             <br>
		            
		        <div class="form-group" align="center" >
					 <input type="button" class="btn btn-primary btn-sm submit " onclick="return add()" value="SUBMIT" id="enviAddSubBtn" formaction="enviActionSubmit.htm" > 
					 <button type="button" class="btn btn-info btn-sm shadow-nohover back" id="back" onclick="backBtn()" formaction="ProcurementStatus.htm" > BACK </button>
				</div>

				<input type="hidden" name="${_csrf.parameterName}"		value="${_csrf.token}" /> 
 		
   </div>    
        

        
        </div>
	</div>
</div>
<input type="hidden" name="projectId" value="<%= projectId %>">
<input type="hidden" name="projectid" value="<%= projectId %>">
<input type="hidden" name="fileId" value="<%= fileId %>">
</form>
</div>
  
  
  <script type="text/javascript">
  
  function add() {
	  
	  var itemNomenclature=$('#itemNomenclature').val();
	  var estimatedCost=$('#estimatedCost').val();
	  /* var status=$('#status').val(); */
	  
	  var Value='<%=value%>';
	  console.log(Value);
	  var remarks=$('#remarks').val();
	  
		if(itemNomenclature==""||itemNomenclature==null ||itemNomenclature=="null" ){
			   alert('Please enter itemNomenclature');
			   document.getElementById("itemNomenclature").style.boxShadow = "rgb(239, 7, 7) 0px 0px 1px 1px";
			   return false;
		   }else if(estimatedCost==""||estimatedCost==null || estimatedCost=="null"){
				 alert('Please enter estimatedCost');
				 document.getElementById("estimatedCost").style.boxShadow = "rgb(239, 7, 7) 0px 0px 1px 1px";
				   return false;
		   }/* else if(status==""||status==null || status=="null"){
				 alert('Please enter status');
				 document.getElementById("status").style.boxShadow = "rgb(239, 7, 7) 0px 0px 1px 1px";
				   return false;
		   } */else if(remarks==""||remarks==null || remarks=="null"){
				 alert('Please Enter remarks');
				 document.getElementById("remarks").style.boxShadow = "rgb(239, 7, 7) 0px 0px 1px 1px";
				   return false;
		   }
		if(Value === "Add"){
	  var confirmation = confirm('Are you sure you want to add the Demand?');
		}else if(Value === "Edit"){
			 var confirmation = confirm('Are you sure you want to Edit the Demand?');
		}
	  if(confirmation){
		  var form = document.getElementById("myfrm");
		   
          if (form) {
           var enviAddSubBtn = document.getElementById("enviAddSubBtn");
              if (enviAddSubBtn) {
                  var formactionValue = enviAddSubBtn.getAttribute("formaction");
                  
                   form.setAttribute("action", formactionValue);
                    form.submit();
                }
           }
	  } else{
    	  return false;
	  }
	
}
  $('#itemNomenclature,#estimatedCost,#remarks').keyup(function (){
	  $('#itemNomenclature,#estimatedCost,#remarks').css({'-webkit-box-shadow' : 'none', '-moz-box-shadow' : 'none','background-color' : 'none', 'box-shadow' : 'none'});
		  });
	  
  

	
	$('#intiDate').daterangepicker({
		"singleDatePicker" : true,
		"linkedCalendars" : false,
		"showCustomRangeLabel" : true,
		"minDate" : new Date(),
		"cancelClass" : "btn-default",
		showDropdowns : true,
		locale : {
			format : 'DD-MM-YYYY'
		}
	});
	document.querySelector("#intiDate").addEventListener("keypress", function (evt) {
	    if (evt.which != 8 && evt.which != 0 && evt.which < 48 || evt.which > 57)
	    {
	        evt.preventDefault();
	    }
	});

	$('textarea').on("keypress",function (e) {
		if(e.which === 32 && !this.value.length){
			e.preventDefault();
		}
	});
$('input').on("keypress",function(e){
	if(e.which === 32 && !this.value.length){
		e.preventDefault();
	}
	
})
function backBtn() {
	  var form = document.getElementById("myfrm");
	   
      if (form) {
       var backBtn = document.getElementById("back");
          if (backBtn) {
              var formactionValue = backBtn.getAttribute("formaction");
              
               form.setAttribute("action", formactionValue);
                form.submit();
            }
       }
}

	</script> 
  
  
</body>
</html>