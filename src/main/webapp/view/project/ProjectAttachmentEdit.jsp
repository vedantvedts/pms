<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<%-- <jsp:include page="../static/sidebar.jsp"></jsp:include> --%>
<title>PROJECT ATTACHMENT  EDIT</title>
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


</style>
</head>
<body>
<%SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
String IntiationId=(String) request.getAttribute("IntiationId");
String InitiationAttachmentId=(String) request.getAttribute("InitiationAttachmentId");
String FileName=(String) request.getAttribute("FileName");
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

        
        <div class="card-body">
  
      <form action="ProjectAttachmentUpdate.htm" method="POST" name="myfrm" id="myfrm" enctype="multipart/form-data">
                <div class="row">
     
         
                   
         <div class="col-md-4 ">
               <div class="form-group">
                            <label class="control-label">File Name</label>
  <input type="text" class="form-control" required="required" aria-describedby="inputGroup-sizing-sm" id="FileName" name="FileName" value="<%=FileName!=null?StringEscapeUtils.escapeHtml4(FileName): "" %>" >

                        </div>
                        
                    </div>
                    
              
            
          <div class="col-md-1 ">
 <div class="form-group">

<input type="submit" class="btn btn-primary btn-sm submit " onclick="Add(myfrm)" value="SUBMIT" name="sub" style="margin-top: 40px;"> 
</div>
</div>   

          <div class="col-md-2 ">
 <div class="form-group">

 <input type="submit" class="btn btn-secondary btn-sm submit " formnovalidate="formnovalidate"  value="BACK"   name="sub" style="margin-top: 40px;" >
</div>
</div> 
 
                </div>
                



	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
	<input type="hidden" name="IntiationId" value="<%=IntiationId %>" />
     <input type="hidden" name="InitiationAttachmentId" value="<%=InitiationAttachmentId %>" />   
  </form>  
    
    
     </div>`     
        








        </div>
</div>
</div>

</div>
  

	
<script type="text/javascript">



</script>
</body>
</html>