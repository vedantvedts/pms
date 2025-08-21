<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="com.vts.pfms.master.model.HolidayMaster"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../static/header.jsp"></jsp:include>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<style type="text/css">

.input-group-text{
font-weight: bold;
}

label{
	font-weight: 800;
	font-size: 16px;
	color:#07689f;
} 

hr{
	margin-top: -2px;
	margin-bottom: 12px;
}
.card b{
	font-size: 20px;
}


</style>
</head>
<body>
<%
SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
  HolidayMaster holiday=(HolidayMaster)request.getAttribute("Holidaydata");
  String action=(String)request.getAttribute("Action");
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
  
<div class="container">
	<div class="row" style="">

		<div class="col-md-12">

 			<div class="card shadow-nohover" >
			 <div class="card-header" style=" background-color: #055C9D;margin-top: ">
                    <b class="text-white">Holiday <%if(action.equalsIgnoreCase("Add")){ %> Add <%}else{ %>Edit<% }%></b>
        		</div>
				<div class="card-body" align="center" >	
				<%if(holiday!=null){ %>									
					<form  action="HolidayEditSumit.htm" method="POST" id="myform" autocomplete="off" >	
					<%}else{ %>
					<form  action="HolidayAddSumit.htm" method="POST" id="myform" autocomplete="off" >
					<%} %>	
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>										
						<div class="form-group">
							<div class="table-responsive">
								<table	class="table table-bordered table-hover table-striped table-condensed ">																	         
			
										<tr>
										<th><label>Holiday Name<span class="mandatory" style="color:red">*</span></label> </th>
										<td><input type="text" class="form-control form-control" placeholder="" id="" name="HoliName" value="<% if(holiday!=null && holiday.getHolidayName()!=null){ %><%=StringEscapeUtils.escapeHtml4(holiday.getHolidayName()) %><%} %>"  required="required"></td>
										</tr>
										
										<tr>
										<th><label>Holiday Date<span class="mandatory" style="color:red">*</span></label> </th>
										<td><input type="text" class="form-control form-control"  id="date" name="HoliDate" value=""  required="required" readonly="readonly"></td>
										</tr>
										
										<tr>
										    <th><label>Holiday Type<span class="mandatory" style="color:red">*</span></label></th>
										    <td><select class="form control form-control " name="HoliType" required="required"> 
										    
										    <option value="" selected disabled>Select</option>
										    <option value="G" <% if(holiday!=null && holiday.getHolidayType().toString().equalsIgnoreCase("G")){ %>selected<%} %> >General</option>
										    <option value="R" <% if(holiday!=null && holiday.getHolidayType().toString().equalsIgnoreCase("R")){ %>selected<%} %> >Restricted </option>										    
 											<%-- <option value="H" <% if(holiday!=null && holiday.getHoliType().toString().equalsIgnoreCase("H")){ %>selected<%} %> >Holiday For Working Saturday/Sunday</option>
									        <option value="W"  <% if(holiday!=null && holiday.getHoliType().toString().equalsIgnoreCase("W")){ %>selected<%} %> >Working Holiday</option>
										     --%>
										    </select></td>										    
										</tr>

									</table>
									<%if(holiday!=null){ %>
									<input type="hidden" value="<%=holiday.getHolidayId() %>" name="HolidayId" >
								
									<button class="btn btn-primary btn-sm submit" name="" value=""  onclick="return confirm('Are You Sure To Update')"> <%if(action.equalsIgnoreCase("Edit")){%>Update <%}else{ %> SUBMIT <%} %></button>
									<button type="submit" class="btn btn-info btn-sm shadow-nohover back" style="margin-left: 1rem;" formaction="HolidayList.htm" formmethod="get" formnovalidate="formnovalidate"  >BACK</button>
									<%}else{ 
										
										
										%>
									<button class="btn btn-primary btn-sm submit" name="" value=""  onclick="return confirm('Are You Sure To Submit')">Submit</button>
									<button type="submit" class="btn btn-info btn-sm shadow-nohover back" style="margin-left: 1rem;" formaction="HolidayList.htm" formmethod="get" formnovalidate="formnovalidate"  >BACK</button>
									<%} %>
									
									</div>
								</div>
									
								<%if(holiday!=null){ %>
							</form>
							<%}else{ %>
							</form>
							<%} %>
						</div>
					</div>
				</div>
		 </div> 
	<script>

	$('#date').daterangepicker({
		"singleDatePicker" : true,
		"linkedCalendars" : false,
		"showCustomRangeLabel" : true,
		//"minDate" :new Date(), 
		<%if(holiday!=null && holiday.getHolidayDate()!=null){ %>
		"startDate" : new Date("<%=holiday.getHolidayDate() %>"),
		
		<%}%>
		"cancelClass" : "btn-default",
		showDropdowns : true,
		locale : {
			format : 'DD-MM-YYYY'
		}
	});
	</script> 
	
  
</body>
</html>