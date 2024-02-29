<%@page import="java.util.stream.Collectors"%>
<%@page import="java.text.Format"%>
<%@page import="com.vts.pfms.master.dto.ProjectFinancialDetails"%>
<%@page import="com.vts.pfms.FormatConverter"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.math.BigDecimal"%> 
<%@page import="com.ibm.icu.text.DecimalFormat"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.time.LocalDate"%>
    
   
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<jsp:include page="../static/header.jsp"></jsp:include>

<title>Procurement Status</title>


 <style type="text/css">
 
 p{
  text-align: justify;
  text-justify: inter-word;
}

  
 th
 {
 	border: 1px solid black;
 	text-align: center;
 	padding: 5px;
 }
 
 td
 {
 	border: 1px solid black;
 	text-align: left;
 	padding: 5px;
 }
 
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
 
 #containers {
    width: 100%;
    height: 100%;
    margin: 0;
    padding: 0;
}

.anychart-credits {
   display: none;
}

.flex-container {
  display: flex;
  flex-direction: column;
  min-height: 100vh;
}

summary[role=button] {
  background-color: white;
  color: black;
  border: 1px solid black ;
  border-radius:5px;
  padding: 0.5rem;
  cursor: pointer;
  
}
summary[role=button]:hover
 {
color: white;
border-radius:15px;
background-color: #4a47a3;

}
 summary[role=button]:focus
{
color: white;
border-radius:5px;
background-color: #4a47a3;
border: 0px ;

}
summary::marker{
	
}
details { 
  margin-bottom: 5px;  
}
details  .content {
background-color:white;
padding: 0 1rem ;
align: center;
border: 1px solid black;
}

}



		.input-group-text {
			font-weight: bold;
		}

		label {
			font-weight: 800;
			font-size: 16px;
			color: #07689f;
		}

		hr {
			margin-top: -2px;
			margin-bottom: 12px;
		}

		.card b {
			font-size: 20px;
		}
		
		input::-webkit-outer-spin-button,
input::-webkit-inner-spin-button {
    /* display: none; <- Crashes Chrome on hover */
    -webkit-appearance: none;
    margin: 0; /* <-- Apparently some margin are still there even though it's hidden */
}

input[type=number] {
    -moz-appearance:textfield; /* Firefox */
}

.blinking-element {
            animation: blinker 1.5s linear infinite;
            color: #D81B60;
            font-size: 1.5em;
            font-weight:600;
            margin-bottom: 20px;
            text-shadow: 5px 5px 10px  #D81B60;
}

@keyframes blinker { 
   0%{opacity: 0;}
  50%{opacity: 1;}
  100%{opacity: 1;}
}

		
</style>


<meta charset="ISO-8859-1">

</head>
<body >
<%

FormatConverter fc=new FormatConverter(); 
SimpleDateFormat sdf=fc.getRegularDateFormat();
SimpleDateFormat sdf1=fc.getSqlDateFormat(); int addcount=0; 
NFormatConvertion nfc=new NFormatConvertion();

List<Object[]> projectslist=(List<Object[]>)request.getAttribute("projectslist");
List<Object[]> fileStatusList=(List<Object[]>)request.getAttribute("fileStatusList");
String projectId=request.getAttribute("projectId").toString();
List<Object[]> pftsStageList=(List<Object[]>)request.getAttribute("pftsStageList");
List<Object[]> pftsStageList1=pftsStageList.stream().filter(i->Integer.parseInt(i[0].toString())<=10).collect(Collectors.toList());
List<Object[]> pftsStageList2=pftsStageList.stream().filter(i->Integer.parseInt(i[0].toString())>=10).collect(Collectors.toList());
List<Object[]> pftsStageList3=pftsStageList.stream().filter(i->Integer.parseInt(i[0].toString())>10).collect(Collectors.toList());
Format format = com.ibm.icu.text.NumberFormat.getCurrencyInstance(new Locale("en", "in"));

%>
<%
	String ses=(String)request.getParameter("result"); 
	String ses1=(String)request.getParameter("resultfail");
%>
	<%if(ses1!=null){ %>
	<div align="center">
	<div class="alert alert-danger" role="alert">
                     <%=ses1 %>
                    </div></div>
	<%}if(ses!=null){ %>
		<div align="center">
			<div class="alert alert-success" role="alert" >
	        	<%=ses %>
	        </div>
	    </div>
    <%} %>

    



	
<br>
<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card shadow-nohover">
					<div class="row card-header">
			   			<div class="col-md-6">
							<h4>Procurement Status</h4>
						</div>
						<div class="col-md-2">
							<%-- <form method="post" action="ProjectBriefing.htm" target="_blank">
								<input type="hidden" name="projectid" value="<%=projectid%>"/>
								<button type="submit" ><img src="view/images/preview3.png"></button>
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							</form> --%>
						</div>				
						<!-- <div class="col-md-10" style="float: right; margin-top: -8px;">
						   <div class="form-inline" style="justify-content: end;margin-bottom:3rem;">
						   <form action="CCMReport.htm" method="POST" id="ccmReport" autocomplete="off"> 
						   <input type="hidden" name="_csrf" value="9b5c3d2d-453a-4566-8d9b-9c311c9ea7d9"> 
						   <table>
					   					<tbody><tr>
					   						<td>
					   							<label class="control-label" style="font-size: 14px; margin-bottom: .0rem;">Date : </label>
					   						</td>
					   						<td>
					   						  <input onchange="this.form.submit()" class="form-control date" type="text" name="DateCCM" id="date" readonly="readonly" style="width: 11rem; background-color:white; text-align: left;" value="26-06-2023"> 
					   						</td>
					   						
					   						<td>
					   							<label class="control-label" style="font-size: 14px; margin-bottom: .0rem;">Select: </label>
					   						</td>
					   						<td>
					   						 <select class="form-control selectdee select2-hidden-accessible" id="selDigitType" name="DigitSel" required="required" onchange="this.form.submit()" data-live-search="true" data-select2-id="selDigitType" tabindex="-1" aria-hidden="true">
                                               <option value="Rupees" selected="selected" data-select2-id="2">Rupees</option>
						                       <option value="Lakhs">Lakhs</option>
						                       <option value="Crores">Crores</option>     
											</select><span class="select2 select2-container select2-container--default" dir="ltr" data-select2-id="1" style="width: 96px;"><span class="selection"><span class="select2-selection select2-selection--single" role="combobox" aria-haspopup="true" aria-expanded="false" tabindex="0" aria-disabled="false" aria-labelledby="select2-selDigitType-container"><span class="select2-selection__rendered" id="select2-selDigitType-container" role="textbox" aria-readonly="true" title="Rupees">Rupees</span><span class="select2-selection__arrow" role="presentation"><b role="presentation"></b></span></span></span><span class="dropdown-wrapper" aria-hidden="true"></span></span>					   		
					   				       </td>
					   					</tr>
					   		</tbody></table>			
						   </form>
						   </div>
						 </div>	 -->	
						<div class="col-md-3 justify-content-end" style="float: right;margin-top: -0.75rem;">
						   <div class="form-inline" style="justify-content: end;margin-bottom:2rem;">
						  <table >
					   					<tbody><tr>
					   						<td style="border: 0 ">
					   							<label class="control-label" style="font-size: 17px;font-weight:bold; margin-bottom: .0rem;">Project : </label>
					   						</td>
									<td  style="border: 0 ">
								<%-- 		<form method="post" action="ProcurementStatus.htm" id="projectchange" >
											
											<select class="form-control selectdee select2-hidden-accessible" name="projectid"  required="required" style="width:200px;" data-live-search="true" data-container="body" onchange="submitForm('projectchange');">
												<%for(Object[] obj : projectslist){
												String projectshortName=(obj[17]!=null)?" ( "+obj[17].toString()+" ) ":"";
													%>
												<option value=<%=obj[0]%><%if(projectId.equals(obj[0].toString())){ %> selected="selected" <%} %> ><%=obj[4]+projectshortName %></option>
												<%} %>
											</select>
											<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
										</form> --%>
										
											<form method="post" action="ProcurementStatus.htm" id="projectchange" >
											<select class="form-control selectdee" name="projectid"  required="required" style="width:200px;" data-live-search="true" data-container="body" onchange="submitForm('projectchange');">
												<%for(Object[] obj : projectslist){ %>
												<option value=<%=obj[0]%><%if(projectId.equals(obj[0].toString())){ %> selected="selected" <%} %> ><%=obj[4] %></option>
												<%} %>
											</select>
											<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
										</form>
									</td>
								</tr>
							</table>
							
						</div>
						</div>
					 </div>
					 	 <div class="card-body">	
					 	      <div class="table-responsive">
	                              <table class="table table-bordered table-hover table-striped table-condensed "  id="myTable"> 
	                                  <thead>
	                                     <tr>
	                                      <th>SN</th>
	                                      <th>DemandNo</th>
	                                      <th>Item Nomenclature</th>
	                                      <th>Estimated cost</th>
	                                      <th>Status</th>
	                                     </tr>
	                                 </thead>
	                                 <tbody>
	                                      <%if(fileStatusList!=null){ int SN=1;%>
	                                      <%for(Object[] fileStatus:fileStatusList){ %>
	                                      <tr>
                                            <td><%=SN++%></td>
                                         <td><% if(fileStatus[1]!=null){ %> <%=fileStatus[1]%><%}else %>--</td>
                                            <td><%=fileStatus[4]%></td>
                                            <td style="text-align: right;">
                                            <%if(fileStatus[3]!=null) {%>
                                            <%=format.format(new BigDecimal(fileStatus[3].toString())).substring(1)%>
                                            <%}else{ %>--<%} %>
                                            </td>
                                            <td >
                                              <table style="margin-left:4rem;">
                                              
                                                <%if(fileStatus[8]!=null ){
                                            	  if(fileStatus[8].toString().equalsIgnoreCase("Y")){
                                            	  %>
                                            	
                                              <tr> 
                                              <td>
                                              <form id="enviEditForm" action="#"  >
                                              <button class="btn btn-sm"  formaction="enviEdit.htm" id="enviEditBtn" type="button"  onclick="openEnviform('<%=fileStatus[0]%>')"><i class="fa fa-pencil-square-o" aria-hidden="true"></i></button>
                                            <button class="btn btn-sm" id="fileCloseBtn"  onclick="return fileClose()" formaction="FileInActive.htm"><i class="fa fa-times" aria-hidden="true" ></i></button>
                                             <input type="hidden" name="itemN" id="itemN" >
                                             <input type="hidden" name="estimatedCost" id="estimatedCost">
                                             <input type="hidden" name="PDOfInitiation" id="PDOfInitiation">
                                             <input type="hidden" name="status" id="status">
                                             <input type="hidden" name="remarks" id="remarks">
                                             <input type="hidden" name="fileId" id="fileId" value="<%=fileStatus[0]%>">
                                             <input type="hidden" name="projectId" value="<%=projectId%>">
                                             </form> </td>
                                              </tr>
                                              <%} }%>
                                              
                                               <tr>
                                               <% if(fileStatus[7] !=null){ %>
                                                <td><%=fileStatus[6]%></td>
                                                <%if(!fileStatus[7].toString().equals("19")){ %>
                                                   <td>
                                                      <button class="btn btn-sm" data-toggle="modal" data-target="#exampleModal" onclick="openEditform('<%=fileStatus[0]%>','<%=fileStatus[1]%>',<%=fileStatus[7]%>,'<%=fileStatus[4]%>')"><i class="fa fa-pencil-square-o" aria-hidden="true"></i></button>
                                                  </td>
                                                   <td style="margin-left:5px;">  
                                                   <form action="FileInActive.htm" method="post">
	                                                   <input type="hidden" name="fileId" value="<%=fileStatus[0]%>" />
	                                                   <input type="hidden" name="projectId" value=<%=projectId%> />
	                                                   <input type="hidden" name="demandNo" value="<%=fileStatus[1]%>" />
	                                                   <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />                                         
	                                                   <button class="btn btn-sm"  onclick="return confirm('Are You Sure To InActive ?')"><i class="fa fa-times" aria-hidden="true"></i></button>
	                                                   <button class="btn btn-sm" type="button" data-toggle="modal" data-target="#PDCModal" onclick="openPDCform('<%=fileStatus[0]%>')">
                                                  	  	<i class="fa fa-calendar" aria-hidden="true"></i>
                                                  	  </button>
	                                                   <%if(Long.parseLong(fileStatus[7].toString())>9){ %>
	                                                   <button class="btn btn-sm "  formaction="FileOrderRetrive.htm" title="Refresh Order"> <i class="fa fa-refresh" aria-hidden="true"></i></button>
	                                                   <%} %>
                                                   </form>
                                                   </td>
                                                  <%} }%>
                                               </tr>
                                              </table>
                                            </td>
	                                      </tr>
	                                      <%} }%>
	                                 </tbody>
	                              </table>
	                        </div>
	                        <div align="center">
	                          <form action="#" id="enviForm" method="post">
	                                <input type="hidden" name="projectId" value=<%=projectId%> />
	                        		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	                        		
	                        		<button  class="btn add" type="button" formaction="AddNewDemandFile.htm" id="ibasAddBtn" onclick="addIbis()">Add Demand From IBAS</button>
<!-- 	                        		<button  class="btn btn-info" style="font-weight:600" type="button" id="manualAddBtn" onclick="addManual()" formaction="AddManualDemand.htm">MANNUAL DEMAND</button>
 -->	                        		<button  class="btn btn-success" style="font-weight:600"  type="button" id="enviBtn" onclick="addEnvi()" formaction="envisagedAction.htm">ENVISAGED DEMAND</button>
	                        		
	                           </form>
	                        
	                        
	                           <%-- <form action="AddNewDemandFile.hmt" method="post">
	                                <input type="hidden" name="projectId" value=<%=projectId%> />
	                        		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	                        		<button  class="btn add" type="submit">Add Demand</button>
	                           </form> --%>
	                        </div>
					 	</div>
					</div>
			</div>
		</div>
	</div>
	
<div class="modal fade bd-example-modal-lg" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
		   <div class="modal-content" style="width: 125%; margin-left:-12%">
			<form action="upadteDemandFile.htm" id="form1" method="post" >
					<div class="modal-header" style="background-color: #ECEFF1">
						<h5 class="modal-title" id="statusModalLabel"></h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<div class="row" >
							<div class="col-md-3">
								<label class="control-label" > Procurement Status :</label>
								</div>
								<div class="col-md-4" style="margin-left: -6%;">
								 <select
									class="form-control selectdee" style="width: 100%"
									id="procstatus" required="required" name="procstatus">
								</select>
								</div>
							
							<div class="col-md-2" >
							   <label class="control-label" >Event Date :</label>
							   </div>
							   <div class="col-md-3" >
							   <input style="margin-left: -23%;"
								type="text" class="form-control" name="eventDate" id="eventDate"
								required="required" readonly="readonly">
						    </div>
						</div>
						<div class="row mt-4">
						<div class="col-md-3" >
								<label> Remarks : </label> 
								</div>
								<div class="col-md-8" style=" margin-left: -6%;" >
								<input type="text" class="form-control"
									name="procRemarks" id="procRemarks" required="required"
									style="width: 122%">
							</div>
							</div>
						<br>
						<div align="center">
							<button type="button" class="btn btn-sm submit" onclick="submitStatus()">Update</button>
							   <input type="hidden" name="fileId" id="updateprocFileId"  value=""/>
                               <input type="hidden" name="demandNo" id="updateprocDemand"  value=""/>
                               <input type="hidden" name="eventDate" id="updateeventDate"  value=""/>
                               <input type="hidden" name="remarks" id="updateprocRemarks" value="">
                               <input type="hidden" name="statusId" id="updateStatus" value="">
                               <input type="hidden" name="projectId" value=<%=projectId%> />
                               <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						</div>
						<br>
						<div class="col-md-12 "
							style="border: 1px solid #055C9D; display: flex; justify-content: space-around;">
							<div>
								<%
								int i = 0;
								for (Object[] obj1 : pftsStageList) {
									if (i == 7)
										break;
								%>
								<p class="pstatus" id="<%=obj1[0].toString()%>"><%=obj1[2].toString()%>
								</p>
								<%
								i++;
								}
								%>
							</div>
							<div>
								<%
								int j = 0;
								for (Object[] obj1 : pftsStageList.stream().skip(7).collect(Collectors.toList())) {
									if (j == 7)
										break;
								%>
								<p class="pstatus" id="<%=obj1[0].toString()%>"><%=obj1[2].toString()%>
								</p>
								<%
								j++;
								}
								%>
							</div>
							<div>
								<%
								int k = 0;
								for (Object[] obj1 : pftsStageList.stream().skip(14).collect(Collectors.toList())) {
									if (k == 7)
										break;
								%>
								<p class="pstatus" id="<%=obj1[0].toString()%>"><%=obj1[2].toString() %>
								</p>
								<%
		                        k++;
		                        } %>
						  </div>
						</div>
					</div>
			</form>
		</div>
	</div>
</div>

<div class="modal fade" id="PDCModal" tabindex="-1" role="dialog" aria-labelledby="PDCModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<form action="UpdateFilePDCInfo.htm" method="post" >
				<div class="modal-header">
					<div>
						<h5 class="modal-title" id="PDCModalLabel">Modal title</h5>
					</div>

					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col-md-4">
							<label class="control-label">PDC</label> 
							<input type="text" class="form-control" name="PDCDate" id="PDCDate" required="required" readonly="readonly">
						</div>

						<div class="col-md-8">
							<label class="control-label">Available for Integration by</label> 
							<input type="text" class="form-control" name="IntegrationDate" id="IntegrationDate" required="required" readonly="readonly" style="width: 50%;">
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<input type="hidden" name="projectId" value="<%=projectId%>" /> 
					<input type="hidden" name="fileId" id="pdcFileId" /> 
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<button type="button" class="btn btn-sm btn-danger" data-dismiss="modal"><b>CLOSE</b></button>
					<button type="submit" class="btn btn-sm submit">Submit</button>
				</div>
			</form>
		</div>
	</div>
</div>

<script type="text/javascript">

function submitForm(frmid)
{ 
  
  document.getElementById(frmid).submit(); 
} 
</script>
	
<script type="text/javascript">

$(document).ready(function(){
	  $("#myTable").DataTable({
	 "lengthMenu": [  5,10,25, 50, 75, 100 ],
	 "pagingType": "simple"
	
});
  });
  
</script>

<script type="text/javascript">
function addEnvi() {
	   var form = document.getElementById("enviForm");
	   
       if (form) {
        var enviBtn = document.getElementById("enviBtn");
           if (enviBtn) {
               var formactionValue = enviBtn.getAttribute("formaction");
               
                form.setAttribute("action", formactionValue);
                 form.submit();
             }
        }
}

function addManual() {
	   var form = document.getElementById("enviForm");
	   
    if (form) {
     var manualBtn = document.getElementById("manualAddBtn");
        if (manualBtn) {
            var formactionValue = manualBtn.getAttribute("formaction");
            
             form.setAttribute("action", formactionValue);
              form.submit();
          }
     }
}

function fileClose() {
	var confirmation=confirm('Are You Sure To InActive ?');
	if(confirmation){
   var form = document.getElementById("enviEditForm");
	   
       if (form) {
        var fileCloseBtn = document.getElementById("fileCloseBtn");
           if (fileCloseBtn) {
               var formactionValue = fileCloseBtn.getAttribute("formaction");
               
                form.setAttribute("action", formactionValue);
                 form.submit();
             }
        }
	}else{
		return false;
	}
}

function addIbis() {
	   var form = document.getElementById("enviForm");
	   
       if (form) {
        var ibasAddBtn = document.getElementById("ibasAddBtn");
           if (ibasAddBtn) {
               var formactionValue = ibasAddBtn.getAttribute("formaction");
               
                form.setAttribute("action", formactionValue);
                 form.submit();
             }
        }
}



function openEnviform(PftsFileId) {
	
	$('#fileId').val(PftsFileId);
	$.ajax({
		type : "GET",
		url : "getEnviEditData.htm",
		data : {
			PftsFileId : PftsFileId
		},
		datatype : 'json',
		success : function(result) {
			var values = JSON.parse(result);
			var date = new Date(values[3]);

			// Get the date components
			var day = date.getDate().toString().padStart(2, '0'); // Get day and pad with leading zero if necessary
			var month = (date.getMonth() + 1).toString().padStart(2, '0'); // Get month (zero-based) and pad with leading zero if necessary
			var year = date.getFullYear();
			
			var formattedDate = day+'-'+month+'-'+year;
			$('#itemN').val(values[1]);
			$('#estimatedCost').val(values[2]);
			$('#PDOfInitiation').val(formattedDate);
			$('#status').val(values[4]);
			$('#remarks').val(values[5]);
			var form = document.getElementById("enviEditForm");
			   
		      if (form) {
		       var enviEditBtn = document.getElementById("enviEditBtn");
		          if (enviEditBtn) {
		              var formactionValue = enviEditBtn.getAttribute("formaction");
		              
		               form.setAttribute("action", formactionValue);
		                form.submit();
		            }
		       }
			

		}
	});	
	
	  
}
</script>


<script type="text/javascript">

function openEditform(fileId,demandid,pstatusid,itemname){
	
	  $('#updateprocDemand').val(demandid);
	  $('#updateprocFileId').val(fileId);
	
	  $('#exampleModal .modal-title').html('<span style="color: #FF3D00;">Demand No : ' + demandid + '<br> <span style="color: #039BE5;">Item : ' + itemname);
	  $('#exampleModal').modal('show');
	  $(".pstatus").removeClass("blinking-element"); // Remove blink class from all elements
      $("#" + pstatusid).addClass("blinking-element"); //add blink class on specific id
      
      $.ajax({
			type : "GET",
			url : "getFileViewList.htm",
			data : {
				fileId : fileId
			},
			datatype : 'json',
			success : function(result) {
				 if (result != null) {
				        var resultData = JSON.parse(result); 
				        $('#procRemarks').val(resultData[9]);
				        $('#procstatus').empty();
				        if(pstatusid<10){
				        <%for(Object[] obj3:pftsStageList1){%>
				        var optionValue = <%=obj3[0]%>;
		     		    var optionText = '<%=obj3[2]%>';
		     	        var option = $("<option></option>").attr("value", optionValue).text(optionText);
		                  if(pstatusid==optionValue){
		                  option.prop('selected', true);
		                  }
		                  $('#procstatus').append(option);
				        <%}%>
				        }else if(pstatusid===10){
				        	 <%for(Object[] obj4:pftsStageList2){%>
						        var optionValue = <%=obj4[0]%>;
				     		    var optionText = '<%=obj4[2]%>';
				     	        var option = $("<option></option>").attr("value", optionValue).text(optionText);
				                  if(pstatusid==optionValue){
				                  option.prop('selected', true);
				                  }
				                  $('#procstatus').append(option);
						        <%}%>	
				        }
				        else{
				            <%for(Object[] obj4:pftsStageList3){%>
					        var optionValue = <%=obj4[0]%>;
			     		    var optionText = '<%=obj4[2]%>';
			     	        var option = $("<option></option>").attr("value", optionValue).text(optionText);
			                  if(pstatusid==optionValue){
			                  option.prop('selected', true);
			                  }
			                  $('#procstatus').append(option);
					        <%}%>	
				        }
				        
				       }
				   }      
			});	
}
</script>

<script type="text/javascript">
function submitStatus(){
	var remarks=$('#procRemarks').val();
	var procstatusId=$('#procstatus').val();
	var procDate=$('#eventDate').val();

	$('#updateStatus').val(procstatusId);
	$('#updateprocRemarks').val(remarks);
	$('#updateeventDate').val(procDate);
	
		if(confirm('Are you Sure To Update ?')){
		$('#form1').submit();  
		}
}

</script>

<script type="text/javascript">
$('#eventDate').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	/* "minDate" :new Date(), */
	"startDate" : new Date(),

	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});


$('#DPdateId').daterangepicker({
	"singleDatePicker" : true,
	"linkedCalendars" : false,
	"showCustomRangeLabel" : true,
	/* "minDate" :new Date(), */
	"startDate" : new Date(),

	"cancelClass" : "btn-default",
	showDropdowns : true,
	locale : {
		format : 'DD-MM-YYYY'
	}
});

</script>
<script type="text/javascript">

$( "#selectDemand" ).change(function() {
  var selectee=$( "#selectDemand" ).val();
  if(selectee=='9'){
	  $("#orderDetails").show();
	  $('#orderNoId').prop('required', true);  
	  $('#orderCostId').prop('required', true);  
  }else{
	  $("#orderDetails").hide();
	  $('#orderNoId').removeAttr('required');
	  $('#orderCostId').removeAttr('required'); 
  }
});

</script>
<!-- <script type="text/javascript">
$('#exampleModal').on('hidden.bs.modal', function () {
	  $("#orderDetails").hide();
	  $('#orderNoId').removeAttr('required');
	  $('#orderCostId').removeAttr('required'); 
	});
	

</script>
	
<script type="text/javascript">
$('#exampleModal').on('shown.bs.modal', function () {
	var selectee=$( "#selectDemand" ).val();
	  if(selectee=='9'){
		  $("#orderDetails").show();
		  $('#orderNoId').prop('required', true);  
		  $('#orderCostId').prop('required', true);  
	  }
});

</script> -->


<script type="text/javascript">

function openPDCform(fileId){
	$.ajax({
		type : "GET",
		url : "getFilePDCInfo.htm",
		data : {
			fileid : fileId,
		},
		datatype : 'json',
		success : function(result) {
			var values = JSON.parse(result);
            $("#pdcFileId").val(fileId);
            
            var PDCDate = new Date();
            var IntegrationDate = new Date();
            if(values[5]!==null){     PDCDate =  new Date(values[5]); }
            if(values[6]!==null){     IntegrationDate = new Date(values[6]); }
            console.log(values[6]);
            $('#PDCDate').daterangepicker({
            	"singleDatePicker" : true,
            	"linkedCalendars" : false,
            	"showCustomRangeLabel" : true,
                "startDate" : PDCDate,
            	"cancelClass" : "btn-default",
            	showDropdowns : true,
            	locale : {
            		format : 'DD-MM-YYYY'
            	}
            });
            $('#IntegrationDate').daterangepicker({
            	"singleDatePicker" : true,
            	"linkedCalendars" : false,
            	"showCustomRangeLabel" : true,
            	"startDate" : IntegrationDate,
            	"cancelClass" : "btn-default",
            	showDropdowns : true,
            	locale : {
            		format : 'DD-MM-YYYY'
            	}
            });
            
            $("#PDCModalLabel").html('Demand No : '+result[1]);
		}
	});	
	


}

</script>

</body>
</html>