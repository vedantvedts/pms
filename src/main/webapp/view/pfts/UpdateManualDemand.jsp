<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="java.text.Format"%>
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
<title>Update Manual Demand</title>
<style type="text/css">
label{
	font-weight: 800;
	font-size: 16px;
	color:#07689f;
} 

.form-group {
    margin-top: 0.5rem;
    margin-bottom: 1rem;
}
.input-group-text{
font-weight: bold;
}
.blinking-element {
            animation: blinker 1.5s linear infinite;
            color: #D81B60;
            font-size: 1.5em;
            font-weight:600;
            margin-bottom: 20px;
            text-shadow: 5px 5px 10px  #D81B60;
}

@keyframes blinker { 
   0%{opacity: 0;}
  50%{opacity: 1;}
  100%{opacity: 1;}
}

.modal-dialog-jump {
  animation: jumpIn 0.5s ease;
}

@keyframes jumpIn {
  0% {
    transform: scale(0.1);
    opacity: 0;
  }
  70% {
    transform: scale(1);
  }
  100% {
    transform: scale(1);
    opacity: 1;
  }
}
</style>
</head>
<body>
  <%
  Object[] fileView = (Object[])request.getAttribute("fileViewList");
  List<Object[]> fileStage=(List<Object[]>)request.getAttribute("pftsStageList");
  List<Object[]> pftsStageList1=fileStage.stream().filter(i->Integer.parseInt(i[0].toString())<=10).collect(Collectors.toList());
  List<Object[]> pftsStageList2=fileStage.stream().filter(i->Integer.parseInt(i[0].toString())>=10).collect(Collectors.toList());
  List<Object[]> pftsStageList3=fileStage.stream().filter(i->Integer.parseInt(i[0].toString())>10).collect(Collectors.toList());
  String projectid = fileView[11].toString();
  int fileViewValue = Integer.parseInt(fileView[7].toString()); 
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

<div class="container-fluid">
	<div class="card shadow-nohover" style="margin-top:0px;">		
		<div class="row card-header">
			<div class="col-md-6">
				<h4>Demand No : <%=fileView[1]!=null?StringEscapeUtils.escapeHtml4(fileView[1].toString()):"-" %></h4>
			</div>
        </div>
        <div class="card-body">
             <form action="updateManualDemandSubmit.htm" method="post">
                     <div class="row mt-2">
				           <div class="col-md-3">
								<label> Item Nomenclature : </label> 
						  </div>
						  <div class="col-md-9" style="margin-left: -13%;">
								<input type="text" class="form-control" value="<%=fileView[4]!=null?StringEscapeUtils.escapeHtml4(fileView[4].toString()):"-" %>" style="width: 118%"
									name="procitems" id="procitems" readonly="readonly">
						  </div>
				     </div>
                     <div class="row mt-2">
						  	<div class="col-md-2">
								<label class="control-label" > Procurement Status :</label>
						   </div>
							<div class="col-md-3" style="margin-left: -5%;">
								 <select onchange="modalOpen()"
									class="form-control selectdee"
									id="procstatus" required="required" name="procstatus">
									<option disabled="true"  selected value="">Select...</option>
									<% if (fileViewValue < 10) {  %>
								       <% for (Object[] obj : pftsStageList1) {%>
								          <% if(obj[0].toString().equalsIgnoreCase("10")){ %>
								           <option value="<%=obj[0]%>"<%if(obj[0].toString().equalsIgnoreCase(fileView[7].toString())){ %> selected <%} %>><%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()):"-"%></option>
									      <% }else{%>
									       <option value="<%=obj[0]%>"<%if(obj[0].toString().equalsIgnoreCase(fileView[7].toString())){ %> selected <%} %>><%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()):"-"%></option>
									      <%} %>
									   <%} %>
									<%}else if(fileViewValue == 10){ %>
									   <% for (Object[] obj : pftsStageList2) {%>
								       <option value="<%=obj[0]%>"<%if(obj[0].toString().equalsIgnoreCase(fileView[7].toString())){ %> selected <%} %>><%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()):"-"%></option>
									   <%} %>
									<%}else{ %>
									   <% for (Object[] obj : pftsStageList3) {%>
								       <option value="<%=obj[0]%>"<%if(obj[0].toString().equalsIgnoreCase(fileView[7].toString())){ %> selected <%} %>><%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()):"-"%></option>
									   <%} %>
									<%} %>
								</select>
								</div>
								
								<div class="col-md-1">
							   <label class="control-label" >Event Date :</label>
							   </div>
							   <div class="col-md-2">
							    <input  class="form-control form-control date"  data-date-format="dd-mm-yyyy" id="datepicker1" 
							    name="eventDate"  required="required">
						    </div>
						    <div class="col-md-1" >
								<label> Remarks : </label> 
								</div>
								<div class="col-md-3">
								<input type="text" class="form-control" value="<%=fileView[9]!=null?StringEscapeUtils.escapeHtml4(fileView[9].toString()):"" %>"
									name="procRemarks" id="procRemarks" required="required"
									style="margin-left: -11%;width: 133%">
							</div>
					 </div>
					 <br>
					  <div class="form-group" align="center" id="btnSubmit1">
					    <button type="submit" class="btn btn-primary btn-sm submit"  value="SUBMIT" id="manualAddBtn" onclick ="return confirm('Are you sure to submit?')">SUBMIT </button>
					 	<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
					 	<input type="hidden" id="pstatusid" value="<%=fileView[7]%>"> 
					 	<input type="hidden" id="projectId" name="projectId" value="<%=projectid%>"> 
					 	<input type="hidden" id="fileId" name="fileId" value="<%=fileView[0]%>">
					    <a class="btn btn-info btn-sm  shadow-nohover back" href="ProcurementStatus.htm?projectid=<%=projectid%>">Back</a>
				     </div>
					 </form>
					 <div id="btnplus"style="display:none;">
					    <button type="button" class=" btn btn_add" onclick="copyDiv()"> <i class="btn btn-sm fa fa-plus" style="color: green; padding: 0px  0px  0px  0px;"></i></button>
					 </div> 
					 <form action="updateManualDemandSubmit.htm" method="post">
					 <div class="divHidden mt-3" id="divHidden" style="display:none;padding: 5px">
						<div class="row mt-2">
							<div class="col-sm-1">
								<label class="control-label">Order No :</label>
							</div>
							<div class="col-sm-2" style="margin-left: -2%;">
								<input type="text" class="form-control" name="orderno"
									id="orderno" required="required" placeholder="Enter Order No">
							</div>
							<div class="col-sm-1">
								<label class="control-label">Order Date :</label>
							</div>
							<div class="col-sm-2">
								<input class="form-control form-control date datepicker2"
									data-date-format="dd-mm-yyyy" id="" name="orderdate"
									required="required" style="margin-left: -8%;">
							</div>
							<div class="col-sm-1" style="margin-left: -1%;">
								<label class="control-label">Order Cost :</label>
							</div>
							<div class="col-sm-2">
								<input type="number" class="form-control" name="ordercost"
									 id="ordercost" required="required"
									placeholder="Enter Cost in Rupees (&#8377;)">
							</div>
							<div class="col-sm-1">
								<label class="control-label">DP Date :</label>
							</div>
							<div class="col-sm-2" style="margin-left: -2%;">
								<input class="form-control form-control date datepicker3"
									data-date-format="dd-mm-yyyy" id="" name="dpdate"
									required="required">
							</div>
						  
						</div>
						<div class="row mt-2">
							<div class="col-md-1">
								<label> Item For : </label>
							</div>
							<div class="col-md-5" style="margin-left: -2%;">
								<input type="text" class="form-control"
									placeholder="Enter Item Details" name="itemfor" id="itemfor"
									required="required" style="width: 97%;">
							</div>
								<div class="col-md-1">
								<label> Vendor : </label>
							</div>
							<div class="col-md-5" style="margin-left: -1%;">
								<input type="text" class="form-control"
									placeholder="Enter Vendor Name" name="vendor" id="vendor"
									required="required" style="width: 95%;">
							</div>
							<span style="margin-left: -1%"><button type="button" id="btnminus" class=" btn btn_rem" onclick="RemoveDiv(this)"> <i class="btn btn-sm fa fa-minus" style="color: red; padding: 0px  0px  0px  0px;"></i></button></span>
						</div>
						<br>
						<div style="height: 2px; background-color: black;"></div>
					</div>
					 <div class="form-group" align="center" id="btnSubmit2" style="display:none;">
					       <button type="submit" class="btn btn-primary btn-sm submit"  value="SUBMIT" id="manualAddBtn" onclick ="return confirm('Are you sure to submit?')">SUBMIT </button>
					 	   <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
					 	   <input type="hidden" id="pstatusid" value="<%=fileView[7]%>"> 
					 	   <input type="hidden" id="projectId" name="projectId" value="<%=projectid%>"> 
					 	   <input type="hidden" id="fileId" name="fileId" value="<%=fileView[0]%>">
					 	   <input type="hidden" id="fileStatusId" name="procstatus" value="">
					 	   <input type="hidden" id="fileEventDate" name="eventDate" value="">
					 	   <input type="hidden" id="fileRemarks" name="procRemarks" value="">
					 	   <input type="hidden" name="flag" value="order">
					       <a class="btn btn-info btn-sm  shadow-nohover back" href="ProcurementStatus.htm?projectid=<%=projectid%>">Back</a>
				      </div>
				 </form>
		              <br>
		            
				<div class="col-md-12"
							style="border: 1px solid #055C9D; display: flex; justify-content: space-around;">
							<div>
								<%
								int i = 0;
								for (Object[] obj1 : fileStage) {
									if (i == 9)
										break;
								%>
								<p class="pstatus" id="<%=obj1[0].toString()%>"><%=obj1[0]!=null?StringEscapeUtils.escapeHtml4(obj1[0].toString()):"-"%>. <%=obj1[2]!=null?StringEscapeUtils.escapeHtml4(obj1[2].toString()):"-"%>
								</p>
								<%
								i++;
								}
								%>
							</div>
							<div>
								<%
								int j = 0;
								for (Object[] obj1 : fileStage.stream().skip(9).collect(Collectors.toList())) {
									if (j == 9)
										break;
								%>
								<p class="pstatus" id="<%=obj1[0].toString()%>"><%=obj1[0]!=null?StringEscapeUtils.escapeHtml4(obj1[0].toString()):"-"%>. <%=obj1[2]!=null?StringEscapeUtils.escapeHtml4(obj1[2].toString()):"-"%>
								</p>
								<%
								j++;
								}
								%>
							</div>
							<div>
								<%
								int k = 0;
								for (Object[] obj1 : fileStage.stream().skip(18).collect(Collectors.toList())) {
									if (k == 9)
										break;
								%>
								<p class="pstatus" id="<%=obj1[0].toString()%>"><%=obj1[0]!=null?StringEscapeUtils.escapeHtml4(obj1[0].toString()):"-"%>. <%=obj1[2]!=null?StringEscapeUtils.escapeHtml4(obj1[2].toString()):"-" %>
								</p>
								<%
		                        k++;
		                        } %>
						  </div>
						</div>
			<!--  <div class="table-responsive">
					<table
						class="table table-bordered table-hover table-striped table-condensed "
						id="myTable" style="width: 91%">
						<thead>
							<tr>
								<th>SN</th>
								<th>OrderNo</th>
								<th>OrderDate</th>
								<th>ItemFor</th>
								<th>OrderCost</th>
								<th>DPDate</th>
								<th>VendorName</th>
								<th>Action</th>
							</tr>
						</thead>
						<tbody>
						     <tr>
						        <td></td>
						        <td></td>
						        <td></td>
						        <td></td>
						        <td></td>
						        <td></td>
						        <td></td>
						        <td></td>
						     </tr>
						</tbody>
					</table>
				</div> -->
         </div>
	</div>
</div>

	<!-- <div class="modal fade my-modal" id="exampleModalCenter" tabindex="-1"
		role="dialog" aria-labelledby="exampleModalCenter"
		aria-hidden="true">
		<div
			class="modal-dialog  modal-lg modal-dialog-centered modal-dialog-jump"
			role="document">
			<div class="modal-content" style="height: 400px;width: 117% !important;">
				<div class="modal-header">
					<h5 style="font-size: x-large; font-weight: 700;margin-inline-start: auto;">Enter Order Details</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-md-2">
							<label class="control-label">Order No :</label>
						</div>
						<div class="col-md-5">
							<input type="text" class="form-control" name="orderno"
							 id="orderno" required="required" placeholder="Enter Order No">
						</div>
						<div class="col-md-2">
							   <label class="control-label" >Order Date :</label>
						</div>
						<div class="col-md-3">
							<input  class="form-control form-control date datepicker2"  data-date-format="dd-mm-yyyy"
							   name="orderdate"  required="required" >
						  </div>
					</div>
					<div class="row mt-2">
						<div class="col-md-2">
							<label class="control-label">Order Cost :</label>
						</div>
						<div class="col-md-5">
							<input type="number" class="form-control" name="ordercost" max="100" min="0"
							 id="ordercost" required="required" placeholder="Enter Cost in Rupees (&#8377;)">
						</div>
						<div class="col-md-2">
							   <label class="control-label" >DP Date :</label>
						</div>
						<div class="col-md-3">
							<input  class="form-control form-control date datepicker3"  data-date-format="dd-mm-yyyy"
							   name="orderdate"  required="required" >
						  </div>
					</div>
					<div class="row mt-2">
				           <div class="col-md-3">
								<label> Item For : </label> 
								</div>
								<div class="col-md-9" style=" margin-left: -9%;" >
								<input type="text" class="form-control" placeholder="Enter Item Details"
									name="itemfor" id="itemfor" required="required"
									style="width:113%">
							</div>
						</div>
						<div class="row mt-2">
				           <div class="col-md-3">
								<label> Vendor : </label> 
								</div>
								<div class="col-md-9" style=" margin-left: -9%;" >
								<input type="text" class="form-control" placeholder="Enter Vendor Name"
									name="itemfor" id="itemfor" required="required"
									style="width:113%">
							</div>
						</div>
				</div>
				<div align="center">
					<button type="button" class="btn btn-primary mb-5" style="font-size: 18px;font-weight: 600">SUBMIT</button>
				</div>
			</div>
		</div>
	</div> -->

<script type="text/javascript">
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
	$('.datepicker2').daterangepicker({
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
	$('.datepicker3').daterangepicker({
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
</script>
<script type="text/javascript">
$(document).ready(function() {
		$(".pstatus").removeClass("blinking-element"); // Remove blink class from all elements
		var pstatusid = $("#pstatusid").val(); // Retrieve value of pstatusid
		$("#" + pstatusid).addClass("blinking-element"); // Add blink class on specific id
	});
	
function modalOpen() {
	var status=$('#procstatus').val();
	var eventdate=$('#datepicker1').val();
	var status=$('#procstatus').val();
	var remarks=$('#procRemarks').val();
	if(status==10){
		$('#divHidden').show();
		$('#btnplus').show();
		$('#btnSubmit2').show();
		$('#btnSubmit1').hide();
		$('#fileStatusId').val(status);
		$('#fileEventDate').val(eventdate);
		$('#fileRemarks').val(remarks);
	}else{
		$('#btnSubmit1').show();
		$('#divHidden').hide();
		$('#btnSubmit2').hide();
		$('#btnplus').hide();
	}
	
}

var elements=document.getElementById("divHidden").innerHTML;
console.log(elements);

function copyDiv(){
	
	/*  $(".divHidden").append(elements); */
	 $(".divHidden").append('<div class="appendedDiv">' + elements + '</div>');
	 
	$('.datepicker2').daterangepicker({
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
	$('.datepicker3').daterangepicker({
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

}

function RemoveDiv(btn) {
    var appendedDivs = document.querySelectorAll('.divHidden .appendedDiv');
    if (appendedDivs.length > 0) {
        // Remove the last appended div
        var lastAppendedDiv = appendedDivs[appendedDivs.length - 1];
        lastAppendedDiv.remove();
    } else {
        console.error("No appended divs found");
    }
}
$(document).ready(function() {
modalOpen()
});
</script>
</body>
</html>