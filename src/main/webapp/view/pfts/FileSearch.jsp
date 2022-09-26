<%@page import="com.vts.pfms.pfts.model.PftsFileStage"%>
<%@page import="com.vts.pfms.pfts.model.PftsEventCreator"%>
<%@page import="com.vts.pfms.pfts.model.PftsFileEvents"%>
<%@page import="com.vts.pfms.pfts.model.PftsDemandImms"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.vts.pfms.master.dto.DemandDetails"%>
<%@page import="com.vts.pfms.master.dto.ProjectFinancialDetails"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.math.BigDecimal"%> 
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

<style type="text/css">

::placeholder {
  color: #F05454 !important;
  opacity: 1!important; 
}
 
 
.btn1
{
	margin: 0px 5px;
	font-family: 'Montserrat', sans-serif;
    font-weight: 800 !important; */
}


</style>

<meta charset="ISO-8859-1">

</head>
<body >
<%

FormatConverter fc=new FormatConverter(); 
SimpleDateFormat sdf=fc.getRegularDateFormat();
SimpleDateFormat sdf1=fc.getSqlDateFormat();
DecimalFormat df = new DecimalFormat("###############.##");


String action=(String)request.getAttribute("action");
String searchData=(String)request.getAttribute("searchData");
List<PftsDemandImms> demandDetails=(List<PftsDemandImms>)request.getAttribute("demandDetails");
String category=(String)request.getAttribute("action");

%>
<% String ses=(String)request.getParameter("result"); 
String ses1=(String)request.getParameter("resultfail");
if(ses1!=null){
%>
	<center>
	
		<div class="alert alert-danger" role="alert">
			<%=ses1 %>
		</div>
	</center>
	<%}if(ses!=null){ %>
	<center>
		<div class="alert alert-success" role="alert">
			<%=ses %>
		</div>

	</center>
	<%} %>

<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card shadow-nohover">

					<div class="card-header"
						style="background-color: #055C9D; margin-top:">
						<h4 style="color: white;">File Search</h4>
					</div>
					<div class="card-body">
						<div class="row" >
								
							  	<div class="col-md-4">
								  	<form class="navbar-form" action="FileSearch.htm" method="post">
									    <div class="input-group add-on">
									      <input type="text" class="form-control " placeholder="Search By DemandNo" name="SearchData" maxlength="100" required>
									      <input type="hidden" name="action" value="DemandNo">
									      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
										    <div class="input-group-btn">
										       <button class="btn btn-primary" style="margin: 0px" type="submit" name="demandNoBut"><font color="white"><i class="fa fa-search" aria-hidden="true"></i></font></button>
										    </div>
									    </div>
								    </form>
							    </div>
							    <div class="col-md-4">
								    <form class="navbar-form" action="FileSearch.htm" method="post">
									    <div class="input-group add-on">
									      <input type="text" class="form-control " placeholder="Search By FileNo" name="SearchData" maxlength="100" required>
									      <input type="hidden" name="action" value="FileNo">
									      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
										    <div class="input-group-btn">
										       <button class="btn btn-primary" style="margin: 0px" type="submit" name="demandNoBut"><font color="white"><i class="fa fa-search" aria-hidden="true"></i></font></button>
										    </div>
									    </div>
								    </form>
							    </div>
							    <div class="col-md-4">
								    <form class="navbar-form" action="FileSearch.htm" method="post">
									    <div class="input-group add-on">
									      <input type="text" class="form-control " placeholder="Search by DemandFor" name="SearchData" maxlength="100" required>
									      <input type="hidden" name="action" value="Item">
									      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
										    <div class="input-group-btn">
										       <button class="btn btn-primary" style="margin: 0px" type="submit" name="demandNoBut"><font color="white"><i class="fa fa-search" aria-hidden="true"></i></font></button>
										    </div>
								   		</div>
								  	</form>
							  	</div>
						  	
						 </div>
						 <br>
						 <%if(demandDetails!=null && demandDetails.size()==1){
							 PftsDemandImms demand=demandDetails.get(0);%>

						 <div class="col-md-12">
						 		<table  class="table table-hover  table-striped table-condensed table-bordered customers scrollTable">
			                               <tbody>
				                               <tr>
				                               		<td colspan="8" class="btn-primary" style="text-align:center ;width:120px;" ><b>Demand Details</b></td>
				                               </tr>
				                                <tr> 
						                            <td style='text-align:left;width:120px;background-color:#e0e2dc;'><b>Division</b></td>
						                            <td style='text-align:left;background-color:#fff8e7;width:150px;'><%=demand.getDivisionCode() %></td>
						                            <td style='text-align:left;width:120px;background-color:#e0e2dc;'><b>Mode&nbsp;Of&nbsp;Tender</b></td>
						                            <td style='text-align:left;background-color:#fff8e7;width:200px;'><%=demand.getDemandMode() %></td>
						                            <td style='text-align:left;width:120px;background-color:#e0e2dc;'><b>Demand&nbsp;No.</b></td>
						                            <td style='text-align:left;background-color:#fff8e7;width:200px;'><%=demand.getDemandNo() %></td>
						                            <td style='text-align:left;width:120px;background-color:#e0e2dc;'><b>Demand&nbsp;Date</b></td>
						                            <td style='text-align:left;background-color:#fff8e7;width:200px;'><%=sdf.format(sdf1.parse(demand.getDemandDate())) %></td>
				                                </tr>
				                                <tr> 
						                            <td style='text-align:left;width:120px;background-color:#e0e2dc;' ><b>Demand&nbsp;Type</b></td>
						                            <td style='text-align:left;background-color:#fff8e7;width:200px;'><%=demand.getDemandCat()%></td>
						                            <td style='text-align:left;width:120px;background-color:#e0e2dc;' ><b>File&nbsp;No.</b></td>
						                            <td style='text-align:left;background-color:#fff8e7;width:200px;' colspan="3"><%=demand.getFileNo() %></td>
						                            <td style='text-align:left;width:120px;background-color:#e0e2dc;' ><b>Initiating&nbsp;Officer</b></td>
						                            <td style='text-align:left;background-color:#fff8e7;width:200px;' ><%=demand.getDemandingOfficer() %></td>
				                                </tr>
				                                <tr> 
						                            <td style='text-align:left;width:120px;background-color:#e0e2dc;'><b>Demand For</b></td>
						                            <td style='text-align:left;background-color:#fff8e7;width:150px;' colspan="3"><%=demand.getItemFor() %></td>
						                            <td style='text-align:left;width:120px;background-color:#e0e2dc;'><b>Project&nbsp;Name</b></td>
						                            <td style='text-align:left;background-color:#fff8e7;width:200px;'><%=demand.getProjectCode() %></td>
					                                <td style='text-align:left;width:120px;background-color:#e0e2dc;'><b>Estimated&nbsp;Cost</b></td>
						                            <td style='text-align:left;background-color:#fff8e7;width:200px;'><%=NFormatConvertion.convert(demand.getEstimatedCost()) %></td>
				                                </tr>
			                           	    </tbody> 
			                </table>
						 	<%
							  	List<Object[]> eventStatusList=(List<Object[]>)request.getAttribute("eventStatusDetails");
							  	List<PftsFileEvents> eventList=(List<PftsFileEvents>)request.getAttribute("eventList");
							 	List<PftsEventCreator> eventCreatorList=(List<PftsEventCreator>)request.getAttribute("eventCreatorList");
							  	List<Object[]> soList=(List<Object[]>)request.getAttribute("soList");
							  	List<Object[]> openedSoList=(List<Object[]>)request.getAttribute("openedSoList");
							  	List<PftsFileStage> fileStageList=(List<PftsFileStage>)request.getAttribute("fileStageList");
							  	
							  	String demandId=(String)request.getAttribute("demandId");
							  	String demandNo=(String)request.getAttribute("demandNo");
							  	String demandIdNo=(String)request.getAttribute("demandIdNo");
							  	
							  	String fileTrackingId=null;
							  	String supplyOrderNo=(String)request.getAttribute("supplyOrderNo");
							  	String startDate=(String)request.getAttribute("eventDate");
							  	String currentDate=sdf.format(new Date());
							  	Integer fileCloseResult=(Integer)request.getAttribute("fileCloseResult");
							  	
						  	%>	
							<%	int status=0;
								if(eventStatusList!=null)
								{ 
								int count=0; %>
								
													<table id="myTable"  class="table table-hover  table-striped table-condensed table-bordered">
								                              <thead> 
								                                <tr class="btn-primary" >            
								                                   <th>Sl No.</th>
								                                   <th>Event Creator</th>
								                                   <th>Event Type</th>
								                                   <th>Event Name</th>
								                                   <th>Event Date </th>
								                                   <th>Remarks</th>
								                               	</tr>
								                               </thead>
								                             <tbody>
								                             <%
								                             if(eventStatusList!=null && eventStatusList.size()>0){ 
								                             for(Object[] obj:eventStatusList){ 
								                            	 count++;
								                            	 fileTrackingId=obj[7].toString();
								                            	 Integer statusCount=(Integer)obj[9];
								                            	 status=status+statusCount;
								                             %>
								                               
								                               <tr>
								                               	<td><%= count%></td>
								                               	<td><%= obj[0]%></td>
								                               	<td><%= obj[2]%></td>
								                               	<td><%= obj[3]%></td>
								                               	<%if(obj[4]!=null){ 
								                               		String eventdate=sdf.format(obj[4]);
								                               	%>
								                               	<td><%= eventdate%></td>
								                               	<%}else{ %>
								                               	<td>--</td>
								                               	<%} %>
								                               	<%if(obj[5]!=null){ %>
								                               	<td><%= obj[5]%></td>
								                               <%}else{ %>
								                               <td>--</td>
								                               <%} %>
								                               </tr>
								                               <%}}else{ %>
								                               <%
								                               status=1;
								                               } %>
								                             </tbody>
													</table>
								
								<%} %>
								
								<div class="col-md-row" align="center">
								  
									<% if(status>0)
									{
										if(eventStatusList!=null && eventStatusList.size()>0)
										{ %>
									  			<button class="btn btn1 btn-primary btn-rounded btn-sm" data-toggle="modal" data-target="#modalLoginForm"> Add New Status Event</button>
										    <%-- <%if(fileCloseResult==1 || fileCloseResult==2){ %>
										    	<button class="btn btn1 btn-info btn-rounded btn-sm" onclick="SODetails()">Supply Order</button>
										    <%} %> --%>
											    <button type="submit" class="btn  btn1 btn-warning btn-sm" data-toggle="modal" data-target="#modalEditEventStatus">Edit Events</button>
										    <%
										  
										    if(openedSoList!=null && openedSoList.size()>0){ %>
										    	<button class="btn btn1 btn-danger btn-rounded btn-sm" data-toggle="modal" data-target="#modalFileClose">File Close</button>
										    <%}else{ %>
										   		<button class="btn  btn1 btn-danger btn-rounded btn-sm" onclick="closeFile()">File Close</button>
										    <%}%>
										    
									    <%}else{ %>
									    	<button class="btn btn1 btn-primary btn-rounded btn-sm" data-toggle="modal" data-target="#modalFileReceivedDate">Add New Status Event</button>
									    <%} 
										
									}else{%>
									   		<button class="btn  btn1 btn-primary btn-rounded btn-sm" disabled="disabled">Add New Status Event</button>
									    	<button class="btn btn1 btn-warning btn-rounded btn-sm" disabled="disabled">Edit Events</button>
									    <%} %>
								   	<a  class="btn btn1 btn-rounded btn-sm back" href="FileSearch.htm"  >Go Back</a>
									
								</div>
			<!-- modal box for enter file received date -->
				<div class="modal fade" id="modalFileReceivedDate" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				  <div class="modal-dialog" role="document">
				    <div class="modal-content">
				      <div class="modal-header text-center">
				        <h4 class="">File Received Date</h4>
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				          <span aria-hidden="true">&times;</span>
				        </button>
				      </div>
				   <form action="Add-Event.htm" method="post">
				    <div class="modal-body">
					     
					      	<div class=" row" style="padding:5px;">
					   			<div class = "col-md-2"></div>
					   			<div class = "col-md-5">
						      		<input type='text' class="form-control datepickerFile" name="date" id="frdate" readonly/>
								</div>
								<div class = "col-md-4">
									<button type="submit" class="btn btn-primary">Submit</button>
								</div>
								</div>
							
					      <input type="hidden" name="demandId" value="<%=demandId%>">
					      <input type="hidden" name="demandNo" value="<%=demandNo%>">
					      <input type="hidden" name="demandIdNo" value="<%=demandIdNo%>">
					      <input type="hidden" name="statusEvent" value="1">
					      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					</div>
				   
				      
			       </form>
				  </div>
				</div>
			</div>					
			<!--  ------------------------ modal box for add new event ------------------------------- --> 
			
								<div class="modal fade bd-example-modal-lg" id="modalLoginForm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
									<div class="modal-dialog modal-dialog-centered" role="document" style="max-width: 55% !important ;">
										<div class="modal-content" >
										<form action="Add-Event.htm" method="post">
											<div class="modal-header">
												<h4 class="">Add Status Event</h4>
												<button type="button" class="close" data-dismiss="modal" aria-label="Close"> <span aria-hidden="true">&times;</span> </button>
											</div>
											<div class="modal-body">
												
												<div class="row" style=" margin:0px; 10px;">
													<div class="col-md-4">
														<span style="font-weight: 600;">File Stage : </span>
														<select class="form-control selectpicker" data-live-search="true" name="filestageId" id="filestageId" onchange="getEvent()" required>
															<option>Select File Stage</option>
															<% if(fileStageList!=null)
															{ 
																for(PftsFileStage obj:fileStageList)
																{ %>
																	<option value="<%=obj.getFileStageId() %>"><%=obj.getFileStageName()%></option>
																<%} 
															}%>
														</select>
													</div>
													<div class="col-md-8">
														<span style="font-weight: 600;">Select Event : </span>
														<div id="selectedEvent">
															<select class="form-control" name="statusEvent" required>
														 	   <option value="">Select Status Event</option>
														    </select>
													    </div>
													</div>
												</div>  
											<!-- selectpicker" data-live-search="true" -->
												<br>
													<div class=" row" style=" margin:0px; 10px;">
														<div class="col-md-4">
															<span style="font-weight: 600;">Event Date : </span>
														   		<input type='text' class="form-control" name="date" id="statuseventdate" readonly/>
														</div>
													<div class="col-md-8">
															<span style="font-weight: 600;">Event Remarks : </span>
														   	<input type="text" class="form-control" placeholder="Remarks" name="remarks" value="" maxlength="100" required>
														</div>
													</div>
												<input type="hidden" id="demandIdNoOrder" name="demandId" value="<%=demandId%>">
												<input type="hidden" id="demandNoNoOrder" name="demandNo" value="<%=demandNo%>">
												<input type="hidden" name="demandIdNo" value="<%=demandIdNo%>">
												<input type="hidden" id="fileTrackingIdNoOrder" name="fileTrackingId" value="<%=fileTrackingId%>">
												<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
												
											</div>
											<div class="modal-body" align="center" >
												<button type="submit" class="btn btn-primary btn-sm submit">Submit</button>
											</div>
													      
										</form>
										</div>
									</div>
								</div>
			<!-- ---------------modal box for add new event----------------------------- -->					
			<!-- --------------- modal box for Edit Event Status ----------------------------- -->
						<div class="modal fade" id="modalEditEventStatus" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
						  <div class="modal-dialog modal-lg" role="document" style="max-width: 70% !important ;">
						    <div class="modal-content">
						      <div class="modal-header">
						        <h4 class="">Edit Event Status</h4>
						        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
						          <span aria-hidden="true">&times;</span>
						        </button>
						      </div>
						      <form action="editStatusEvent-page.htm" method="post">
						      <div class="panel panel-default ">
						      <div class=" row" style="padding:5px;">
						      	<div class="col-md-12">
							      	<div class="panel panel-default ">
								      	<div style="padding-top:5px;padding-left:5px;padding-right:5px;">
											<table  id="myTable1" class="addDataTable3 table table-hover  table-striped table-condensed table-bordered">
								                              <thead> 
								                                <tr class="btn-primary">            
								                                   <th>Sl&nbsp;No.</th>
								                                   <th>Event&nbsp;Creator</th>
								                                   <th>Event&nbsp;Type</th>
								                                   <th>Event&nbsp;Name</th>
								                                   <th>Event&nbsp;Date </th>
								                                   <th>Remarks</th>
								                                  </tr>
								                               </thead>
								                             <tbody>
								                             <%
								                             if(eventStatusList!=null){ 
								                             for(Object[] obj:eventStatusList){
								                             %>
								                             	<tr>
								                               	<td><input type="radio" name="EventStatusId" value="<%= obj[8]%>" required="required"></td>
								                               	<td><%= obj[0]%></td>
								                               	<td><%= obj[2]%></td>
								                               	<td><%= obj[3]%></td>
								                               	<%if(obj[4]!=null){ 
								                               		String eventdate=sdf.format(obj[4]);
								                               	%>
								                               	<td><%= eventdate%></td>
								                               	<%}else{ %>
								                               	<td>--</td>
								                               	<%} %>
								                               	<%if(obj[5]!=null){ %>
								                               	<td><%= obj[5]%></td>
								                               <%}else{ %>
								                               <td>--</td>
								                               <%} %>
								                               </tr>
								                             <%}} %>
								                             </tbody>
								            	 </table>
								             </div>
							             </div>
						             </div>
						      </div>
						      	
						      	
						      <input type="hidden" name="demandId" value="<%=demandId%>">
						      <input type="hidden" name="demandNo" value="<%=demandNo%>">
						      <input type="hidden" name="demandIdNo" value="<%=demandIdNo%>">
						      <input type="hidden" name="fileTrackingId" value="<%=fileTrackingId%>">
						      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						</div>
						   
						    
						    <div class="modal-body" align="center">
						        <button type="submit" class="btn btn-primary btn-sm submit">Submit</button>
						    </div>
						      
						       </form>
						  </div>
						</div>
					</div>				 
						 
<!-- --------------- modal box for Edit Event Status ----------------------------- -->
<!-- --------------- modal box for close file ----------------------------- -->	 
				<div class="modal fade" id="modalFileClose" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
					  <div class="modal-dialog" role="document">
					    <div class="modal-content">
					      <div class="modal-header text-center">
					       		<h4 class="">Close Supply Order</h4>
					       		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					          		<span aria-hidden="true">&times;</span>
					       		</button>
					      </div>
					      <div class="modal-body">
					      <div class=" row" style="padding:5px;">
					      <div class="col-md-12">
					      	
					      	<div style="padding-top:5px;padding-left:5px;padding-right:5px;">
								
							<table id=""  class="addDataTable2 table table-hover  table-striped table-condensed table-bordered">
					                              <thead> 
					                                <tr class="btn-primary">            
					                                   <th style="text-align:center;">Previous&nbsp;Supply&nbsp;Order&nbsp;No.</th>
					                                  </tr>
					                               </thead>
					                             <tbody>
					                             <%
					                             if(openedSoList!=null){ 
					                             for(Object[] str:openedSoList){
					                             %>
					                             
					                             	<tr>
					                             	<td align="center">
					                             	<form action="fileClose.htm" method="post">
					                             		<input type="text" name="SupplyOrderNo" value="<%=str[0] %>" readonly>
					                             		<input type="hidden" name="demandId" value="<%=demandId%>">
													    <input type="hidden" name="demandNo" value="<%=demandNo%>">
													    <input type="hidden" name="fileTrackingId" value="<%=fileTrackingId%>">
													    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					                             		<button type="submit" name="orderCloseId" value="<%=str[1] %>" class="btn btn-danger btn-sm" onclick="return closeFile()">Close</button>
					                             	</form>
					                             	</td>
					                             	</tr>
					                             <%}} %>
					                             </tbody>
					             </table>
					             </div>
					             </div>
					             </div>
					      </div>
					      
					      
					      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					      <input type="hidden" id="SodemandId" name="demandId" value="<%=demandId%>">
					      <input type="hidden" id="SodemandNo" name="demandNo" value="<%=demandNo%>">
					      <input type="hidden" id="SodemandIdNo" name="demandIdNo" value="<%=demandIdNo%>">
					      <input type="hidden" id="fileTrackingId" name="fileTrackingId" value="<%=fileTrackingId%>">
					</div>
				</div>
			</div>
		</div>
   
<!-- --------------- modal box for close file ----------------------------- -->
						 </div>
<!-- --------------- for list of demands ----------------------------- -->						 
							 
						 <%}else if(demandDetails!=null && demandDetails.size()>1){ %>

								  <div class="col-md-12">
								  	<%if(category!=null){ %>
									  	<div align="center" style="background-color: #99DDCC;margin-bottom: 8px;"> 
										  	<div class="" >
										  		<b><font size="4" color="#560e1c">Demand List Of Category :</font> <font color="#337cdf" size="4"><%=category %></font><font size="4" color="#560e1c">, Search Data :</font> <font size="4" color="#337cdf"><%=searchData %></font></b>
										    </div>
										</div>
								    <%} %>
									<form action="New-Event.htm"  method="post">
										<%if(demandDetails!=null){ %>
								          <table id="addDataTable6"  class="table table-hover  table-striped table-condensed table-bordered">
				                	          <thead> 
								    	          <tr style="background-color:#0b7abf;color:white;">            
									                  <th>Select</th>
									                  <th>Item Description</th>
									                  <th>File No</th>
									                  <th>Demand&nbsp;No </th>
									                  <th>Demand&nbsp;Date</th>
									                  <th>Estimated&nbsp;Cost</th>
									              </tr>
									         	</thead>
									            <tbody>
									            <%if(demandDetails!=null){ 
									            	for(PftsDemandImms demand:demandDetails){
									                Date dDate=sdf.parse(demand.getDemandDate());
									            %>
									            	<tr> 
									                	<td><input type="radio" name="demandIdNo" required value="<%=demand.getDemandNo() %>##<%=demand.getDemandId() %>" ></td>
									                    <td><%=demand.getItemFor() %></td>
									                    <td><%=demand.getFileNo() %></td>
									                    <td><%=demand.getDemandNo() %>
									                    <td><%=sdf.format(dDate)%></td>
									                    <td align="right"><%=NFormatConvertion.convert(demand.getEstimatedCost()) %></td>
									                </tr>
									           <%} }%>
									           </tbody> 
									      </table>
									      <%if(demandDetails!=null && demandDetails.size()>0){ %>
									      	<div align="center">
									            <button type="submit" class="btn btn-success">Submit</button>
									        </div>
									      <%} else{%>
									      	<div align="center">
									            <button type="submit" class="btn btn-success" disabled>Submit</button>
									        </div>
									      <%}} %>
									      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
								    </form>
								  </div>
							   
						 <%} %>
					
				</div>
				</div>
				
			</div>
		</div>
	
	
<script type="text/javascript">
function getEvent(){
	var $filestageId=$("#filestageId").val();
	var txt = '';
	 $.ajax({
		url: 'getFileEventAjax.htm',
		type: 'GET',
		data: { filestageId: $filestageId},
		success: function(result){
			var jsonObj=JSON.parse(result);
			txt += '<select class="form-control" name="statusEvent">'
			for (x in jsonObj) 
			{
				txt +='<option value='+jsonObj[x].FileEventId+'>'+jsonObj[x].EventName+'</option>';
			}
			 txt += '</select>';
			$("#selectedEvent").html(txt);
		}
	});  
		
}

$('#statuseventdate , #frdate').daterangepicker({

	"singleDatePicker": true,
	"showDropdowns": true,
	"cancelClass": "btn-default",
	
	locale: {
    	format: 'DD-MM-YYYY'
	}
}); 

$(document).ready(function(){
	  $("#myTable, #myTable1, #addDataTable6").DataTable({
	 "lengthMenu": [ 5, 10,25, 50, 75, 100 ],
	 "pagingType": "simple",
	 "pageLength": 5
		
	
});

});
  
</script>

<script type="text/javascript">

	 function closeFile(){
		var demandId=$("#demandIdNoOrder").val();
		var demandNo=$("#demandNoNoOrder").val();
		var fileTrackingId=$("#fileTrackingIdNoOrder").val();
		var r = confirm("Are Youe Sure!");
		if (r == true) {
			
			
			location.href = "fileCloseNoOrder.htm?demandNo="+demandNo+"&fileTrackingId="+fileTrackingId+"&demandId="+demandId;
			
		} else {
		  return false;
		}
	} 
	
	function SODetails(){
		var demandId=$("#demandIdNoOrder").val();
		var demandNo=$("#demandNoNoOrder").val();
		var fileTrackingId=$("#fileTrackingIdNoOrder").val();
		location.href = "SODetails.htm?demandNo="+demandNo+"&demandId="+demandId+"&fileTrackingId="+fileTrackingId;
	}
	
</script>
	
</body>
</html>