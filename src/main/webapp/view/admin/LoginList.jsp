<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

<title>LOGIN LIST</title>
<style type="text/css">

label{
font-weight: bold;
  font-size: 13px;
}

.table .font{
	  font-family:'Muli', sans-serif !important;
	  font-style: normal;
	  font-size: 13px;
	  font-weight: 400 !important;
	 
}

.table button {
    background-color: Transparent !important;
    background-repeat:no-repeat;
    border: none;
    cursor:pointer;
    overflow: hidden;
    outline:none;
    text-align: left !important;
}
.table td{
	padding:5px !important;
}
 .resubmitted{
	color:green;
}

	.fa{
		font-size: 1.20rem;
	}
	
.datatable-dashv1-list table tbody tr td{
	padding: 8px 10px !important;
}

.table-project-n{
	color: #005086;
}

#table thead tr th{
	padding: 0px 0px !important;
}

#table tbody tr td{
	padding:2px 3px !important;
}


/* icon styles */

.cc-rockmenu {
	color:fff;
	padding:0px 5px;
	font-family: 'Lato',sans-serif;
}

.cc-rockmenu .rolling {
  display: inline-block;
  cursor:pointer;
  width: 34px;
  height: 30px;
  text-align:left;
  overflow: hidden;
  transition: all 0.3s ease-out;
  white-space: nowrap;
  
}
.cc-rockmenu .rolling:hover {
  width: 108px;
}
.cc-rockmenu .rolling .rolling_icon {
  float:left;
  z-index: 9;
  display: inline-block;
  width: 28px;
  height: 52px;
  box-sizing: border-box;
  margin: 0 5px 0 0;
}
.cc-rockmenu .rolling .rolling_icon:hover .rolling {
  width: 312px;
}

.cc-rockmenu .rolling i.fa {
    font-size: 20px;
    padding: 6px;
}
.cc-rockmenu .rolling span {
    display: block;
    font-weight: bold;
    padding: 2px 0;
    font-size: 14px;
    font-family: 'Muli',sans-serif;
}

.cc-rockmenu .rolling p {
	margin:0;
}

.width{
	width:270px !important;
}


</style>
</head>
<body>


<%List<Object[]> LoginTypeList=(List<Object[]>)request.getAttribute("LoginTypeList"); %>


	
<%String ses=(String)request.getParameter("result"); 
 String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null){
	%><div align="center">
	<div class="alert alert-danger" role="alert">
                     <%=ses1 %>
                    </div></div>
	<%}if(ses!=null){ %>
	<div align="center">
	<div class="alert alert-success" role="alert" >
                     <%=ses %>
                   </div></div>
                    <%} %>

<br>	


	
<div class="container-fluid">		
	<div class="row">

		<div class="col-md-12">
			<div class="card shadow-nohover" >
				<h3 class="card-header">
					Login List
				</h3>
			</div>
		</div>
				
		<div class="card-body"> 
		
					 
			                                    <table id="table" data-toggle="table" data-pagination="true" data-search="true" data-show-columns="true" data-show-pagination-switch="true" data-show-refresh="true" data-key-events="true" data-show-toggle="true" data-resizable="true" data-cookie="true"
			                                        data-cookie-id-table="saveId" data-show-export="true" data-click-to-select="true" data-toolbar="#toolbar">
			                                        <thead>
			                                         
			                                            <tr>
			                                             	
			                                                <th >Username</th>
			                                                <th >Employee</th>
			                                                <th >Division</th>
			                                                <th  >Form Role </th>
			                                                <th>Action</th>
			                                                     
			                                            </tr>
			                                        </thead>
			                                        <tbody>
													   <%for(Object[] 	obj:LoginTypeList){ %>
													   
													    <tr>
													 
													   <td ><%if(obj[0]!=null){%><%=obj[0] %><%}else{ %>-<%} %></td>
													   <td><%=obj[1] %></td>
													 	<td><%=obj[2] %></td>
													     <td ><%if(obj[3]!=null){%><%=obj[3] %><%}else{ %>-<%} %></td>
														
													<td  class="left width">
														
														<%-- href="PreviewPage.htm?InitiationId=<%=obj[0]%>" --%>
														
														
														 <%-- <form action="PreviewPage.htm" method="POST" name="myfrm"  style="display: inline">
															<button  class="editable-click" name="InitiationId" value="<%=obj[0] %>"  formtarget="_blank" >  
																<div class="cc-rockmenu">
											                      <div class="rolling">
											                        <figure class="rolling_icon"><img src="view/images/plus.png"  ></figure>
											                        <span>   &nbsp;Add   </span>
											                      </div>
											                     </div> 
															</button>
															<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
															</form> --%>
															
														
											              <form action="LoginTypeEditRevoke.htm" method="POST" name="myfrm"  style="display: inline">
															<button  class="editable-click" name="sub" value="edit">
																<div class="cc-rockmenu">
																 <div class="rolling">	
											                        <figure class="rolling_icon"><img src="view/images/edit.png" ></figure>
											                        <span>Edit</span>
											                      </div>
											                     </div>
											                  </button>   
											                  <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />   
											               
											              
											        		<button  class="editable-click" name="sub" value="revoke" >
																<div class="cc-rockmenu">
																 <div class="rolling">	
											                        <figure class="rolling_icon"><img src="view/images/remove.png" ></figure>
											                        <span>Revoke</span>
											                      </div>
											                     </div>
											                  </button>   
															
															<input type="hidden" name="LoginId" value="<%=obj[4] %>"/>
															<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
														
															</form>
														</td>

													  </tr>
 												<%} %>
											</tbody>
				    					
			    
	                                    </table>
		                      
	                                </div>
	                            </div>
	
	
	
</div>	
	
	
	
	
<script type="text/javascript">

$(function () {
	  $('[data-toggle="tooltip"]').tooltip()
	})


function Prints(myfrm){
	
	 var fields = $("input[name='btSelectItem']").serializeArray();

	 
	  if (fields.length === 0){
		  myalert();
	 event.preventDefault();
	return false;
	}
	  return true;
}

/* 
$(document).ready(function(){
	
	$("#table").DataTable({
		"pageLength": 5
	})
})
 */


</script>
<div class="modal" id="loader">
					<!-- Place at bottom of page -->
				</div>
</body>
</html>