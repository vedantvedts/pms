<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="../static/header.jsp"></jsp:include>

<title>FEED BACK</title>
<style type="text/css">
.table thead tr th {
	background-color: aliceblue;
	
}

.table thead tr td {
	background-color: #f9fae1;
	text-align: left;
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


	<div class="row">
		<div class="col-md-12 ">
			<div class="card shadow-nohover" >
				<div class="card-header" >
					<div class="row">
						<div class="col-md-6"><h3>FEEDBACK</h3></div>
						
						<div class="col-md-6"><a class="btn btn-sm back" href="FeedBack.htm" style="float: right;">BACK</a></div>
					</div>
				</div>
				<div class="card-body">
				
					<form action="FeedBackAdd.htm" method="POST" id="Feedbackadd" enctype="multipart/form-data">
						<div class="table-responsive">
							<table class="table table-bordered table-hover table-striped table-condensed " id="myTable16" style="width: 90%;">
								<thead>
									<tr>
										<th style="text-align: left;"><label>Feedback Type: <span class="mandatory" style="color: red;">*</span></label></th>
										<td >
											<select class="form-control selectdee" id="ftype" name="feedbacktype" data-container="body" data-live-search="true"   style="font-size: 5px;">
												<option value=""  selected="selected"	hidden="true">--Select--</option>
												<option value="B">Bug</option>
												<option value="C">Content Change</option>
												<option value="U">User Interface</option>
												<option value="N">New Requirement</option>
											</select>
										</td>
										<th style="text-align: left;"> <label>File :</label> </th>
										<td > <input type="file" name="FileAttach" style="margin-right: -110px;"> </td>
									</tr>
									<tr>
										<th style="text-align: left;"><label>Feedback: <span class="mandatory" style="color: red;">*</span></label></th>
										<td colspan="3">
										    <textarea rows="4" style="display:block; margin-top: 10px;" class="form-control"  id="summernote1" name="Feedback"  placeholder="Enter Feedback..!!"  ></textarea>
										</td>
									</tr>
									<tr>
									</tr>
								</thead>
							</table>
						</div>
						<div align="center">
							<input type="submit" class="btn btn-primary btn-sm editbasic"  value="Submit"  name="sub" onclick="return confirm('Are You Sure to Submit?');"/>
						</div>									
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
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