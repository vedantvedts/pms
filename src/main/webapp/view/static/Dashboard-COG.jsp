<%@page import="java.util.List"%>
<%@page import="java.math.BigDecimal"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
</head>
<body>
<% List<Object[]> CashOutGo= (List<Object[]>)request.getAttribute("DashboardFinanceCashOutGo"); %>

	<div  class="card " id="project-attributes" style="margin:0px 0px 5px 0px;background-color: rgba(0,0,0,0.1) !important;display: none;">
		<div class="card-body" style="padding: 0px !important">
			<div class="col-md-12" align="left">
				<table class="table" style="margin-bottom: -5px !important; margin-top: -5px !important;" >
					    <tr>
					      <th>Project :</th>
					      <td id="pro-attr-name"></td>
					      <th>DoS :</th>
					      <td id="pro-attr-DoS"></td>
					      <th>PDC :</th>
					      <td id="pro-attr-PDC"></td>
					      <th>Sanc Cost :</th>
					      <td id="pro-attr-sanc"></td>
					      <th>Category : </th>
					      <td id="pro-attr-category"></td>
					      <th>Stage : </th>
					      <td id="pro-attr-stage"></td>
					    </tr>
				</table>
				
			</div>
		</div>	
	</div>

		
	<div class="card  cashoutgo" style="margin: 5px 0px;background-color: rgba(0,0,0,0.1) !important;">
		<div class="card-body row" style="padding: 3px !important">
			<div class="col-md-12">
				
				<% 
				      	BigDecimal AllotCap = new BigDecimal(0.0);
				      	BigDecimal ExpCap = new BigDecimal(0.0);
				      	BigDecimal BalCap = new BigDecimal(0.0);
				      	BigDecimal Q1Cap = new BigDecimal(0.0);
				      	BigDecimal Q2Cap = new BigDecimal(0.0);
				      	BigDecimal Q3Cap = new BigDecimal(0.0);
				      	BigDecimal Q4Cap = new BigDecimal(0.0);
				      	BigDecimal AddlCap = new BigDecimal(0.0);
				      	
				      	BigDecimal AllotRev = new BigDecimal(0.0);
				      	BigDecimal ExpRev = new BigDecimal(0.0);
				      	BigDecimal BalRev = new BigDecimal(0.0);
				      	BigDecimal Q1Rev = new BigDecimal(0.0);
				      	BigDecimal Q2Rev = new BigDecimal(0.0);
				      	BigDecimal Q3Rev = new BigDecimal(0.0);
				      	BigDecimal Q4Rev = new BigDecimal(0.0);
				      	BigDecimal AddlRev = new BigDecimal(0.0);
				      	
				      	BigDecimal AllotOth = new BigDecimal(0.0);
				      	BigDecimal ExpOth = new BigDecimal(0.0);
				      	BigDecimal BalOth = new BigDecimal(0.0);
				      	BigDecimal Q1Oth = new BigDecimal(0.0);
				      	BigDecimal Q2Oth = new BigDecimal(0.0);
				      	BigDecimal Q3Oth = new BigDecimal(0.0);
				      	BigDecimal Q4Oth = new BigDecimal(0.0);
				      	BigDecimal AddlOth = new BigDecimal(0.0);
				      
				      %>
				<table class="table cashoutgotable" id="cashoutgotable" >
				  <thead>
				    <tr>
				      <th style="width:10rem"><img src="view/images/rupee.png" /> &nbsp;&nbsp;Cash Out Go (<span style="color: green">&#8377;</span>Cr)</th>
				      <th scope="col" style="width:10rem">Allot</th>
				      <th scope="col" style="width:10rem">Exp</th>
				      <th scope="col" style="width:10rem">Bal</th>
				      <th scope="col" style="width:10rem">COG-Q1</th>
				      <th scope="col" style="width:10rem">COG-Q2</th>
				      <th scope="col" style="width:10rem">COG-Q3</th>
				      <th scope="col" style="width:10rem">COG-Q4</th>
				      <th scope="col" style="width:10rem">Addl(-)/Surr(+)</th>
				    </tr>
				  </thead>
				  <tbody>
				  
				    <tr>
				      <th scope="row" style="text-align: left">
				      	<!-- <span class="shadow COGLegend" style="color:#5C192F" >&#x220E;</span>&nbsp;<span class="COGLegend">CAP</span>&nbsp;  -->
				      	<span style="border-left: 2px solid darkgrey" id="COGProject">&nbsp;&nbsp; Project</span>
				      </th>
				      <td>
				      	<div class="progress cashoutgobar">
						  <div class="progress-bar primary" role="Allotment" id="ProAllotCap" style="width: 33%" aria-valuenow="15" aria-valuemin="0" aria-valuemax="100" data-toggle="tooltip" title="Project Capital : <%=CashOutGo.get(0)[3] %> Cr" ><%=CashOutGo.get(0)[3] %></div>
						  <% AllotCap=AllotCap.add(new BigDecimal( CashOutGo.get(0)[3].toString())); %>
						  <div class="progress-bar bg-success" role="progressbar" id="ProAllotRev" style="width: 33%" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100" data-toggle="tooltip" title="Project Revenue : <%=CashOutGo.get(1)[3] %> Cr"  ><%=CashOutGo.get(1)[3] %></div>
						  <% AllotRev=AllotRev.add(new BigDecimal( CashOutGo.get(1)[3].toString())); %>
						  <div class="progress-bar bg-info" role="progressbar" id="ProAllotOth" style="width: 34%" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100" data-toggle="tooltip" title="Project Others : <%=CashOutGo.get(2)[3] %> Cr"  ><%=CashOutGo.get(2)[3] %></div>
						  <% AllotOth=AllotOth.add(new BigDecimal( CashOutGo.get(2)[3].toString())); %>
						</div>
				      </td>
				      <td>
				      	<div class="progress cashoutgobar">
						  <div class="progress-bar primary" role="progressbar" id="ProExpCap" style="width: 33%" aria-valuenow="15" aria-valuemin="0" aria-valuemax="100" data-toggle="tooltip"title="Project Capital : <%=CashOutGo.get(0)[4] %> Cr"  ><%=CashOutGo.get(0)[4] %></div>
						  <% ExpCap=ExpCap.add(new BigDecimal( CashOutGo.get(0)[4].toString())); %>
						  <div class="progress-bar bg-success" role="progressbar" id="ProExpRev" style="width: 33%" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100" data-toggle="tooltip" title="Project Revenue : <%=CashOutGo.get(1)[4] %> Cr"  ><%=CashOutGo.get(1)[4] %></div>
						  <% ExpRev=ExpRev.add(new BigDecimal( CashOutGo.get(1)[4].toString())); %>
						  <div class="progress-bar bg-info" role="progressbar" id="ProExpOth" style="width: 34%" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100" data-toggle="tooltip" title="Project Others : <%=CashOutGo.get(2)[4] %> Cr"  ><%=CashOutGo.get(2)[4] %></div>
						  <% ExpOth=ExpOth.add(new BigDecimal( CashOutGo.get(2)[4].toString())); %>
						</div>
				      </td>
				      <td>
				      	<div class="progress cashoutgobar">
						  <div class="progress-bar primary" role="progressbar" id="ProBalCap" style="width: 33%" aria-valuenow="15" aria-valuemin="0" aria-valuemax="100" data-toggle="tooltip" title="Project Capital : <%=CashOutGo.get(0)[5] %> Cr"  ><%=CashOutGo.get(0)[5] %></div>
						  <% BalCap=BalCap.add(new BigDecimal( CashOutGo.get(0)[5].toString())); %>
						  <div class="progress-bar bg-success" role="progressbar" id="ProBalRev" style="width: 33%" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100" data-toggle="tooltip" title="Project Revenue : <%=CashOutGo.get(1)[5] %> Cr" ><%=CashOutGo.get(1)[5] %></div>
						  <% BalRev=BalRev.add(new BigDecimal( CashOutGo.get(1)[5].toString())); %>
						  <div class="progress-bar bg-info" role="progressbar" id="ProBalOth" style="width: 34%" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100" data-toggle="tooltip"title="Project Others : <%=CashOutGo.get(2)[5] %> Cr" ><%=CashOutGo.get(2)[5] %></div>
						  <% BalOth=BalOth.add(new BigDecimal( CashOutGo.get(2)[5].toString())); %>
						</div>
				      </td>
				      <td>
				      	<div class="progress cashoutgobar">
						  <div class="progress-bar primary" role="progressbar" id="ProQ1Cap" style="width: 33%" aria-valuenow="15" aria-valuemin="0" aria-valuemax="100" data-toggle="tooltip"  title="Project Capital : <%=CashOutGo.get(0)[6] %> Cr" ><%=CashOutGo.get(0)[6] %></div>
						  <% Q1Cap=Q1Cap.add(new BigDecimal( CashOutGo.get(0)[6].toString())); %>
						  <div class="progress-bar bg-success" role="progressbar" id="ProQ1Rev" style="width: 33%" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100" data-toggle="tooltip"title="Project Revenue : <%=CashOutGo.get(1)[6] %> Cr" ><%=CashOutGo.get(1)[6] %></div>
						  <% Q1Rev=Q1Rev.add(new BigDecimal( CashOutGo.get(1)[6].toString())); %>
						  <div class="progress-bar bg-info" role="progressbar" id="ProQ1Oth" style="width: 34%" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100" data-toggle="tooltip"title="Project Others : <%=CashOutGo.get(2)[6] %> Cr" ><%=CashOutGo.get(2)[6] %></div>
						  <% Q1Oth=Q1Oth.add(new BigDecimal( CashOutGo.get(2)[6].toString())); %>
						</div>
				      </td>
				      <td>
				      	<div class="progress cashoutgobar">
						  <div class="progress-bar primary" role="progressbar" id="ProQ2Cap" style="width: 33%" aria-valuenow="15" aria-valuemin="0" aria-valuemax="100" data-toggle="tooltip" title="Project Capital : <%=CashOutGo.get(0)[7] %> Cr" ><%=CashOutGo.get(0)[7] %></div>
						  <% Q2Cap=Q2Cap.add(new BigDecimal( CashOutGo.get(0)[7].toString())); %>
						  <div class="progress-bar bg-success" role="progressbar" id="ProQ2Rev" style="width: 33%" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100" data-toggle="tooltip"title="Project Revenue : <%=CashOutGo.get(1)[7] %> Cr" ><%=CashOutGo.get(1)[7] %></div>
						  <% Q2Rev=Q2Rev.add(new BigDecimal( CashOutGo.get(1)[7].toString())); %>
						  <div class="progress-bar bg-info" role="progressbar" id="ProQ2Oth" style="width: 34%" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100" data-toggle="tooltip"title="Project Others : <%=CashOutGo.get(2)[7] %> Cr" ><%=CashOutGo.get(2)[7] %></div>
						  <% Q2Oth=Q2Oth.add(new BigDecimal( CashOutGo.get(2)[7].toString())); %>
						</div>
				      </td>
				      <td>
				      	<div class="progress cashoutgobar">
						  <div class="progress-bar primary" role="progressbar" id="ProQ3Cap" style="width: 33%" aria-valuenow="15" aria-valuemin="0" aria-valuemax="100" data-toggle="tooltip" title="Project Capital : <%=CashOutGo.get(0)[8] %> Cr" ><%=CashOutGo.get(0)[8] %></div>
						  <% Q3Cap=Q3Cap.add(new BigDecimal( CashOutGo.get(0)[8].toString())); %>
						  <div class="progress-bar bg-success" role="progressbar" id="ProQ3Rev" style="width: 33%" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100" data-toggle="tooltip"title="Project Revenue : <%=CashOutGo.get(1)[8] %> Cr"  ><%=CashOutGo.get(1)[8] %></div>
						  <% Q3Rev=Q3Rev.add(new BigDecimal( CashOutGo.get(1)[8].toString())); %>
						  <div class="progress-bar bg-info" role="progressbar" id="ProQ3Oth" style="width: 34%" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100" data-toggle="tooltip"title="Project Others : <%=CashOutGo.get(2)[8] %> Cr"  ><%=CashOutGo.get(2)[8] %></div>
						  <% Q3Oth=Q3Oth.add(new BigDecimal( CashOutGo.get(2)[8].toString())); %>
						</div>
				      </td>
				      <td>
				      	<div class="progress cashoutgobar">
						  <div class="progress-bar primary" role="progressbar" id="ProQ4Cap" style="width: 33%" aria-valuenow="15" aria-valuemin="0" aria-valuemax="100" data-toggle="tooltip" title="Project Capital : <%=CashOutGo.get(0)[9] %> Cr" ><%=CashOutGo.get(0)[9] %></div>
						  <% Q4Cap=Q4Cap.add(new BigDecimal( CashOutGo.get(0)[9].toString())); %>
						  <div class="progress-bar bg-success" role="progressbar" id="ProQ4Rev" style="width: 33%" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100" data-toggle="tooltip"title="Project Revenue : <%=CashOutGo.get(1)[9] %> Cr" ><%=CashOutGo.get(1)[9] %></div>
						  <% Q4Rev=Q4Rev.add(new BigDecimal( CashOutGo.get(1)[9].toString())); %>
						  <div class="progress-bar bg-info" role="progressbar" id="ProQ4Oth" style="width: 34%" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100" data-toggle="tooltip"title="Project Others : <%=CashOutGo.get(2)[9] %> Cr" ><%=CashOutGo.get(2)[9] %></div>
						  <% Q4Oth=Q4Oth.add(new BigDecimal( CashOutGo.get(2)[9].toString())); %>
						</div>
				      </td>
				      <td>
				      	<div class="progress cashoutgobar">
						  <div class="progress-bar primary" role="progressbar" id="ProAddlCap" style="width: 33%" aria-valuenow="15" aria-valuemin="0" aria-valuemax="100" data-toggle="tooltip"title="Project Capital : <%=CashOutGo.get(0)[10] %> Cr"  ><%=CashOutGo.get(0)[10] %></div>
						  <% AddlCap=AddlCap.add(new BigDecimal( CashOutGo.get(0)[10].toString())); %>
						  <div class="progress-bar bg-success" role="progressbar" id="ProAddlRev" style="width: 33%" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100" data-toggle="tooltip"title="Project Revenue : <%=CashOutGo.get(1)[10] %> Cr" ><%=CashOutGo.get(1)[10] %></div>
						  <% AddlRev=AddlRev.add(new BigDecimal( CashOutGo.get(1)[10].toString())); %>
						  <div class="progress-bar bg-info" role="progressbar" id="ProAddlOth" style="width: 34%" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100" data-toggle="tooltip"title="Project Others : <%=CashOutGo.get(2)[10] %> Cr" ><%=CashOutGo.get(2)[10] %></div>
						  <% AddlOth=AddlOth.add(new BigDecimal( CashOutGo.get(2)[10].toString())); %>
						</div>
				      </td>
				    </tr>
				
				    <tr id="COG-Buildup-row">
				      <th scope="row" style="text-align: left">
					      <!-- <span class="shadow " style="color:#466136">&#x220E;</span>&nbsp;REV&nbsp;&nbsp; --> 
					      <span style="border-left: 2px solid darkgrey">&nbsp;&nbsp; BuildUp</span>
				      </th>
				      <td>
				      	<div class="progress cashoutgobar">
						  <div class="progress-bar primary" role="progressbar" style="width: 33%" aria-valuenow="15" aria-valuemin="0" aria-valuemax="100" data-toggle="tooltip" title="BuildUp Capital : <%=CashOutGo.get(3)[3] %> Cr"  ><%=CashOutGo.get(3)[3] %></div>
						  <% AllotCap = AllotCap.add(new BigDecimal( CashOutGo.get(3)[3].toString())); %>
						  <div class="progress-bar bg-success" role="progressbar" style="width: 33%" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100" data-toggle="tooltip" title="BuildUp Revenue : <%=CashOutGo.get(4)[3] %> Cr"  ><%=CashOutGo.get(4)[3] %></div>
						  <% AllotRev=AllotRev.add(new BigDecimal( CashOutGo.get(4)[3].toString())); %>
						  <div class="progress-bar bg-info" role="progressbar" style="width: 34%" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100" data-toggle="tooltip" title="BuildUp Others : <%=CashOutGo.get(5)[3] %> Cr" ><%=CashOutGo.get(5)[3] %></div>
						  <% AllotOth=AllotOth.add(new BigDecimal( CashOutGo.get(5)[3].toString())); %>
						</div>
				      </td>
				      <td>
				      	<div class="progress cashoutgobar">
						  <div class="progress-bar primary" role="progressbar" style="width: 33%" aria-valuenow="15" aria-valuemin="0" aria-valuemax="100" data-toggle="tooltip"title="BuildUp Capital : <%=CashOutGo.get(3)[4] %> Cr" ><%=CashOutGo.get(3)[4] %></div>
						  <% ExpCap=ExpCap.add(new BigDecimal( CashOutGo.get(3)[4].toString())); %>
						  <div class="progress-bar bg-success" role="progressbar" style="width: 33%" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100" data-toggle="tooltip"title="BuildUp Revenue : <%=CashOutGo.get(4)[4] %> Cr" ><%=CashOutGo.get(4)[4] %></div>
						  <% ExpRev=ExpRev.add(new BigDecimal( CashOutGo.get(4)[4].toString())); %>
						  <div class="progress-bar bg-info" role="progressbar" style="width: 34%" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100" data-toggle="tooltip"title="BuildUp Others : <%=CashOutGo.get(5)[4] %> Cr" ><%=CashOutGo.get(5)[4] %></div>
						  <% ExpOth=ExpOth.add(new BigDecimal( CashOutGo.get(5)[4].toString())); %>
						</div>
				      </td>
				      <td>
				      	<div class="progress cashoutgobar">
						  <div class="progress-bar primary" role="progressbar" style="width: 33%" aria-valuenow="15" aria-valuemin="0" aria-valuemax="100" data-toggle="tooltip"title="BuildUp Capital :  <%=CashOutGo.get(3)[5] %> Cr" ><%=CashOutGo.get(3)[5] %></div>
						  <% BalCap=BalCap.add(new BigDecimal( CashOutGo.get(3)[5].toString())); %>
						  <div class="progress-bar bg-success" role="progressbar" style="width: 33%" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100" data-toggle="tooltip"title="BuildUp Revenue : <%=CashOutGo.get(4)[5] %> Cr" ><%=CashOutGo.get(4)[5] %></div>
						  <% BalRev=BalRev.add(new BigDecimal( CashOutGo.get(4)[5].toString())); %>
						  <div class="progress-bar bg-info" role="progressbar" style="width: 34%" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100" data-toggle="tooltip" title="BuildUp Others : <%=CashOutGo.get(5)[5] %> Cr" ><%=CashOutGo.get(5)[5] %></div>
						  <% BalOth=BalOth.add(new BigDecimal( CashOutGo.get(5)[5].toString())); %>
						</div>
				      </td>
				      <td>
				      	<div class="progress cashoutgobar">
						  <div class="progress-bar primary" role="progressbar" style="width: 33%" aria-valuenow="15" aria-valuemin="0" aria-valuemax="100" data-toggle="tooltip"title="BuildUp Capital :  <%=CashOutGo.get(3)[6] %> Cr" ><%=CashOutGo.get(3)[6] %></div>
						  <% Q1Cap=Q1Cap.add(new BigDecimal( CashOutGo.get(3)[6].toString())); %>
						  <div class="progress-bar bg-success" role="progressbar" style="width: 33%" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100" data-toggle="tooltip"title="BuildUp Revenue : <%=CashOutGo.get(4)[6] %> Cr" ><%=CashOutGo.get(4)[6] %></div>
						  <% Q1Rev=Q1Rev.add(new BigDecimal( CashOutGo.get(4)[6].toString())); %>
						  <div class="progress-bar bg-info" role="progressbar" style="width: 34%" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100" data-toggle="tooltip" title="BuildUp Others : <%=CashOutGo.get(5)[6] %> Cr" ><%=CashOutGo.get(5)[6] %></div>
						  <% Q1Oth=Q1Oth.add(new BigDecimal( CashOutGo.get(5)[6].toString())); %>
						</div>
				      </td>
				      <td>
				      	<div class="progress cashoutgobar">
						  <div class="progress-bar primary" role="progressbar" style="width: 33%" aria-valuenow="15" aria-valuemin="0" aria-valuemax="100" data-toggle="tooltip"title="BuildUp Capital : <%=CashOutGo.get(3)[7] %> Cr" ><%=CashOutGo.get(3)[7] %></div>
						  <% Q2Cap=Q2Cap.add(new BigDecimal( CashOutGo.get(3)[7].toString())); %>
						  <div class="progress-bar bg-success" role="progressbar" style="width: 33%" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100" data-toggle="tooltip" title="BuildUp Revenue : <%=CashOutGo.get(4)[7] %> Cr"  ><%=CashOutGo.get(4)[7] %></div>
						  <% Q2Rev=Q2Rev.add(new BigDecimal( CashOutGo.get(4)[7].toString())); %>
						  <div class="progress-bar bg-info" role="progressbar" style="width: 34%" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100" data-toggle="tooltip" title="BuildUp Others : <%=CashOutGo.get(5)[7] %> Cr" ><%=CashOutGo.get(5)[7] %></div>
						  <% Q2Oth=Q2Oth.add(new BigDecimal( CashOutGo.get(5)[7].toString())); %>
						</div>
				      </td>
				      <td>
				      	<div class="progress cashoutgobar">
						  <div class="progress-bar primary" role="progressbar" style="width: 33%" aria-valuenow="15" aria-valuemin="0" aria-valuemax="100" data-toggle="tooltip"title="BuildUp Capital : <%=CashOutGo.get(3)[8] %> Cr" ><%=CashOutGo.get(3)[8] %></div>
						  <% Q3Cap=Q3Cap.add(new BigDecimal( CashOutGo.get(3)[8].toString())); %>
						  <div class="progress-bar bg-success" role="progressbar" style="width: 33%" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100" data-toggle="tooltip" title="BuildUp Revenue : <%=CashOutGo.get(4)[8] %> Cr"  ><%=CashOutGo.get(4)[8] %></div>
						  <% Q3Rev=Q3Rev.add(new BigDecimal( CashOutGo.get(4)[8].toString())); %>
						  <div class="progress-bar bg-info" role="progressbar" style="width: 34%" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100" data-toggle="tooltip" title="BuildUp Others : <%=CashOutGo.get(5)[8] %> Cr" ><%=CashOutGo.get(5)[8] %></div>
						  <% Q3Oth=Q3Oth.add(new BigDecimal( CashOutGo.get(5)[8].toString())); %>
						</div>
				      </td>
				      <td>
				      	<div class="progress cashoutgobar">
						  <div class="progress-bar primary" role="progressbar" style="width: 33%" aria-valuenow="15" aria-valuemin="0" aria-valuemax="100" data-toggle="tooltip"title="BuildUp Capital : <%=CashOutGo.get(3)[9] %> Cr" ><%=CashOutGo.get(3)[9] %></div>
						  <% Q4Cap=Q4Cap.add(new BigDecimal( CashOutGo.get(3)[9].toString())); %>
						  <div class="progress-bar bg-success" role="progressbar" style="width: 33%" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100" data-toggle="tooltip" title="BuildUp Revenue : <%=CashOutGo.get(4)[9] %> Cr"  ><%=CashOutGo.get(4)[9] %></div>
						  <% Q4Rev=Q4Rev.add(new BigDecimal( CashOutGo.get(4)[9].toString())); %>
						  <div class="progress-bar bg-info" role="progressbar" style="width: 34%" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100" data-toggle="tooltip" title="BuildUp Others : <%=CashOutGo.get(5)[9] %> Cr" ><%=CashOutGo.get(5)[9] %></div>
						  <% Q4Oth=Q4Oth.add(new BigDecimal( CashOutGo.get(5)[9].toString())); %>
						</div>
				      </td>
				      <td>
				      	<div class="progress cashoutgobar">
						  <div class="progress-bar primary" role="progressbar" style="width: 33%" aria-valuenow="15" aria-valuemin="0" aria-valuemax="100" data-toggle="tooltip"title="BuildUp Capital : <%=CashOutGo.get(3)[10] %> Cr" ><%=CashOutGo.get(3)[10] %></div>
						  <% AddlCap=AddlCap.add(new BigDecimal( CashOutGo.get(3)[10].toString())); %>
						  <div class="progress-bar bg-success" role="progressbar" style="width: 33%" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100" data-toggle="tooltip" title="BuildUp Revenue : <%=CashOutGo.get(4)[10] %> Cr"  ><%=CashOutGo.get(4)[10] %></div>
						  <% AddlRev=AddlRev.add(new BigDecimal( CashOutGo.get(4)[10].toString())); %>
						  <div class="progress-bar bg-info" role="progressbar" style="width: 34%" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100" data-toggle="tooltip"title="BuildUp Others : <%=CashOutGo.get(5)[10] %> Cr"  ><%=CashOutGo.get(5)[10] %></div>
						  <% AddlOth=AddlOth.add(new BigDecimal( CashOutGo.get(5)[10].toString())); %>
						</div>
				      </td>
				    </tr>
				  
				    <tr id="COG-Total-row">
				      <th scope="row" style="text-align: left">
				      	<!-- <span class="shadow " style="color:#591A69 ">&#x220E;</span>&nbsp;OTH&nbsp;  -->
				      	<span style="border-left: 2px solid darkgrey">&nbsp;&nbsp; Total</span>
				      </th>
				      <td>
				      	<div class="progress cashoutgobar">
						  <div class="progress-bar primary" role="progressbar" style="width: 33%" aria-valuenow="15" aria-valuemin="0" aria-valuemax="100" data-toggle="tooltip" title="Total Capital : <%=AllotCap %> Cr" ><%=AllotCap %></div>
						  <div class="progress-bar bg-success" role="progressbar" style="width: 33%" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100" data-toggle="tooltip" title="Total Revenue : <%=AllotRev %> Cr" ><%=AllotRev %></div>
						  <div class="progress-bar bg-info" role="progressbar" style="width: 34%" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100" data-toggle="tooltip" title="Total Others : <%=AllotOth %> Cr" ><%=AllotOth %></div>
						</div>
				      </td>
				      <td>
				      	<div class="progress cashoutgobar">
						  <div class="progress-bar primary" role="progressbar" style="width: 33%" aria-valuenow="15" aria-valuemin="0" aria-valuemax="100" data-toggle="tooltip" title="Total Capital : <%=ExpCap %> Cr" ><%=ExpCap %></div>
						  <div class="progress-bar bg-success" role="progressbar" style="width: 33%" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100" data-toggle="tooltip" title="Total Revenue : <%=ExpRev %> Cr" ><%=ExpRev %></div>
						  <div class="progress-bar bg-info" role="progressbar" style="width: 34%" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100" data-toggle="tooltip" title="Total Others : <%=ExpOth %> Cr" ><%=ExpOth %></div>
						</div>
				      </td>
				      <td>
				      	<div class="progress cashoutgobar">
						  <div class="progress-bar primary" role="progressbar" style="width: 33%" aria-valuenow="15" aria-valuemin="0" aria-valuemax="100" data-toggle="tooltip" title="Total Capital :  <%=BalCap %> Cr" ><%=BalCap %></div>
						  <div class="progress-bar bg-success" role="progressbar" style="width: 33%" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100" data-toggle="tooltip" title="Total Revenue : <%=BalRev %> Cr" ><%=BalRev %></div>
						  <div class="progress-bar bg-info" role="progressbar" style="width: 34%" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100" data-toggle="tooltip" title="Total Others : <%=BalOth %> Cr" ><%=BalOth %></div>
						</div>
				      </td>
				      <td>
				      	<div class="progress cashoutgobar">
						  <div class="progress-bar primary" role="progressbar" style="width: 33%" aria-valuenow="15" aria-valuemin="0" aria-valuemax="100" data-toggle="tooltip" title="Total Capital : <%=Q1Cap %> Cr"><%=Q1Cap %></div>
						  <div class="progress-bar bg-success" role="progressbar" style="width: 33%" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100" data-toggle="tooltip" title="Total Revenue : <%=Q1Rev %> Cr" ><%=Q1Rev %></div>
						  <div class="progress-bar bg-info" role="progressbar" style="width: 34%" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100" data-toggle="tooltip" title="Total Others : <%=Q1Oth %> Cr" ><%=Q1Oth %></div>
						</div>
				      </td>
				      <td>
				      	<div class="progress cashoutgobar">
						  <div class="progress-bar primary" role="progressbar" style="width: 33%" aria-valuenow="15" aria-valuemin="0" aria-valuemax="100" data-toggle="tooltip" title="Total Capital : <%=Q2Cap %> Cr"><%=Q2Cap %></div>
						  <div class="progress-bar bg-success" role="progressbar" style="width: 33%" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100" data-toggle="tooltip" title="Total Revenue : <%=Q2Rev%> Cr" ><%=Q2Rev %></div>
						  <div class="progress-bar bg-info" role="progressbar" style="width: 34%" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100" data-toggle="tooltip" title="Total Others : <%=Q2Oth %> Cr" ><%=Q2Oth %></div>
						</div>
				      </td>
				      <td>
				      	<div class="progress cashoutgobar">
						  <div class="progress-bar primary" role="progressbar" style="width: 33%" aria-valuenow="15" aria-valuemin="0" aria-valuemax="100" data-toggle="tooltip" title="Total Capital : <%=Q3Cap %> Cr"><%=Q3Cap %></div>
						  <div class="progress-bar bg-success" role="progressbar" style="width: 33%" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100" data-toggle="tooltip" title="Total Revenue : <%=Q3Rev %> Cr" ><%=Q3Rev %></div>
						  <div class="progress-bar bg-info" role="progressbar" style="width: 34%" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100" data-toggle="tooltip" title="Total Others : <%=Q3Oth %> Cr" ><%=Q3Oth %></div>
						</div>
				      </td>
				      <td>
				      	<div class="progress cashoutgobar">
						  <div class="progress-bar primary" role="progressbar" style="width: 33%" aria-valuenow="15" aria-valuemin="0" aria-valuemax="100" data-toggle="tooltip" title="Total Capital : <%=Q4Cap %> Cr" ><%=Q4Cap %></div>
						  <div class="progress-bar bg-success" role="progressbar" style="width: 33%" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100" data-toggle="tooltip" data-placement="top" title="Total Revenue : <%=Q4Rev %> Cr"  ><%=Q4Rev %></div>
						  <div class="progress-bar bg-info" role="progressbar" style="width: 34%" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100" data-toggle="tooltip"title="Total Others : <%=Q4Oth %> Cr" ><%=Q4Oth %></div>
						</div>
				      </td>
				      <td>
				      	<div class="progress cashoutgobar">
						  <div class="progress-bar primary" role="progressbar" style="width: 33%" aria-valuenow="15" aria-valuemin="0" aria-valuemax="100" data-toggle="tooltip" title="Total Capital : <%=AddlCap%>" ><%=AddlCap %></div>
						  <div class="progress-bar bg-success" role="progressbar" style="width: 33%" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100" data-toggle="tooltip" title="Total Revenue : <%=AddlRev%>"><%=AddlRev %></div>
						  <div class="progress-bar bg-info" role="progressbar" style="width: 34%" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100" data-toggle="tooltip" title="Total Others : <%=AddlOth%>"><%=AddlOth %></div>
						</div>
				      </td>
				    </tr>
				  
				  </tbody>
				</table>
			</div>
			   </div>
	</div>	 
	

<script type="text/javascript">

function showProjectAttributes($ProjectCode)
{
	if($ProjectCode!='0')
	{
		$.ajax({
			
			type:"GET",
			url:"ProjectAttribures.htm",
			data :{
				ProjectCode : $ProjectCode
			},
			datatype : 'json',
			success : function(result) {
				var values = JSON.parse(result);
				console.log(values);
				$('#pro-attr-name').html(values[1]+' - '+values[0]);
				$('#pro-attr-DoS').html(moment(values[3]).format('DD-MM-YYYY'));
				$('#pro-attr-PDC').html(moment(values[6]).format('DD-MM-YYYY'));
				$('#pro-attr-sanc').html((Number(values[7])/10000000).toFixed(2)+' Cr (<b>Fe : </b>'+(Number(values[9])/10000000).toFixed(2)+' Cr'+')');
				$('#pro-attr-category').html(values[14]);
				if(values[16]!=null){
					$('#pro-attr-stage').html(values[16]);
				}else{
					$('#pro-attr-stage').html('     -      ');
				}
				$('#project-attributes').show();
				$('#projecttitle').html(values[0]);
				
			}
	
		})
	}
}


function CashOutGoProject($ProjectCode)
{
	
	$.ajax({
		
		type:"GET",
		url:"CashoutgoProject.htm",
		data :{
			ProjectCode : $ProjectCode
		},
		datatype : 'json',
		success : function(result) {
			var values = JSON.parse(result);
			
			if($ProjectCode==='0'){
				$('#COGProject').html('&nbsp;&nbsp;Project');
				$('#project-attributes').hide();
				$('#projecttitle').html('PROJECT HEALTH');
			}else
			{
				showProjectAttributes($ProjectCode);
				$('#COGProject').html('&nbsp;&nbsp;'+$ProjectCode);
			}
			$('#ProAllotCap').html(values[0][3]).attr('data-original-title','Project Capital : '+values[0][3] +' Cr');
			$('#ProAllotRev').html(values[1][3]).attr('data-original-title','Project Revenue : '+values[1][3] +' Cr');
			$('#ProAllotOth').html(values[2][3]).attr('data-original-title','Project Others : '+values[2][3] +' Cr');
			
			$('#ProExpCap').html(values[0][4]).attr('data-original-title','Project Capital : '+values[0][4] +' Cr');
			$('#ProExpRev').html(values[1][4]).attr('data-original-title','Project Revenue : '+values[1][4] +' Cr');
			$('#ProExpOth').html(values[2][4]).attr('data-original-title','Project Others : '+values[2][4] +' Cr');
			
			$('#ProBalCap').html(values[0][5]).attr('data-original-title','Project Capital : '+values[0][5] +' Cr');
			$('#ProBalRev').html(values[1][5]).attr('data-original-title','Project Revenue : '+values[1][5] +' Cr');
			$('#ProBalOth').html(values[2][5]).attr('data-original-title','Project Others : '+values[2][5] +' Cr');
			
			$('#ProQ1Cap').html(values[0][6]).attr('data-original-title','Project Capital : '+values[0][6] +' Cr');
			$('#ProQ1Rev').html(values[1][6]).attr('data-original-title','Project Revenue : '+values[1][6] +' Cr');
			$('#ProQ1Oth').html(values[2][6]).attr('data-original-title','Project Others : '+values[2][6] +' Cr');
			
			$('#ProQ2Cap').html(values[0][7]).attr('data-original-title','Project Capital : '+values[0][7] +' Cr');
			$('#ProQ2Rev').html(values[1][7]).attr('data-original-title','Project Revenue : '+values[1][7] +' Cr');
			$('#ProQ2Oth').html(values[2][7]).attr('data-original-title','Project Others : '+values[2][7] +' Cr');
			
			$('#ProQ3Cap').html(values[0][8]).attr('data-original-title','Project Capital : '+values[0][8] +' Cr');
			$('#ProQ3Rev').html(values[1][8]).attr('data-original-title','Project Revenue : '+values[1][8] +' Cr');
			$('#ProQ3Oth').html(values[2][8]).attr('data-original-title','Project Others : '+values[2][8] +' Cr');
			
			$('#ProQ4Cap').html(values[0][9]).attr('data-original-title','Project Capital : '+values[0][9] +' Cr');
			$('#ProQ4Rev').html(values[1][9]).attr('data-original-title','Project Revenue : '+values[1][9] +' Cr');
			$('#ProQ4Oth').html(values[2][9]).attr('data-original-title','Project Others : '+values[2][9] +' Cr');
			
			$('#ProAddlCap').html(values[0][10]).attr('data-original-title','Project Capital : '+values[0][10] +' Cr');
			$('#ProAddlRev').html(values[1][10]).attr('data-original-title','Project Revenue : '+values[1][10] +' Cr');
			$('#ProAddlOth').html(values[2][10]).attr('data-original-title','Project Others : '+values[2][10] +' Cr');
			
			
			
		}

	})
	
}


</script>

</body>
</html>