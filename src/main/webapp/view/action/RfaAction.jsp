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


<title>RFA Action</title>
<style type="text/css">

body{
background-color: #f2edfa;
overflow-x:hidden !important; 
}

p {
	text-align: justify;
	text-justify: inter-word;
}

th {
	border: 1px solid black;
	text-align: center;
	padding: 5px;
}

td {
	text-align: left;
	padding: 5px;
}

}
.textcenter {
	text-align: center;
}

.border {
	border: 1px solid black;
}

.textleft {
	text-align: left;
}

.nav-link {
	color: black;
	font-size: 18px;
}
#remarksTd1{
font-weight: bold;

color: #007bff;
}
#remarksDate{
color: black;
font-size: 13px;
}
#closeImg{
height: 25px;
width: 25px;
background-color: transparent;
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
		
List<Object[]> RfaActionList=(List<Object[]>) request.getAttribute("RfaActionList");
List<Object[]> ProjectList=(List<Object[]>)request.getAttribute("ProjectList");
String Project=(String)request.getAttribute("Project");
List<Object[]> EmployeeList=(List<Object[]>)request.getAttribute("EmployeeList");
String Employee=(String)request.getAttribute("Employee");
String EmpId=(String)request.getAttribute("EmpId");
String fdate=(String)request.getAttribute("fdate");
String tdate=(String)request.getAttribute("tdate");  
String LoginType=(String)request.getAttribute("LoginType");
String UserId=(String)request.getAttribute("UserId");
String Status = (String)request.getAttribute("Status");
List<String> toUserStatus  = Arrays.asList("AA","RC","RV","REV");


%>

	<%String ses=(String)request.getParameter("result"); 
 String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null){
	%>
	<center>
		<div class="alert alert-danger" role="alert">
			<%=ses1 %>
		</div>
	</center>
	<%}if(ses!=null){ %>
	<center>
		<div class="alert alert-success" role="alert">
			<%=ses %>
		</div>
	</center>
	<%} %>


	<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card shadow-nohover">
                 
                 <div class="card-header ">  

					<div class="row">
						<h5 class="col-md-2">RFA List</h5>  
							<div class="col-md-10" style="float: right; margin-top: -12px;">
					   			<form method="post" action="#" name="dateform" id="dateform">
					   				<table >
					   					<tr>
					   						<td >
					   							<label class="control-label" style="font-size: 17px; margin-bottom: .0rem;font-weight: 700;">Project: </label>
					   						</td>
					   						<td style=" padding-right: 50px">
                                                        <select class="form-control selectdee " name="Project" id="Project" required="required"  data-live-search="true"  >
                                                         <option value="A"  <%if(Project.equalsIgnoreCase("A")){%> selected="selected" <%}%>>ALL</option>	
                                                           <%
                                                           for(Object[] obj:ProjectList){ %>
														   <option value="<%=obj[0] %>" <%if(Project.equalsIgnoreCase(obj[0].toString())){ %> selected="selected" <%} %>><%=obj[4] %></option>	
														<%} %>
																</select>	        
											</td>
											
					   									   		
					   						<td >
					   							<label class="control-label" style="font-size: 17px; margin-bottom: .0rem;font-weight: 700;">From Date: </label>
					   						</td>
					   						<td style="padding-right: 20px">
					   							<input  class="form-control"  data-date-format="dd/mm/yyyy" id="fdate" name="fdate"  required="required"  value="<%=sdf.format(sdf1.parse(fdate))%>">
					   						</td>
					   						<td>
					   							<label class="control-label" style="font-size: 17px; margin-bottom: .0rem; font-weight: 700;">To Date: </label>
					   						</td>
					   						<td style=" padding-right: 20px">
					   							<input  class="form-control "  data-date-format="dd/mm/yyyy" id="tdate" name="tdate"  required="required"  value="<%= sdf2.format(sdf3.parse(tdate))%>">
					   						</td>
					   						<td >
					   							<label class="control-label" style="font-size: 17px; margin-bottom: .0rem;font-weight: 700;">RFA Status: </label>
					   						</td>
					   						<td style=" padding-right: 20px">
                                                <select class="form-control selectdee " name="Status" id="Status" required="required" >                                                     
											        <option value="A" <%if("A".equalsIgnoreCase(Status)){%>selected="selected" <%}%> >  All</option>	
											        <option value="O" <%if("O".equalsIgnoreCase(Status)){%>selected="selected" <%}%> >  Open</option>
											        <option value="C" <%if("C".equalsIgnoreCase(Status)){%>selected="selected" <%}%> > Close</option>
										        </select>	       
											</td>
					   						<td>
					   							
					   						</td>			
					   					</tr>   					   				
					   				</table>
					   				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
					   			</form>
		   					</div>
		   				</div>	   							

					</div>
                 
					<form action="#" method="post" id="myFrom" >
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
						<div class="card-body">
							<div class="table-responsive">
								<table
									class="table table-bordered table-hover table-striped table-condensed "
									id="myTable">
									<thead>
										<tr>
											<th style="width:2%;">SN</th>
											<th>RFA No</th>
											<th>RFA Date</th>
											<th>Project</th>
											<th>Priority</th>
											<th>Assigned To</th>
											<th>Action</th>
										</tr>
									</thead>
									<tbody>
									
										<%if(RfaActionList!=null){
										int i=0;
										for(Object[] obj:RfaActionList) { %>
										<tr>
											<td style="text-align: center;"><%=++i %> <input type="hidden" name="createdBy" value="<%= obj[11]%>"> </td>
											<td><%=obj[3] %></td>
											<td style="text-align: center;"><%=sdf.format(obj[4])%></td>
											<td style="text-align: center;"><%=obj[2] %></td>
											<td style="text-align: center;"><%=obj[5] %></td>
											<td><%=obj[10] %></td>
											<td class="left width">
												<button class="editable-click bg-transparent"
													formaction="RfaActionPrint.htm" formmethod="get"
													formnovalidate="formnovalidate" name="rfaid" value="<%=obj[0]%>/<%=obj[3] %>" 
													style="margin-left: 31%;" formtarget="_blank"   data-toggle="tooltip" data-placement="top"  data-original-title="VIEW DOCUMENT">
													<div class="cc-rockmenu">
														<div class="rolling">
															<figure class="rolling_icon">
																<img src="view/images/preview3.png">
															</figure>
														</div>
													
													</div>
		
												</button> 
			 			 <%if(obj[11].toString().equalsIgnoreCase(UserId)&& toUserStatus.contains(obj[14].toString()) ){ %>
			 			 <button class="btn bg-transparent" formaction="RfaActionEdit.htm" formmethod="post" type="submit" name="Did" value="<%=obj[0].toString() %>" onclick="" 
			 				data-toggle="tooltip" data-placement="top" data-original-data="" title="" data-original-title="EDIT"
			 			 >
			 			 <i class="fa fa-lg fa-pencil-square-o" style="color:orange" aria-hidden="true"></i>
			 			 </button><%} %>
												<input type="hidden"   /> <input
												type="hidden" name="${_csrf.parameterName}"
												value="${_csrf.token}" />
					                       <%
					                       if(obj[11].toString().equalsIgnoreCase(UserId) && toUserStatus.contains(obj[14].toString())){%>
					                     
											<button class="editable-click"  style="background-color: transparent;" 
											formaction="RfaActionForward.htm" formmethod="POST" formnovalidate="formnovalidate"
												name="rfaa" value="<%=obj[0]%>" 
												onclick="return frdRfa(<%=obj[0]%>,'<%=obj[14]%>');"
													data-toggle="tooltip" data-placement="top" id="rfaCloseBtn" title="" data-original-title="FORWARD RFA"
												
												>
												<div class="cc-rockmenu" >
														<figure class="rolling_icon" >
															<img src="view/images/forward1.png">
														</figure>
												</div>
											</button>
											<input type="hidden" name="${_csrf.parameterName}"
												value="${_csrf.token}" /> 
												
	                                      <% }if(obj[11].toString().equalsIgnoreCase(UserId) && obj[14].toString().equalsIgnoreCase("AF")){
	                                      %>
												<button data-original-title="REVOKE" class="editable-click" name="sub" type="button"
													value="" style="background-color: transparent;"
													formaction="RfaActionReturnList.htm" formmethod="POST"
													formnovalidate="formnovalidate" name="rfa" id="rfaRevokeBtn"
													value="<%=obj[0]%>"
													onclick="return returnRfa(<%=obj[0]%>,'<%=obj[14]%>','<%=obj[15]%>')">
													
														
														<i class="fa fa-backward" aria-hidden="true" style="color: #007bff; font-size: 24px; position: relative; top: 5px;"></i>
													
												</button> 
	                                    <% } if(obj[11].toString().equalsIgnoreCase(UserId) && Integer.valueOf(obj[16].toString()) >0){ %>  
													<button title="REMARKS" class="editable-click" name="sub" type="button"
													value="" style="background-color: transparent;"
													formaction="RemarksList.htm" formmethod="POST"
													formnovalidate="formnovalidate" name="rfa" id="rfaRemarksBtn"
													value="<%=obj[0]%>"
													onclick="return rfaRemarks(<%=obj[0]%>,'<%=obj[14]%>')">
													
														
														<i class="fa fa-comment" aria-hidden="true" style="color: #143F6B; font-size: 24px; position: relative; top: 5px;"></i>
													
												</button> 
											 <%} if(obj[14].toString().equalsIgnoreCase("AP")){%>  
											 	<button class="editable-click"  style="background-color: transparent;" 
											formaction="RfaActionForward.htm" formmethod="POST" formnovalidate="formnovalidate"
												name="rfaa" value="<%=obj[0]%>" 
												onclick="return rfaClose(<%=obj[0]%>,'<%=obj[14]%>');"
													data-toggle="tooltip" data-placement="top" id="rfaFwdBtn" title="" data-original-title="CLOSE RFA"
												
												>
												<div class="cc-rockmenu" >
														<figure class="rolling_icon" >
															<img src="view/images/close.png" id="closeImg">
														</figure>
												</div>
											</button>
											<%} %>
											<input type="hidden" name="projectid" value="<%=obj[13].toString() %>" > 
											<input type="hidden" name="UserId" value="<%=UserId%>">
											<input type="hidden" name="RfaStatus" value="" id="RfaStatus">
											<input type="hidden" name="rfa" value="" id="rfa">
											<input type="hidden" name="assigneed" value="" id="createdBy">
											</td>
											
										</tr>
										<%}} %>
									</tbody>
								</table>
							</div>
						</div>
						<div align="center" style="margin-bottom: 20px">

							<input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}" />
								
							<button class="btn add" type="button" formaction="RfaActionAdd.htm" name="sub" value="add" onclick="addRfa()" id="addRfaBtn">ADD</button>
						   <%--  <%if(RfaActionList!=null){
							  for(Object[] list:RfaActionList) {%>
							   <%if(list[11].toString().equalsIgnoreCase(UserId)){ %>	
						
							  <%} %>
							<%}}%> --%>
								
							<a class="btn btn-info shadow-nohover back"
								href="MainDashBoard.htm">BACK</a>
						</div>
						<input type="hidden" name="sub" value="add">
					</form>
				</div>
			</div>
		</div>
	</div>

		<!-- -- ******************************************************************Remarks  Model Start ***********************************************************************************-->
<form class="form-horizontal" role="form"
			action="#" method="POST" id="returnFrm" autocomplete="off">
			<div class="modal fade bd-example-modal-lg" id="rfaRemarksmodal"
				tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
				aria-hidden="true">
				<div class="modal-dialog modal-lg">
					<div class="modal-content addreq" style="width: 100%; position: relative; " >
						<div class="modal-header" id="modalreqheader" style="background-color: #021B79">
							<h5 class="modal-title" id="exampleModalLabel" style="color: #fff">RFA Remarks</h5>
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close" style="color: white">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div style="height: 300px; overflow: auto;">
							<div class="modal-body">
							
		<div class="form-inline" >
		<table class=" table-hover table-striped remarksDetails " style="width: 100%;"  >
		<tbody id="remarksTb"></tbody>
							</table>

				<input type="hidden" name="${_csrf.parameterName}"		value="${_csrf.token}" /> 
 		<input type="hidden" name="rfa" id="rfaHidden">
 		<input type="hidden" name="RfaStatus" id="RfaStatusHidden">
    
        

        
        
	</div>

	
							</div>
						</div>
					</div>

				</div>
				</div>
		
		</form>
</body>

<script type="text/javascript">

function Edit(myfrm){

	 var fields = $("input[name='Did']").serializeArray();
	
	 console.log(fields+"--")
	  if (fields.length === 0){
	alert("Please Select A Record");
	 event.preventDefault();
	return false;
	}
		  return true;	
	}

$(document).ready(function(){
	  $("#myTable").DataTable({
	 "lengthMenu": [  5,10,25, 50, 75, 100 ],
	 "pagingType": "simple"
	
});
  });
  

$('#fdate').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});


$('#tdate').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});
$(function () {
	$('[data-toggle="tooltip"]').tooltip()
	})
	
		$(document).ready(function(){
						   $('#fdate, #tdate,#Project,#Status').change(function(){
							   var form = document.getElementById("dateform");
							 
				               if (form) {
				                        // Set the form's action attribute to the formactionValue o submit form
				                        form.setAttribute("action", "RfaAction.htm");
				                         form.submit();
				                     }
				                });
						 
						}); 
		function frdRfa(rfaId,RfaStatus) {
			$('#rfa').val(rfaId);
			$('#RfaStatus').val(RfaStatus);
			
			  var confirmation = confirm('Are You Sure To Forward this RFA ?');
			  if(confirmation){
				  var form = document.getElementById("myFrom");
				   
		        if (form) {
		         var rfaFwdBtn = document.getElementById("rfaFwdBtn");
		            if (rfaFwdBtn) {
		                var formactionValue = rfaFwdBtn.getAttribute("formaction");
		                
		                 form.setAttribute("action", formactionValue);
		                  form.submit();
		              }
		         }
			  } else{
		  	  return false;
			  }
			
		}
		
		function rfaClose(rfaId,RfaStatus) {
			$('#rfa').val(rfaId);
			$('#RfaStatus').val(RfaStatus);
			
			  var confirmation = confirm('Are You Sure To Close this RFA ?');
			  if(confirmation){
				  var form = document.getElementById("myFrom");
				   
		        if (form) {
		         var rfaFwdBtn = document.getElementById("rfaCloseBtn");
		            if (rfaFwdBtn) {
		                var formactionValue = rfaFwdBtn.getAttribute("formaction");
		                
		                 form.setAttribute("action", formactionValue);
		                  form.submit();
		              }
		         }
			  } else{
		  	  return false;
			  }
			
		}
						
function returnRfa(rfaId,RfaStatus,createdBy) {
	$('#rfa').val(rfaId);
	$('#RfaStatus').val(RfaStatus);
	$('#createdBy').val(createdBy);
	  var confirmation = confirm('Are You Sure To Return this RFA ?');
	  if(confirmation){
		  var form = document.getElementById("myFrom");
		   
        if (form) {
         var rfaRevokeBtn = document.getElementById("rfaRevokeBtn");
            if (rfaRevokeBtn) {
                var formactionValue = rfaRevokeBtn.getAttribute("formaction");
                
                 form.setAttribute("action", formactionValue);
                  form.submit();
              }
         }
	  } else{
  	  return false;
	  }
	
}
function rfaRemarks(rfaId,RfaStatus) {
	$('#rfaRemarksmodal').modal('show');
	console.log(rfaId);
	$.ajax({
        type: "GET",
        url: "getrfaRemarks.htm",
        data: {
        	rfaId : rfaId,
        	status : 'user'
        },
        dataType: 'json', 
        success: function(result) {
        	$("#remarksTb").empty();
        	if(result!=null && Array.isArray(result) && result.length>0){
        		
        		
        		  var ReplyAttachTbody = '';
		          for (var z = 0; z < result.length; z++) {
		            var row = result[z];
		            ReplyAttachTbody += '<tr>';
		            ReplyAttachTbody += '<td id="remarksTd1">'+row[0]+' &nbsp; <span id="remarksDate"> '+fDate(row[2])+'</span>';
		            ReplyAttachTbody += '</td>';
		            ReplyAttachTbody += '</tr>';
		            ReplyAttachTbody += '<tr>';
		            ReplyAttachTbody += '<td id="remarksTd2">  '+row[1]+'';
		            ReplyAttachTbody += '</td>';
		            ReplyAttachTbody += '</tr>';

		          }
		          $('#remarksTb').append(ReplyAttachTbody);
        }
        }
	})
}

 function fDate(fdate) {
	 var dateString = fdate;

	// Create a Date object from the original date string
	var date = new Date(dateString);

	// Get the date components
	var day = date.getDate().toString().padStart(2, '0'); // Get day and pad with leading zero if necessary
	var month = (date.getMonth() + 1).toString().padStart(2, '0'); // Get month (zero-based) and pad with leading zero if necessary
	var year = date.getFullYear();
	var hours = date.getHours().toString().padStart(2, '0'); // Get hours and pad with leading zero if necessary
	var minutes = date.getMinutes().toString().padStart(2, '0'); // Get minutes and pad with leading zero if necessary

	// Create the formatted date string
	var formattedDate = day+'-'+month+'-'+year+' '+hours+':'+minutes;
	return formattedDate;
}
 


function addRfa() {
	
		  var form = document.getElementById("myFrom");
		   
      if (form) {
       var addRfaBtn = document.getElementById("addRfaBtn");
          if (addRfaBtn) {
              var formactionValue = addRfaBtn.getAttribute("formaction");
              
               form.setAttribute("action", formactionValue);
                form.submit();
            }
       }
	 
	
}

</script>
</html>