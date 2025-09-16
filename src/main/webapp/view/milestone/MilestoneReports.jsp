<%@page import="org.apache.commons.text.StringEscapeUtils"%>

<%@page import="com.ibm.icu.text.DecimalFormat"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"

    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.io.ByteArrayOutputStream,java.io.ObjectOutputStream"%>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>

<html>

<head>

<meta charset="ISO-8859-1">

<jsp:include page="../static/header.jsp"></jsp:include>

  <spring:url value="/resources/css/milestone/milestoneReports.css" var="milestoneReports" />     

	<link href="${milestoneReports}" rel="stylesheet" />

 



<title>Milestone OIC List</title>



</head>

 

<body>

  <%

  



  

  List<Object[]> MilestoneList=(List<Object[]>)request.getAttribute("MilestoneList");

  SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");

  SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd");

  

  

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



    <br />

  



   

   

   

   <div class="container-fluid">

		<div class="row">

			<div class="col-md-12">

				<div class="card shadow-nohover">

				<div class="row card-header">

			     <div class="col-md-10">

					<h4 >Milestone List</h4>

					</div>

					<div class="col-md-2 justify-content-end floatRight" >

				

					 </div>

					 </div>

					<div class="card-body">



						<div class="data-table-area mg-b-15">

							<div class="container-fluid">





								<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">

									<div class="sparkline13-list">



										<div class="sparkline13-graph">

											<div class="datatable-dashv1-list custom-datatable-overright">

											

												<table class="table table-bordered table-hover table-striped table-condensed" id="table">

													<thead>



														<tr>

															<th class="width-5">SN</th>

															<th class="text-left" >Milestone No</th>

															<th class="text-left" >Project Name</th>

															<th class="text-left" >Activity Type</th>

															<th class="text-left" >Milestone Activity</th>

															<th class="width-110px">Start Date</th>	

															<th class="width-110px">End Date</th>	

															<th class="width-110px">Progress</th>										

														 	<th >View</th>

														 		

														 	

														</tr>

													</thead>

													<tbody>

														<%int  count=1;

															

														 	if(MilestoneList!=null&&MilestoneList.size()>0){

															for(Object[] obj: MilestoneList){ %>

														<tr>

															<td   class="center width-1" ><%=count %></td>

															<td class="width-30px">Mil-<%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()):" - "%></td>

															<td class="width-30px"><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()):" - "%></td>

															<td class="width-30px"><%=obj[3]!=null?StringEscapeUtils.escapeHtml4(obj[3].toString()):" - "%></td>

															<td class="tdDetails"><%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()):" - " %></td>

															

															<td class="width-30px"><%=obj[5]!=null?sdf.format(obj[5]):" - "%></td>

															<td class="width-8" ><%=obj[6]!=null?sdf.format(obj[6]):" - "%></td>	

																<td>

																<%if( obj[7]!=null && !obj[7].toString().equalsIgnoreCase("0")){ %>

															<div class="progress progressClass " >

															<div class="progress-bar progress-bar-striped width-<%=obj[7]  %>" role="progressbar"  aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" >

															<%=StringEscapeUtils.escapeHtml4(obj[7].toString())%>

															</div> 

															</div> <%}else{ %>

															<div class="progress progressClass" >

															<div class="progress-bar noProgress" role="progressbar"   >

															Not Started .

															</div>

															</div> <%} %>

																</td>

																<td  class="left width">		

																

														 

																

																	

														 <form action="MilestoneActivityUpdate.htm" method="POST" name="myfrm"  class="display: inline">

															<button  class="editable-click">

																<div class="cc-rockmenu">

																 <div class="rolling">	

											                        <figure class="rolling_icon"><img src="view/images/clipboard.png" ></figure>

											                        <span>Update</span>

											                      </div>

											                     </div>

											                  </button>   

											                  

															<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 

														    <input type="hidden" name="MilestoneActivityId" value="<%=obj[0]%>"/>

															<input type="hidden" name="projectid" value="<%=obj[8]%>"/>

															

													 </form> 

																

																		

															</td>

		

														</tr>

												<% count++; } }else{%>

												<tr>

													<td colspan="9" " class="center text-center">No List Found</td>

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

   



  

<script>







$(document).ready(function(){
	  $("#table").DataTable({
	 "lengthMenu": [10,25, 50, 75, 100 ],
	 "pagingType": "simple",
		 "pageLength": 10
});
});




</script>















</body>

</html>

