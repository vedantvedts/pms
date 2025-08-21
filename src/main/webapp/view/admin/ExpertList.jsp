<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<%-- <jsp:include page="../static/sidebar.jsp"></jsp:include> --%>
<title>EXPERT LIST</title>
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
<%
SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
List<Object[]> expertList=(List<Object[]>)request.getAttribute("ExpertList");
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
	
<div class="container-fluid">		
	<div class="row">
		<div class="col-md-12">
		
			<div class="card shadow-nohover" >
			<div class="card-header">
			<div class=row>
				<div class="col-3"><h4>Expert List</h4></div>
				 <div class="col-7"></div>
				 <div class="col-2">
				<form method="post" style="margin-left: 4.2rem; " action="ExpertAdd.htm" >
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
									<button type="submit" style="margin-top: -5px;" name="projecttype" value="N" class="btn btn-sm add" >ADD EXPERT</button>						
				</form>	
				</div>
			</div>
								</div>
				<div class="card-body"> 
		
					 <div class="data-table-area mg-b-15">
			            <div class="container-fluid">
			                
			                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
			                        <div class="sparkline13-list">
			                           <!--  <div class="sparkline13-hd">
			                                <div class="main-sparkline13-hd">
			                                    <h3> <span class="table-project-n">Initiation List</span> </h3>
			                                </div>
			                            </div> -->
			                            <div class="sparkline13-graph">
			                               <!--  <div class="datatable-dashv1-list custom-datatable-overright"> -->
			                                    <table class="table table-bordered table-hover table-striped table-condensed "  id="myTableExpert"> 
			                                        <thead style=" text-align: center;">
			                                         
			                                            <tr>
			                                                <th >Sr No.</th>
			                                                <th >Expert No.</th>
			                                                <th >Name</th>
			                                                <th >Designation</th>
			                                                <th >Organization </th>
			                                                <th >Status </th>
			                                                <th>Edit and Revoke</th>       
			                                            </tr>
			                                        </thead>
			                                        <tbody>
			                                        <%if(expertList!=null){
			                                        int srno=1;
			                                        %>
			                                            <%for(Object[] expert:expertList){ %>
			                                            <tr>
			                                                <td><%=srno++%></td>
			                                               <td><%=expert[1]!=null?StringEscapeUtils.escapeHtml4(expert[1].toString()): " - "%></td>
			                                               <td><%=expert[2]!=null?StringEscapeUtils.escapeHtml4(expert[2].toString()): " - "%></td>
			                                               <td><%=expert[3]!=null?StringEscapeUtils.escapeHtml4(expert[3].toString()): " - "%></td>
			                                               <td><%=expert[7]!=null?StringEscapeUtils.escapeHtml4(expert[7].toString()): " - "%></td>
			                                               <td>
			                                               <%
			                                            
			                                               if(Integer.parseInt(expert[8].toString())==1) {%>
			                                                     <span class="badge badge-success">Active</span>  
			                                               <%}else{ %>
			                                               <span class="badge badge-danger">Inactive</span>
			                                               <%} %>
			                                               </td>
			                                              			<td  class="left width">
												
													 <form action="ExpertEditRevoke.htm" method="POST" name="myfrm"  style="display: inline">
															<button  class="editable-click" name="sub" value="edit">
																<div class="cc-rockmenu">
																 <div class="rolling">	
											                        <figure class="rolling_icon"><img src="view/images/edit.png" ></figure>
											                        <span>Edit</span>
											                      </div>
											                     </div>
											                  </button>   
											                  <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
											                    
											               <%  if(Boolean.parseBoolean(expert[8].toString())) {%>
			                                                   <button  class="editable-click" name="sub" value="revoke" onclick="Delete(myfrm)">
																<div class="cc-rockmenu">
																 <div class="rolling">	
											                        <figure class="rolling_icon"><img src="view/images/remove.png" ></figure>
											                        <span>Revoke</span>
											                      </div>
											                     </div>
											                  </button>   
			                                               <%}%>
			                                               
											              
											        		
															
															<input type="hidden" name="expertId" value="<%=expert[0] %>"/>
															<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
														
															</form>
			                                               </td>
			                                               
			                                             </tr>
			                                             <%}%>
													 <%} %>
											</tbody>
				    					<!-- 	<tfoot>
				    						<tr>
				    					
				    						<td colspan="8" align="right">
				    				
				    						</td>
				    						</tr>
				    						
				    						</tfoot> -->
				    
			                                    </table>
			                      
			                               <!--  </div> -->
			                            </div>
			                        </div>
			                    </div>
			          	 </div>
			        </div>
        	</div>
        </div>
        
	
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




function Delete(myfrm){

	  var cnf=confirm("Are You Sure To Make Expert Revoke !");
	  if(cnf){
	
	return true;
	
	}
	  else{
		  event.preventDefault();
			return false;
			}
	
	}

</script>

<script type="text/javascript">

$(document).ready(function(){
	  $("#myTableExpert").DataTable({
	 "lengthMenu": [ 5, 10,25, 50, 75, 100 ],
	 "pagingType": "simple",
	 "pageLength": 5
});
});
  
</script>

</body>
</html>