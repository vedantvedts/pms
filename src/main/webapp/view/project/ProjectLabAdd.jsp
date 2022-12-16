<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<%-- <jsp:include page="../static/sidebar.jsp"></jsp:include> --%>
<title>PROJECT COST  ADD</title>
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
List<Object[]> ProjectIntiationLabList=(List<Object[]>)request.getAttribute("ProjectIntiationLabList");
List<Object[]> LabList=(List<Object[]>)request.getAttribute("LabList");
Object[] ProjectDetailes=(Object[])request.getAttribute("ProjectDetailes");
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
<div class="col-md-12 ">
  <b style="color: green;">Title :&nbsp;<%=ProjectDetailes[7] %>(<%=ProjectDetailes[6] %>)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; || &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;LAB COUNT:&nbsp;<%if(ProjectDetailes[13]!=null) { %><%=ProjectDetailes[13]%><%}else{ %>0<%} %>
  	
  	</b>

 
 	</div>
 	</div>
  </div>
        
        <div class="card-body">
        
          <form action="ProjectLabdeleteSubmit.htm" method="POST" name="myfrm4" id="myfrm4" >
                        <table id="table" data-toggle="table" data-pagination="true" data-search="true" data-show-columns="true" data-show-pagination-switch="true" data-show-refresh="true" data-key-events="true" data-show-toggle="true" data-resizable="true" data-cookie="true"
                                        data-cookie-id-table="saveId" data-show-export="true" data-click-to-select="true" data-toolbar="#toolbar">
                                        <thead>
                                         
                                            <tr>
                                                <th class="center">Select</th>
                                                <th data-field="id" >Lab Name</th>
                                             
                                                   
                                            </tr>
                                        </thead>
                                        
	    	<tbody>
									    <%for(Object[] 	obj:ProjectIntiationLabList){ %>
									<tr>
									 	<td><input type="radio" name="btSelectItem" value=<%=obj[1] %>  ></td> 
									   	<td><%=obj[2] %></td>
									
									     
								 	</tr>
								
									    <%} %>
									    </tbody>
	    
                                    </table>
        
                <div class="form-group">

<div align="center" style="margin-top: 10px">
 <button type="submit" class="btn btn-danger btn-sm delete"  value="DELETE"   name="sub" onclick=" Prints(myfrm4)">DELETE </button>
</div>

</div>

	<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}" /> 
				
		<input type="hidden" name="IntiationId"
				value="<%=IntiationId %>" /> 		
				
 	</form>
        
        
        
        
        <form action="ProjectLabAddSubmit.htm" method="POST" name="myfrm" id="myfrm" >
      

                    <table id="table" data-toggle="table" data-pagination="true" data-search="true" data-show-columns="true" data-show-pagination-switch="true" data-show-refresh="true" data-key-events="true" data-show-toggle="true" data-resizable="true" data-cookie="true"
                                        data-cookie-id-table="saveId" data-show-export="true" data-click-to-select="true" data-toolbar="#toolbar">
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
									 	<td class="center"><input type="checkbox" name="Lid" value=<%=obj[0] %>  ></td> 
									   	<td class="center"><%=obj[2] %></td>
									<td><%=obj[1] %></td>
									     
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




</script>
</body>
</html>