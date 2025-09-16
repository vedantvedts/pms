<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
       <%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<%-- <jsp:include page="../static/sidebar.jsp"></jsp:include> --%>
<title>GROUP MASTER EDIT</title>
<spring:url value="/resources/css/master/labDetails.css" var="labDetails" />     
<link href="${labDetails}" rel="stylesheet" />
</head>
<body>

<%


List<Object[]> groupheadlist=(List<Object[]>)request.getAttribute("groupheadlist");


List<Object[]> labmasterdata=(List<Object[]>)request.getAttribute("labmasterdata");


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
	
<div class="container">		
<div class="row">


<div class="col-md-12">
  
 <div class="card shadow-nohover" >
<div class="card-header headerCard" >
                    <h5 class="text-white"  ><b>Lab Details</b></h5>
</div>
<div class="card-body"> 
    <form action="#" method="POST" name="frm1">
    
    

<div class="table-responsive">
	  <table class="table table-bordered table-hover table-striped table-condensed " >
  <thead>
  
<%for(Object[] obj:labmasterdata){ %>

<tr>
  <th  class="thClass" colspan="3">
<label >Lab Code:
<span class="mandatory" >*</span>
</label>
</th>
 <td colspan="5" >
 
<input value=<%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()):"-"%>  readonly class="form-control form-control" type="text" name="LabCode" required="required" maxlength="10"  id="LabCode" >

 
</td>

</tr>


<tr>
 <th colspan="3" >
<label >Lab Name:
<span class="mandatory" >*</span>
</label>
</th>
 <td colspan="5">
 
  	<input  class="form-control form-control labNameinput" type="text" name="LabName" required="required" maxlength="255"  value="<%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()):""%>" readonly >
 

</td>

</tr>


<tr>

<th colspan="3" >
<label >Lab Unit Code:
<span class="mandatory" >*</span>
</label>
</th>
 <td colspan="5">
 
 <input  value=<%=obj[3]!=null?StringEscapeUtils.escapeHtml4(obj[3].toString()):""%> readonly class="form-control form-control" type="text" name="" required="required" maxlength="100"   id="LabAddress">

</td>
</tr>


<tr>
<th colspan="3" >
<label >Lab Address:
<span class="mandatory" >*</span>
</label>
</th>
 <td colspan="5" >
 
 <input  value="<%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()):""%>"  readonly class="form-control form-control"  type="text" name="LabAddress" required="required" min='1'   maxlength="255"   id="LabAddress">

</td>


</tr>


<tr>

<th colspan="3" >
<label >Lab City:
<span class="mandatory" >*</span>
</label>
</th>
 <td colspan="5">
 
<input  value=<%=obj[5]!=null?StringEscapeUtils.escapeHtml4(obj[5].toString()):""%>  readonly class="form-control form-control labCity"  type="text" name="LabCity" required="required" maxlength="255"   id="">

</td>

</tr>


<tr>
 <th colspan="3" >
<label >Lab Pin:
<span class="mandatory" >*</span>
</label>
</th>
 <td colspan="5" >
 
<input  value=<%=obj[6]!=null?StringEscapeUtils.escapeHtml4(obj[6].toString()):""%>  readonly class="form-control form-control labCity" type="number" name="LabPin" required="required" maxlength="255"  id="">
<input type="hidden" name="Did" value=<%=obj[0]%>  >
 <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}"  />
	 

</td>


</tr>
<tr>
<td colspan="7"  ><button type="submit"  class="btn btn-warning btn-sm edit editbtn"  name="sub" value="edit"   >EDIT</button></td>
</tr>

<%} %>

</thead> 
</table>

</div>


</form>
	</div></div></div></div>
</div>	
	
</body>
<script>
  $(document).ready(function(){
	  $('#ghempid').select2();
  });
</script>
</html>