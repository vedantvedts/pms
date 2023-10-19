

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
<title>RFA Forward List</title>
<style type="text/css">
#button {
   float: left;
   width: 80%;
   padding: 5px;
   background: #dcdfe3;
   color: black;
   font-size: 17px;
   border:none;
   border-left: none;
   cursor: pointer;
}


body{

   overflow-x: hidden; 
    overflow-y: hidden; 

}
.returnLabel{
font-weight: bolder;
}

</style>
</head>
<body>
<%	
	
FormatConverter fc=new FormatConverter(); 
SimpleDateFormat sdf=fc.getRegularDateFormat();
SimpleDateFormat sdf1=fc.getSqlDateFormat();

SimpleDateFormat sdf2=new SimpleDateFormat("dd-MM-yyyy");
SimpleDateFormat sdf3=new SimpleDateFormat("yyyy-MM-dd");
	
List<Object[]> RfaForwardList=(List<Object[]>) request.getAttribute("RfaForwardList");
List<Object[]> RfaForwardApprovedList=(List<Object[]>) request.getAttribute("RfaForwardApprovedList");
String EmpId=(String)request.getAttribute("EmpId");
String rfaCount=(String) request.getAttribute("rfaCount");
List<String> toAssigneRevokeStatus  = Arrays.asList("AF","AC","RFA");
	 
	 
%>


<div class="card-header page-top ">
	<div class="row">
		<div class="col-md-8">
			<h5>RFA Forward List </h5>
		</div>
			
		</div>
</div>	

  <%	
    String ses=(String)request.getParameter("result"); 
 	String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null){ %>
	
	<div align="center">
		<div class="alert alert-danger" role="alert">
        	<%=ses1 %>
        </div>
   	</div>
	<%}if(ses!=null){ %>
	<div align="center">
		<div class="alert alert-success" role="alert" >
        	<%=ses %>
        </div>
    </div>
	<%} %>
<br>
  	
  	<div class="page card dashboard-card">
 <div class="card-body" >	
   <div align="center">	
  
	<div class="row w-100" style="margin-bottom: 10px;">
		<div class="col-12">
         <ul class="nav nav-pills mb-3" id="pills-tab" role="tablist" style="background-color: #E1E5E8;padding:0px;">
		  <li class="nav-item" style="width: 50%;"  >
		    <div class="nav-link active" style="text-align: center;" id="pills-mov-property-tab" data-toggle="pill" data-target="#pills-mov-property" role="tab" aria-controls="pills-mov-property" aria-selected="true">
			   <span>Pending</span> 
				<span class="badge badge-danger badge-counter count-badge" style="margin-left: 0px;">
				   		 <%if(RfaForwardList.size()>99){ %>
				   			99+
				   		<%}else{ %>
				   			<%=RfaForwardList.size() %>
						<%} %>			   			
				  </span>  
		    </div>
		  </li>
		  <li class="nav-item"  style="width: 50%;">
		    <div class="nav-link " style="text-align: center;" id="pills-imm-property-tab" data-toggle="pill" data-target="#pills-imm-property" role="tab" aria-controls="pills-imm-property" aria-selected="false">
		    	 <span>Approved</span> 
		    	  <span class="badge badge-danger badge-counter count-badge" style="margin-left: 0px;">
				   		 <%if(RfaForwardApprovedList.size()>99){ %>
				   			99+
				   		<%}else{ %>
				   			<%=RfaForwardApprovedList.size() %>
						<%} %>			   			
				  </span>  
		    </div>
		  </li>
		</ul>
	   </div>
	</div>
	</div>
	
	
	
	<div class="card">					
		<div class="card-body">
		<div class="container-fluid" >
           <div class="tab-content" id="pills-tabContent">
            <div class="tab-pane fade show active" id="pills-mov-property" role="tabpanel" aria-labelledby="pills-mov-property-tab">
		    <form action="#" method="POST" id="">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
             <div class="table-responsive">
              <table class="table table-hover  table-striped table-condensed table-bordered table-fixed" id="myTable1">
				<thead>
										<tr>
											<th>Select</th>
											<th>RFA No</th>
											<th>RFA Date</th>
											<th>Project</th>
											<th>Priority</th>
											<th>Forwarded By</th>
											<th>Action</th>
										</tr>
									</thead>
									<tbody>
									
										<%if(RfaForwardList!=null){
										int count=0;
										for(Object[] obj:RfaForwardList) {%>
										<tr>
											<td style="text-align: center;"><%=++count%></td>
											<td><%=obj[3] %></td>
											<td style="text-align: center;"><%=sdf.format(obj[4])%></td>
											<td style="text-align: center;"><%=obj[2] %></td>
											<td style="text-align: center;"><%=obj[5] %></td>
											<td><%=obj[11] %></td>
											<td class="left width" style="text-align: center;">

												<button class="editable-click bg-transparent"
													formaction="RfaActionPrint.htm" formmethod="get"
													formnovalidate="formnovalidate" name="rfaid"
													value="<%=obj[0] %>/<%=obj[3] %>"
													formtarget="_blank">
													<div class="cc-rockmenu">
														<div class="rolling">
															<figure class="rolling_icon">
																<img src="view/images/preview3.png">
															</figure>
														</div>

													</div>

												</button> <input type="hidden" /> <input type="hidden"
												name="${_csrf.parameterName}" value="${_csrf.token}" /> <input
												type="hidden" name="projectid"
												value="<%=obj[12].toString() %>"> <input
												type="hidden" name="RfaStatus"
												value="<%=obj[10].toString()%>">
											<%%>
												<button class="editable-click"
													style="background-color: transparent;"
													formaction="RfaActionForward.htm" formmethod="POST"
													formnovalidate="formnovalidate" name="rfa"
													value="<%=obj[0]%>"
													onclick="return confirm('Are You Sure To Forward this RFA ?');">
													<div class="cc-rockmenu">
														<figure class="rolling_icon">
															<img src="view/images/forward1.png">
														</figure>
													</div>
												</button>
											
												 <input type="hidden" name="${_csrf.parameterName}"
												value="${_csrf.token}" /> 
											
												 <%if(toAssigneRevokeStatus.contains(obj[10])){%> 
												<button class="editable-click" name="sub" type="button"
													value="" style="background-color: transparent;"
													formaction="#" formmethod="POST"
													formnovalidate="formnovalidate" name="rfa"
													value="<%=obj[0]%>" id="rfaReturnBtn"
													onclick="return returnRfa(<%=obj[0]%>,'<%=obj[10]%>','<%=obj[14]%>');">
														<i class="fa fa-backward" aria-hidden="true" style="color: red; font-size: 24px; position: relative; top: 5px;"></i>
												</button> 
												 <%} %> 
											</td>
										</tr>
										<%}} %>
									</tbody>
   
            </table>
          </div>
          <input type="hidden" name="isApproval" value="Y">
         </form>
				
			  </div>
 
	<!---------------------------------------------- Approved List ----------------------------------------------------->	
	
		<div class="tab-pane fade" id="pills-imm-property" role="tabpanel" aria-labelledby="pills-imm-property-tab">
		
			    <form action="#" method="POST" id="">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
             <div class="table-responsive">
              <table class="table table-hover  table-striped table-condensed table-bordered table-fixed" id="myTable2">
				<thead>
										<tr>
											<th>Select</th>
											<th>RFA No</th>
											<th>RFA Date</th>
											<th>Project</th>
											<th>Priority</th>
											<th>Forwarded By</th>
											<th>Action</th>
										</tr>
									</thead>
									<tbody>
									
										<%if(RfaForwardApprovedList!=null){
										int count=0;
										for(Object[] obj:RfaForwardApprovedList) {%>
										<tr>
											<td style="text-align: center;"><%=++count%></td>
											<td><%=obj[3] %></td>
											<td style="text-align: center;"><%=sdf.format(obj[4])%></td>
											<td style="text-align: center;"><%=obj[2] %></td>
											<td style="text-align: center;"><%=obj[5] %></td>
											<td><%=obj[11] %></td>
											<td class="left width" style="text-align: center;">

												<button class="editable-click bg-transparent"
													formaction="RfaActionPrint.htm" formmethod="get"
													formnovalidate="formnovalidate" name="rfaid"
													value="<%=obj[0]%>/<%=obj[3]%>"
													formtarget="_blank">
													<div class="cc-rockmenu">
														<div class="rolling">
															<figure class="rolling_icon">
																<img src="view/images/preview3.png">
															</figure>
														</div>

													</div>

												</button> <input type="hidden" /> <input type="hidden"
												name="${_csrf.parameterName}" value="${_csrf.token}" /> <input
												type="hidden" name="projectid"
												value="<%=obj[12].toString() %>"> <input
												type="hidden" name="RfaStatus"
												value="<%=obj[10].toString()%>">
											
												 <input type="hidden" name="${_csrf.parameterName}"
												value="${_csrf.token}" /> 
									
											
											</td>
										</tr>
										<%}} %>
									</tbody>
   
            </table>
          </div>
          <input type="hidden" name="isApproval" value="Y">
         </form>
               </div>
               </div>
               </div>				
			  </div>
		   </div>
		</div>
     </div>

 	<!-- -- ******************************************************************Assign  Model Start ***********************************************************************************-->
 		<form class="form-horizontal" role="form"
			action="#" method="POST" id="myform1" autocomplete="off">
			<div class="modal fade bd-example-modal-lg" id="rfamodal"
				tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
				aria-hidden="true">
				<div class="modal-dialog modal-lg">
					<div class="modal-content addreq" style="width: 120%;">
						<div class="modal-header" id="modalreqheader">
							<h5 class="modal-title" id="exampleModalLabel">RFA Add</h5>
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close" style="color: white">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div style="height: 550px; overflow: auto;">
							<div class="modal-body">
							
								<div class="col-md-12">
									<div class="row">
										<div class="col-md-5">
											<label style="font-size: 17px; margin-top: 5%; margin-left: 4%; color: #07689f; font-weight: bold;" >RFA No. </label>
				                            <label><input type="text" class="form-control" name="RfaNo" id="RfaNo" readonly="readonly"></label>
										</div>
										
										<div class="col-md-7">
											<label style="font-size: 17px; margin-top: 4%; margin-left: 5%; color: #07689f; font-weight: bold;" >Date of Completion : </label><span class="mandatory" style="color: red;">*</span>
				                            <label><input type="text"  id="fdate" name="fdate" value=""class="form-control"></label>
										</div>
										</div>
									</div>
                                 
									<div class=col-md-12>
										<div class="row">
											<div class="col-md-5">
												<label style="font-size: 17px; margin-top: 5%; color: #07689f; margin-left: 0.1rem; font-weight: bold;">Visual Inspection and Observation<span class="mandatory" style="color: red;">*</span></label>
											</div>
											<div class="col-md-7" style="margin-top: 10px">
												<div class="form-group">
													<input type="text" name="observation" class="form-control"
														id="observation" maxlength="255" required="required"
														placeholder="Maximum 250 Chararcters"
														style="line-height: 4rem !important">
												</div>
											</div>
										</div>
									</div>
									
									<div class=col-md-12>
										<div class="row">
											<div class="col-md-6">
												<label style="margin: 0px; font-size: 17px; color: #07689f; font-weight: bold;">Clarification <span class="mandatory" style="color: red;">*</span></label>
											</div>
										</div>
									</div>
									<div class="col-md-12">
										<div class="row">
											<div class="col-md-12" id="textarea" >
												<div class="form-group">
													<textarea required="required" name="clarification"
														class="form-control" maxlength="1000" id="clarification"
														rows="5" cols="53" placeholder="Maximum 1000 Chararcters"></textarea>
												</div>
											</div>
										</div>
									</div>
									
									<div class=col-md-12>
										<div class="row">
											<div class="col-md-3">
												<label style="font-size: 18px; margin-top: 5%; color: #07689f; margin-left: 0.1rem ; font-weight: bold;">Action Required<span class="mandatory" style="color: red;">*</span></label>
											</div>
											<div class="col-md-8" style="margin-top: 10px">
												<div class="form-group" style="width: 113%">
													<input type="text" class="form-control" name="Rfaaction"
														id="action" maxlength="255" required="required"
														placeholder="Maximum 250 Chararcters"
														style="line-height: 3rem !important">
												</div>
											</div>
										</div>
									</div>
									

									<input type="hidden" name="rfaid" id="rfaidvalue"
										value="" />
									<div class="form-group" align="center" style="margin-top: 3%;">
										<input type="hidden" name="${_csrf.parameterName}"
											value="${_csrf.token}" />
										<span id="btnsub"><button type="button" id="assignSubBtn" class="btn btn-primary btn-sm submit" id="submit" formaction="RfaAssignFormSubmit.htm"  value="SUBMIT" onclick="return assignSub()">SUBMIT</button></span>
									</div>
	
							</div>
						</div>
					</div>

				</div>
			</div>
		</form>
		
		<!-- -- ******************************************************************Assign  Model End ***********************************************************************************-->
<form class="form-horizontal" role="form"
			action="#" method="POST" id="returnFrm" autocomplete="off">
			<div class="modal fade bd-example-modal-lg" id="rfaReturnmodal"
				tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
				aria-hidden="true">
				<div class="modal-dialog modal-lg">
					<div class="modal-content addreq" style="width: 150%; position: relative; right: 200px;" >
						<div class="modal-header" id="modalreqheader" style="background-color: #021B79">
							<h5 class="modal-title" id="exampleModalLabel" style="color: #fff">RFA Return</h5>
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close" style="color: white">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div style="height: 530px; overflow: auto;">
							<div class="modal-body">
							<div class="row" style="" id="mainrow">
		<div class="col-md-12">
 			
		
        
        		
            <div class="row">
		                    <div class="col-md-2">
		                        <div class="form-group">
		                            <label class="control-label returnLabel">Project</label>
		                           
			                         <%--    <select class="form-control selectdee " id="ProjectProgramme"  name="projectid" >
										    <option disabled="true"  selected value="">Select...</option>
										     <% for (Object[] obj : ProjectList) {%>
											<option value="<%=obj[0]%>"><%=obj[4]%></option>
											<%} %>
			  							</select> --%>
			  							<input  class="form-control"   id="ProjectProgramme" name="ProjectProgramme"  readonly="readonly"  style="width: 80%;"  >	
			  							
		                        </div>
		                    </div>

		                    <div class="col-md-3">
		                        <div class="form-group">
		                            <label class="control-label returnLabel">Priority</label>
		                           
		                           <%--  	<select class="custom-select"  required="required"name="priority" id="priority" >
										    <option disabled="true"  selected value="">Choose...</option>
											 <% for (Object[] obj : PriorityList) {%>
											<option value="<%=obj[0]%>"><%= "(" + obj[0] + ")" + obj[1]%></option>
											<%} %>
		  								</select> --%>
		  								<input  class="form-control"   id="priority" name="priority"  readonly="readonly"  style="width: 80%;" >	
		                        </div>
		                    </div>
		                    
		                    <div class="col-md-3">
		                        <div class="form-group">
		                            <label class="control-label returnLabel">Date</label>
		                          
						  			<input  class="form-control"   id="datepicker1" name="rfadate" readonly="readonly"   style="width: 80%;" >						
		                        </div>
		                    </div>
		                    
		                  <div class="col-md-4">
		                     <div class="form-group">
		                            <label class="control-label returnLabel">Assigned To</label>
		                       
		                    <%--   <select class="form-control selectdee" required="required" name="assignee" id="assignee">
		                         <option disabled="disabled" selected value="" >Choose...</option>                            
		                         <% for(Object[] obj : EmployeeList) { %>
		                         <option value=<%=obj[0]%>><%=obj[1]%> , <%=obj[2] %></option>
		                         <%} %>
		                      </select> --%>
		                      <input  class="form-control"   id="assignee" name="assignee"   readonly="readonly" style="width: 80%;" >	
		                  </div>
		            </div> 
		            
		          </div>
		      
		            <div class="row">
		                  <div class="col-md-3" style="max-width: 18%">
		                      <label class="control-label returnLabel"> Problem Satement</label>
		                    
		                  </div>
		                  <div class="col-md-10" style="max-width: 82%">
		                      <textarea class="form-control" rows="1" cols="30" readonly="readonly"  name="statement" id="statement" maxlength="200"></textarea>
		                  </div>
		            </div>
		            
		            <br>
		            
		            <div class="row">
		                  <div class="col-md-3" style="max-width: 18%">
		                      <label class="control-label returnLabel">Description</label>
		                    
		                  </div>
		                  <div class="col-md-10" style="max-width: 82%">
		                      <textarea class="form-control" rows="3" cols="30" readonly="readonly"  name="description" id="description" maxlength="500"></textarea>
		                  </div>
		            </div>
		            
		            <br>
		            
		            <div class="row">
		                  <div class="col-md-3" style="max-width: 18%">
		                      <label class="control-label returnLabel">References</label>
		                     
		                  </div>
		                  <div class="col-md-10" style="max-width: 82%">
		                      <input class="form-control"  readonly="readonly" name="reference" id="reference" maxlength="100">
		                  </div>
		            </div><br>
		                <div class="row">
		                  <div class="col-md-3" style="max-width: 18%">
		                      <label class="control-label returnLabel">Reply</label>
		                      <span class="mandatory" style="color: #cd0a0a;">*</span>
		                    
		                  </div>
		                  <div class="col-md-10" style="max-width: 82%">
		                      <textarea class="form-control" rows="3" cols="30" placeholder="Max 500 Characters" name="replyMsg" id="replyMsg" maxlength="500"></textarea>
		                  </div>
		            </div>
		           
		             <br>
		            
		        <div class="form-group" align="center" >
					<span id="btnsub"><button type="button" id="returnSubBtn" class="btn btn-primary btn-sm submit" id="submit" formaction="RfaActionReturnList.htm"  value="SUBMIT" onclick="return returnSub()">SUBMIT</button></span>
				</div>

				<input type="hidden" name="${_csrf.parameterName}"		value="${_csrf.token}" /> 
 		<input type="hidden" name="rfa" id="rfaHidden">
 		<input type="hidden" name="RfaStatus" id="RfaStatusHidden">
 		<input type="hidden" name="userId" id="userIdHidden">
    
        

        
        
	</div>
</div>
	
							</div>
						</div>
					</div>

				</div>
				</div>
		
		</form>

<script>

$("#myTable1,#myTable2").DataTable({
    "lengthMenu": [ 5,10,20,50,75,100],
    "pagingType": "simple"
    	
});

$(document).ready(function(){
	  $("#myTable").DataTable({
	 "lengthMenu": [  5,10,25, 50, 75, 100 ],
	 "pagingType": "simple"
	
});
});


$('#fdate').daterangepicker({
	
	"singleDatePicker": true,
	"showDropdowns": true,
	"cancelClass": "btn-default",
	/* "minDate":new Date(), */
	"startDate":new Date(), 
	locale: {
  	format: 'DD-MM-YYYY'
		}
});

function showModel(RfaNo,rfaId) {
	  document.getElementById('RfaNo').value=RfaNo;
	  document.getElementById('rfaidvalue').value=rfaId;
	  $('#rfamodal').modal('show');
	 
}
function showdata(a,b){
	console.log(a+ " "+b);
	document.getElementById('RfaNo').value=b;
	document.getElementById('rfaidvalue').value=a;
	
	$.ajax({
		
		type:'GET',
		url:'RfaAssignAjax.htm',
		datatype:'json',
		data:{
			rfaId:a,
		},
		success:function(result){
			var ajaxresult = JSON.parse(result);
			console.log(result)
			  const date = new Date(ajaxresult[4]);
						   const formattedDate = date.toLocaleDateString('en-GB', {
                        day: '2-digit',
                        month: '2-digit',
                        year: 'numeric',
                        }).replace(/\//g, '-');
						   console.log(formattedDate)
			$('#fdate').val(formattedDate);
			$('#clarification').val(ajaxresult[6]);
			$('#observation').val(ajaxresult[5]);
			$('#action').val(ajaxresult[7]);
		}
	})
	 
  $('#rfamodal').modal('show');
}
function submitform(){
	if(!confirm("Are you sure to Update")){
		
		event.preventDefault();
		return false;
	}else{
		
		$('#myform1').submit();
		return true;
	}
}

function assignSub() {
	
	  var observation=$('#observation').val();
	  var clarification=$('#clarification').val();
	  var action=$('#action').val();
	  
		if(observation==""||observation==null ||observation=="null" ){
			   alert('Please Enter observation');
			   return false;
		   }else if(clarification==""||clarification==null || clarification=="null"){
				 alert('Please Enter clarification');
				   return false;
		   }else if(action==""||action==null || action=="null"){
				 alert('Please Enter action');
				   return false;
		   }
	  var confirmation = confirm('Are you sure you want to add the Assign/Update Details?');
	  if(confirmation){
		  var form = document.getElementById("myform1");
		   
        if (form) {
         var assignSubBtn = document.getElementById("assignSubBtn");
            if (assignSubBtn) {
                var formactionValue = assignSubBtn.getAttribute("formaction");
                
                 form.setAttribute("action", formactionValue);
                  form.submit();
              }
         }
	  } else{
  	  return false;
	  }
	
}
$('#observation,#clarification,#action').keyup(function (){
	  $('#observation,#clarification,#action').css({'-webkit-box-shadow' : 'none', '-moz-box-shadow' : 'none','background-color' : 'none', 'box-shadow' : 'none'});
		  });

function returnRfa(rfaId,rfaStatus,userId) {
	$('#rfaReturnmodal').modal('show');
	$('#rfaHidden').val(rfaId);
	$('#RfaStatusHidden').val(rfaStatus);
	$('#userIdHidden').val(userId);
	
	$.ajax({
		
		type:'GET',
		url:'getRfaAddData.htm',
		datatype:'json',
		data:{
			rfaId:rfaId,
		},
		success:function(result){
			var ajaxresult = JSON.parse(result);
			  const date = new Date(ajaxresult[2]);
						   const formattedDate = date.toLocaleDateString('en-GB', {
                        day: '2-digit',
                        month: '2-digit',
                        year: 'numeric',
                        }).replace(/\//g, '-');
						   
						   $('#ProjectProgramme').val(ajaxresult[0]);
						   $('#priority').val(ajaxresult[1]);
						   $('#datepicker1').val(formattedDate);
						   $('#assignee').val(ajaxresult[3]);
						   $('#statement').val(ajaxresult[4]);
						   $('#description').val(ajaxresult[5]);
						   $('#reference').val(ajaxresult[6]);
		}
	})
	  
}

function returnSub() {
	var reply=$('#replyMsg').val();
	if(reply==null || reply=="" || reply=="null"){
		alert("Please enter Reply");
		document.getElementById("replyMsg").style.boxShadow = "rgb(239, 7, 7) 0px 0px 1px 1px";
		return false;
	}else{
	
	 var confirmation = confirm('Are You Sure To Return this RFA ?');
	  if(confirmation){
		  var form = document.getElementById("returnFrm");
		   
	       if (form) {
	        var returnSubBtn = document.getElementById("returnSubBtn");
	           if (returnSubBtn) {
	               var formactionValue = returnSubBtn.getAttribute("formaction");
	               
	                form.setAttribute("action", formactionValue);
	                 form.submit();
	             }
	        }
	
	  } else{
	  return false;
	  }
	}
}
$('#replyMsg').keyup(function (){
	  $('#replyMsg').css({'-webkit-box-shadow' : 'none', '-moz-box-shadow' : 'none','background-color' : 'none', 'box-shadow' : 'none'});
		  });

<%-- 	<%if(tab!=null && tab.equals("closed")){%>
	
		$('#pills-imm-property-tab').click();
	
	<%}%>
	
	$('#fromdate').daterangepicker({
		"singleDatePicker" : true,
		"linkedCalendars" : false,
		"showCustomRangeLabel" : true,
		/* "minDate" :datearray,   */
		 "startDate" : new Date('<%=fromdate%>'), 
		"cancelClass" : "btn-default",
		showDropdowns : true,
		locale : {
			format : 'DD-MM-YYYY'
		}
	});
		
		
		$('#todate').daterangepicker({
			"singleDatePicker" : true,
			"linkedCalendars" : false,
			"showCustomRangeLabel" : true,
			"startDate" : new Date('<%=todate%>'), 
			"minDate" :$("#fromdate").val(),  
			"cancelClass" : "btn-default",
			showDropdowns : true,
			locale : {
				format : 'DD-MM-YYYY'
			}
		});

		 $(document).ready(function(){
			   $('#fromdate, #todate').change(function(){
			       $('#myform').submit();
			    });
			});  --%>
	
	
	
	
 </script>

</body>


</html>