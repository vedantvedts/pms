<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="java.util.Arrays"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<spring:url value="/resources/summernote-lite.js" var="SummernoteJs" />
<spring:url value="/resources/summernote-lite.css" var="SummernoteCss" />
<script src="${SummernoteJs}"></script>
<link href="${SummernoteCss}" rel="stylesheet" />
<spring:url value="/resources/css/cars/InitiationList.css" var="initiationList" />
<link href="${initiationList}" rel="stylesheet" />
<spring:url value="/resources/css/cars/carscommon.css" var="carscommon" />
<link href="${carscommon}" rel="stylesheet" />
</head>
<body>
<%
FormatConverter fc = new FormatConverter();
List<Object[]> intiationList = (List<Object[]>)request.getAttribute("InitiationList");
String committeeId = (String)request.getAttribute("committeeId");
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
	
<br>
<div class="container-fluid">
	<div class="row">
		<div class="col-md-12">
			<div class="card shadow-nohover">
				<div class="row card-header">
			   		<div class="col-md-6">
						<h4>Initiation List</h4>
					</div>
				</div>
				<div class="card-body">	
	                
	                
	                <div align="center">
	                	<form action="#" id="myform" method="post">
	                    	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	                        <button  class="btn add" type="submit" name="Action" value="Add" formaction="CARSInitiationDetails.htm" formnovalidate="formnovalidate">Add CARS</button>
	                 	</form>
	              	</div>
				
				
				
				</div>
				
				<%if(intiationList!=null && intiationList.size()>0) {%>
				<!-- search box -->
					<form method="get" class="form-inline my-2 my-lg-0 search-box-sty">
						<div >
							<input name="search" id="search" required class="form-control mr-sm-2" placeholder="Search" aria-label="Search" type="Search" />
							<input type="submit" class="btn btn-outline-success my-2 my-sm-0" name="clicked" value="Search" />
							<a href="CARSInitiationList.htm"><button type="submit" class="btn btn-outline-danger my-2 my-sm-0" formnovalidate="formnovalidate" >Reset</button></a>
							
						</div>
					</form>
				<!-- search ends -->
					
					<!-- card project visualizations -->
					<div class="div-form-search">
						<div class="card-deck p-rel" >
							<%
							for(Object[] obj: intiationList){ 
								String carstitle = obj[4].toString();
								List<String> transactionCodes = Arrays.asList(obj[15].toString().split(","));
								String amount = String.format("%.2f", Double.parseDouble(obj[20]!=null?obj[20].toString():obj[13].toString())/100000);
							%>
								
								<div class="card div-card-1">
									<div class="card-body">
										<div class="container">
				  							<div class="row">
					  							<div class="col-lg">
													<h4 class="card-title" ><%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - " %></h4></div>
											
											</div>
										</div>
									
										
										<div class="container">
					  						<div class="row">
												<div class="col-xl hei-45">
												Title : 
														<%if(obj[4]!=null){%>
														    <span>
														    	<%if(carstitle.length()<100){%> <%=carstitle!=null?StringEscapeUtils.escapeHtml4(carstitle): " - "%> <%}else{%><%=carstitle!=null?StringEscapeUtils.escapeHtml4(carstitle).substring(0,100):" - "%>
														    </span>
															<span>
																<b><span class="span-font"><a href="#" class="text-decoration-none" onclick="titlemodal('<%=obj[0]%>','<%=obj[4]%>')" >......(View More)</a></span></b>
															</span>
											         		<%}%> 
														<%}else{ %>
															-
														<%} %>
												<br/></div>
											</div>
										</div>
									
										<div class="container">
					  						<div class="row">
					  							<div class="col-xl text-left">
													Date : <%if(obj[3]!=null) {%><%=fc.SqlToRegularDate(StringEscapeUtils.escapeHtml4(obj[3].toString())) %><%} else {%>-<%} %>
												</div>
												<div class="col-">
													Funds from : <%if(obj[7]!=null) {%> <%if(StringEscapeUtils.escapeHtml4(obj[7].toString()).equalsIgnoreCase("0")) {%>Buildup<%} else{%>Project<%} }%>
												</div>
												
											</div>
										</div>
									
										<div class="container" >
					  						<div class="row">
												<div class="col-xl">
													Cost : <%=amount %> Lakhs
												</div>
												<div class="col-">
													Duration : <%=obj[33]!=null?StringEscapeUtils.escapeHtml4(obj[33].toString()):(obj[8]!=null?StringEscapeUtils.escapeHtml4(obj[8].toString()):"0") %> Months
												</div>
											</div>
										</div>
										
										<div class="container" >
					  						<div class="row">
												<div class="col-xl">
													<form action="#">
				                                        	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				                                        	<input type="hidden" name="carsInitiationId" value="<%=obj[0] %>">
				                                       	  	<button type="submit" class="btn btn-sm btn-link-1 w-100 btn-status fw-600 color-<%=obj[11].toString().replace("#", "").trim() %>" formaction=CARSTransStatus.htm value="<%=obj[0] %>" name="carsInitiationId"  data-toggle="tooltip" data-placement="top" title="Transaction History" formtarget="_blank">
											    			<%=obj[10]!=null?StringEscapeUtils.escapeHtml4(obj[10].toString()): " - " %> <i class="fa fa-telegram i-float" aria-hidden="true" ></i>
											    			</button>
	                                        			</form>
													<br/>
												</div>
											</div>
										</div>
												
										<div class="div-bot">
											<div class="container">
						  						<div class="row text-center">
													<div class="col-xl">
													
														<form action="#" method="post">
		                                        			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		                                        	
	                                       	 				<button class="editable-clicko" name="carsInitiationId" value="<%=obj[0] %>" formaction="CARSInitiationDetails.htm">
																<div class="cc-rockmenu">
																	<div class="rolling">
																		<figure class="rolling_icon">
																			<img src="view/images/clipboard.png">
																		</figure>
																		<span>Details</span>
																	</div>
																</div>
											    			</button>
											    			<%if(obj[12]!=null && (obj[12].toString().equalsIgnoreCase("FWD") || obj[12].toString().equalsIgnoreCase("SFU"))) {%>
					                                       	 	<button class="editable-clicko" name="carsUserRevoke" value="<%=obj[0] %>/<%=obj[12] %>" formaction="CARSUserRevoke.htm" formmethod="post" onclick="return confirm('Are you sure to revoke?')">
																	<div class="cc-rockmenu">
																		<div class="rolling">
																			<figure class="rolling_icon">
																				<img src="view/images/userrevoke.png" class="w-22">
																			</figure>
																			<span>Revoke</span>
																		</div>
																	</div>
															    </button>
											    			<%} %>
											    			<%if(obj[14]!=null && obj[14].toString().equalsIgnoreCase("A")) {%>
		                                       	 				<button class="editable-clicko" name="carsInitiationId" value="<%=obj[0] %>" formaction="CARSMilestonesMonitor.htm">
																	<div class="cc-rockmenu">
																		<div class="rolling">
																			<figure class="rolling_icon">
																				<img src="view/images/milestone.png">
																			</figure>
																			<span>Milestones</span>
																		</div>
																	</div>
												    			</button>
											    			<%} %>
												    		<%if((transactionCodes.contains("AGD") || transactionCodes.contains("APD")) ) {%>
		                                       	 				<button class="editable-clicko" name="carsInitiationId" value="<%=obj[0] %>" formaction="CommitteeMainMembers.htm">
																	<div class="cc-rockmenu">
																		<div class="rolling">
																			<figure class="rolling_icon">
																				<img src="view/images/committee.jpeg" class="w-35">
																			</figure>
																			<span>Constitute</span>
																		</div>
																	</div>
												    			</button>
												    			
												    			<input type="hidden" name="committeeid" value="<%=committeeId%>">
												    			<input type="hidden" name="committeemainid" value="<%=obj[19] %>">
												    			<input type="hidden" name="projectid" value="0">
												    			<input type="hidden" name="divisionid" value="0">
												    			<input type="hidden" name="initiationid" value="0">
												    		<%} %>	
												    		<textarea id="currentStatus<%=obj[0] %>" class="dis-non"><%=obj[34]!=null?StringEscapeUtils.escapeHtml4(obj[34].toString()):"" %></textarea>
											    			<button type="button" class="editable-clicko" id="carsDetails" data-id="<%=obj[0] %>" data-carsno="<%=obj[2] %>" data-toggle="modal" data-target="#currentStatusModal" formnovalidate="formnovalidate">
																<div class="cc-rockmenu">
																	<div class="rolling">
																		<figure class="rolling_icon">
																			<img src="view/images/current-status.png" class="w-30">
																		</figure>
																		<span>Status</span>
																	</div>
																</div>
											    			</button>
		                                        		</form>
													</div>
												</div>
											</div>
										</div>
										
									</div>
								</div>
							
							<% }%>
							</div>
							<br/><br/>						
					</div>
					<!-- card project visualizations FINISH -->
					
					<div class="pagin pagin-sty"  >
						<nav aria-label="Page navigation example" >
							<div class="pagination" >
								<% int pagin = Integer.parseInt(request.getAttribute("pagination").toString()) ; %>
							
									<div class="page-item">
										<form method="get" action="CARSInitiationList.htm" onsubmit="return verify()">
											<input class="page-link" type="submit" <%if(pagin==0){ %>disabled<%} %> value="Previous" />
											<% if (request.getAttribute("searchFactor")!=null){ %>
												<input type="hidden" value="<%= request.getAttribute("searchFactor").toString() %>" name="search" />
											<%} %>
											<input type="hidden" id="pagination" name="pagination" value=<%=pagin-1 %> />
										</form>
									</div>
									<div class="page-item">
										<input class="page-link" type="button" value="<%=pagin+1 %>" disabled/>
									</div>
									<div class="page-item">
										<form method="get" action="CARSInitiationList.htm" >
											<% int last=pagin+2;if(Integer.parseInt(request.getAttribute("maxpagin").toString())<last)
												last=0; %>
												<input class="page-link" type="submit" value="Next" <%if(last==0){ %><%="disabled"%><%} %> />
												<input type="hidden" name="pagination" value=<%=pagin+1 %> />
										</form>
									</div>
							</div>
						</nav>
					</div>
				<%} %>	
				
				<!-- ------------------------------------- CARS Full Title Modal ----------------------------- -->
				<div class="modal fade" id="titlemodal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
					<div class="modal-dialog modal-dialog-jump modal-dialog-centered max-wid" role="document" >
						<div class="modal-content min-hei" >
						    <div class="modal-header modal-bg" >
						    	<h4 class="modal-title title-col" id="model-card-header" >Title</h4>
						        <button type="button" class="close" data-dismiss="modal" aria-label="Close" >
						          <span aria-hidden="true">&times;</span>
						        </button>
						    </div>
						    
							<div class="modal-body p-2" >
								<div class="card-body modal-card-body" >
									<div class="row" id="titledata">
									</div>
								</div>
							</div>
							
						</div>
					</div>
				</div>
				
				<!-- ------------------------------------- CARS Full Title Modal End ----------------------------- -->
				<!-- ------------------------------------- CARS Current Status Modal ----------------------------- -->
				<div class="modal fade bd-example-modal-lg mt-plus-5" id="currentStatusModal" tabindex="-1" role="dialog" aria-labelledby="currentStatusModal" aria-hidden="true" >
					<div class="modal-dialog modal-lg max-w-900" role="document" >
						<div class="modal-content">
							<div class="modal-header bg-primary text-light" >
					        	<h5 class="modal-title ">Current Status - <span id="carsnoheader"></span></h5>
						        <button type="button" class="close ts-non"  data-dismiss="modal" aria-label="Close">
						          <span aria-hidden="true" class="span-col">&times;</span>
						        </button>
					      	</div>
			     			<div class="modal-body">
			     				<div class="container-fluid mt-3">
			     					<div class="row">
										<div class="col-md-12 " align="left">
											<form action="CARSCurrentStatusSubmit.htm" method="POST" id="myfrm">
												<div id="Editor" class="center"></div>
												<textarea id="currentStatus" name="currentStatus" class="dis-non"></textarea>
												<div class="mt-2" align="center" id="detailsSubmit">
													<span id="EditorDetails"></span>
													<input type="hidden" name="carsInitiationId" id="carsInitiationId">
													<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
													<span id="Editorspan">
														<span id="btn1" class="d-block"><button type="submit"class="btn btn-sm btn-warning edit mt-2" onclick="return confirm('Are you sure to Update?')">UPDATE</button></span>
													</span>
												</div>
											</form>
										</div>
									</div>
			     				</div>
			     			</div>
			     		</div>
			     	</div>
			     </div>				
			     <!-- ------------------------------------- CARS Current Status Modal End----------------------------- -->				
			</div>
		</div>
	</div>
</div>	

<script type="text/javascript">
function titlemodal(carsinitiationid,carstitle) {
	
	$('#titledata').html(carstitle);
	$('#titlemodal').modal('toggle');
	event.preventDefault();
}
	
	

</script>

<script type="text/javascript">

$(document).ready(function(){
	  $("#myTable").DataTable({
	 "lengthMenu": [  5,10,25, 50, 75, 100 ],
	 "pagingType": "simple"
	
	});
	  
	  
});

function verify(){
	const ele = document.getElementById("pagination").value;
	if(ele<0)
	{
		return false;
	}
	return true;
}

//Define a common Summernote configuration
var summernoteConfig = {
    width: 900,
    toolbar: [
        ['style', ['bold', 'italic', 'underline', 'clear']],
        ['font', ['fontsize', 'fontname', 'color', 'superscript', 'subscript']],
        ['insert', ['picture', 'table']],
        ['para', ['ul', 'ol', 'paragraph']],
        ['height', ['height']]
    ],
    fontSizes: ['8', '9', '10', '11', '12', '14', '16', '18', '24', '36', '48', '64', '82', '150'],
    fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New', 'Helvetica', 'Impact', 'Tahoma', 'Times New Roman', 'Verdana','Segoe UI','Segoe UI Emoji','Segoe UI Symbol'],
    buttons: {
        superscript: function() {
            return $.summernote.ui.button({
                contents: '<sup>S</sup>',
                tooltip: 'Superscript',
                click: function() {
                    document.execCommand('superscript');
                }
            }).render();
        },
        subscript: function() {
            return $.summernote.ui.button({
                contents: '<sub>S</sub>',
                tooltip: 'Subscript',
                click: function() {
                    document.execCommand('subscript');
                }
            }).render();
        }
    },
    height: 300
};

// This is for RSQR
/* CKEDITOR.replace('Editor', editor_config); */
$('#Editor').summernote(summernoteConfig);

$('#currentStatusModal').on('show.bs.modal', function (event) {
    var button = $(event.relatedTarget); // Button that triggered the modal
    var id = button.data('id');          // Extract info from data-* attributes
    var carsno = button.data('carsno');
    var status = $('#currentStatus'+id).val();
    status = (status=='null' || status == null)?'':status;


    // Escape script tags so they show as text
    status = escapeScriptTags(status);
    
    // Update the modal's content
    var modal = $(this);
    modal.find('.modal-title #carsnoheader').text(carsno);
    modal.find('.modal-body #carsInitiationId').val(id); // Example of updating a modal element
    modal.find('.modal-body #currentStatus').html(status);
    
    //
    modal.find('.modal-body #Editor').summernote('code', status);
});
function escapeScriptTags(html) {
    return html.replace(/<script/gi, '&lt;script')
               .replace(/<\/script>/gi, '&lt;/script&gt;');
}


$('#myfrm').submit(function() {
	 var data = $('#Editor').summernote('code');
	 $('textarea[name=currentStatus]').val(data);
});
</script>
</body>
</html>