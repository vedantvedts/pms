<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
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

th{
 text-align : center;
}

/* icon styles */
.cc-rockmenu {
	color: fff;
	padding: 0px 5px;
	font-family: 'Lato', sans-serif;
}

.cc-rockmenu .rolling {
	display: inline-block;
	cursor: pointer;
	width: 34px;
	height: 30px;
	text-align: left;
	overflow: hidden;
	transition: all 0.3s ease-out;
	white-space: nowrap;
}

.cc-rockmenu .rolling:hover {
	width: 108px;
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
.btn-status {
  position: relative;
  z-index: 1; 
}

.btn-status:hover {
  transform: scale(1.05);
  z-index: 5;
  box-shadow: 0 0 20px rgba(0, 0, 0, 0.5);
}
</style>
</head>
<body>
<%	
	
	List<Object[]> roadMapPendingList =(List<Object[]>)request.getAttribute("roadMapPendingList");
	List<Object[]> roadMapApprovedList =(List<Object[]>)request.getAttribute("roadMapApprovedList");
	String fromdate = (String)request.getAttribute("fromdate");
	String todate   = (String)request.getAttribute("todate");
	
	String tab   = (String)request.getAttribute("tab");
	
	FormatConverter fc = new FormatConverter();
	SimpleDateFormat sdf = fc.getSqlDateFormat();
	SimpleDateFormat rdf = fc.getRegularDateFormat();
	

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
			<div class="col-md-12">
				<div class="card shadow-nohover">
					<div class="row card-header">
			   			<div class="col-md-6">
							<h4>Road Map Approvals</h4>
						</div>
					</div>
					<div class="card-body">

						<div class="row w-100" style="margin-bottom: 10px;">
							<div class="col-12">
         						<ul class="nav nav-pills mb-3" id="pills-tab" role="tablist" style="background-color: #E1E5E8;padding:0px;">
		  							<li class="nav-item" style="width: 50%;"  >
		    							<div class="nav-link active" style="text-align: center;" id="pills-mov-property-tab" data-toggle="pill" data-target="#pills-mov-property" role="tab" aria-controls="pills-mov-property" aria-selected="true">
			   								<span>Pending</span> 
											<span class="badge badge-danger badge-counter count-badge" style="margin-left: 0px;">
				   		 						<%if(roadMapPendingList.size() >99 ){ %>
				   									99+
				   								<%}else{ %>
				   								<%=roadMapPendingList.size() %>
												<%} %>			   			
				  							</span> 
		    							</div>
		  							</li>
		  							<li class="nav-item"  style="width: 50%;">
		    							<div class="nav-link" style="text-align: center;" id="pills-imm-property-tab" data-toggle="pill" data-target="#pills-imm-property" role="tab" aria-controls="pills-imm-property" aria-selected="false">
		    	 							<span>Approved</span> 
		    	 							<span class="badge badge-danger badge-counter count-badge" style="margin-left: 0px;">
				   		 						<%if(roadMapApprovedList.size()>99){ %>
				   									99+
				   								<%}else{ %>
				   								<%=roadMapApprovedList.size() %>
												<%} %>			   			
				  							</span> 
		    							</div>
		  							</li>
								</ul>
	   						</div>
						</div>
	
						<!-- Pending List -->
						<div class="card">					
							<div class="card-body">
								<div class="container-fluid" >
           							<div class="tab-content" id="pills-tabContent">
            							<div class="tab-pane fade show active" id="pills-mov-property" role="tabpanel" aria-labelledby="pills-mov-property-tab">
		    								<form action="#" method="POST" id="">
            									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            									<input type="hidden" name="isApproval" value="Y">
             									<div class="table-responsive">
              										<table class="table table-hover  table-striped table-condensed table-bordered table-fixed" id="myTable">
														<thead>
															<tr>
					   											<th style="">SN</th>
					   											<th style="">Initiated By</th>
					   											<!-- <th>EmpNo</th>
					   											<th>CARSNo</th> -->
					   											<th style="">Date</th>
					   											<th style="">Approval for</th>
                       											<th style="">Action</th>
                  											</tr>
														</thead>
                 										<tbody>
                       										<% int SN=0;
					   										    if(roadMapPendingList!=null && roadMapPendingList.size()>0){
                         							 			for(Object[] form:roadMapPendingList ){
                      							 			%>
                        									<tr>
                            									<td style="text-align: center;width: 5%;"><%=++SN%></td>
                            									<td style="width: 30%;"><%=form[2]!=null?StringEscapeUtils.escapeHtml4(form[2].toString()): " - "%>, <%=form[3]!=null?StringEscapeUtils.escapeHtml4(form[3].toString()): " - "%></td>
                            									<%-- <td style="text-align: center;width: 10%;"><%=form[1]%></td>
                            									<td style="text-align: center;width: 15%;"><%=form[6]%></td> --%>
                            									<td style="text-align: center;width: 10%;"><%=form[5]!=null?fc.SqlToRegularDate(form[5].toString()):" - " %></td>
                            									<td style="text-align: center;width: 10%;"><%=form[6]!=null?StringEscapeUtils.escapeHtml4(form[6].toString()): " - "%></td>
                            									<td style="text-align: center;width: 20%;">
                            										<button type="submit" class="btn btn-sm view-icon" formaction="RoadMapDetailsPreview.htm" name="roadMapId" value="<%=form[4]%>" data-toggle="tooltip" data-placement="top" title="Road Map Preview" style="font-weight: 600;" >
								   										<div class="cc-rockmenu">
																			<div class="rolling">
																				<figure class="rolling_icon">
																					<img src="view/images/preview3.png">
																				</figure>
																				<span>Preview</span>
																			</div>
																		</div>
																	</button>
																				
																	<button type="submit" class="btn btn-sm" formaction="RoadMapPreviewDownload.htm" name="roadMapId" value="<%=form[4]%>" formtarget="blank" formmethod="post" data-toggle="tooltip" data-placement="top" title="Download">
								  	 									<div class="cc-rockmenu">
																			<div class="rolling">
																				<figure class="rolling_icon">
																					<img src="view/images/document.png">
																				</figure>
																				<span>Road Map</span>
																			</div>
																		</div>
																	</button>
																	
						 										</td>
                        									</tr>
                       										<%} }%>
                       										
                 										</tbody>  
            										</table>
          										</div>
         									</form>
			  							</div>
 
										<!-- Approved List -->	
										<div class="tab-pane fade" id="pills-imm-property" role="tabpanel" aria-labelledby="pills-imm-property-tab">	
											<div class="card-body main-card " >	
												<form method="post" action="RoadMapApprovals.htm" >
													<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
													<input type="hidden" name="tab" value="closed"/>
														<div class="row w-100" style="margin-top: 10px;margin-bottom: 10px;">
															<div class="col-md-12" style="float: right;">
																<table style="float: right;">
																	<tr>
																		<td> From Date :&nbsp; </td>
							        									<td> 
																			<input type="text" class="form-control input-sm mydate" onchange="this.form.submit()"  readonly="readonly"  <%if(fromdate!=null){%>
								        										value="<%=fc.SqlToRegularDate(fromdate)%>" <%}%> value=""  id="fromdate" name="fromdate"  required="required"   > 
																		</td>
																		<td></td>
																		<td >To Date :&nbsp;</td>
																		<td>					
																			<input type="text"  class="form-control input-sm mydate" onchange="this.form.submit()"  readonly="readonly" <%if(todate!=null){%>
								        	 									value="<%=fc.SqlToRegularDate(todate)%>" <%}%>  value=""  id="todate" name="todate"  required="required"  > 							
																		</td>
																	</tr>
																</table>
					 										</div>
					 									</div>
												</form>
												<div class="row" >
		 											<div class="col-md-12">
														<form action="#" method="POST" id="">
            												<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            												<input type="hidden" name="isApproval" value="N">
             													<div class="table-responsive">
              														<table class="table table-hover  table-striped table-condensed table-bordered table-fixed" id="myTable1">
																		<thead>
																			<tr>
					   															<th>SN</th>
					  															<th>Initiated By</th>
					  															<!-- <th>EmpNo</th>
					   															<th>CARSNo</th> -->
					   															<th style="">Approval for</th>
                       															<th style="width: ">Status</th>
                       															<th style="width: ">Action</th>
                  															</tr>
																		</thead>
                 														<tbody>
                      													    <%	int SNA=0;
                      													    	if(roadMapApprovedList!=null && roadMapApprovedList.size()>0) {
                          															for(Object[] form:roadMapApprovedList ) {
                       													    %>
                        													<tr>
                            													<td style="text-align: center;width: 5%;"><%=++SNA%></td>
                            													<td style="text-align: left;width: 22%;"><%=form[2]!=null?StringEscapeUtils.escapeHtml4(form[2].toString()): " - "%>, <%=form[3]!=null?StringEscapeUtils.escapeHtml4(form[3].toString()): " - "%></td>
                            													<%-- <td style="text-align: center;width: 5%;"><%=form[1] %> </td>
                            													<td style="text-align: center;width: 15%;"><%=form[6] %> </td> --%>
                            													<td style="text-align: center;width: 8%;"><%=form[6]!=null?StringEscapeUtils.escapeHtml4(form[6].toString()): " - " %> </td>
                            													<td style="text-align: center;width: 25%;">
																					<button type="submit" class="btn btn-sm btn-link w-50 btn-status" formaction="RoadMapTransStatus.htm" value="<%=form[4] %>" name="roadMapId"  data-toggle="tooltip" data-placement="top" title="Transaction History" style=" color: <%=form[9] %>; font-weight: 600;" formtarget="_blank">
								    													<%=form[8]!=null?StringEscapeUtils.escapeHtml4(form[8].toString()): " - " %> <i class="fa fa-telegram" aria-hidden="true" style="float: right;margin-top: 0.3rem;"></i>
								    												</button>
								    												
						 														</td>
						 														<td style="text-align: center;width: 20%;">
						 															<button type="submit" class="btn btn-sm view-icon" formaction="RoadMapDetailsPreview.htm" name="roadMapId" value="<%=form[4]%>" data-toggle="tooltip" data-placement="top" title="Road Map Preview" style="font-weight: 600;" >
								   														<div class="cc-rockmenu">
																							<div class="rolling">
																								<figure class="rolling_icon">
																									<img src="view/images/preview3.png">
																								</figure>
																								<span>Preview</span>
																							</div>
																						</div>
																					</button>
																					
																					<button type="submit" class="btn btn-sm" formaction="RoadMapPreviewDownload.htm" name="roadMapId" value="<%=form[4]%>" formtarget="blank" formmethod="post" data-toggle="tooltip" data-placement="top" title="Download">
								  	 													<div class="cc-rockmenu">
																							<div class="rolling">
																								<figure class="rolling_icon">
																									<img src="view/images/document.png">
																								</figure>
																								<span>Road Map</span>
																							</div>
																						</div>
																					</button>
            
						 														</td>
                        													</tr>
                       													 	<%} }%>
                   														</tbody>
                 													</table>
                												</div> 
               												</form>
               											</div>
               										</div>
               									</div>				
			  								</div>
		   								</div>
									</div>
     							</div>
							</div>
						</div>
					</div>
				</div>
		</div>
</div>
					
<script type="text/javascript">
$("#myTable1,#myTable").DataTable({
    "lengthMenu": [ 50, 75, 100],
    "pagingType": "simple"

});

$('#fromdate').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	/* "minDate" :datearray,   */
	 <%-- "startDate" : new Date('<%=fromdate%>'), --%> 
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
		<%-- "startDate" : new Date('<%=todate%>'), --%> 
		"minDate" :$("#fromdate").val(),  
		"cancelClass" : "btn-default",
		showDropdowns : true,
		locale : {
			format : 'DD-MM-YYYY'
		}
	});

	 /* $(document).ready(function(){
		   $('#fromdate, #todate').change(function(){
		       $('#myform').submit();
		    });
		}); */ 

	<%if(tab!=null && tab.equals("closed")){%>
	
		$('#pills-imm-property-tab').click();
	
	<%}%>
	<% String val = request.getParameter("val");
	if(val!=null && val.equalsIgnoreCase("app")){%>
		$('#pills-imm-property-tab').click();
	<%}%>
	
	
	$(function () {
		$('[data-toggle="tooltip"]').tooltip()
		});	
	
</script>

</body>
</html>