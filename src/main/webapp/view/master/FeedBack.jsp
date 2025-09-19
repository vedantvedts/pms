<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="../static/header.jsp"></jsp:include>

<title>FEED BACK</title>
<spring:url value="/resources/css/master/feedBack.css" var="feedbackList" />     
<link href="${feedbackList}" rel="stylesheet" />

</head>
<body>


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
    
<%List<Object[]> fblist = (List<Object[]>)request.getAttribute("FeedbackList"); %>

	<div class="row">
		<div class="col-md-1 "></div>
		<div class="col-md-10 ">
			<div class="card shadow-nohover" >
				<div class="card-header" >
					<div class="row">
						<div class="col-md-6"><h4>FEEDBACK</h4></div>
						<div class="col-md-6 backbtn" ><a class="btn btn-sm back" <%if(fblist!=null && fblist.size()>0){%> href="FeedBack.htm" <%}else{%> href="MainDashBoard.htm"<%}%>  class="backbtntop">BACK</a></div>
					</div>
				</div>
				<div class="card-body">
					<form action="FeedBackAdd.htm" method="POST" id="Feedbackadd" enctype="multipart/form-data">
						<div class="table-responsive">
							<table class="table table-bordered table-hover table-striped table-condensed " id="myTable16" >
								<thead>
									    <tr>
											<th  class="feedbackTypeTh"><label>Feedback Type: <span class="mandatory" >*</span></label></th>
											<td>
												<select class="form-control selectdee" id="ftype" name="feedbacktype" data-container="body" data-live-search="true"   >
													<option value=""  selected="selected"	hidden="true">--Select--</option>
													<option value="B">Bug</option>
													<option value="C">Content Change</option>
													<option value="N">New Requirement</option>
													<option value="U">User Interface</option>
												</select>
											</td>
											<th  class="fileLabel"> <label>File :</label> </th>
											<td> <input type="file" name="FileAttach" class="fileAttach" accept="image/*,.pdf" > </td>
										</tr>
										<tr>
											<th class="feedbackTypeTh"><label>Feedback: <span class="mandatory mandateClass" >*</span></label></th>
											<td colspan="3">
											    <textarea rows="4"  class="form-control"  id="summernote1" name="Feedback"  placeholder="Enter Feedback..!!"  ></textarea>
											</td>
										</tr>
								</thead>
							</table>
						</div>
						<div align="center">
							<input type="submit" class="btn btn-primary btn-sm editbasic"  value="Submit"  name="sub" onclick="return confirm('Are You Sure to Submit?');"/>
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						</div>		
					</form>									
				</div>
			</div>
		</div>
	</div>	
</body>
<script type="text/javascript">

	  $("#Feedbackadd").on('submit', function (e) {

		  var data =$('#summernote1').val();;
		  var feedbacktype = $('#ftype').val();
		  if(feedbacktype=='' ){
			  alert("Please Select Feedback Type!");
			  return false;
		  }else if(data=='' ){
			  alert("Please Enter Feedback!");
			  return false;
		  }else if(data.length>999){
			  alert("Feedback data is too long!");
			  return false;
	  	  }else{
			  return true;
		  }  
});  
</script>

  
</html>