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
<title>PROJECT INT  LIST</title>
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

	.fa-long-arrow-right{
		font-size: 2.20rem;
		padding: 0px 5px;
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

		.label{
			border-radius: 3px;
  			color: white;
  			padding:1px 2px;
		}
		.label-primary{
			background-color:#D62AD0; /* D62AD0 */
		}
		.label-warning{
  			background-color:#5C33F6;
		}
		.label-info{
  			background-color:#006400;
  			
		}
		.label-success{
			background-color:#4B0082;
		}

		.trup
		{
			padding:5px 10px 0px 10px ;			
			border-top-left-radius : 5px; 
			border-top-right-radius: 5px;
			font-size: 14px;
			font-weight: 600;
			
			
		}
		
		.trdown
		{
			padding:0px 10px 5px 10px ;			
			border-bottom-left-radius : 5px; 
			border-bottom-right-radius: 5px;
			font-size: 14px;
			font-weight: 600;
		}




</style>
</head>
<body>
<%SimpleDateFormat sdf=new SimpleDateFormat("dd-MM-yyyy");
List<Object[]> ProjectIntiationList=(List<Object[]>) request.getAttribute("ProjectIntiationList");
List<Object[]> projectapprovalflowempdata=(List<Object[]>) request.getAttribute("projectapprovalflowempdata");

DecimalFormat df=new DecimalFormat("0.00");
NFormatConvertion nfc=new NFormatConvertion();
%>



<%String ses=(String)request.getParameter("result"); 
 String ses1=(String)request.getParameter("resultfail");
	if(ses1!=null){
	%>
	
	
	<center>
	
	<div class="alert alert-danger" role="alert">
                     <%=ses1 %>
                    </div></center>
	<%}if(ses!=null){ %>
	<center>
	<div class="alert alert-success" role="alert" >
                     <%=ses %>
            </div>
            
    </center>
    
    
                    <%} %>


	
<br>	
	
<div class="container-fluid">		
	<div class="row">
		<div class="col-md-12">
		
			<div class="card shadow-nohover" style="margin-top: -1% " >
			
				<h3 class="card-header">
					Initiation List
				
				</h3>
				
				<div class="card-body"> 
		
					
			                                    
			                                     <table class="table table-bordered table-hover table-striped table-condensed "  id="table1"> 
			                                        <thead>
			                                         
			                                            <tr>
			                                             	<th>IsMain</th>
			                                                <th >Category</th>
			                                                <th >Title</th>
			                                                <th >Code</th>
			                                                <th  >Security Classification </th>
			                                                <th >Cost</th>
			                                                <th  >Duration</th> 
			                                                <th style="width: 25%" >Preview, Forward and Details</th>       
			                                            </tr>
			                                        </thead>
			                                        <tbody>
													   <%for(Object[] 	obj:ProjectIntiationList){ %>
													   
													    <tr>
													 	<td class="center"><%if(obj[8]!=null){%><%=obj[8] %><%}else{ %>-<%} %></td>
													   <td class="center"><%if(obj[2]!=null){%><%=obj[2] %><%}else{ %>-<%} %></td>
													   <td class="wrap"><%=obj[5] %></td>
													 	<td><%=obj[4] %></td>
													 	<td class="wrap"><%if(obj[3]!=null){%><%=obj[3] %><%}else{ %>-<%} %></td>
												     <td class="right" >
												      <%if(obj[6]!=null){%><%=nfc.convert(Double.parseDouble(obj[6].toString())/100000) %><%}else{ %>-<%} %> 
												     
												     <%-- <%if(obj[6]!=null){%><%=obj[6]%><%}else{ %>-<%} %> --%>
												     
												     </td>
													     <td class="center"><%if(obj[7]!=null){%><%=obj[7] %><%}else{ %>-<%} %></td>
														
													<td  class="left width">
														
														<%-- href="PreviewPage.htm?InitiationId=<%=obj[0]%>" --%>
														
														
														 <form action="PreviewPage.htm" method="POST" name="myfrm"  style="display: inline">
															<button  class="editable-click" name="InitiationId" value="<%=obj[0] %>"  formtarget="_blank" >  
																<div class="cc-rockmenu">
											                      <div class="rolling">
											                        <figure class="rolling_icon"><img src="view/images/preview3.png"  ></figure>
											                        <span>Preview</span>
											                      </div>
											                     </div> 
															</button>
															<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
															</form>
															
														
													 	<form action="ProjectIntiationForward.htm" method="POST" name="myfrm"  style="display: inline">
															<button  class="editable-click" name="InitiationId" value="<%=obj[0]%>" onclick="return confirm('Are You Sure To Forward this Project?');">
																<div class="cc-rockmenu">
																 <div class="rolling">	
											                        <figure class="rolling_icon"><img src="view/images/forward1.png" ></figure>
											                        <span>Forward</span>
											                      </div>
											                     </div>
											                  </button>   
											                  <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
											                  <input type="hidden" name="projectcode" value="<%=obj[4] %>"/>   
											                  <input type="hidden" name="pdd" value="<%=obj[9] %>"/> 
											             </form>  
											               
											              
											              <form action="ProjectIntiationListSubmit.htm" method="POST" name="myfrm"  style="display: inline">
											        		<button  class="editable-click" name="sub" value="Details" >
																<div class="cc-rockmenu">
																 <div class="rolling">	
											                        <figure class="rolling_icon"><img src="view/images/clipboard.png" ></figure>
											                        <span>Details</span>
											                      </div>
											                     </div>
											                  </button>   
															
															<input type="hidden" name="btSelectItem" value="<%=obj[0] %>" />
															<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" /> 
														
															</form>
															
															<form action="IntiationChecklist.htm" method="POST" name="myfrm"  style="display: inline">
															<button  class="editable-click" name="InitiationId" value="<%=obj[0]%>" >
																<div class="cc-rockmenu">
																 <div class="rolling">	
											                        <figure class="rolling_icon"><img src="view/images/checklist.png" ></figure>
											                        <span>Checklist</span>
											                      </div>
											                     </div>
											                  </button>   
											                  <input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
											                  <input type="hidden" name="initiationid" value="<%=obj[0] %>"/>   
											             </form>  
															
															
														</td>

													  </tr>
 												<%} %>
											</tbody>
				    						<tfoot>
				    						<tr>
				    					
				    						<td colspan="8" align="right">
				    						<b>Cost In Lakhs, Duration In Months.</b>
				    						</td>
				    						</tr>
				    						
				    						</tfoot>
				    
			                                    </table>
			                      
			                                </div>
			                                
			                  <hr>
			                  
			                <div class="row"  >
						 		<div class="col-md-12" style="text-align: center;"><b>Approval Flow</b></div>
						 	</div>
						 	<div class="row"  style="text-align: center; padding-top: 10px; padding-bottom: 15px; " >
				                <table  align="center" >
				                	<tr>
				                		<td class="trup" style="background: #B5EAEA;">
				                			Division Head
				                		</td>
				                		<td rowspan="2">
				                			 <i class="fa fa-long-arrow-right " aria-hidden="true"></i>
				                		</td >
				                		
				                		<td class="trup" style="background: #C6B4CE;">

				                			DO-P&C

				                			<!-- P&C DO -->

				                		</td>
				                		<td rowspan="2">
				                			 <i class="fa fa-long-arrow-right " aria-hidden="true"></i>
				                		</td>
				                		
				                		<td class="trup" style="background: #E8E46E;">
				                			AD 
				                		</td>
				                		<td rowspan="2">
				                			<i class="fa fa-long-arrow-right " aria-hidden="true"></i>
				                		</td>
				                		
				                		<td class="trup" style="background: #FBC7F7;" >
				                			TCM
				                		</td>
				                			                		
				                	</tr>			   
				                	
				                	<tr>
				                		<td class="trdown" style=" background:#B5EAEA; " >	
				                			<%--  <%if(projectapprovalflowempdata.size()>0){ %>
							                     <%for(Object[] obj : projectapprovalflowempdata){ %>
							                     	<%if(obj[3].toString().equals("Division Head") ){ %>
							                     		<%=obj[1] %>,<%=obj[2] %>
							                     	<%} %>
							                     <%} %>
							               <%} %>      --%> 
							               Division Head of PDD
							               
				                		</td>
				                		<td class="trdown"  style="background: #C6B4CE;" >	
				                			<%if(projectapprovalflowempdata.size()>0){ %>
							                     <%for(Object[] obj : projectapprovalflowempdata){ %>
							                     	<%if(obj[3].toString().equals("DO-RTMD") ){ %>
							                     		<%=obj[1] %>,<%=obj[2] %>
							                     	<%} %>
							                     <%} %>
							               <%} %>
				                		</td>
				                		<td class="trdown" style="background: #E8E46E;" >	
				                			<%if(projectapprovalflowempdata.size()>0){ %>
							                     <%for(Object[] obj : projectapprovalflowempdata){ %>
							                     	<%if(obj[3].toString().equals("AD") ){ %>
							                     		<%=obj[1] %>,<%=obj[2] %>
							                     	<%} %>
							                     <%} %>
							               <%} %>
				                		</td>
				                		<td class="trdown" style="background: #FBC7F7;" >	
				                			<%if(projectapprovalflowempdata.size()>0){ %>
							                     <%for(Object[] obj : projectapprovalflowempdata){ %>
							                     	<%if(obj[3].toString().equals("TCM") ){ %>
							                     		<%=obj[1] %>,<%=obj[2] %>
							                     	<%} %>
							                     <%} %>
							               <%} %>
				                		</td>
				                	</tr>             	
				                </table>			             
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


$(document).ready(function(){
	
	$("#table1").DataTable({
		"pageLength": 5
	})
})



</script>
<div class="modal" id="loader">
					<!-- Place at bottom of page -->
				</div>
</body>
</html>