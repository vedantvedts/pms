<%@page import="java.text.Format"%>
<%@page import="com.vts.pfms.master.dto.ProjectFinancialDetails"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.math.BigDecimal"%> 
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.time.LocalDate"%>
    
   
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

<title>Procurement Status</title>


 <style type="text/css">
 
 p{
  text-align: justify;
  text-justify: inter-word;
}

  
 th
 {
 	border: 1px solid black;
 	text-align: center;
 	padding: 5px;
 }
 
 td
 {
 	border: 1px solid black;
 	text-align: left;
 	padding: 5px;
 }
 
  }
 .textcenter{
 	
 	text-align: center;
 }
 .border
 {
 	border: 1px solid black;
 }
 .textleft{
 	text-align: left;
 }
 
 #containers {
    width: 100%;
    height: 100%;
    margin: 0;
    padding: 0;
}

.anychart-credits {
   display: none;
}

.flex-container {
  display: flex;
  flex-direction: column;
  min-height: 100vh;
}

summary[role=button] {
  background-color: white;
  color: black;
  border: 1px solid black ;
  border-radius:5px;
  padding: 0.5rem;
  cursor: pointer;
  
}
summary[role=button]:hover
 {
color: white;
border-radius:15px;
background-color: #4a47a3;

}
 summary[role=button]:focus
{
color: white;
border-radius:5px;
background-color: #4a47a3;
border: 0px ;

}
summary::marker{
	
}
details { 
  margin-bottom: 5px;  
}
details  .content {
background-color:white;
padding: 0 1rem ;
align: center;
border: 1px solid black;
}

}



		.input-group-text {
			font-weight: bold;
		}

		label {
			font-weight: 800;
			font-size: 16px;
			color: #07689f;
		}

		hr {
			margin-top: -2px;
			margin-bottom: 12px;
		}

		.card b {
			font-size: 20px;
		}
		
		input::-webkit-outer-spin-button,
input::-webkit-inner-spin-button {
    /* display: none; <- Crashes Chrome on hover */
    -webkit-appearance: none;
    margin: 0; /* <-- Apparently some margin are still there even though it's hidden */
}

input[type=number] {
    -moz-appearance:textfield; /* Firefox */
}
		
</style>


<meta charset="ISO-8859-1">

</head>
<body >
<%

FormatConverter fc=new FormatConverter(); 
SimpleDateFormat sdf=fc.getRegularDateFormat();
SimpleDateFormat sdf1=fc.getSqlDateFormat(); int addcount=0; 
NFormatConvertion nfc=new NFormatConvertion();

List<Object[]> projectslist=(List<Object[]>)request.getAttribute("projectslist");
List<Object[]> fileStatusList=(List<Object[]>)request.getAttribute("fileStatusList");
String projectId=request.getAttribute("projectId").toString();

Format format = com.ibm.icu.text.NumberFormat.getCurrencyInstance(new Locale("en", "in"));

%>
<%
	String ses=(String)request.getParameter("result"); 
	String ses1=(String)request.getParameter("resultfail");
%>
	<%if(ses1!=null){ %>
	<div align="center">
	<div class="alert alert-danger" role="alert">
                     <%=ses1 %>
                    </div></div>
	<%}if(ses!=null){ %>
		<div align="center">
			<div class="alert alert-success" role="alert" >
	        	<%=ses %>
	        </div>
	    </div>
    <%} %>

    



	
<br>
<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card shadow-nohover">
					<div class="row card-header">
			   			<div class="col-md-6">
							<h4>Procurement Status</h4>
						</div>
						<div class="col-md-3">
							<%-- <form method="post" action="ProjectBriefing.htm" target="_blank">
								<input type="hidden" name="projectid" value="<%=projectid%>"/>
								<button type="submit" ><img src="view/images/preview3.png"></button>
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							</form> --%>
						</div>						
						<div class="col-md-3 justify-content-end" style="float: right;">
							<table style="margin-top: -10px;">
								<tr>
									<td  style="border: 0 "><h4>Project :</h4></td>
									<td  style="border: 0 ">
										<form method="post" action="ProcurementStatus.htm" id="projectchange" >
											<select class="form-control selectdee" name="projectid"  required="required" style="width:200px;" data-live-search="true" data-container="body" onchange="submitForm('projectchange');">
												<%for(Object[] obj : projectslist){ %>
												<option value=<%=obj[0]%><%if(projectId.equals(obj[0].toString())){ %> selected="selected" <%} %> ><%=obj[4] %></option>
												<%} %>
											</select>
											<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
										</form>
									</td>
								</tr>
							</table>
							
						</div>
					 </div>
					 	 <div class="card-body">	
					 	      <div class="table-responsive">
	                              <table class="table table-bordered table-hover table-striped table-condensed "  id="myTable"> 
	                                  <thead>
	                                     <tr>
	                                      <th>SN</th>
	                                      <th>DemandNo</th>
	                                      <th>Item Nomenclature</th>
	                                      <th>Estimated cost</th>
	                                      <th>Status</th>
	                                     </tr>
	                                 </thead>
	                                 <tbody>
	                                      <%if(fileStatusList!=null){ int SN=1;%>
	                                      <%for(Object[] fileStatus:fileStatusList){ %>
	                                      <tr>
                                            <td><%=SN++%></td>
                                            <td><%=fileStatus[1]%></td>
                                            <td><%=fileStatus[4]%></td>
                                            <td style="text-align: right;"><%=format.format(new BigDecimal(fileStatus[3].toString())).substring(1)%></td>
                                            <td >
                                              <table style="margin-left:4rem;">
                                               <tr>
                                                <td><%=fileStatus[6]%></td>
                                                <%if(!fileStatus[7].toString().equals("16")){ %>
                                                   <td>
                                                      <button class="btn btn-sm" data-toggle="modal" data-target="#exampleModal" onclick="openEditform('<%=fileStatus[0]%>','<%=fileStatus[1]%>')"><i class="fa fa-pencil-square-o" aria-hidden="true"></i></button>
                                                  </td>
                                                   <td style="margin-left:5px;">  
                                                   <form action="FileInActive.htm" method="post">
	                                                   <input type="hidden" name="fileId" value="<%=fileStatus[0]%>" />
	                                                   <input type="hidden" name="projectId" value=<%=projectId%> />
	                                                   <input type="hidden" name="demandNo" value="<%=fileStatus[1]%>" />
	                                                   <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />                                         
	                                                   <button class="btn btn-sm"  onclick="return confirm('Are You Sure To InActive ?')"><i class="fa fa-times" aria-hidden="true"></i></button>
	                                                   <button class="btn btn-sm" type="button" data-toggle="modal" data-target="#PDCModal" onclick="openPDCform('<%=fileStatus[0]%>')">
                                                  	  	<i class="fa fa-calendar" aria-hidden="true"></i>
                                                  	  </button>
	                                                   <%if(Long.parseLong(fileStatus[7].toString())>8){ %>
	                                                   <button class="btn btn-sm "  formaction="FileOrderRetrive.htm" title="Refresh Order"> <i class="fa fa-refresh" aria-hidden="true"></i></button>
	                                                   <%} %>
                                                   </form>
                                                   </td>
                                                  <%} %>
                                               </tr>
                                              </table>
                                            </td>
	                                      </tr>
	                                      <%} }%>
	                                 </tbody>
	                              </table>
	                        </div>
	                        <div align="center">
	                           <form action="AddNewDemandFile.hmt" method="post">
	                                <input type="hidden" name="projectId" value=<%=projectId%> />
	                        		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	                        		<button  class="btn add" type="submit">Add Demand</button>
	                           </form>
	                        </div>
					 	</div>
					</div>
			</div>
		</div>
	</div>
	
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<form action="upadteDemandFile.htm" method="post" onsubmit="return confirm('Are you sure to submit');">
				<div class="modal-header">
					<div id="headerId">
						<h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
					</div>

					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-md-8">
							<table style="border: none; margin-top: -6px;">
								<tr>
									<td style="border: none; padding-bottom: .2rem;">
										<label class="control-label">Event Status</label>
									</td>
								</tr>
								<tr>
									<td style="border: none; padding: 0px;">
										<select	class="custom-select selectdee" style="width: 20rem;" id="selectDemand" required="required" name="statusId">
											<option disabled="true" selected value="">Choose...</option>
	
										</select>
									</td>
								</tr>
							</table>
						</div>

						<div class="col-md-4">
							<label class="control-label">Event Date</label> <input
								type="text" class="form-control" name="eventDate" id="eventDate"
								required="required" readonly="readonly">
						</div>
					</div>

					<div class="row">
						<div class="col-md-12">
							<label class="control-label">Remarks</label> <input type="text" class="form-control" name="remarks" id="remarksId" value="Nil" required="required">
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<input type="hidden" name="projectId" value="<%=projectId%>" /> 
					<input type="hidden" name="fileId" id="updateFileId" /> 
					<input type="hidden" name="demandNo" id="DemandNo" /> 
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
					<button type="submit" class="btn submit">Submit</button>
				</div>
			</form>
		</div>
	</div>
</div>

<div class="modal fade" id="PDCModal" tabindex="-1" role="dialog" aria-labelledby="PDCModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<form action="UpdateFilePDCInfo.htm" method="post" >
				<div class="modal-header">
					<div>
						<h5 class="modal-title" id="PDCModalLabel">Modal title</h5>
					</div>

					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-md-4">
							<label class="control-label">PDC</label> 
							<input type="text" class="form-control" name="PDCDate" id="PDCDate" required="required" readonly="readonly">
						</div>

						<div class="col-md-8">
							<label class="control-label">Available for Integration by</label> 
							<input type="text" class="form-control" name="IntegrationDate" id="IntegrationDate" required="required" readonly="readonly" style="width: 50%;">
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<input type="hidden" name="projectId" value="<%=projectId%>" /> 
					<input type="hidden" name="fileId" id="pdcFileId" /> 
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<button type="button" class="btn btn-sm btn-danger" data-dismiss="modal"><b>CLOSE</b></button>
					<button type="submit" class="btn btn-sm submit">Submit</button>
				</div>
			</form>
		</div>
	</div>
</div>


<script type="text/javascript">

function submitForm(frmid)
{ 
  
  document.getElementById(frmid).submit(); 
} 
</script>
	
<script type="text/javascript">

$(document).ready(function(){
	  $("#myTable").DataTable({
	 "lengthMenu": [  5,10,25, 50, 75, 100 ],
	 "pagingType": "simple"
	
});
  });
  
</script>
<script type="text/javascript">

function openEditform(fileId , demandid){
	var x=x+'<option disabled="true"  value="" style="font-size:20px;">Choose...</option>';
	$.ajax({
		type : "GET",
		url : "getStatusEvent.htm",
		data : {
			fileid : fileId,
			projectId:<%=projectId%>
		},
		datatype : 'json',
		success : function(result) {
		var values = JSON.parse(result);

		for(i = 0; i < values.length; i++){
				 x=x+"<option value="+values[i][0]+">"+ values[i][2]+ "</option>"; 
			  			   		     
			}
	        
			$("#selectDemand").html(x); 
			$("#DemandNo").val(demandid); 
            $("#updateFileId").val(fileId);
		}
		});	
	

$("#headerId").html('<h5 class="modal-title" id="exampleModalLabel"> Demand No : '+demandid+'</h5>');
}

</script>

<script type="text/javascript">


$('#eventDate').daterangepicker({
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


$('#DPdateId').daterangepicker({
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

</script>
<script type="text/javascript">

$( "#selectDemand" ).change(function() {
  var selectee=$( "#selectDemand" ).val();
  if(selectee=='9'){
	  $("#orderDetails").show();
	  $('#orderNoId').prop('required', true);  
	  $('#orderCostId').prop('required', true);  
  }else{
	  $("#orderDetails").hide();
	  $('#orderNoId').removeAttr('required');
	  $('#orderCostId').removeAttr('required'); 
  }
});

</script>
<script type="text/javascript">
$('#exampleModal').on('hidden.bs.modal', function () {
	  $("#orderDetails").hide();
	  $('#orderNoId').removeAttr('required');
	  $('#orderCostId').removeAttr('required'); 
	});
	

</script>
	
<script type="text/javascript">
$('#exampleModal').on('shown.bs.modal', function () {
	var selectee=$( "#selectDemand" ).val();
	  if(selectee=='9'){
		  $("#orderDetails").show();
		  $('#orderNoId').prop('required', true);  
		  $('#orderCostId').prop('required', true);  
	  }
});

</script>


<script type="text/javascript">

function openPDCform(fileId){
	$.ajax({
		type : "GET",
		url : "getFilePDCInfo.htm",
		data : {
			fileid : fileId,
		},
		datatype : 'json',
		success : function(result) {
			var values = JSON.parse(result);
            $("#pdcFileId").val(fileId);
            
            var PDCDate = new Date();
            var IntegrationDate = new Date();
            if(values[5]!==null){     PDCDate =  new Date(values[5]); }
            if(values[6]!==null){     IntegrationDate = new Date(values[6]); }
            console.log(values[6]);
            $('#PDCDate').daterangepicker({
            	"singleDatePicker" : true,
            	"linkedCalendars" : false,
            	"showCustomRangeLabel" : true,
                "startDate" : PDCDate,
            	"cancelClass" : "btn-default",
            	showDropdowns : true,
            	locale : {
            		format : 'DD-MM-YYYY'
            	}
            });
            $('#IntegrationDate').daterangepicker({
            	"singleDatePicker" : true,
            	"linkedCalendars" : false,
            	"showCustomRangeLabel" : true,
            	"startDate" : IntegrationDate,
            	"cancelClass" : "btn-default",
            	showDropdowns : true,
            	locale : {
            		format : 'DD-MM-YYYY'
            	}
            });
            
            $("#PDCModalLabel").html('Demand No : '+result[1]);
		}
	});	
	


}

</script>
</body>
</html>