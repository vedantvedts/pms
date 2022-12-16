<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<%-- <jsp:include page="../static/sidebar.jsp"></jsp:include> --%>
<title>PROJECT INT  ADD</title>
<style type="text/css">

.input-group-text{
font-weight: bold;
}

label{
	font-weight: 800;
	font-size: 16px;
	color:#07689f;
} 

</style>
</head>
<body>
<%SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
String IntiationId=(String) request.getAttribute("IntiationId");
List<Object[]> LabList=(List<Object[]>) request.getAttribute("LabList");
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
<div class="row" style="margin-top: -20px;">

<div class="col-md-12">

 <div class="card shadow-nohover" >

        
        <div class="card-body">
           <form action="ProjectIntiationListSubmit.htm" method="POST" name="myfrm" >
    
 <div class="table-responsive">
	   <table class="table table-bordered table-hover table-striped table-condensed "  id="myTable"> 
	   <thead>
	   <tr>
	 <th>Select</th>
	  <th>Lab Name</th>
	  <th>Lab code</th>
	
	

	  </tr>
	   </thead>
    <tbody>
	    <%for(Object[] 	obj:LabList){ %>
	    <tr>
	  <td><input type="checkbox" name="Pid" value=<%=obj[0] %>  ></td> 
	   <td><%=obj[1] %></td>
	  <td><%=obj[2] %></td>
	   
	    
	    </tr>
	    

	    </tbody>
	    
	    <%} %>
</table>
 	
</div>

<center> 
<button type="submit" class="btn btn-primary btn-sm add" name="sub" value="Add"  >Add</button>

</center>
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

function Add(myfrm){
	
	 event.preventDefault();
	 var ShortName = $("#ShortName"). val();
		

$
.ajax({

type : "GET",
url : "ProjectShortNameCount.htm",
data : {
	ProjectShortName : ShortName
},
datatype : 'json',
success : function(result) {

	var result = JSON.parse(result);
	var values = Object.keys(result).map(function(e) {
		  return result[e]
		});


	if(result>0){
	   
		alert("Short Name Already Present")


}else{
	$('#myfrm').submit();
}
}
}); 

}

</script>
</body>
</html>