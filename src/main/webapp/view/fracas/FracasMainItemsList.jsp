<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="java.time.LocalDate"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.io.ByteArrayOutputStream,java.io.ObjectOutputStream"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<script src="./resources/js/multiselect.js"></script>
<link href="./resources/css/multiselect.css" rel="stylesheet"/>
 
   <spring:url value="/resources/css/fracasModule/fracasMainItemsList.css" var="fracasMainItemsList" />     
<link href="${fracasMainItemsList}" rel="stylesheet" />
<title>FRACAS List</title>

<title> ADD COMMITTEE</title>

</head>
 
<body>
<% 
 	FormatConverter fc=new FormatConverter(); 
	SimpleDateFormat sdf=fc.getRegularDateFormat();
	SimpleDateFormat sdf1=fc.getSqlDateFormat();

	
  List<Object[]>  projectslist=(List<Object[]>)request.getAttribute("projectlist");
  List<Object[]>  projectmainitemslist=(List<Object[]>)request.getAttribute("projectmainitemslist");
  String projectid=(String)request.getAttribute("projectid");
  String LabCode=(String)request.getAttribute("LabCode");
  
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
				<div class="card-header">
					<div class="row">
						<div class="col-md-9">
							<h4 class="text-blue">Failure Reporting, Analysis, and Corrective Action System (FRACAS)  List</h4>
						</div>
						<div class="col-md-3 dropdownDiv"  >
							<form action="FracasMainItemsList.htm" method="post" id="projectchange">
								<table  class="dropDownStyles">
									<tr>
										<td> <label class="control-label">Project : </label></td>
										<td>
											<select class="form-control selectdee" id="projectid" name="projectid" required onchange="$('#projectchange').submit();">
												<%-- <option <%if(projectid.equals("0")){ %>selected <%} %>	value="0">General</option> --%>
												<% for (Object[] obj : projectslist) {
    										    String projectshortName=(obj[17]!=null)?" ( "+obj[17].toString()+" ) ":"";
    										     %>
											    <option value="<%=obj[0]%>" <%if(obj[0].toString().equalsIgnoreCase(projectid)){ %>selected="selected" <%} %>> <%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()): " - "%> <%=projectshortName!=null?StringEscapeUtils.escapeHtml4(projectshortName): " - "%>  </option>
											    <%} %>
												<%-- <%for(Object[] obj:projectslist){ %>
													<option <%if(projectid.equals(obj[0].toString())){ %>selected <%} %> value="<%=obj[0]%>"><%=obj[4]%></option>	
												<%} %> --%>
											</select>
										</td>
									</tr>
								</table>
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							</form>
						</div>
					</div>
				</div>
				<div class="card-body">
										
										<div class="table-responsive">
						   					<table class="table table-bordered table-hover table-striped table-condensed "  id="myTable" > 
						   						<thead>
														<tr>
															<th>SN.</th>
															<th>Project</th>
															<th>Type</th>
															<th>Item</th>
															<th>FRACAS Date</th>
															<th>Attachment</th>
															<th>Actions</th>
														</tr>
													</thead>   
													<%if(projectmainitemslist.size()>0){ %>
														<%for(int i=0;i<projectmainitemslist.size();i++){ %>
															<tr>
																<td><%=i+1 %></td>
																<td><%=projectmainitemslist.get(i)[6]!=null?StringEscapeUtils.escapeHtml4(projectmainitemslist.get(i)[6].toString()): " - " %></td>
																<td><%=projectmainitemslist.get(i)[5]!=null?StringEscapeUtils.escapeHtml4(projectmainitemslist.get(i)[5].toString()): " - " %></td>
																<td><%= projectmainitemslist.get(i)[2]!=null?StringEscapeUtils.escapeHtml4(projectmainitemslist.get(i)[2].toString()): " - " %></td>
																<td><%=projectmainitemslist.get(i)[3]!=null?sdf.format(sdf1.parse( projectmainitemslist.get(i)[3].toString() )):" - " %></td>
																<td>
																	<%if(projectmainitemslist.get(i)[7]!=null){ %>
																		<form action="FracasAttachDownload.htm" method="post" target="_blank" >
																			<button class="btn dwn-btn"  ><i class="fa fa-download"></i></button>
																			<input type="hidden" name="fracasattachid" value="<%= projectmainitemslist.get(i)[7] %>">
																			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
																		</form>
																	<%}else{ %>
																		-
																	<%} %>
																</td>
																<td  class="mainItemEdit" >
																
																	<form action="FracasMainItemEdit.htm" method="post"  class="editform">
																		<button class="editable-click" name="sub"
																			value="Modify">
																			<div class="cc-rockmenu">
																				<div class="rolling">
																					<figure class="rolling_icon">
																						<img src="view/images/edit.png">
																					</figure>
																					<span>Edit</span>
																				</div>
																			</div>
																		</button>
																		
																		<input type="hidden" name="fracasmainid"	value="<%=projectmainitemslist.get(i)[0] %>" /> 
																		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
																	</form>
																	<form action="FracasAssign.htm" method="post"  class="assignForm">
																		<button class="editable-click" name="sub"
																			value="Modify">
																			<div class="cc-rockmenu">
																				<div class="rolling">
																					<figure class="rolling_icon">
																						<i class="fa fa-plus-square-o fa-3x assignbutton"  aria-hidden="true"></i>
																					</figure>
																					<span>Assign</span>
																				</div>
																			</div>
																		</button>
																		<input type="hidden" name="LabCode"	value="<%=LabCode %>" /> 
																		<input type="hidden" name="fracasmainid"	value="<%=projectmainitemslist.get(i)[0] %>" /> 
																		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
																	</form>
																		
																	
																</td>
															</tr>
														<%} %>
													<%}else { %>
														<tr>
															<td colspan="7" align="center">No Records Found</td>
														</tr>													
													<%} %>
												</table>
											</div>
											
										
						<br>
						<div class="row">
							<div class="col-md-5"></div>
							<div class="col-md-2">
								<table  align="center">
									<tr>
										<td>
											<form action="FracasMainAdd.htm" method="post" >
												<button type="submit" class="btn btn-sm add">ADD</button>
												<input type="hidden" name="projectid" value="<%=projectid%>">
												<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
											</form>
										</td>
										<td>										
											<a  class="btn btn-sm back" href="MainDashBoard.htm">BACK</a>
										</td>
									</tr>
								</table>
							</div>							
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>		
						
						
				<div class="card-footer"><br>
				</div>
			

 <script type="text/javascript">

$(document).ready(function(){

		  $("#myTable").DataTable({
		 "lengthMenu": [10,25, 50, 75, 100 ],
		 "pagingType": "simple",
			 "pageLength": 10
	});
});
	  
</script>  
 
</body>
</html>