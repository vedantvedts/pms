<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
    <%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<%-- <jsp:include page="../static/sidebar.jsp"></jsp:include> --%>
<title>PROJECT COST  ADD</title>
<spring:url value="/resources/css/projectModule/projectLabAdd.css" var="projectLabAdd" />
<link href="${projectLabAdd}" rel="stylesheet" />
</head>
<body>
<%SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
String IntiationId=(String) request.getAttribute("IntiationId");
List<Object[]> ProjectIntiationLabList=(List<Object[]>)request.getAttribute("ProjectIntiationLabList");
List<Object[]> LabList=(List<Object[]>)request.getAttribute("LabList");
Object[] ProjectDetailes=(Object[])request.getAttribute("ProjectDetailes");
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
<div class="row" >

<div class="col-md-12">

 <div class="card shadow-nohover" >
  <div class="card-header">
 <div class="row" >
<div class="col-md-12 ">
  <b class="text-success">Title :&nbsp;<%=ProjectDetailes[7]!=null?StringEscapeUtils.escapeHtml4(ProjectDetailes[7].toString()): " - " %>(<%=ProjectDetailes[6]!=null?StringEscapeUtils.escapeHtml4(ProjectDetailes[6].toString()): " - " %>)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; || &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;LAB COUNT:&nbsp;<%if(ProjectDetailes[13]!=null) { %><%=StringEscapeUtils.escapeHtml4(ProjectDetailes[13].toString())%><%}else{ %>0<%} %>
  	
  	</b>

 
 	</div>
 	</div>
  </div>
        
        <div class="card-body">
        
          <form action="ProjectLabdeleteSubmit.htm" method="POST" name="myfrm4" id="myfrm4" >
                                    <table class="table table-bordered table-hover table-striped table-condensed" id="myTable12" >
                                        
                                        <thead>
                                         
                                            <tr>
                                                <th class="center">Select</th>
                                                <th data-field="id" >Lab Name</th>
                                             
                                                   
                                            </tr>
                                        </thead>
                                        
	    	<tbody>
									    <%for(Object[] 	obj:ProjectIntiationLabList){ %>
									<tr>
									 	<td><input type="radio" name="btSelectItem" value=<%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): "" %>  ></td> 
									   	<td><%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - " %></td>
									
									     
								 	</tr>
								
									    <%} %>
									    </tbody>
	    
                                    </table>
        
                <div class="form-group">

<div align="center" class="margingtop10">
 <button type="submit" class="btn btn-danger btn-sm delete"  value="DELETE"   name="sub" onclick=" Prints(myfrm4)">DELETE </button>
</div>

</div>

	<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}" /> 
				
		<input type="hidden" name="IntiationId"
				value="<%=IntiationId %>" /> 		
				
 	</form>
        
        
        
        
        <form action="ProjectLabAddSubmit.htm" method="POST" name="myfrm" id="myfrm" >
      

                                      <table class="table table-bordered table-hover table-striped table-condensed" id="myTable123" >
                                        <thead>
                                         
                                            <tr>
                                                <th class="center">Select</th>
                                                <th class="center">Code</th>
                                                <th >Lab Name</th>
                                             
                                                   
                                            </tr>
                                        </thead>
                                        
	    	<tbody>
									    <%for(Object[] 	obj:LabList){ %>
									<tr>
									 	<td class="center"><input type="checkbox" name="Lid" value=<%=obj[0]!=null?StringEscapeUtils.escapeHtml4(obj[0].toString()): "" %>  ></td> 
									   	<td class="center"><%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - " %></td>
									<td><%=obj[1] !=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - "%></td>
									     
								 	</tr>
								
									    <%} %>
									    </tbody>
	    
                                    </table>


          
         <hr>
         
        <div class="form-group">
<center>

 <button type="submit" class="btn btn-primary btn-sm submit"  value="SUBMIT"   name="sub">SUBMIT </button>
 <input type="submit" class="btn btn-primary btn-sm submit back" formnovalidate="formnovalidate"  value="BACK"   name="sub" >

</center>
</div>

	<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}" /> 
				
		<input type="hidden" name="IntiationId"
				value="<%=IntiationId %>" /> 		
				
 	</form>
        
     </div>`     
        








        </div>
</div>
</div>


  

	
<script type="text/javascript">


function Prints(myfrm4){
	
	 var fields = $("input[name='btSelectItem']").serializeArray();

	 
	  if (fields.length === 0){
		  myalert();
	 event.preventDefault();
	return false;
	}
	 
		  return true;	 
			
	}

$(document).ready(function(){
	  $("#myTable12").DataTable({
	 "lengthMenu": [  5,10,25, 50, 75, 100 ],
	 "pagingType": "simple",
	 "pageLength": 5

	});
});

$(document).ready(function(){
	  $("#myTable123").DataTable({
	 "lengthMenu": [  5,10,25, 50, 75, 100 ],
	 "pagingType": "simple",
	 "pageLength": 10

	});
});



</script>
</body>
</html>