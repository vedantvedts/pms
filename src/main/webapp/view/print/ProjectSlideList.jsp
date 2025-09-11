<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"
import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.io.ByteArrayOutputStream,java.io.ObjectOutputStream"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
</head>
<body>
<%
SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
List<Object[]> projectslist=(List<Object[]>)request.getAttribute("projectslist");
String projectid=(String)request.getAttribute("projectid");
List<Object[]> projectslidelist=(List<Object[]>)request.getAttribute("ProjectSlideFreezedList");
%>
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card shadow-nohover">
					<div class="card-header row">
						<div class="col-md-6">
							<h4 class="">Project Slide Freezed List</h4>
						</div>
						<div class="col-md-6" align="right" style="margin-top: -8px;">
							<form method="post" action="ProjectSlide.htm" >
								<table>
									<tr>
										<td>
											<b>Project : </b>
										</td>
										<td>
											<select class="form-control items selectdee" name="projectid"  required="required" style="width:200px;" data-live-search="true" data-container="body" onchange="this.form.submit();">
												<%for(Object[] obj : projectslist){ %>
													<option <%if(projectid!=null && projectid.equals(obj[0].toString())) { %>selected <%} %>value=<%=obj[0]!=null?StringEscapeUtils.escapeHtml4(obj[0].toString()): " - "%> ><%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()): " - " %></option>
												<%} %>
											</select>
										</td>
									</tr>
								</table>
								<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
							</form>
						</div>
					</div>
					<div class="card-body">
					<form action="##">
					  <table class="table table-bordered table-hover table-striped table-condensed "  id="table1"> 
			                                        <thead>
			                                         
			                                            <tr>
			                                             	<th style="text-align: center;">SN</th>
			                                                <th style="text-align: center;">ReviewBy</th>
			                                                <th style="text-align: center;">Review date</th>
													<!--    <th style="text-align: center;">EmpName</th>   -->
			                                                <th style="text-align: center;">Action</th>
			                                            </tr>
			                                        </thead>
			                                        <tbody>
												<% int sn=0;for(Object[] 	obj:projectslidelist){ %>
												<tr>
													 <td style="text-align: center;"><%=++sn%></td>
													 <td class="wrap"><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - "%></td>
													 <td  style="text-align: center;"><%=sdf.format(obj[2]) %></td>
													 <%-- <td><%=obj[3] %></td> --%>
													 <td>
													 	<div  align="center">
															<a  
															 href="freezedSlideAttachDownload.htm?freezedId=<%=obj[0]%>" 
															 target="_blank"><i class="fa fa-download"></i></a>
														</div>
													 </td>
												</tr>
 												<%} %>
											</tbody>
			            </table>   
			            </form>  
					</div>
				</div>
			</div>
		</div>
	</div>		
<script type="text/javascript">
		$(document).ready(function(){
			  $("#table1").DataTable({
			 "lengthMenu": [  5,10,25, 50, 75, 100 ],
			 "pagingType": "simple"
			
			});
		});
</script>	
</body>
</html>