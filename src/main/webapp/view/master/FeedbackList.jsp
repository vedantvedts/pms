<%@page import="java.util.stream.Collectors"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.util.* , java.text.DateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<title>FEEDBACK LIST</title>
<style type="text/css">

.cc-rockmenu {
	color: fff;
	padding: 0px 5px;
	font-family: 'Lato', sans-serif;
}

.cc-rockmenu .rolling {
	display: inline-block;
	cursor: pointer;
	width: 33px;
	height: 30px;
	text-align: left;
	overflow: hidden;
	transition: all 0.3s ease-out;
	white-space: nowrap;
}

.cc-rockmenu .rolling:hover {
	width: 120px;
}

.cc-rockmenu .viewcommittees:hover {
	width: 157px;
}



.cc-rockmenu .rolling .rolling_icon {
	float: left;
	z-index: 9;
	display: inline-block;
	width: 28px;
	height: 52px;
	box-sizing: border-box;
	margin: 0 5px 0 0;
}

.cc-rockmenu .rolling .rolling_icon:hover .rolling {
	width: 312px;
}

.cc-rockmenu .rolling i.fa {
	font-size: 20px;
	padding: 6px;
}

.cc-rockmenu .rolling span {
	display: block;
	font-weight: bold;
	padding: 2px 0;
	font-size: 14px;
	font-family: 'Muli', sans-serif;
}

.cc-rockmenu .rolling p {
	margin: 0;
}

.width {
	width: 270px !important;
}

a:hover {
	color: white;
}

</style>


</head>
<body>
<%String ses=(String)request.getParameter("result"); 
 	String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null){
%>
	<div align="center">
		<div class="alert alert-danger" role="alert">
			<%=ses1 %>
		</div>
	</div>
	<%}if(ses!=null){ %>
	<div align="center">
		<div class="alert alert-success" role="alert">
			<%=ses %>
		</div>
	</div>
<%} %>

		

			<%
				DateFormat inputFormatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
				SimpleDateFormat sdf1=new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
				List<Object[]> FeedbackList = (List<Object[]>) request.getAttribute("FeedbackList");
				List<Object[]> attachment = (List<Object[]>) request.getAttribute("Attchment");
				String logintype=(String)session.getAttribute("LoginType");
				String fromdate = (String)request.getAttribute("fromdate");
				String todate = (String)request.getAttribute("todate");
				String feedbacktype = (String)request.getAttribute("feedbacktype");
			%>

			<div class="container-fluid">	

			<div class="row">
			<div class="col-md-1"></div>
				<div class="col-md-10">
				 <div class="card shadow-nohover" >
					<div class="card-header">
					<form action="FeedbackList.htm" method="post">
						<div class="row">
							<div class="col-md-3"><h4>Feedback List</h4></div>
							<div class="col-md-8" style="margin-top: -10px;">
								<table> 
										<tr>
										<th> Type: </th>
										<td style="width: 150px;">
											<select class="form-control selectdee" id="ftype" name="feedbacktype" data-container="body" data-live-search="true"   style="font-size: 5px;" onchange="this.form.submit()">
												<option value=""  selected="selected"	hidden="true">--Select--</option>
												<option value="A" <%if(feedbacktype!=null && "A".equalsIgnoreCase(feedbacktype)){%> selected="selected" <%}%> >All</option>
												<option value="B" <%if(feedbacktype!=null && "B".equalsIgnoreCase(feedbacktype)){%> selected="selected" <%}%>>Bug</option>
												<option value="C" <%if(feedbacktype!=null && "C".equalsIgnoreCase(feedbacktype)){%> selected="selected" <%}%>>Content Change</option>
												<option value="N" <%if(feedbacktype!=null && "N".equalsIgnoreCase(feedbacktype)){%> selected="selected" <%}%>>New Requirement</option>
												<option value="U" <%if(feedbacktype!=null && "U".equalsIgnoreCase(feedbacktype)){%> selected="selected" <%}%>>User Interface</option>

											</select>
										</td>
										<th>From Date:</th>
										<td><input  class="form-control form-control date"  data-date-format="dd-mm-yyyy" id="datepicker1" name="Fromdate"  required="required"  style="width: 120px;"
										<%if(fromdate!=null){%> value="<%=(fromdate) %>" <%} %>
										onchange="this.form.submit()"></td>
										<th>To Date:</th>
										<td><input  class="form-control form-control" data-date-format="dd-mm-yyyy" id="datepicker3" name="Todate"  style="width: 120px;"
										<%if(todate!=null){%> value="<%=(todate) %>" <%} %>	
										 onchange="this.form.submit()"></td>
										</tr>
								</table>
							</div>
							<div class="col-md-1" style="margin-top: -6px;"><a class="btn btn-sm back" href="MainDashBoard.htm" style="float: right;">BACK</a></div>
						</div>
						<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
						</form>
					</div>	
					<div class="card-body"> 
					<form action="##">
							 <div class="datatable-dashv1-list custom-datatable-overright">
			                    
			                <table class="table table-bordered table-hover table-striped table-condensed " id="myTable" > 
			                    <thead>
								<tr>
									<th style="text-align: center ; width:5%; ">SN.</th>
									<th style="text-align: center ;width:15%;">Name</th>
									<th style="text-align: center ;width:10%;">Type</th>
									<th style="text-align: center ;width:10%;">Date</th>
									<th style="text-align: center ;width:35%;">View</th>
									<th style="text-align: center ;width:15%;">
										Action
									</th>
								</tr>
							</thead>
							<tbody>
								<% int count=0;
									for (Object[] obj : FeedbackList) {
										String feedback = obj[3].toString();
								%>
								<tr>
									<td style="text-align: center;"><%=++count%></td>
									<td style="text-align: left;"><%=obj[1]%></td>  
									<td style="text-align: center;"><%=obj[4]%></td>
									<td style="text-align: center;"><%=sdf.format(inputFormatter.parse(obj[2].toString()) ) %></td>
									<td style="text-align: left; "><span <% if(obj[5]!=null && obj[5].toString().equalsIgnoreCase("C")){%> style="color:#649d1a;" <%}%>><%if(feedback.length()<90){%> <%=feedback%> <%}else{%> <% %><%=feedback.substring(0,90)%> 
									</span>
										 <button type="button" class="editable-click" name="sub" value="Modify" onclick="feedbackmodal('<%=obj[0]%>' , '<%=sdf1.format(inputFormatter.parse(obj[2].toString()) )%>')">
													<b><span style="color:#1176ab;font-size: 14px;">......(View More)</span></b>
										</button> <%}%>
									</td>
									<td>
									<%
								
										
										if(obj[5]!=null && obj[5].toString().equalsIgnoreCase("C") ){
											
										%>
										
											<input id="remarks<%=obj[0]%>" value="<%=obj[6]%>" type="hidden">
											<button class="editable-click" type="button" name="sub" value="Details" 	onclick="ClosefeedbackmodalRemarks( '<%=obj[0]%>')">
												<div class="cc-rockmenu">
														<div class="rolling">
														   <figure class="rolling_icon">
																<i class="fa fa-eye fa-3x" aria-hidden="true" style="color: blue;"></i>
															</figure>
														<span>Remarks</span>
														</div>
													</div>
											  </button> 
										 <%}else{  if(logintype.equalsIgnoreCase("A")){%>
											<button class="editable-click" type="button" name="sub" value="Details" 	onclick="Closefeedbackmodal( '<%=obj[0]%>','<%=obj[1]%>' , '<%=sdf1.format(inputFormatter.parse(obj[2].toString()) )%>')">
												<div class="cc-rockmenu">
														<div class="rolling">
														   <figure class="rolling_icon">
																<i class="fa fa-times-circle" aria-hidden="true"></i>
															</figure>
														<span>Close</span>
														</div>
													</div>
											  </button> 
										  <%}}%>
									
									
									<% List<Object[]> list = attachment.stream().filter(e-> e[0].toString().equalsIgnoreCase(obj[0].toString())).collect(Collectors.toList());
									if(list!=null && list.size()>0){
									%>
										<a href="FeedbackAttachDownload.htm?attachid=<%=list.get(0)[1]%>" title="Download"><i class="fa fa-download fa-2x" aria-hidden="true" style="width: 10px;"></i></a>
									 <%}%>
									 </td>
								</tr>
								<%
									}
								%>
							</tbody>
						</table>
					</div>
					
					 <div align="center"> 
					 		<button type="submit" class="btn btn-primary btn-sm add" formaction="FeedBackPage.htm" formmethod="get">ADD Feedback </button>				 	
					 </div>
					 <div align="center">
					 	<span style="float: left;"> <b style="color: red; ">Note: </b> B=Bug, C=Content Change , N=New Requirement, U=User Interface   </span>
					 </div>
					 </form>		
				</div>
			</div>
		</div>
	</div>
	
	</div>
	
	
	
		<div class="modal fade" id="feedbackdata" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered" role="document" style="max-width: 93% !important;height: 90%;">
				<div class="modal-content" style="min-height: 90%;" >
				    <div class="modal-header" style="background-color: rgba(0,0,0,.03);">
				    	<h4 class="modal-title" id="model-card-header" style="color: #145374">Feedback By <span id="feedby"></span></h4>
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close" >
				          <span aria-hidden="true">&times;</span>
				        </button>
				    </div>
				    
					<div class="modal-body"  style="padding: 0.5rem !important;">
						<div class="card-body" style="min-height:30% ;max-height: 93% !important;overflow-y: auto;">
							<div class="row" id="feedbackdiv">
							</div>
						</div>
					</div>
					
				</div>
			</div>
		</div>
	
	<div class="modal fade" id="Closefeedback" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered" role="document" style="max-width: 53% !important;height: 45%;">
				<div class="modal-content" style="min-height: 45%;" >
				    <div class="modal-header" style="background-color: rgba(0,0,0,.03);">
				    	<h4 class="modal-title" id="model-card-header" style="color: #145374">Close Feedback <!-- By <span id="feedby1"></span> --></h4>
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close" >
				          <span aria-hidden="true">&times;</span>
				        </button>
				    </div>
				     <div class="modal-body">
  	      
  	      	<form action="CloseFeedBack.htm" method="POST">
  	      		<div class="row">
					<div class="col-md-12" > <b>Remarks : </b><br>
  	      		    		<textarea rows="2" style="display:block; " class="form-control"  id="Remarks" name="Remarks"  placeholder="Enter Remarks..!!"  required="required"></textarea>
  	      		    </div>
  	      		</div>
  	      		<br>
  	      		<div align="center">
  	      			<input type="submit" class="btn btn-primary btn-sm submit " id="sub" value="Submit" name="sub"  onclick="return confirm('Are You Sure To Submit ?')" > 
  	      		</div>
  	      		<input type="hidden" name="feedbackid" id="FEEDBACKID">
  	      		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
  	      	</form>
  	      </div>
				</div>
			</div>
		</div>
	
	<div class="modal fade" id="ClosefeedbackRemarks" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered" role="document" style="max-width: 53% !important;height: 45%;">
				<div class="modal-content" style="min-height: 45%;" >
				    <div class="modal-header" style="background-color: rgba(0,0,0,.03);">
				    	<h4 class="modal-title" id="model-card-header" style="color: #145374"> Feedback Remarks<!-- By <span id="feedby1"></span> --></h4>
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close" >
				          <span aria-hidden="true">&times;</span>
				         
				        </button>
				    </div>
				   
				    <div class="modal-body"  style="padding: 0.5rem !important;">
						<div class="card-body" style="min-height:30% ;max-height: 93% !important;overflow-y: auto;">
							<span id="REMARKS"></span>
						</div>
					</div>
				</div>
			</div>
		</div>

</body>

<script>

function feedbackmodal(feedbackid , feedbackdate)
{
	
	$.ajax({
		
		type : "GET",
		url : "FeedbackContent.htm",
		data : {
			
			feedbackid : feedbackid
			
		},
		datatype : 'json',
		success : function(result) {
			var result= JSON.parse(result);
			var values= Object.keys(result).map(function(e){
				
				return result[e]
				
			})

			$('#feedby').html(values[1]+' on '+feedbackdate);
			$('#feedbackdiv').html(values[3]);
			$('#feedbackdata').modal('toggle');
		}
	});
}

function Closefeedbackmodal(feedbackid ,feedbackby , feedbackdate)
{
	$("#FEEDBACKID").val(feedbackid);
	$('#Closefeedback').modal('toggle');
}
function ClosefeedbackmodalRemarks(feedbackid)
{
	$('#ClosefeedbackRemarks').modal('toggle');
	$("#REMARKS").html($("#remarks"+feedbackid).val());
}
</script>




<script type="text/javascript">
$(document).ready(function(){
	  $("#myTable").DataTable({
	 "lengthMenu": [ 5, 10,25, 50, 75, 100 ],
	 "pagingType": "simple",
	 "pageLength": 5
	});
});
  
$(document).ready(function(){
	
	  $("#datepicker1").daterangepicker({
	        minDate: 0,
	        maxDate: 0,
	        numberOfMonths: 1,
	        autoclose: true,
	        "singleDatePicker" : true,
			"linkedCalendars" : false,
			"showCustomRangeLabel" : true,
	        onSelect: function(selected) {
	        $("#datepicker3").datepicker("option","minDate", selected)
	        },
	        locale : {
				format : 'DD-MM-YYYY'
			}
	    });

	    $("#datepicker3").daterangepicker({
	        minDate: 0,
	        maxDate: 0, 
	        numberOfMonths: 1,
	        autoclose: true,
	        "singleDatePicker" : true,
			"linkedCalendars" : false,
			"showCustomRangeLabel" : true,
			"minDate":$("#datepicker1").val(),
		    onSelect: function(selected) {
		    	
		    $("#datepicker1").datepicker("option","maxDate", selected)
	        },
	        locale : {
				format : 'DD-MM-YYYY'
			}
	    }); 

});
</script>


</html>