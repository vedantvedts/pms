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
<title>PROJECT ATTACHMENT  ADD</title>
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

b{
	font-family: 'Lato',sans-serif;
}

</style>
</head>
<body>
<%SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
String IntiationId=(String) request.getAttribute("IntiationId");
Object[] ProjectDetailes=(Object[])request.getAttribute("ProjectDetailes");

String filesize=(String) request.getAttribute("filesize"); 

%>











<%String ses=(String)request.getParameter("result"); 
 String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null){
	%><center>
	<div class="alert alert-danger" role="alert">
                     <%=ses1 %>
                    </div></center>
	<%}if(ses!=null){ %>
	<center>
	<div class="alert alert-success" role="alert" >
                     <%=ses %>
                   </div></center>
                    <%} %>







    <div class="container">
<div class="row" style="">

<div class="col-md-12">

 <div class="card shadow-nohover" >
	
		<div class="card-header">
 <div class="row" >
 <div class="col-md-3"><h3>Attachment</h3>
 </div>
	<div class="col-md-9 " style="">
		<b style="color: green;float: right;">Title :&nbsp;<%=ProjectDetailes[7] %> (<%=ProjectDetailes[6] %>)</b> 
 	</div>
 	</div>
  </div>

        <div class="card-body">
  
      <form action="ProjectAttachmentAddSubmit.htm" method="POST" name="myfrm" id="myfrm" enctype="multipart/form-data">
                <div class="row">                   
         <div class="col-md-4 ">
               <div class="form-group">
                            <label class="control-label">File Name</label>
  <input type="text" class="form-control" required="required" aria-describedby="inputGroup-sizing-sm" id="FileName" name="FileName" >

                        </div>
                        
                    </div>
                    
            <div class="col-md-5 ">
               <div class="form-group">
                            <label class="control-label">File Attach</label>
  <input type="file" class="form-control" required="required" aria-describedby="inputGroup-sizing-sm" id="FileAttach" name="FileAttach" onchange="Filevalidation('FileAttach');"  >

                        </div>
                        
                    </div>                 
            
          <div class="col-md-1 ">
 <div class="form-group">

<input type="submit" class="btn btn-primary btn-sm submit " onclick="validate()" value="SUBMIT" name="sub" style="margin-top: 40px;"> 
</div>
</div>   

          <div class="col-md-2 ">
 <div class="form-group">

 <input type="submit" class="btn btn-secondary btn-sm back " formnovalidate="formnovalidate"  value="BACK"   name="sub" style="margin-top: 40px;" >
</div>
</div> 
 
                </div>
                



	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
	<input type="hidden" name="IntiationId" value="<%=IntiationId %>" />
        
  </form>  
    
</div>
        








        </div>
</div>
</div>

</div>
  
<script type="text/javascript">
						
   function  Filevalidation (fileid)  
    {
       const fi = $('#'+fileid )[0].files[0].size;							 	
       const file = Math.round((fi / 1024/1024));
       if (file >= <%=filesize%> ) 
       {
       	alert("File too Big, please select a file less than <%=filesize%> mb");
       } 
    }
						

function validate(){
	var oFile = document.getElementById("FileAttach").files[0]; 

	if (oFile.size > 2097152) 
	{
	    alert("File size must less than 2MB!");
	    event.preventDefault();
	    
	}

	
}


</script>



</body>
</html>