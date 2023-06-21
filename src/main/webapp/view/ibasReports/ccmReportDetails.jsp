<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.io.ByteArrayOutputStream,java.io.ObjectOutputStream"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="java.math.RoundingMode"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>
<title>CCM Details Report</title>
<style type="text/css">
label{
font-weight: bold;
  font-size: 13px;
}
body{
background-color: #f2edfa;
overflow-x:hidden !important; 
}
h6{
	text-decoration: none !important;
}
.table button{
	
	background-color: white !important;
	border: 3px solid #17a2b8;
	padding: .275rem .5rem !important;
}

.table button:hover {
	color: black !important;
	
}
#table tbody tr td {

	    padding: 4px 3px !important;

}



.fixed-table-body thead th .th-inner {
    background-color: #055C9D;
    color:white;
}

tr.custom-Heading-row{
  background-color: #F0F8FF;
  text-align: center;
}

tr.custom-Total-row{
  background-color: #FFF5EE;
}

tr.custom-GrandTotal-row{
  background-color: #DCDCDC;
  font-weight:block;
}

</style>
</head>
<body>
  <%
  FormatConverter fc=new FormatConverter(); 
  SimpleDateFormat sdf=fc.getRegularDateFormat();
  SimpleDateFormat sdf1=fc.getSqlDateFormat();
  
  
  DecimalFormat df = new DecimalFormat( "#####################.##");
  DecimalFormat dfPercF=new DecimalFormat("###.##");
  String Date=(String)request.getAttribute("dateForCCMDetails");
  String DigitType =(String)request.getAttribute("digitTypeSel");
  Integer DigitValue = (Integer)request.getAttribute("digitValueSel");
  String QuarterType=(String)request.getAttribute("quarterType");
  String FinYear=(String)request.getAttribute("financialYear"); 
  String FromYear=(String)request.getAttribute("fromYear");
  String ToYear=(String)request.getAttribute("toYear");
  String ProjectId=(String)request.getAttribute("projectId");
  String BudgetHeadId=(String)request.getAttribute("budgetHeadId");
  String ProjectCode=(String)request.getAttribute("projectCode");
  String BudgetHead=(String)request.getAttribute("budgetHead");
  String date=(String)request.getAttribute("dateForCCMDetails");


  List <Object[]> CCMExpenditureList=(List)request.getAttribute("ccmExpenditureList");
  List CCMReportCashOutGoList=(List)request.getAttribute("ccmReportCashOutGoList");
  Map<String, List<Object[]>> CCMDetailedMap=(Map<String, List<Object[]>>)request.getAttribute("ccmDetailedMap");
  %>
  
  
  
   <div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card shadow-nohover">
				   
      <%if(ProjectCode!=null){ %>
				<div class="card-header ">  
					
						<div class="row">
						 <div class="float-container">
						  <div id="label1" style="width: 100%;float: left;text-align: left"> 
						 <b><font size="4" >Cash Out Go Details Of Project :<%=ProjectCode %>, Budget Head : <%=BudgetHead %>, Financial Year : <%=FinYear %>(In <%=DigitType %>)</font></b>  
						  </div>
						   <div class="label2" style="float: left;text-align: right">
						   
						   
						   </div>
						 </div>
						 </div>
				</div>
				
				
					<div class="data-table-area mg-b-15">
							<div class="container-fluid">
								<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
									<div class="sparkline13-list">
										<div class="sparkline13-graph">
											<div class="datatable-dashv1-list custom-datatable-overright">
												<div id="toolbar">
												</div>
					  <%if (CCMReportCashOutGoList!=null&&CCMReportCashOutGoList.size() != 0) {%>
					                               <table id="table" data-toggle="table" data-pagination="true"
													data-search="true" data-show-columns="true"
													data-show-pagination-switch="true" data-show-refresh="true"
													data-key-events="true" data-show-toggle="true"
													data-resizable="true" data-cookie="true"
													data-cookie-id-table="saveId" data-show-export="true"
													data-click-to-select="true" data-toolbar="#toolbar"  >
		
		       <thead >
		       <tr>
		       <th style="width: 5px;">SN</th>
		       <th>File No</th>
		       <th class="text-nowrap">SO No</th>
			   <th class="text-nowrap">Item</th>
			   <th class="text-nowrap">Pay Amount</th>
			   <th class="text-nowrap">Pay Date</th>
		       </tr>
		       </thead>
		       <tbody>	
		       <%
		       int count=0;
		       BigDecimal totalpayAmount = new BigDecimal("0.00");
		       BigDecimal grandPayAmount = new BigDecimal("0.00");
 /***1st loop starts************/
	       for (String ccmKey : CCMDetailedMap.keySet()) {
					String qType=null;
					if("Q1".equalsIgnoreCase(ccmKey)){
						qType="I Quarter";
					}else if("Q2".equalsIgnoreCase(ccmKey)){
						qType="II Quarter";
					}else if("Q3".equalsIgnoreCase(ccmKey)){
						qType="III Quarter";
					}else if("Q4".equalsIgnoreCase(ccmKey)){
						qType="IV Quarter";
					}else if("Q5".equalsIgnoreCase(ccmKey)){
						qType="Future";
					}
		       %>
	<!-- ----------------------------SubHead----------------------------------------------- -->	       
		       <tr class="custom-Heading-row">  
						<td align="center" colspan="7"><font size="3"><b>Cash Out Go Of <%=qType %></b></font></td>
				</tr>
				<%
            /***2nd loop starts************/
				for (Object[] obj : CCMDetailedMap.get(ccmKey)) { 
					count++;
					totalpayAmount =  totalpayAmount.add(new BigDecimal(obj[5].toString()));
					grandPayAmount =  grandPayAmount.add(new BigDecimal(obj[5].toString()));

					%>	
	<!-- ----------------------------Values----------------------------------------------- -->	
	              <tr>  
						<td style="text-align:center"><%=count %></td>
						<td style="text-align:left" ><%=obj[2]%></td>
						<td style="text-align:left"><%= obj[3]%></td>
						<td style="text-align:left"><%= obj[4]%></td>
						<td style="text-align:right"><%= df.format(new BigDecimal(obj[5].toString()))%></td><!--Pay Amount -->
						<td style="text-align:center"><%if(obj[6]!=null) {%><%=sdf.format(obj[6])%><%} %></td><!--Pay Date -->
				</tr>		       				
					
		  <% /***2nd loop ends************/} %>
		  <!-- ----------------------------Total----------------------------------------------- -->	
		  	   <tr class="custom-Total-row">  
						<td colspan="4" ><font size="3"><b>Total Amount OF <%=qType %>:</b></font></td>
						<td style="text-align:right"><b><%= df.format(totalpayAmount)%></b></td>
						<td ></td>
					</tr>
		  
		       
          <% 
            totalpayAmount = new BigDecimal("0.00");
           /***1st loop ends************/} %>
            <!-- ----------------------------Grand Total----------------------------------------------- -->	
            <tr class="custom-GrandTotal-row">  
						<td colspan="4" ><font size="3"><b>Grand Total Amount :</b></font></td>
						<td align="right"><%= df.format(grandPayAmount)%></td>
						<td ></td>
					</tr>
		       </tbody>
		     </table>
		
      </div>
      <%} %>     
      
      </div>
      
        <%}else{ %>
        <%if (CCMExpenditureList!=null&&CCMExpenditureList.size() != 0) {
        	int count =0;
        	BigDecimal totalExpenditure = new BigDecimal("0.00");
        	for (Object[] obj : CCMExpenditureList) { 
        		count++;
        		totalExpenditure    =  totalExpenditure.add(new BigDecimal(obj[6].toString()));
        	%>
        <div class="card-body">
       <div class="table-responsive" >
       
      <div class="row text-center"><b><font face="Maiandra " size="5" color="#800000">Expenditure Details Of Project : <%=obj[0]%>(In <%=DigitType %>)</font></b></div>
			  <table class="table table-bordered table-hover table-striped table-condensed" id="CCMReportExp" > 
		       <thead >
		       <tr>
		       <th style="width: 5px;">SN</th>
               <th>File No</th>
			   <th>SO No</th>
			   <th>Vendor</th>
			   <th class="text-nowrap">Item</th>
			   <th class="text-nowrap">Amount</th>
			   <th class="text-nowrap">UB Date</th>	
		       </tr>
		       </thead>
		       <tbody>		
		       <tr>
		        <td style="text-align:center"><%=count %></td>
		        <td ><%=obj[2]%></td>
				<td ><%= obj[3]%></td>
				<td ><%= obj[4]%></td>
				<td ><%= obj[5]%></td>
				<td style="text-align:right"><%= df.format(new BigDecimal(obj[6].toString()))%></td><!--Pay Amount -->
				<td style="text-align:center"><%if(obj[7]!=null) {%><%=sdf.format(obj[7])%><%} %></td><!--Pay Date -->
		       </tr>
		       </tbody>
		       <tfoot>
						<tr> 
							<td colspan="5"></td>
							<td align="right"><%= df.format(totalExpenditure)%></td>
							<td></td>
						</tr>
					</tfoot>	
		       </table>
		 </div>
		</div> 
	  <%} /******End Of Exp******/%> 	
      <%} %>          
      <%} %>  
						
				</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<br>
						<div class="card-footer" align="right">&nbsp;</div>
					</div>
				</div>
		

	
</body>
</html>