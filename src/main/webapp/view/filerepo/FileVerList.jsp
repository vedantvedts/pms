<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.io.ByteArrayOutputStream,java.io.ObjectOutputStream"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<title>File Ver. List</title>
<spring:url value="/resources/css/fileRepo/FileVerList.css" var="fileVerList" />
<link href="${fileVerList}" rel="stylesheet" />
</head>
<body>
  <%
  List<Object[]> ProjectList=(List<Object[]>)request.getAttribute("ProjectList");
  SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
  SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd");
  String ProjectId=(String)request.getAttribute("ProjectId");
  String ProjectName=(String)request.getAttribute("ProjectName");
 %>

  <nav class="navbar navbar-light bg-light nav-m-minus" >
  <a class="navbar-brand"></a>
  <form class="form-inline"  method="POST" action="FileListInRepo.htm">
<input type="hidden" name="ProjectId" value="<%=ProjectId %>" >
<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
 <input class="btn btn-primary btn-sm back" type="submit" name="submit" value="Back" >
</form>
</nav>

<div class="container-fluid">   
          
<div class="row"> 

<div class="col-md-12" >
	<div class="card card-border"  >
    	<div class="card-body mt-minus" >
        	
  
					
         <div class="panel panel-info mt-2" >
         
      		<div class="panel-heading ">
        		<h4 class="panel-title">
          			<span class="span-font"><%=ProjectName!=null?StringEscapeUtils.escapeHtml4(ProjectName): " - "%></span>  
        		</h4>
         	<div  class="f-right-3">
		 		
	
       	</div>
      
      
		<div class="f-right"  >  
		<a data-toggle="collapse" data-parent="#accordion" href="#collapse1" > <i class="fa fa-plus" id="Clk"></i></a>

   		</div>
     </div>
     <!-- panel-heading end -->
  	
	  	<div id="collapse1" class="panel-collapse collapse in">
	  	<%List<Object[]> ProjectSubList=(List<Object[]>)request.getAttribute("ProjectSubList");
	  	  int ProjectSubCount=1;
	  	  if(ProjectSubList!=null&&ProjectSubList.size()>0){
	  	  for(Object[] obj:ProjectSubList){
	  		  
	  	%>
	  	<div class="row">  
				   <div class="col-md-11 ml-4"  align="left"  >
				   
				     <div class="panel panel-info">
					      <div class="panel-heading">
					        <h4 class="panel-title">
					        	<div>
						          
						 
									<span  class="span-font"><%=ProjectSubCount %>...../L<%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()): " - "%>/<%=obj[5]!=null?StringEscapeUtils.escapeHtml4(obj[5].toString()): " - "%>/<%=obj[3]!=null?StringEscapeUtils.escapeHtml4(obj[3].toString()): " - "%>  Ver.<%=obj[6]!=null?StringEscapeUtils.escapeHtml4(obj[6].toString()): " - "%></span>
						          		
						          		
						          		
						          	
					       		</div>
					        </h4>
					       		<div class="f-right" > 
					       		  <form  id="myForm<%=ProjectSubCount %>" action="FileUnpack.htm" method="post">
						 
														
										<input type="hidden" name="specname" value="Agenda-Presentation">
										<input type="hidden" name="ProjectId" value="<%=ProjectId %>" >
										<input type="hidden" name="ProjectName" value="<%=ProjectName %>">
                                        <input type="hidden" name="FileUploadId" value="<%=obj[1] %>">
										<input type="hidden" name="formname" value="rm" />
										<input type="hidden" name="Rev" value="<%=obj[6] %>">
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						          		
						          		<div class="m-minus" >
						          			<button type="submit" name="sub" class="btn btn-light btn-sm btn-wid"    form="myForm<%=ProjectSubCount %>"  ><i class="fa fa-download" aria-hidden="true"></i></button>
						          		</div>
						          		
						          	</form>					       		
                                            </div>
					      </div>
					  			<div id="collapse55<%=ProjectSubCount %>" class="panel-collapse collapse in">
	
					  </div>
					 </div>
					 
				  </div>
	  			</div>
	  	
	  	
	  	<%ProjectSubCount++;}} %>

	  			
	     </div>      
	       
   </div>
   <!-- panel end -->   

   

   

		</div><!-- Big card-body end -->
	
	</div><!-- Card End  -->
	
</div> <!-- col-md-5 end -->


</div>
</div>


<script type="text/javascript">
$(document).ready(function(){
    // Add minus icon for collapse element which is open by default
    $(".collapse.show").each(function(){
    	$(this).prev(".panel-heading").find(".fa").addClass("fa-minus").removeClass("fa-plus");
    });
    
    // Toggle plus minus icon on show hide of collapse element
    $(".collapse").on('show.bs.collapse', function(){
    	$(this).prev(".panel-heading").find(".fa").removeClass("fa-plus").addClass("fa-minus");
    }).on('hide.bs.collapse', function(){
    	$(this).prev(".panel-heading").find(".fa").removeClass("fa-minus").addClass("fa-plus");
    });
});
$('#Clk').click();
$(document).ready(function() {
	   $('#ProjectId').on('change', function() {
	     $('#submit').click();

	   });
	});
</script>
</body>
</html>