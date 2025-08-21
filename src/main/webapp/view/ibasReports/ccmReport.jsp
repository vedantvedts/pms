<%@page import="org.apache.commons.text.StringEscapeUtils"%>
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
<title>CCM Report</title>
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

.clickable-row {
    cursor: pointer;
  }
</style>
</head>
<body>
  <%
  DecimalFormat df = new DecimalFormat( "#####################.##");
  DecimalFormat dfPercF=new DecimalFormat("###.##");
  List<Object[]> CCMReportList=(List)request.getAttribute("ccmReportList");
  Map<String,List<Object[]>> CCMMap=(Map<String,List<Object[]>>)request.getAttribute("ccmMap");

  String Date=(String)request.getAttribute("dateForCCM");
  String DigitType =(String)request.getAttribute("digitTypeSel");
  Integer DigitValue = (Integer)request.getAttribute("digitValueSel");
  String QuarterType=(String)request.getAttribute("quarterType");
  String FinYear=(String)request.getAttribute("financialYear"); 
  String FromYear=(String)request.getAttribute("fromYear");
  String ToYear=(String)request.getAttribute("toYear");
  String StartDate=(String)request.getAttribute("startDate");
  String EndDate=(String)request.getAttribute("endDate");

  String cogQ1=(String)request.getAttribute("cogQ1");
  String cogQ2=(String)request.getAttribute("cogQ2");
  String cogQ3=(String)request.getAttribute("cogQ3");
  String cogQ4=(String)request.getAttribute("cogQ4");

  int count=0;	
  BigDecimal expenditurePer = new BigDecimal("0.00");

  BigDecimal totalAllot = new BigDecimal("0.00");
  BigDecimal totalExp = new BigDecimal("0.00");
  BigDecimal totalBalance = new BigDecimal("0.00");
  BigDecimal totalExpPer = new BigDecimal("0.00");
  BigDecimal totalCogQ1 = new BigDecimal("0.00");
  BigDecimal totalCogQ2 = new BigDecimal("0.00");
  BigDecimal totalCogQ3 = new BigDecimal("0.00");
  BigDecimal totalCogQ4 = new BigDecimal("0.00");
  BigDecimal totalAddSurr = new BigDecimal("0.00");

  BigDecimal grandtotalAllot = new BigDecimal("0.00");
  BigDecimal grandtotalExp = new BigDecimal("0.00");
  BigDecimal grandtotalBalance = new BigDecimal("0.00");
  BigDecimal grandtotalExpPer = new BigDecimal("0.00");
  BigDecimal grandtotalCogQ1 = new BigDecimal("0.00");
  BigDecimal grandtotalCogQ2 = new BigDecimal("0.00");
  BigDecimal grandtotalCogQ3 = new BigDecimal("0.00");
  BigDecimal grandtotalCogQ4 = new BigDecimal("0.00");
  BigDecimal grandTotalAddSurr = new BigDecimal("0.00");



  %>
     
     <% 
	    String ses = (String) request.getParameter("resultSuccess");
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
      
      <div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card shadow-nohover">
				
				
				
					<div class="card-header ">  
					
						<div class="row">
						 <h4 class="col-md-2">CCM Report</h4>  <br>
						 
						 <div class="col-md-10" style="float: right; margin-top: -8px;">
						   <div class="form-inline" style="justify-content: end;margin-bottom:3rem;">
						   <form action="CCMReport.htm" method="POST" id="ccmReport" autocomplete="off"> 
						   <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
						   <table >
					   					<tr>
					   						<td >
					   							<label class="control-label" style="font-size: 14px; margin-bottom: .0rem;">Date : </label>
					   						</td>
					   						<td >
					   						  <input onchange="this.form.submit()"  class="form-control date" type="text"  name="DateCCM" id="date"  
                                                 readonly="readonly"style="width: 11rem; background-color:white; text-align: left;"   <%if(Date!=null){ %>value="<%=StringEscapeUtils.escapeHtml4(Date)%>"<%} %>> 
					   						</td>
					   						
					   						<td >
					   							<label class="control-label" style="font-size: 14px; margin-bottom: .0rem;">Select: </label>
					   						</td>
					   						<td >
					   						 <select class="form-control selectdee " id="selDigitType" name="DigitSel"  required="required"  onchange="this.form.submit()"  data-live-search="true"  >
                                               <option value="Rupees" <%if(DigitType!=null && DigitType.equalsIgnoreCase("Rupees")){ %>selected="selected"<%} %>   >Rupees</option>
						                       <option value="Lakhs" <%if(DigitType!=null && DigitType.equalsIgnoreCase("Lakhs")){ %>selected="selected"<%} %> >Lakhs</option>
						                       <option value="Crores" <%if(DigitType!=null && DigitType.equalsIgnoreCase("Crores")){ %>selected="selected"<%} %>>Crores</option>     
											</select>					   		
					   				       </td>
					   					</tr>
					   		</table>			
						   </form>
						   </div>
						 </div>
						 
						</div>
					
					</div>
					
					
					 <div style="margin-top: 0rem;margin-bottom:0.8rem;margin-left:-1.2rem;margin-right:-1.1rem">
			    <hr style="border: 1px solid #0e6fb6; width: 100%"> </div>
      
            <div class="float-container">
            <div id="label1" style="width: 50%;float: left;text-align: left"> <b><font size="4" >CCM Report AS On Date : <%=Date!=null?StringEscapeUtils.escapeHtml4(Date): " - " %>&nbsp;(In <%=DigitType!=null?StringEscapeUtils.escapeHtml4(DigitType): " - " %>)</font></b></div>
            <div class="label2" style="width: 50%;float: left;text-align: right">
            
					</div>
					
					
						<div class="data-table-area mg-b-15">
							<div class="container-fluid">
								<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
									<div class="sparkline13-list">
										<div class="sparkline13-graph">
											<div class="datatable-dashv1-list custom-datatable-overright">
												<div id="toolbar">
												</div>
					
					                               <table id="table" data-toggle="table" data-pagination="true"
													data-search="true" data-show-columns="true"
													data-show-pagination-switch="true" data-show-refresh="true"
													data-key-events="true" data-show-toggle="true"
													data-resizable="true" data-cookie="true"
													data-cookie-id-table="saveId" data-show-export="true"
													data-click-to-select="true" data-toolbar="#toolbar">
					<thead>
					 <tr>
					 <th>Project Code</th>
                     <th class="text-nowrap">Allotment</th>
			         <th class="text-nowrap">Expenditure</th>
			        <th class="text-nowrap">Balance</th>
			        <th class="text-nowrap">Exp %</th>
			              <!-- Apr,May, Jun is Q1 -->
							<%if("Q1".equalsIgnoreCase(QuarterType)){ %>
						        <th class="text-nowrap">COG Q1</th>
						        <th class="text-nowrap">COG Q2</th>
							    <th class="text-nowrap">COG Q3</th>
							    <th class="text-nowrap">COG Q4</th>
						    <%} %>
							
							<!-- July,Aug, Sept is Q2 -->
							<%if("Q2".equalsIgnoreCase(QuarterType)){ %>
							    <th class="text-nowrap">COG Q2</th>
							    <th class="text-nowrap">COG Q3</th>
							    <th class="text-nowrap">COG Q4</th>
							<%} %>
							
								<!-- Oct,Nov, Dec is Q3 -->
							<%if("Q3".equalsIgnoreCase(QuarterType)){ %>
							    <th class="text-nowrap">COG Q3</th>
							    <th class="text-nowrap">COG Q4</th>
							<%} %>
							
								<!-- Jan,Feb, Mar is Q4-->
							<%if("Q4".equalsIgnoreCase(QuarterType)){ %>
							   <th class="text-nowrap">COG Q4</th>
							<%} %>
							<th class="text-nowrap">Addl(-)/Surr(+)</th>
				   </tr>
		          </thead>
		          
		            <tbody id="ccmtbody">	
						<%if (CCMReportList!=null&&CCMReportList.size() != 0) {	%>	
					
					<!----------------------------------- SUBHEAD ----------------------------------------------------->
<!--1st loop O--><%for (String ccm : CCMMap.keySet()) { %>
					<tr class="custom-Heading-row">
					   <%if("Q1".equalsIgnoreCase(QuarterType)){ %>
	                    <td align="center" colspan="10"><font size="3"><b>Budget Head : <%=ccm!=null?StringEscapeUtils.escapeHtml4(ccm): " - " %></b></font></td>
	                   <%} %>
					  <%if("Q2".equalsIgnoreCase(QuarterType)){ %>
						 <td align="center" colspan="9"><font size="3"><b>Budget Head : <%=ccm!=null?StringEscapeUtils.escapeHtml4(ccm): " - " %></b></font></td>
	                  <%} %>
	                  <%if("Q3".equalsIgnoreCase(QuarterType)){ %>
						  <td align="center" colspan="8"><font size="3"><b>Budget Head : <%=ccm!=null?StringEscapeUtils.escapeHtml4(ccm): " - " %></b></font></td>
	                  <%} %>
	                  <%if("Q4".equalsIgnoreCase(QuarterType)){ %>
						  <td align="center" colspan="7"><font size="3"><b>Budget Head : <%=ccm!=null?StringEscapeUtils.escapeHtml4(ccm): " - " %></b></font></td>
	                  <%} %>
					</tr>
					
					
					<!--------------------------------------------- DETAILS -------------------------------------------------------->
<!--2nd loop --><%for (Object[] obj : CCMMap.get(ccm)) {%>
                      <% 
                     
                      
                      
                        totalAllot    =  totalAllot.add(new BigDecimal(obj[4].toString()));
                        totalExp      =  totalExp.add(new BigDecimal(obj[5].toString()));
                        totalBalance  =  totalBalance.add(new BigDecimal(obj[6].toString()));
                     
                        if ( (totalExp.compareTo(BigDecimal.ZERO) != 0) || (totalAllot.compareTo(BigDecimal.ZERO) != 0)  ) { 
                        	  totalExpPer = (totalExp.divide(totalAllot, 4, RoundingMode.HALF_UP)).multiply(new BigDecimal("100.00"));
    				    }else{
    				    	totalExpPer = new BigDecimal("0.00");
    				    }
                        totalCogQ1 =  totalCogQ1.add(new BigDecimal(obj[7].toString()));
                        totalCogQ2 =  totalCogQ2.add(new BigDecimal(obj[8].toString()));
                        totalCogQ3 =  totalCogQ3.add(new BigDecimal(obj[9].toString()));
                        totalCogQ4 =  totalCogQ4.add(new BigDecimal(obj[10].toString()));
                        totalAddSurr = totalAddSurr.add(new BigDecimal(obj[11].toString())); 
                       
                       
                        
                        
                        grandtotalAllot = grandtotalAllot.add(new BigDecimal(obj[4].toString()));
                        grandtotalExp   = grandtotalExp.add(new BigDecimal(obj[5].toString()));
                        grandtotalBalance = grandtotalBalance.add(new BigDecimal(obj[6].toString()));
                        if ( (grandtotalAllot.compareTo(BigDecimal.ZERO) != 0)  || (grandtotalExp.compareTo(BigDecimal.ZERO) != 0)) { 
                        	grandtotalExpPer = (grandtotalExp.divide(grandtotalAllot, 4, RoundingMode.HALF_UP)).multiply(new BigDecimal("100.00"));
    				    }else{
    				    	grandtotalExpPer = new BigDecimal("0.00");
    				    }
                        grandtotalCogQ1 =  grandtotalBalance.add(new BigDecimal(obj[7].toString()));
                        grandtotalCogQ2 =  grandtotalCogQ2.add(new BigDecimal(obj[8].toString()));
                        grandtotalCogQ3 =  grandtotalCogQ3.add(new BigDecimal(obj[9].toString()));
                        grandtotalCogQ4 =  grandtotalCogQ4.add(new BigDecimal(obj[10].toString()));
                        grandTotalAddSurr = grandTotalAddSurr.add(new BigDecimal(obj[11].toString()));
                        
                        
                        count++;
                  %> 
<!-- ---------------------------------CLICKABLE ROW START---------------------------------------------------------- -->
                  <tr class='clickable-row' title="Click Here For Details"
                  data-href="CCMReportDetailsData.htm?fromYear=<%=FromYear%>&toYear=<%=ToYear%>&projectid=<%=obj[0]%>&Budgetheadid=<%=obj[2]%>&date=<%=Date %>&digitvalue=<%=DigitValue %>&digittype=<%=DigitType %>&quartertype=<%=QuarterType%>"
                    >
                  	<td ><%=obj[1]!=null?StringEscapeUtils.escapeHtml4(obj[1].toString()): " - "%></td><!-- Project Code -->
                  	<td align="right"><%= obj[1]!=null? df.format(new BigDecimal(StringEscapeUtils.escapeHtml4(obj[4].toString()))):" - " %></td><!--Allotment -->
                  	<td align="right"><%= obj[1]!=null? df.format(new BigDecimal(StringEscapeUtils.escapeHtml4(obj[5].toString()))):" - "%></td><!--Expenditure -->
                  	<td align="right"><%= obj[1]!=null? df.format(new BigDecimal(StringEscapeUtils.escapeHtml4(obj[6].toString()))):" - "%></td><!-- Balance -->
                  	 <%
                  	    if (!(obj[4].toString()).equalsIgnoreCase("0.00") && !obj[5].toString().equalsIgnoreCase("0.00")) {
                  	        expenditurePer = (new BigDecimal(obj[5].toString()).divide(new BigDecimal(obj[4].toString()), 2, RoundingMode.HALF_UP)).multiply(new BigDecimal("100.00"));
                  	    }else{
                  	     // Handle divide by zero error
                  	    expenditurePer = new BigDecimal("0.00");
                  	   System.out.println("Error calculating expenditure percentage: " );
                  	}%>
                  	<td align="right"><%=dfPercF.format(expenditurePer) %> %</td><!-- exp% -->
														<!-- Apr,May, Jun is Q1 -->
					<%if("Q1".equalsIgnoreCase(QuarterType)){ %>
						<%if(Double.parseDouble(cogQ1)>=0){ %>
					<td align="right"><%=obj[7]!=null? df.format(Double.parseDouble(StringEscapeUtils.escapeHtml4(obj[7].toString()))):" - "%></td>
						<%} %>
						<%if(Double.parseDouble(cogQ2)>=0){ %>
					<td align="right"><%=obj[8]!=null? df.format(Double.parseDouble(StringEscapeUtils.escapeHtml4(obj[8].toString()))):" - "%></td>
						<%} %>
						<%if(Double.parseDouble(cogQ3)>=0){ %>
					<td align="right"><%=obj[9]!=null? df.format(Double.parseDouble(StringEscapeUtils.escapeHtml4(obj[9].toString()))):" - "%></td>
						<%} %>
					   <%if(Double.parseDouble(cogQ4)>=0){ %>
					<td align="right"><%=obj[10]!=null? df.format(Double.parseDouble(StringEscapeUtils.escapeHtml4(obj[10].toString()))):" - "%></td>
					   <%} %>
					<%} %>
							
					  		<!-- July,Aug, Sept is Q2 -->
					<%if("Q2".equalsIgnoreCase(QuarterType)){ %>
						<%if(Double.parseDouble(cogQ2)>=0){ %>
					<td align="right"><%= obj[8]!=null? df.format(Double.parseDouble(StringEscapeUtils.escapeHtml4(obj[8].toString()))):" - "%></td>
						<%} %>
						<%if(Double.parseDouble(cogQ3)>=0){ %>
					<td align="right"><%=obj[9]!=null? df.format(Double.parseDouble(StringEscapeUtils.escapeHtml4(obj[9].toString()))):" - "%></td>
						<%} %>
					    <%if(Double.parseDouble(cogQ4)>=0){ %>
					<td align="right"><%= obj[10]!=null? df.format(Double.parseDouble(StringEscapeUtils.escapeHtml4(obj[10].toString()))):" - "%></td>
						<%} %>
					<%} %>
	                        <!-- Oct,Nov, Dec is Q3 -->
					<%if("Q3".equalsIgnoreCase(QuarterType)){ %>
						<%if(Double.parseDouble(cogQ3)>=0){ %>
					<td align="right"><%= obj[9]!=null? df.format(Double.parseDouble(StringEscapeUtils.escapeHtml4(obj[9].toString()))):" - "%></td>
						<%} %>
					   <%if(Double.parseDouble(cogQ4)>=0){ %>
					<td align="right"><%= obj[10]!=null? df.format(Double.parseDouble(StringEscapeUtils.escapeHtml4(obj[10].toString()))):" - "%></td>
						<%} %>
					<%} %>
							<!-- Jan,Feb, Mar is Q4-->
					<%if("Q4".equalsIgnoreCase(QuarterType)){ %>
						<%if(Double.parseDouble(cogQ4)>=0){ %>
					<td align="right"><%= obj[10]!=null? df.format(Double.parseDouble(StringEscapeUtils.escapeHtml4(obj[10].toString()))):" - "%></td>
						<%} %>
					<%} %>
							
					 <td align="right"><b><font size="3"><%= obj[11]!=null? df.format(Double.parseDouble(StringEscapeUtils.escapeHtml4(obj[11].toString()))):" - "%></font></b></td>
					
					</tr>	
		
                 
     <!--2nd loop C--><%} %>
     
     
<!-- ---------------------------------CLICKABLE ROW END---------------------------------------------------------- -->
 <!-- --------------------------------- TOTAL AMOUNT ROW STARTS---------------------------------------------------------- --> 
             <tr class="custom-Total-row" >
             <td align="center" colspan="1"><font size="3"><b>Total Amount (<%=ccm!=null?StringEscapeUtils.escapeHtml4(ccm): " - " %>) :</b></font></td>
             <td align="right"><%=totalAllot!=null? df.format(totalAllot):" - "%></td>
			 <td align="right"><%=totalExp!=null? df.format(totalExp):" - "%></td>
			 <td align="right"><%=totalBalance!=null? df.format(totalBalance):" - "%></td>
			 <td align="right"><%=totalExpPer!=null? dfPercF.format(totalExpPer):" - " %> %</td>
			     <!-- Apr,May, Jun is Q1 -->
			     
		     <%if("Q1".equalsIgnoreCase(QuarterType)){ %>   
		        <%if(Double.parseDouble(cogQ1)>=0){ %>
			<td align="right"><%=totalCogQ1!=null? df.format(totalCogQ1):" - "%></td>
				<%} %>
			    <%if(Double.parseDouble(cogQ2)>=0){ %>
			<td align="right"><%=totalCogQ2!=null? df.format(totalCogQ2):" - "%></td>
				<%} %>
				<%if(Double.parseDouble(cogQ3)>=0){ %>
			<td align="right"><%=totalCogQ3!=null? df.format(totalCogQ3):" - "%></td>
				<%} %>
				<%if(Double.parseDouble(cogQ4)>=0){ %>
			<td align="right"><%=totalCogQ4!=null? df.format(totalCogQ4):" - "%></td>
				<%} %>
		     <%} %>  
		     
		          <!-- July,Aug, Sept is Q2 -->
		    <%if("Q2".equalsIgnoreCase(QuarterType)){ %> 
		       <%if(Double.parseDouble(cogQ2)>=0){ %> 
		    <td align="right"><%= totalCogQ2!=null?df.format(totalCogQ2):" - "%></td>
				<%} %>
				<%if(Double.parseDouble(cogQ3)>=0){ %>
			<td align="right"><%=totalCogQ3!=null? df.format(totalCogQ3):" - "%></td>
				<%} %>
				<%if(Double.parseDouble(cogQ4)>=0){ %>
			<td align="right"><%=totalCogQ4!=null? df.format(totalCogQ4):" - "%></td>
				<%} %>  
		    <%} %>  
		       <!-- Oct,Nov, Dec is Q3 -->
		   <%if("Q3".equalsIgnoreCase(QuarterType)){ %> 
		       <%if(Double.parseDouble(cogQ3)>=0){ %>
			<td align="right"><%=totalCogQ3!=null? df.format(totalCogQ3):" - "%></td>
				<%} %>
				<%if(Double.parseDouble(cogQ4)>=0){ %>
			<td align="right"><%=totalCogQ4!=null? df.format(totalCogQ4):" - "%></td>
				<%} %> 
		    <%} %>  
		           <!-- Jan,Feb, Mar is Q4-->
			<%if("Q4".equalsIgnoreCase(QuarterType)){ %>
				<%if(Double.parseDouble(cogQ4)>=0){ %>
			<td align="right"><%= totalCogQ4!=null?df.format(totalCogQ4):" - "%></td>
				<%} %>
			<%} %>
 
            <td align="right"><b><font size="3"><%=totalAddSurr!=null? df.format(totalAddSurr):" - "%></font></b></td>
            
            </tr>
                <% 
                totalAllot = new BigDecimal("0.00");
                totalExp = new BigDecimal("0.00");
                totalBalance = new BigDecimal("0.00");
                totalExpPer = new BigDecimal("0.00");
                totalCogQ1 = new BigDecimal("0.00");
                totalCogQ2 = new BigDecimal("0.00");
                totalCogQ3 = new BigDecimal("0.00");
                totalCogQ4 = new BigDecimal("0.00");
                totalAddSurr = new BigDecimal("0.00");
            %> 
                  
          <!--1st loop C--><%} %>     
                  
<!-- --------------------------------- TOTAL AMOUNT ROW ENDS---------------------------------------------------------- -->                
 <!-- --------------------------------- GRAND TOTAL AMOUNT ROW STARTS---------------------------------------------------------- -->
	              <tr class="custom-GrandTotal-row">
	              <td align="center" colspan="1"><font size="3"><b>Grand Total Amount : </b></font></td>
	              <td align="right"><font size="2"><%=grandtotalAllot!=null? df.format(grandtotalAllot):" - "%></font></td>
				  <td align="right"><%=grandtotalExp!=null? df.format(grandtotalExp):" - "%></td>
				  <td align="right"><%=grandtotalBalance!=null? df.format(grandtotalBalance):" - "%></td>
				  <td align="right"><%=grandtotalExpPer!=null?dfPercF.format(grandtotalExpPer):" - " %> %</td>
				  
				       <!-- Apr,May, Jun is Q1 -->
				  <%if("Q1".equalsIgnoreCase(QuarterType)){ %>
					 <%if(Double.parseDouble(cogQ1)>=00){ %>
				  <td align="right"><%=grandtotalCogQ1!=null? df.format(grandtotalCogQ1):" - "%></td>
					  <%} %>
					  <%if(Double.parseDouble(cogQ2)>=0){ %>
				  <td align="right"><%= grandtotalCogQ2!=null?df.format(grandtotalCogQ2):" - "%></td>
					   <%} %>
					   <%if(Double.parseDouble(cogQ3)>=0){ %>
				  <td align="right"><%=grandtotalCogQ3!=null? df.format(grandtotalCogQ3):" - "%></td>
						<%} %>
						<%if(Double.parseDouble(cogQ4)>=0){ %>
				  <td align="right"><%=grandtotalCogQ4!=null? df.format(grandtotalCogQ4):" - "%></td>
						<%} %>
					<%} %>
							
							<!-- July,Aug, Sept is Q2 -->
					<%if("Q2".equalsIgnoreCase(QuarterType)){ %>
						<%if(Double.parseDouble(cogQ2)>=0){ %>
					<td align="right"><%=grandtotalCogQ2!=null? df.format(grandtotalCogQ2):" - "%></td>
						<%} %>
						<%if(Double.parseDouble(cogQ3)>=0){ %>
					<td align="right"><%=grandtotalCogQ3!=null? df.format(grandtotalCogQ3):" - "%></td>
						<%} %>
					    <%if(Double.parseDouble(cogQ4)>=0){ %>
					<td align="right"><%=grandtotalCogQ4!=null? df.format(grandtotalCogQ4):" - "%></td>
						<%} %>
					<%} %>
							
								<!-- Oct,Nov, Dec is Q3 -->
					<%if("Q3".equalsIgnoreCase(QuarterType)){ %>
						<%if(Double.parseDouble(cogQ3)>=0){ %>
					<td align="right"><%=grandtotalCogQ3!=null? df.format(grandtotalCogQ3):" - "%></td>
						<%} %>
					    <%if(Double.parseDouble(cogQ4)>=0){ %>
					<td align="right"><%=grandtotalCogQ4!=null? df.format(grandtotalCogQ4):" - "%></td>
						<%} %>
					<%} %>
							
								<!-- Jan,Feb, Mar is Q4-->
					<%if("Q4".equalsIgnoreCase(QuarterType)){ %>
						<%if(Double.parseDouble(cogQ4)>=0){ %>
					<td align="right"><%=grandtotalCogQ4!=null? df.format(grandtotalCogQ4):" - "%></td>
						<%} %>
					<%} %>   
				       
				   <td align="right"><b><font size="3"><%=grandTotalAddSurr!=null? df.format(grandTotalAddSurr):" - "%></font></b></td>
				
	              </tr>
	
 <!-- --------------------------------- GRAND TOTAL AMOUNT ROW ENDS---------------------------------------------------------- -->	

	<%}else{ %>
					<tr >
						 <%if("Q1".equalsIgnoreCase(QuarterType)){ %>
	                  <td align="center" colspan="10">No Data Found.</td>
	                   <%} %>
						 <%if("Q2".equalsIgnoreCase(QuarterType)){ %>
						 <td align="center" colspan="9">No Data Found.</td>
	                   <%} %>
	                    <%if("Q3".equalsIgnoreCase(QuarterType)){ %>
						 <td align="center" colspan="8">No Data Found.</td>
	                   <%} %>
	                     <%if("Q4".equalsIgnoreCase(QuarterType)){ %>
						 <td align="center" colspan="7">No Data Found.</td>
	                   <%} %>
						</tr>
					<%} %>
			     </table>
					
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
			</div>
		</div>
</div>
	
					

</body>
<script>
$(".date").daterangepicker({

	autoclose: true,
    "singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	showDropdowns : true,
    locale : {
		format : 'DD-MM-YYYY'
	}
});	
</script>
<script type="text/javascript">
$(document).ready(function() {
    $(".clickable-row").click(function() {
        window.location = $(this).data("href");
    });
});
</script>
</html>