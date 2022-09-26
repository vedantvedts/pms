<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="com.vts.pfms.pfts.model.PftsDemandImms"%>
<%@page import="java.math.BigInteger"%>
<%@page import="com.vts.pfms.pfts.model.PftsFileEvents"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.time.LocalDate"%>
    
   
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<meta charset="ISO-8859-1">
 
 
 
 <style type="text/css">.mandatory{color:#d9534f;}</style>
<style type="text/css">

.table thead tr th{vertical-align:middle; text-align: center; font-size: 12px; white-space: nowrap;}
.table tbody tr td{vertical-align:middle; text-align: center; font-size: 12px; white-space: nowrap; }



</style>
<style>
.btn1{
background-color:#158ad0!important;
}
.btn1{
padding-top: 6px!important;
padding-right: 10px!important;
padding-bottom: 6px!important;
padding-left: 10px!important;
}

::placeholder {
  color: #F05454 !important;
  opacity: 1!important; 
}



.table-wrapper-scroll-y {
display: block;
max-height: 280px;
overflow-y: auto;
-ms-overflow-style: -ms-autohiding-scrollbar;
}

.table-wrapper-scroll-x {
display: block;
max-height: 330px;
overflow-y: auto;
-ms-overflow-style: -ms-autohiding-scrollbar;
}

#customers {
    font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
    border-collapse: collapse;
    width: 100%;
}

#customers td, #customers th {
    border: 1px solid #ddd;
    padding: 8px;
}


#customers th {
    padding-top: 12px;
    padding-bottom: 12px;
    text-align: left;
    background-color: #0b7abf;
    color: white;
}

.clickable:hover{
  cursor: pointer;
  background-color: #68829e;
  color:#f9f9f9;
}


</style>
<style>

.label-sanc{
  background-color:#006400;
}

.label-indigo{
  background-color:	#4B0082;
}


.bulet {
        width:16px;
        position:absolute;
        top:120px;
        left:30px;
    }
    .roundChecked {
        width:16px;
        height:16px;
        border-radius:50px;
        border:4px #529b22 solid;
        border-width:4px;
        border-style:solid;
    }
    .lineChecked {
        width:3px;
        height:75px;
        background-color:#529b22;
        margin:auto 6px;

    }
    .roundUnChecked {
        width:16px;
        height:16px;
        border-radius:50px;
        border:4px #c2bfbf solid;
        border-width:4px;
        border-style:solid;

    }
    .lineUnChecked {
        width:3px;
        height:75px;
        background-color:#c2bfbf;
        margin:auto 6px;

    }
    
   
    .full-size {
    width:100%;
    border-top:3px solid #ccc;
}

.full-size .inner-panel {
    background-color:white;
    padding:20px 5px 20px 5px;
    border-bottom:1px solid #ccc;
    border-top:1px solid #ccc;
    display: flex;
    min-height:60px;
}.full-size .inner-panel .action-btn {
    background-color:#415dab;
    font-size:14px !important;
    font-weight:600;
    width:89px;
    height:24px;
    padding: 3px 4px;
    color:white;
}
.full-size .inner-panel .mail-btn {
    background-color:white;
    font-size:14px !important;
    border:1px solid #415dab;
    font-weight:600;
    width:104px;
    height:24px;
    padding: 3px 4px;
    color:#415dab;
}.desc-line{
    color:#3b3f48;
}
.desc-bold{
    color:#000;
    font-weight:bold;
    font-size:20px;
    border-radius: 5px;
    
    padding:1px 4px;
}

.full-size .inner-panel .center {
    margin:auto;
}

.full-size .inner-panel .sign {
    color:#c2bfbf;
    font-size:22px;
}





.content-header{
padding-top:10px !important;
padding-bottom:10px !important;
}


</style>
 
 
 
 
 
 
 
 
</head>
<body >


<%

FormatConverter fc=new FormatConverter(); 
SimpleDateFormat rdf=fc.getRegularDateFormat();
SimpleDateFormat qdf=fc.getSqlDateFormat(); 

List<PftsDemandImms>DemandImmsListForFileTracking=(List<PftsDemandImms>)request.getAttribute("DemandImmsListForFileTracking"); 
List<Object[]>  FileTrackingFlowDetails =(List<Object[]>)request.getAttribute("FileTrackingFlowDetails");
Object[] DemandImmsMainDetailsByDemandId =(Object[])request.getAttribute("DemandImmsMainDetailsByDemandId");


String DemandIdForFullFlowDetails=(String)request.getAttribute("DemandIdForFullFlowDetails");


%>
 <%if(request.getAttribute("FileNotInitiateForThisDemand")!=null){ %>
		<div align="center">
			<div class="alert alert-danger" >
				<p>
					File Has Not Been Initiated For <%if(DemandImmsMainDetailsByDemandId!=null){%><%=DemandImmsMainDetailsByDemandId[1]%><%}%> Demand
				</p>
			</div>
		</div>
 <%}%>
 
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card shadow-nohover">

					<div class="card-header">
						<h4>File Tracking User Search</h4>
					</div>
					<div class="card-body">
						  <div class="row" >
						  
								  <div class="col-md-4">
								  <form class="navbar-form" action="file-tracking-user-search-result.htm" method="post">
								    <div class="input-group add-on">
								      <input type="text" class="form-control" placeholder="Type Demand Number" name="DemandNo" id="demandNo" maxlength="12" required>
								      <div class="input-group-btn">
								      	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
								        <button class="btn btn-default btn1 btn-primary" type="submit" name="DemandNoButton"><font color="white"><i class="fa fa-search" aria-hidden="true"></i></font></button>
								      </div>
								    </div>
								  </form>
								  </div>
								  
								  <div class="col-md-4">
								  <form class="navbar-form" action="file-tracking-user-search-result.htm" method="post">
								    <div class="input-group add-on">
								      <input type="text" class="form-control" placeholder="Type Project Code" name="ProjectCode" maxlength="52" required>
								      <div class="input-group-btn">
								      	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
								        <button class="btn btn-default btn1 btn-primary" type="submit" name="ProjectCodeButton"><font color="white"><i class="fa fa-search" aria-hidden="true"></i></font></button>
								      </div>
								    </div>
								  </form>
								  </div>
								  
								  <div class="col-md-4">
								  <form class="navbar-form" action="file-tracking-user-search-result.htm" method="post">
								    <div class="input-group add-on">
								      <input type="text" class="form-control" placeholder="Type Item Name" name="ItemNomenclature" required>
								      <div class="input-group-btn">
								      	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
								        <button class="btn btn-default btn1 btn-primary" type="submit" name="ItemNomenclatureButton"><font color="white"><i class="fa fa-search" aria-hidden="true"></i></font></button>
								      </div>
								    </div>
								  </form>
								  </div>
								  
						  </div>
						  <br>
						  <%if(DemandImmsListForFileTracking!=null){ %>
						  <div class="row" >
						  	 <div class="col-md-12">
								 
		     						 <form id="form-id"  action="file-tracking-user-search-flow.htm" method="post">
					                       <table id="myTable" class="table table-hover  table-striped table-condensed table-bordered" >
					                              <thead> 
					                                <tr>            
					                                   <th>Select</th>
					                                   <th>Demand No</th>
					                                   <th>Demand For</th>
					                                   <th>Estimated Cost</th>
					                                   <th>Project Code</th>
					                                </tr>
					                               </thead>
					                               <tbody>
					                                <%if(DemandImmsListForFileTracking!=null&&DemandImmsListForFileTracking.size()>0)
					                                  for(PftsDemandImms ls:DemandImmsListForFileTracking){{%>
					                                <tr> 
						                             <td><input type="radio" id="DemandId"   name="DemandId" required value="<%=ls.getDemandNo()%>" onclick="FileTrackingFormSubmit()" onchange="FileTrackingFormSubmit()"></td>
					                                 <td><%= ls.getDemandNo()%></td>
					                                 <td style='text-align:left;'><%=ls.getItemFor() %></td>
					                                 <td><%= ls.getEstimatedCost()%></td>
					                                 <td><%=ls.getProjectCode()%></td>
					                              <% }} %>
					                           		</tr>
					                           </tbody> 
					                       </table>
					                       <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					                 </form>      
					 		</div>
						</div>
						<% }%>
						
	<!-- --------------------------------------------------report----------------------------  -->
					<div>
						<div class="row" style="align-self: center;">
						 
						 <%if(request.getAttribute("TrackingPanelVisible")!=null){ %>
							<div class="container-fluid" >
								<div class="row">
								    <div class=col-md-11>
									
									   <nav class="navbar navbar-custom bg-f7 " style="background-color: #f7f0c7;">
							              <div class="col-md-6"><span><b>Demand For :  <%if(DemandImmsMainDetailsByDemandId!=null){%><%=DemandImmsMainDetailsByDemandId[1]%><%}%></b> </span></div>
							              <div class="col-md-6"><span><b>Demand No  :  <%if(DemandImmsMainDetailsByDemandId!=null){%><%=DemandImmsMainDetailsByDemandId[2]%><%}%></b> </span></div>
							              
							              <br>
							              <div class="col-md-6"><span><b>Demand Date :      <%if(DemandImmsMainDetailsByDemandId!=null){%><%=rdf.format(qdf.parse(DemandImmsMainDetailsByDemandId[3].toString()))%><%}%></b></span></div>
							              <div class="col-md-6"><span><b>Estimated  Cost :  <%if(DemandImmsMainDetailsByDemandId!=null){%><%=DemandImmsMainDetailsByDemandId[4]%><%}%></b></span></div>
							             
							           </nav> 
									
									
							        <div class="row" align="center">    
									  <div class="col-md-1"></div>
									  <div class="col-md-1"><b style=color:#337ab7; >FLOW</b></div>
									  <div class="col-md-1"></div>
									  <div class="col-md-3"><b style=color:#337ab7;>EVENT NAME </b></div>
									  <div class="col-md-2"><b style=color:#337ab7;>Forwarded By </b></div>
									  <div class="col-md-2"><b style=color:#337ab7;>Forwarded To</b></div>
									  <div class="col-md-2"><b style=color:#337ab7;>Action Date</b></div>
									</div>
							        
							        <div class="full-size">
							            <div class="bulet" style="">
							               
							                 
							               
							                 <% int  count=0;
							                     String Demand="N";
							                     String Tender="N";
							                     String SupplyOrder="N";
							                     String Receipt="N";
							                     String Accounting="N";
							                     String Bill="N";
							                     String FileTrackingId="";
							                     
							                  if(FileTrackingFlowDetails!=null){
							                  for(Object[] ls:FileTrackingFlowDetails ){
							                	  FileTrackingId=ls[1].toString();
							                	 if("D".equalsIgnoreCase(ls[8].toString())) 
							                	 {
							                		Demand="Y";
							                	 }
							                	 if("T".equalsIgnoreCase(ls[8].toString())) 
							                	 {
							                		 Tender="Y";
							                	 }
							                	 if("S".equalsIgnoreCase(ls[8].toString())) 
							                	 {
							                		 SupplyOrder="Y";
							                	 }
							                	 if("R".equalsIgnoreCase(ls[8].toString())) 
							                	 {
							                		 Receipt="Y";
							                	 }
							                	 if("A".equalsIgnoreCase(ls[8].toString())) 
							                	 {
							                		 Accounting="Y";
							                	 }
							                	 if("B".equalsIgnoreCase(ls[8].toString())) 
							                	 {
							                		 Bill="Y";
							                	 }
							                 }}%>
							                
							                
							                 <%if("Y".equalsIgnoreCase(Demand)){%>
							                 <div class="roundChecked"></div>
							                 <div class="lineChecked"></div>
							                 <%}else{%>
							                 <div class="roundUnChecked"></div>
							                 <div class="lineUnChecked"></div>
							                 <%}%>
							                
							                
							                 <%if("Y".equalsIgnoreCase(Tender)){%>
							                 <div class="roundChecked"></div>
							                 <div class="lineChecked"></div>
							                 <%}else{%>
							                 <div class="roundUnChecked"></div>
							                 <div class="lineUnChecked"></div>
							                 <%}%>
							                
							                
							                
							                <%if("Y".equalsIgnoreCase(SupplyOrder)){%>
							                 <div class="roundChecked"></div>
							                 <div class="lineChecked"></div>
							                 <%}else{%>
							                 <div class="roundUnChecked"></div>
							                 <div class="lineUnChecked"></div>
							                 <%}%>
							                
							                 
							               
							                 <%if("Y".equalsIgnoreCase(Receipt)){%>
							                 <div class="roundChecked"></div>
							                 <div class="lineChecked"></div>
							                 <%}else{%>
							                 <div class="roundUnChecked"></div>
							                 <div class="lineUnChecked"></div>
							                 <%}%>
							                
							                 <%if("Y".equalsIgnoreCase(Accounting)){%>
							                 <div class="roundChecked"></div>
							                 <div class="lineChecked"></div>
							                 <%}else{%>
							                 <div class="roundUnChecked"></div>
							                 <div class="lineUnChecked"></div>
							                 <%}%>
							                 
							                 
							                 <%if("Y".equalsIgnoreCase(Bill)){%>
							                 <div class="roundChecked"></div>
							                 <%}else{%>
							                 <div class="roundUnChecked"></div>
							                  <%}%>
							                 
							                 
							                
							                
							            </div>
							                   
							                      
							                       <div class="inner-panel">
							                        <div class="col-md-1">
							                            
							                        </div>
							                        <div class="col-md-2 center">
							                           <a href="file-tracking-full-flow-details.htm?FileTrackingId=<%=FileTrackingId%>&DemandIdForFullFlowDetails=<%=DemandIdForFullFlowDetails%>" target="blank">
							                           <span class="desc-bold" style="background-color: #B5DEFF;" >Demand</span></a> 
							                           
							                        </div>
							                      
							                       <%if(FileTrackingFlowDetails!=null){
							                         for(Object[] ls:FileTrackingFlowDetails ){
							                         if("D".equalsIgnoreCase(ls[8].toString())){
							                         %>
							                         
							                         <div class="col-md-3 center">
							                            <span class="desc-line"><%=ls[6]%></span>
							                        </div>
							                         <div class="col-md-2 center"><%=ls[2]%> </div>
							                         <div class="col-md-2 center"><%=ls[3]%></div>
							                           <div class="col-md-2 center"><%=rdf.format(qdf.parse(ls[4].toString()))%>  </div>
							                      <%break;}}}%>
							                         <br>
							                    </div>
							                 
							                     <br>
							                     <div class="inner-panel">
							                        <div class="col-md-1">
							                            
							                        </div>
							                        <div class="col-md-2 center">
							                            <a href="file-tracking-full-flow-details.htm?FileTrackingId=<%=FileTrackingId%>&DemandIdForFullFlowDetails=<%=DemandIdForFullFlowDetails%>" target="blank">
							                            <span class="desc-bold" style="background-color: #FFCCD2;"  >Tender</span></a>
							                         </div>
							                      
							                         <%if(FileTrackingFlowDetails!=null){
							                         for(Object[] ls:FileTrackingFlowDetails ){
							                         if("T".equalsIgnoreCase(ls[8].toString())){
							                         %>
							                        
							                          <div class="col-md-3 center">
							                             <span class="desc-line"><%=ls[6]%></span>
							                           </div>
							                          <div class="col-md-2 center"><%=ls[2]%> </div>
							                          <div class="col-md-2 center"><%=ls[3]%></div>
							                          <div class="col-md-2 center"><%=rdf.format(qdf.parse(ls[4].toString()))%>  </div>
							                     
							                      
							                      <%break;}}}%>
							                         <%if("N".equalsIgnoreCase(Tender)){%>
							                          <div class="col-md-9 center"></div>
							                         <%}%>
							                        <br>
							                    </div>
							                    
							                    
							                     <br>
							                     <div class="inner-panel">
							                        <div class="col-md-1">
							                            
							                        </div>
							                        <div class="col-md-2 center">
							                             <a href="file-tracking-full-flow-details.htm?FileTrackingId=<%=FileTrackingId%>&DemandIdForFullFlowDetails=<%=DemandIdForFullFlowDetails%>" target="blank">
							                             <span class="desc-bold" style="background-color: #CDBBA7;"  >Supply Order</span></a>
							                        </div>
							                      
							                         <%if(FileTrackingFlowDetails!=null){
							                         for(Object[] ls:FileTrackingFlowDetails ){
							                         if("S".equalsIgnoreCase(ls[8].toString())){
							                         %>
							                        
							                          <div class="col-md-3 center">
							                             <span class="desc-line"><%=ls[6]%></span>
							                           </div>
							                          <div class="col-md-2 center"><%=ls[2]%> </div>
							                          <div class="col-md-2 center"><%=ls[3]%></div>
							                          <div class="col-md-2 center"><%=rdf.format(qdf.parse(ls[4].toString()))%>  </div>
							                     
							                      
							                      <%break;}}}%>
							                        <%if("N".equalsIgnoreCase(SupplyOrder)){%>
							                          <div class="col-md-9 center"></div>
							                         <%}%> 
							                        <br>
							                    </div>
							                    
							                    <br>
							                     <div class="inner-panel">
							                        <div class="col-md-1">
							                            
							                        </div>
							                        <div class="col-md-2 center">
							                          <a href="file-tracking-full-flow-details.htm?FileTrackingId=<%=FileTrackingId%>&DemandIdForFullFlowDetails=<%=DemandIdForFullFlowDetails%>" target="blank">
							                          <span class="desc-bold" style="background-color: #F09AE9;" >Receipt</span></a>
							                         </div>
							                      
							                       <%if(FileTrackingFlowDetails!=null){
							                         for(Object[] ls:FileTrackingFlowDetails ){
							                         if("R".equalsIgnoreCase(ls[8].toString())){
							                         %>
							                        
							                          <div class="col-md-3 center">
							                             <span class="desc-line"><%=ls[6]%></span>
							                           </div>
							                          <div class="col-md-2 center"><%=ls[2]%> </div>
							                          <div class="col-md-2 center"><%=ls[3]%></div>
							                          <div class="col-md-2 center"><%=rdf.format(qdf.parse(ls[4].toString()))%>  </div>
							                     
							                      
							                      <%break;}}}%>
							                         <%if("N".equalsIgnoreCase(Receipt)){%>
							                          <div class="col-md-9 center"></div>
							                         <%}%>
							                        <br>
							                    </div>
							                       
							                      
							                   
							                    <br>
							                     <div class="inner-panel">
							                        <div class="col-md-1">
							                            
							                        </div>
							                        <div class="col-md-2 center">
							                           <a href="file-tracking-full-flow-details.htm?FileTrackingId=<%=FileTrackingId%>&DemandIdForFullFlowDetails=<%=DemandIdForFullFlowDetails%>" target="blank">
							                           <span class="desc-bold" style="background-color: #EDE682;" >Accounting</span></a>
							                        </div>
							                      
							                         <%if(FileTrackingFlowDetails!=null){
							                         for(Object[] ls:FileTrackingFlowDetails ){
							                         if("A".equalsIgnoreCase(ls[8].toString())){
							                         %>
							                        
							                          <div class="col-md-3 center">
							                             <span class="desc-line"><%=ls[6]%></span>
							                           </div>
							                          <div class="col-md-2 center"><%=ls[2]%> </div>
							                          <div class="col-md-2 center"><%=ls[3]%></div>
							                          <div class="col-md-2 center"><%=rdf.format(qdf.parse(ls[4].toString()))%>  </div>
							                     
							                      
							                      <%break;}}}%>
							                         <%if("N".equalsIgnoreCase(Accounting)){%>
							                          <div class="col-md-9 center"></div>
							                         <%}%>
							                        <br>
							                    </div>
							                    
							                    
							                     <br>
							                     <div class="inner-panel">
							                        <div class="col-md-1">
							                            
							                        </div>
							                        <div class="col-md-2 center">
							                            <a href="file-tracking-full-flow-details.htm?FileTrackingId=<%=FileTrackingId%>&DemandIdForFullFlowDetails=<%=DemandIdForFullFlowDetails%>" target="blank">
							                            <span class="desc-bold" style="background-color: #A2B29F;" >Bill</span></a>
							                         </div>
							                      
							                          
							                         
							                         <%if(FileTrackingFlowDetails!=null){
							                         for(Object[] ls:FileTrackingFlowDetails ){
							                         if("B".equalsIgnoreCase(ls[8].toString())){
							                         %>
							                        
							                          <div class="col-md-3 center">
							                             <span class="desc-line"><%=ls[6]%></span>
							                           </div>
							                          <div class="col-md-2 center"><%=ls[2]%> </div>
							                          <div class="col-md-2 center"><%=ls[3]%></div>
							                          <div class="col-md-2 center"><%=rdf.format(qdf.parse(ls[4].toString()))%>  </div>
							                     
							                      
							                        <%break;}}}%>
							                         <%if("N".equalsIgnoreCase(Bill)){%>
							                          <div class="col-md-9 center"></div>
							                         <%}%>
							                        <br>
							                    </div>
							                        
							                      
							                       
							                        
							                    </div>
							                    
							                   
							                
							                </div>
							
							        </div>
								</div>
							<%}%>
						 
						 
						 
						 
						 </div>
					</div>
						
						
						
					</div>  <!-- ---card body---  -->
				</div>
			</div>
		</div>
	</div>

<script type="text/javascript">

function FileTrackingFormSubmit()
{
	var form = document.getElementById("form-id");
	form.submit();
	}


$(document).ready(function(){
	  $("#myTable").DataTable({
	 "lengthMenu": [  5,10,25, 50, 75, 100 ],
	 "pagingType": "simple"
	
});
});


</script>
</body>
</html>