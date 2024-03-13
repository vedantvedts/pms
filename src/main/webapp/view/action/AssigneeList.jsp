<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.io.ByteArrayOutputStream,java.io.ObjectOutputStream"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="java.time.LocalDate"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

 

<title>Assignee List</title>
<style type="text/css">
label{
font-weight: bold;
  font-size: 13px;
}
.spans{
font-weight: 600;
}
body{
background-color: #f2edfa;
overflow-x:hidden !important; 
}
h6{
	text-decoration: none !important;
}
.cc-rockmenu {
	color: fff;
	padding: 0px 5px;
	font-family: 'Lato', sans-serif;
}

.cc-rockmenu .rolling {
	display: inline-block;
	cursor: pointer;
	width: 24px;
	height: 22px;
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

.width {
	width: 270px !important;
}

a:hover {
	color: white;
}

</style>
</head>
 
<body>
  <%

  List<Object[]> AssigneeList=(List<Object[]>)request.getAttribute("AssigneeList");
  List<Object[]> AssigneemainList=(List<Object[]>)request.getAttribute("AssigneemainList");
  SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
  SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd");
 
  String EmpId = ((Long)session.getAttribute("EmpId")).toString();
  
 %>



<%String ses=(String)request.getParameter("result"); 
 String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null){
	%>
	<div align="center">
	<div class="alert alert-danger" role="alert" >
               <%=ses1 %>
                    </div></div>
	<%}if(ses!=null){ %>
	<div align="center">
	<div class="alert alert-success" role="alert"  >
        <%=ses %>
        </div></div>
        <%} %>
    <br />
    

	<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card shadow-nohover">
				
					<h5 class="card-header">Assigned List</h5>
					
					<div class="card-body">

						<div class="data-table-area mg-b-15">
							<div class="container-fluid">
								<!-- <form action="ProjectIntiationListSubmit.htm" method="POST" name="myfrm" > -->
								<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
									<div class="sparkline13-list">

										<div class="sparkline13-graph">
											<div class="datatable-dashv1-list custom-datatable-overright">
												<div id="toolbar">
												<!-- 	<select class="form-control dt-tb">
														<option value="">Export Basic</option>
														<option value="all">Export All</option>
														<option value="selected">Export Selected</option>
													</select> -->
													<span class="badge">PDC COLOR CODES:</span>
												<span class="badge badge-primary  p-2">PDC ON TODAY</span>
												<span class="badge badge-success p-2">UPCOMING PDC</span>
												<span class="badge badge-danger p-2">MISSED PDC</span>
												</div>
											<!-- 	<div align="right" style="height:30px;width:100%;">
												<span class="badge">PDC COLOR CODES:</span>
												<span class="badge badge-primary  p-2">PDC ON TODAY</span>
												<span class="badge badge-success p-2">UPCOMING PDC</span>
												<span class="badge badge-danger p-2">MISSED PDC</span>
												 </div> -->
												<table id="table" data-toggle="table" data-pagination="true"
													data-search="true" data-show-columns="true"
													data-show-pagination-switch="true" data-show-refresh="true"
													data-key-events="true" data-show-toggle="true"
													data-resizable="true" data-cookie="true"
													data-cookie-id-table="saveId" data-show-export="true"
													data-click-to-select="true" data-toolbar="#toolbar">
													<thead>

														<tr>
															<th>SN</th>
															<th>Action Id</th>
															<th style="">Action Item</th>
															<th class="width-110px">PDC</th>
															<th class="width-110px">Assigned Date</th>								
														 	<th style="">Assigner</th>	
														 	<th>Remarks</th>
														 	<th class="width-140px">Action</th>
														</tr>
													</thead>
													<tbody>
														<%int count=1;
														if(AssigneemainList!=null&&AssigneemainList.size()>0){	
										         	for (Object[] obj :AssigneemainList) {
										   			   %>
														<tr>
															<td class="center"><%=count %></td>
															<td><%=obj[9] %></td>
															<td>
															<%if(obj[5].toString().length()>100){ %>
															<%=obj[5].toString().substring(0, 100) %>
															<input type="hidden" value='"<%=obj[5].toString()%>"' id="td<%=obj[0].toString()%>">
														 <span style="text-decoration: underline;font-size:13px;color: #145374;cursor: pointer;font-weight: bolder" onclick="showAction('<%=obj[0].toString()%>','<%=obj[9].toString()%>')">show more..</span>
															<%}else{ %>
															<%=obj[5].toString() %>
															<%} %>
															</td>
															<td><span <%if(LocalDate.now().toString().equalsIgnoreCase(obj[4].toString())) {%>class="text-primary spans"<%} %>
															<%if(LocalDate.now().isAfter(LocalDate.parse(obj[4].toString()))){ %>class="text-danger spans"<%} %>
															<%if(LocalDate.now().isBefore(LocalDate.parse(obj[4].toString()))){ %>class="text-success spans"<%} %>
															>
															<%=sdf.format(obj[4])%></span>
															</td>
															<td><%=sdf.format(obj[3])%></td>
															<td><%=obj[1]%>, <%=obj[2]%></td>
															<td><%if(obj[7]!=null){%><%=obj[7] %><%}else{ %>-<%} %></td>
															
															
															<td class="left width">		
																
															<form name="myForm1" id="myForm1" action="ActionSubLaunch.htm" method="POST" 
																	style="display: inline">

																	<button class="btn btn-sm editable-click" name="sub" value="Details" 	>
																		<div class="cc-rockmenu">
																			<div class="rolling">
																				<figure class="rolling_icon">
																					<img src="view/images/preview3.png">
																				</figure>
																				<span>Details</span>
																			</div>
																		</div>
																	</button>
												                    <input type="hidden" name="Assigner" value="<%=obj[1]%>,<%=obj[2]%>"/>													
                                                                    <input type="hidden" name="ActionLinkId" value="<%=obj[8]%>"/>
																	<input type="hidden" name="ActionMainId" value="<%=obj[0]%>"/>
																	<input type="hidden" name="ActionNo" value="<%=obj[9]%>"/>
																	<input type="hidden" name="ActionAssignid" value="<%=obj[10]%>"/>
																	<input type="hidden" name="ProjectId" value="<%=obj[14]%>"/>
 																	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
																	<%if(obj[13]!=null && obj[11]!=null && EmpId.equalsIgnoreCase(obj[11].toString()) && Integer.valueOf(obj[13].toString())< 5){ %>
																		      <button type="submit"  class="btn btn-sm editable-click" name="Action" value="ReAssign"  formaction="ActionLaunch.htm" formmethod="POST"  >
																				<div class="cc-rockmenu">
																				 <div class="rolling">	
																				 <figure class="rolling_icon">
																				 	<img src="view/images/repeat.png"  >
															                       </figure>
															                        <span> Distribute</span>
															                      </div>
															                     </div>
															                  </button> 
															                 <%-- <button type="submit"  class="btn btn-sm" name="ActionAssignid" value="<%=obj[10]%>" formtarget="blank" title="Action Tree"  formaction="ActionTree.htm" formmethod="POST"  >
																				<!-- <i class="fa fa-solid fa-sitemap" style=" font-size: 30px; color: #CE7777;"></i> -->
																				<img src="view/images/tree.png"  >
																		    </button>  --%>
																		    <button type="submit"  class="btn btn-sm editable-click" name="ActionAssignid" value="<%=obj[10]%>" formtarget="blank" title="Action Tree"    formaction="ActionTree.htm" formmethod="POST"  >
																				<div class="cc-rockmenu">
																				 <div class="rolling">	
																				 <figure class="rolling_icon">
																				 	<img src="view/images/tree.png"  >
															                       </figure>
															                        <span> Action Tree</span>
															                      </div>
															                     </div>
															                  </button> 

													                  <%}%>
																</form> 		
															</td>
														</tr>
												<% count++; } }else{%>
												<tr>
													<td colspan="6" style="text-align: center">No List Found</td>
												</tr>
												<%} %>
											</tbody>
										</table>
												
										<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />


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



<!-- Modal for action -->
<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header" style="height:50px;">
        <h5 class="modal-title" id="exampleModalLongTitle">Action</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="color:red;">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body" id="modalbody">
     
      </div>
      <div align="right" id="header" class="p-2"></div>
    </div>
  </div>
</div>










<script>
	$('#DateCompletion').daterangepicker({
			"singleDatePicker" : true,
			"linkedCalendars" : false,
			"showCustomRangeLabel" : true,
			/* "minDate" : new Date(), */
			"cancelClass" : "btn-default",
			showDropdowns : true,
			locale : {
				format : 'DD-MM-YYYY'
			}
		});
	
		
		function showAction(a,b){
			/* var y=JSON.stringify(a); */
			var y=$('#td'+a).val();
			console.log(a);
			$('#modalbody').html(y);
			$('#header').html(b);
			$('#exampleModalCenter').modal('show');
		}
	</script>  


</body>
</html>