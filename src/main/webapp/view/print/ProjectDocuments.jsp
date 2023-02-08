<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1"> 
<jsp:include page="../static/header.jsp"></jsp:include>

 <style type="text/css">
 
 p{
  text-align: justify;
  text-justify: inter-word;
}

  label{
	font-weight: 800;
	font-size: 16px;
	color:#07689f;
} 
  
 th
 {
 	
 	text-align: center;
 	
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
	padding:5px ;
}
 
  
 .textcenter{
 	
 	text-align: center;
 }
 .border
 {
 	border: 1px solid black;
 }
 .textleft{
 	text-align: left;
 }

label{
	font-weight: 800;
	font-size: 16px;
	color:#07689f;
} 

</style>
</head>
<body>
<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card shadow-nohover">
					<div class="row card-header">
			   			<div class="col-md-6">
							<h3>Project Document List</h3>
						</div>
						<div class="col-md-2">
						</div>						
						<div class="col-md-4 justify-content-end" style="float: right;"></div>
					 </div>
					 	 <div class="card-body">	
					 	      <div class="table-responsive">
	                             <table class="table table-bordered table-hover table-striped table-condensed "  id="myTable" >
			                 <thead>
								<tr align="center">
									<th style="width: 10%;" data-field="0" tabindex="0" >SN</th>
									<th style="width: 50%;"> Project Name</th>
									<th style="width: 20%;"> Sheet Number</th>
									<th style="width: 20%;"> Action</th>
								</tr>
							</thead>
							<tbody style="text-align: center">
							    <tr>
								    <td>1</td>
								    <td align="left">Cost Estimate</td>
								    <td>SHEET_01</td>
								    <td><a href="##" name=""  value=""><i class="fa fa-eye" aria-hidden="true"></i> </a></td>
							    </tr>
							    
							    <tr>
								    <td>2</td>
								    <td align="left"> TRA AND PRI VERIFICATION / VETTING</td>
								    <td>SHEET_02</td>
								    <td><a href="##" name=""  value=""><i class="fa fa-eye" aria-hidden="true"></i></a></td>
							    </tr>
							    
							    <tr>
								    <td>3</td>
								    <td align="left">DMC Presentation</td>
								    <td>SHEET_03</td>
								    <td><a href="##" name=""  value=""><i class="fa fa-eye" aria-hidden="true"></i></a></td>
							    </tr>
							    
							     <tr>
								    <td>4</td>
								    <td align="left">Project / Programme Proposal</td>
								    <td>SHEET_04</td>
								    <td><a href="##" name=""  value=""><i class="fa fa-eye" aria-hidden="true"></i></a></td>
							    </tr>
							    
							     <tr>
								    <td>5</td>
								    <td align="left">CCS NOTING</td>
								    <td>SHEET_05</td>
								    <td><a href="##" name=""  value=""><i class="fa fa-eye" aria-hidden="true"></i></a></td>
							    </tr>
							    
							     <tr>
								    <td>6</td>
								    <td align="left">Project / Programme Sanction</td>
								    <td>SHEET_06</td>
								    <td><a href="ProjectSanctionPreview.htm" name=""  value=""><i class="fa fa-eye" aria-hidden="true"></i></a></td>
							    </tr>
							    
							    <tr>
								    <td>7</td>
								    <td align="left">Appointment of PD / Programme Director</td>
								    <td>SHEET_07</td>
								    <td><a href="##" name=""  value=""><i class="fa fa-eye" aria-hidden="true"></i></a></td>
							    </tr>
							    
							    <tr>
								    <td>8</td>
								    <td align="left">Annual Audit Statement of Expenditure</td>
								    <td>SHEET_08</td>
								    <td><a href="##" name=""  value=""><i class="fa fa-eye" aria-hidden="true"></i></a></td>
							    </tr> 
							    
							    <tr>
								    <td>9</td>
								    <td align="left">Briefing Paper PMRC / EB / Apex / PJB / PMB</td>
								    <td>SHEET_09</td>
								    <td><a href="##" name=""  value=""><i class="fa fa-eye" aria-hidden="true"></i></a></td>
							    </tr>
							    
							    <tr>
								    <td>10</td>
								    <td align="left">Minutes of Meeting PMRC / EB / Apex / PJB / PMB</td>
								    <td>SHEET_10</td>
								    <td><a href="##" name=""  value=""><i class="fa fa-eye" aria-hidden="true"></i></a></td>
							    </tr>
							    
							    <tr>
								    <td>11</td>
								    <td align="left">SoC for PDC Extension</td>
								    <td>SHEET_11</td>
								    <td><a href="##" name=""  value=""><i class="fa fa-eye" aria-hidden="true"></i></a></td>
							    </tr>
							    
							    <tr>
								    <td>12</td>
								    <td align="left">SoC for Cost Revision / Re-allocation of Funds in Project</td>
								    <td>SHEET_12</td>
								    <td><a href="##" name=""  value=""><i class="fa fa-eye" aria-hidden="true"></i></a></td>
							    </tr>
							    
							    <tr>
								    <td>13</td>
								    <td align="left">SoC for Project Completed with Partial Success</td>
								    <td>SHEET_13</td>
								    <td><a href="##" name=""  value=""><i class="fa fa-eye" aria-hidden="true"></i></a></td>
							    </tr>
							    
							    <tr>
								    <td>14</td>
								    <td align="left">Audit of Statement of Accounts (Expenditure) and Administrative Closure of Project / Programme</td>
								    <td>SHEET_14</td>
								    <td><a href="##" name=""  value=""><i class="fa fa-eye" aria-hidden="true"></i></a></td>
							    </tr>
							    
							    <tr>
								    <td>15</td>
								    <td align="left">Govt. Letter for PDC extension</td>
								    <td>SHEET_15</td>
								    <td><a href="PdcExtention.htm" name=""  value=""><i class="fa fa-eye" aria-hidden="true"></i></a></td>
							    </tr>
							    
							    <tr>
								    <td>16</td>
								    <td align="left">Govt. Letter for Cost Revision / Re-allocation of Funds</td>
								    <td>SHEET_16</td>
								    <td><a href="ReallocationReport.htm" name=""  value=""><i class="fa fa-eye" aria-hidden="true"></i></a></td>
							    </tr>
							    
							     <tr>
								    <td>17</td>
								    <td align="left">Govt. Letter for Project closure</td>
								    <td>SHEET_17</td>
								    <td><a href="##" name=""  value=""><i class="fa fa-eye" aria-hidden="true"></i></a></td>
							    </tr>
							    
							    <tr>
								    <td>18</td>
								    <td align="left">Change of Project Nodal Lab to New Lab</td>
								    <td>SHEET_18</td>
								    <td><a href="##" name=""  value=""><i class="fa fa-eye" aria-hidden="true"></i></a></td>
							    </tr>
							    
							    <tr>
								    <td>19</td>
								    <td align="left">Change of Project Category During Project Currency</td>
								    <td>SHEET_19</td>
								    <td><a href="##" name=""  value=""><i class="fa fa-eye" aria-hidden="true"></i></a></td>
							    </tr>
							    
							    <tr>
								    <td>20</td>
								    <td align="left">Project proposal</td>
								    <td>SHEET_20</td>
								    <td><a href="##" name=""  value=""><i class="fa fa-eye" aria-hidden="true"></i></a></td>
							    </tr>
							    
							</tbody>
							
							
                       </table>
	                        </div>
	                    
					 	</div>
					</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">

$(document).ready(function(){	
	$("#myTable").DataTable({
		 "lengthMenu": [  25, 50, 75, 100 ],
		 "pagingType": "simple"
	});
});
  
</script>
</html>