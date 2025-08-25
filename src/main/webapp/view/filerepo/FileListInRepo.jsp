<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.io.ByteArrayOutputStream,java.io.ObjectOutputStream"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<title>File List</title>

  <style>
    .bs-example{
        margin: 20px;
    }
    .accordion .fa{
        margin-right: 0.5rem;
    }
</style>

  	<style type="text/css">
		

label{
  font-weight: bold;
  font-size: 13px;
}
 
.note-editable {
  line-height: 1.0;
}
.panel-info {
    border-color: #bce8f1;
}
.panel {
    margin-bottom: 10px;
    background-color: #fff;
    border: 1px solid transparent;
    border-radius: 4px;
    -webkit-box-shadow: 0 1px 1px rgba(0, 0, 0, .05);
    box-shadow: 0 1px 1px rgba(0, 0, 0, .05);
}
 .panel-heading {
    background-color: #FFF !important;
    border-color: #bce8f1 !important;
    border-bottom: 2px solid #466BA2 !important;
    color: #1d5987;
}
.panel-title {
    margin-top: 0;
    margin-bottom: 0;
    font-size: 13px;
    color: inherit;
    font-weight: bold;
}
.panel-info > .panel-heading {
    color: #31708f;
    background-color: #d9edf7;
    border-color: #bce8f1;
}
* {
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
}
div {
    display: block;
}

element.style {
}
.olre-body .panel-info .panel-heading {
    background-color: #FFF !important;
    border-color: #bce8f1 !important;
    border-bottom: 2px solid #466BA2 !important;
   
}
.panel-info > .panel-heading {
    color: #31708f;
    background-color: #d9edf7;
    border-color: #bce8f1;
}
.panel-info > .panel-heading {
    color: #31708f;
    background-color: #d9edf7;
    border-color: #bce8f1;
}
.panel-info > .panel-heading {
    color: #31708f;
    background-color: #d9edf7;
    border-color: #bce8f1;
}
.panel-info > .panel-heading {
    color: #31708f;
    background-color: #d9edf7;
    border-color: #bce8f1;
}
.panel-info > .panel-heading {
    color: #31708f;
    background-color: #d9edf7;
    border-color: #bce8f1;
}
.panel-info>.panel-heading {
    color: #31708f;
    background-color: #d9edf7;
    border-color: #bce8f1;
}
.panel-heading {
    padding: 3px 10px;
    border-bottom: 1px solid transparent;
    border-top-left-radius: 3px;
    border-top-right-radius: 3px;
}
.panel-heading {
    padding: 3px 10px;
    border-bottom: 1px solid transparent;
    border-top-left-radius: 3px;
    border-top-right-radius: 3px;
}
.panel-heading {
    padding: 3px 10px;
    border-bottom: 1px solid transparent;
    border-top-left-radius: 3px;
    border-top-right-radius: 3px;
}
.panel-heading {
    padding: 3px 10px;
    border-bottom: 1px solid transparent;
    border-top-left-radius: 3px;
    border-top-right-radius: 3px;
}
.panel-heading {
    padding: 3px 10px;
    border-bottom: 1px solid transparent;
    border-top-left-radius: 3px;
    border-top-right-radius: 3px;
}
.p-5 {
    padding: 5px;
}
.panel-heading {
    padding: 10px 15px;
    border-bottom: 1px solid transparent;
    border-top-left-radius: 3px;
    border-top-right-radius: 3px;
}
* {
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
}
* {
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
}
* {
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
}
* {
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
}
* {
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
}
* {
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
}
user agent stylesheet
div {
    display: block;
}

.panel-info {
    border-color: #bce8f1;
}

.form-check{
	margin:0px 4%;
}

		</style>
</head>
<body>
  <%
  List<Object[]> ProjectList=(List<Object[]>)request.getAttribute("ProjectList");
  SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
  SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd");
  String ProjectId=(String)request.getAttribute("ProjectId");
  String ProjectName=(String)request.getAttribute("ProjectName");
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

  <nav class="navbar navbar-light bg-light" style="margin-top: -1%;">
  <a class="navbar-brand"></a>
  <form class="form-inline"  method="POST" action="FileListInRepo.htm">

                            		<label class="control-label">Project Name :  </label>
                              		<select class="form-control selectdee" id="ProjectId" required="required" name="ProjectId">
    									<option disabled="true"  selected value="">Choose...</option>
    										<% for (Object[] obj : ProjectList) {%>
										<option value="<%=obj[0]%>"  <%if(obj[0].toString().equalsIgnoreCase(ProjectId)){ %>selected="selected" <%} %>><%=obj[2]!=null?StringEscapeUtils.escapeHtml4(obj[2].toString()): " - "%> (<%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - "%>) </option>
											<%} %>
  									</select>
<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
 <input id="submit" type="submit" name="submit" value="Submit" hidden="hidden">
</form>
</nav>

<div class="container-fluid">   
          
<div class="row"> 

<div class="col-md-12" >
	<div class="card" style="border-color:#00DADA  ;margin-top: 2%;" >
    	<div class="card-body" style="margin-top: -8px" >
        	
  
					
         <div class="panel panel-info" style="margin-top: 10px;" >
         
      		<div class="panel-heading ">
        		<h4 class="panel-title">
          			<span  style="font-size:14px"><%=ProjectName!=null?StringEscapeUtils.escapeHtml4(ProjectName): " - "%></span>  
        		</h4>
         	<div   style="float: right !important; margin-top:-23px; ">
		 		
	
       	</div>
      
      
		<div   style="float: right !important; margin-top:-20px; ">  
		<a data-toggle="collapse" data-parent="#accordion" href="#collapse1" > <i class="fa fa-plus" id="Clk"></i></a>

   		</div>
     </div>
     <!-- panel-heading end -->
  	
	  	<div id="collapse1" class="panel-collapse collapse in">
	  	<%List<Object[]> ProjectSubList=(List<Object[]>)request.getAttribute("ProjectSubList");
	  	  int ProjectSubCount=1;
	  	  if(ProjectSubList!=null&&ProjectSubList.size()>0){
	  	  for(Object[] obj:ProjectSubList){
	  		  String [] Str=obj[2].toString().split(":");
	  		  
	  	%>
	  	<div class="row">  
				   <div class="col-md-11"  align="left"  style="margin-left: 20px;">
				   
				     <div class="panel panel-info">
					      <div class="panel-heading">
					        <h4 class="panel-title">
					        	<div>
						          
						 
									<span  style="font-size:14px"><%=ProjectSubCount %>...../L<%=obj[4]!=null?StringEscapeUtils.escapeHtml4(obj[4].toString()): " - "%>/<%=obj[5]!=null?StringEscapeUtils.escapeHtml4(obj[5].toString()): " - "%>/<%=obj[3]!=null?StringEscapeUtils.escapeHtml4(obj[3].toString()): " - "%> Ver.<%=obj[6]!=null?StringEscapeUtils.escapeHtml4(obj[6].toString()): " - "%></span>
						          		
						          		
						          		
						          	
					       		</div>
					        </h4>
					       		<div style="float: right !important; margin-top:-20px; " > 
					       		  <form  id="myForm<%=ProjectSubCount %>" action="FileUnpack.htm" method="post">
						 
														
										<input type="hidden" name="specname" value="Agenda-Presentation">
										<input type="hidden" name="ProjectId" value="<%=ProjectId %>" >
										<input type="hidden" name="ProjectName" value="<%=ProjectName %>">
                                        <input type="hidden" name="FileId" value="<%=obj[0] %>">
                                        <input type="hidden" name="FileUploadId" value="<%=obj[1] %>">
										<input type="hidden" name="formname" value="rm" />
										<input type="hidden" name="Rev" value="<%=obj[6] %>">
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						          		
						          		<div style="margin-top:-2px; margin-left: 10px;">
						          		   <button type="submit" name="sub" class="btn btn-info btn-sm"    form="myForm<%=ProjectSubCount %>"   formaction="FileVerList.htm"  style="width:22px; height: 24px; font-size:12px; font-weight: bold; text-align: justify; "><i class="fa fa-code-fork" aria-hidden="true" ></i></button>
						          			<button type="submit" name="sub" class="btn btn-light btn-sm"    form="myForm<%=ProjectSubCount %>"  style="width:30px; height: 24px; font-size:12px; font-weight: bold; text-align: justify; "><i class="fa fa-download" aria-hidden="true"></i></button>
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