<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.util.* , java.text.DateFormat"%>
	<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<title>FEEDBACK LIST</title>
<spring:url value="/resources/css/master/feedbackList.css" var="feedbackList" />     
<link href="${feedbackList}" rel="stylesheet" />
</head>
<body>

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
		<div class="row">
			<div class="col-md-1"></div>
			<div class="col-md-10">
				<div class="card shadow-nohover" >
					<div class="card-header">
						<form action="FeedbackList.htm" method="post">
							<div class="row">
								<div class="col-md-3"><h4>Feedback List</h4></div>
								<div class="col-md-8 md8col" >
									<table> 
										<tr>
											<th> Type: </th>
											<td  class="typetd">
												<select class="form-control selectdee" id="ftype" name="feedbacktype" data-container="body" data-live-search="true"    onchange="this.form.submit()">
													<option value=""  selected="selected"	hidden="true">--Select--</option>
													<option value="A" <%if(feedbacktype!=null && "A".equalsIgnoreCase(feedbacktype)){%> selected="selected" <%}%> >All</option>
													<option value="B" <%if(feedbacktype!=null && "B".equalsIgnoreCase(feedbacktype)){%> selected="selected" <%}%>>Bug</option>
													<option value="C" <%if(feedbacktype!=null && "C".equalsIgnoreCase(feedbacktype)){%> selected="selected" <%}%>>Content Change</option>
													<option value="N" <%if(feedbacktype!=null && "N".equalsIgnoreCase(feedbacktype)){%> selected="selected" <%}%>>New Requirement</option>
													<option value="U" <%if(feedbacktype!=null && "U".equalsIgnoreCase(feedbacktype)){%> selected="selected" <%}%>>User Interface</option>
												</select>
											</td>
											<th>From Date:</th>
											<td>
												<input  class="form-control form-control date"  data-date-format="dd-mm-yyyy" id="datepicker1" name="Fromdate"  required="required"  
												<%if(fromdate!=null){%> value="<%=(fromdate) %>" <%} %> onchange="this.form.submit()">
											</td>
											<th>To Date:</th>
											<td>
												<input  class="form-control form-control date" data-date-format="dd-mm-yyyy" id="datepicker3" name="Todate"  
												<%if(todate!=null){%> value="<%=(todate) %>" <%} %>	onchange="this.form.submit()">
											</td>
										</tr>
									</table>
								</div>
								<div class="col-md-1 backButton" ><a class="btn btn-sm back backbtn" href="MainDashBoard.htm" >BACK</a></div>
							</div>
							<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
						</form>
					</div>	
					<div class="card-body"> 
							<div class="datatable-dashv1-list custom-datatable-overright">
			                    
			                	<table class="table table-bordered table-hover table-striped table-condensed " id="myTable" > 
				                    <thead class="center">
										<tr>
											<th width="5%">SN.</th>
											<th width="15%">Name</th>
											<th width="5%">Type</th>
											<th width="10%">Date</th>
											<th width="35%">View</th>
											<th width="20%">Action</th>
										</tr>
									</thead>
									<tbody>
										<% int count=0;
											for (Object[] obj : FeedbackList) {
												String feedback = obj[3].toString();
										%>
										<tr>
											<td class="center"><%=++count%></td>
											<td><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()):"-"%></td>  
											<td class="center"><%=obj[4]!=null? StringEscapeUtils.escapeHtml4(obj[4].toString()):"-"%></td>
											<td class="center"><%=obj[2]!=null?sdf.format(inputFormatter.parse(obj[2].toString()) ):"-" %></td>
											<td>
												<span <%if(obj[5]!=null && obj[5].toString().equalsIgnoreCase("C")){%>   class="spanClss"<%}%>>
													<%if(feedback.length()<90){ %> 
														<%=feedback!=null?StringEscapeUtils.escapeHtml4(feedback):"-"%> 
													<%}else{ %>
														<%=feedback!=null?StringEscapeUtils.escapeHtml4(feedback.substring(0,90)):"-" %> 
														 <button type="button" class="editable-click" name="sub" value="Modify" onclick="feedbackmodal('<%=obj[0]!=null?StringEscapeUtils.escapeHtml4(obj[0].toString()):"-"%>' , '<%=obj[2]!=null?sdf1.format(inputFormatter.parse(obj[2].toString())):"" %>')">
															<b><span  class="readMoreSpan">......(View More)</span></b>
														</button> 
													<% }%>
												</span>
											</td>
											<td class="center">
												<form action="#" id="feedbackaction_<%=count%>">
													<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
													
													<input type="hidden"  name="feedbackId" value="<%=obj[0] %>">
													<button class="editable-click" type="submit" formaction="FeedbackTransaction.htm" formmethod="post" formnovalidate="formnovalidate" >
														<div class="cc-rockmenu">
															<div class="rolling">
																<figure class="rolling_icon">
																	<i class="fa fa-comments" aria-hidden="true"></i>
																</figure>
																<span  class="comments">Comments</span>
															</div>
														</div>
													</button>
													<%if(logintype.equalsIgnoreCase("A") && obj[5]!=null && !obj[5].toString().equalsIgnoreCase("C")){ %>
														<button class="editable-click" type="submit" formaction="CloseFeedBack.htm" formmethod="post" formnovalidate="formnovalidate"
														onclick="return confirm('Are you sure to Close?')" >
															<div class="cc-rockmenu">
																<div class="rolling">
																	<figure class="rolling_icon">
																		<i class="fa fa-times-circle iconCircle" aria-hidden="true" ></i>
																	</figure>
																	<span  class="close">Close</span>
																</div>
															</div>
														</button>
													<%} %>
													<% List<Object[]> list = attachment.stream().filter(e-> e[0].toString().equalsIgnoreCase(obj[0].toString())).collect(Collectors.toList());
													if(list!=null && list.size()>0){ %>
														<button type="submit" class="editable-click" name="attachid" value="<%=list.get(0)[1]!=null?StringEscapeUtils.escapeHtml4(list.get(0)[1].toString()):""%>" formaction="FeedbackAttachDownload.htm" formmethod="get" formnovalidate="formnovalidate" title="Download">
															<div class="cc-rockmenu">
																<div class="rolling">
																	<figure class="rolling_icon">
																		<i class="fa fa-download" aria-hidden="true"></i>
																	</figure>
																	<span  class="download">Download</span>
																</div>
															</div>
														</button>
													<%}%>
												</form>	
									 		</td>
										</tr>
										<%}%>
									</tbody>
								</table>
							</div>
							<form action="#">
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
								<div align="center"> 
						 			<button type="submit" class="btn btn-primary btn-sm add" formaction="FeedBackPage.htm" formmethod="get">ADD Feedback </button>				 	
						 		</div>
					 		</form>
					 		<div align="center">
					 			<span  class="noteSpan"> <b  class="noteBold">Note: </b> B=Bug, C=Content Change , N=New Requirement, U=User Interface   </span>
					 		</div>	
					</div>
				</div>
			</div>
		</div>
	
	</div>
	
	
	
	<div class="modal fade" id="feedbackdata" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered dialogModal" role="document" >
			<div class="modal-content contentModal"  >
				<div class="modal-header headerModal" >
			    	<h4 class="modal-title feedbackBy" id="model-card-header" >Feedback By <span id="feedby"></span></h4>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close" >
			          <span aria-hidden="true">&times;</span>
			        </button>
				</div>
				    
				<div class="modal-body bodyModal"  >
					<div class="card-body bodyC" >
						<div class="row" id="feedbackdiv"></div>
					</div>
				</div>
					
			</div>
		</div>
	</div>
	
	<div class="modal fade" id="Closefeedback" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered dialogModal1 " role="document" >
			<div class="modal-content closefeedbackmodal" >
				<div class="modal-header headerModal" >
					<h4 class="modal-title feedbackBy" id="model-card-header" >Comment <!-- By <span id="feedby1"></span> --></h4>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close" >
			          <span aria-hidden="true">&times;</span>
			        </button>
				</div>
				<div class="modal-body">
  	      
		  	      	<form action="CloseFeedBack.htm" method="POST">
		  	      		<div class="row">
							<div class="col-md-12" > <b>Comment : </b><br>
		  	      		    		<textarea rows="2"  class="form-control"  id="Remarks" name="Remarks"  placeholder="Enter Comments"  required="required"></textarea>
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
		<div class="modal-dialog modal-dialog-centered dialogModal1" role="document" >
			<div class="modal-content modalC"  >
				<div class="modal-header headerModal" >
			    	<h4 class="modal-title feedbackBy" id="model-card-header" > Feedback Remarks<!-- By <span id="feedby1"></span> --></h4>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close" >
			          <span aria-hidden="true">&times;</span>
			         
			        </button>
				</div>
				   
			    <div class="modal-body bodyModal"  >
					<div class="card-body remarksBody" >
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