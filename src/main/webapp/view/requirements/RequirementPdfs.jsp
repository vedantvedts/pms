 <%@page import="com.vts.pfms.requirements.model.RequirementInitiation"%>
<%@page import="com.vts.pfms.NFormatConvertion"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.Month"%>
<%@page import="java.time.LocalDateTime"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"
	import="java.util.*,com.vts.*,java.text.SimpleDateFormat,java.util.stream.Collectors"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">

<style>
  .modalcontainer {
      position: fixed;
      bottom: 45%;
      right: 20px;
      width: 300px;
      max-width: 80%;
      background-color: #fff;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
      border-radius: 8px;
      z-index: 1000;
      font-family: Arial, sans-serif;
     display: none;
    }


    .modal-container {
      position: fixed;
      bottom: 20px;
      right: 20px;
      width: 300px;
      max-width: 80%;
    
      background-color: #fff;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
      border-radius: 8px;
      display: none;
      z-index: 1000;
      font-family: Arial, sans-serif;
     
    }

    .modalheader {
    display: flex;
    align-items: center;
    justify-content: end;
    padding:8px;
      background-color: #FFC436;
      color: #fff;
      border-top-left-radius: 8px;
      border-top-right-radius: 8px;
    }

    .modalcontent {
    
      padding: 10px 10px 10px 10px;
    }

    .modalfooter {
      text-align: right;
      border-bottom-left-radius: 8px;
      border-bottom-right-radius: 8px;
    }

    .modal-close {
      cursor: pointer;
      color: red;
    }

    /* Style for the button */
 
</style>
</head>
<body>

<%
List<Object[]>RequirementList = (List<Object[]>)request.getAttribute("RequirementList");
List<Object[]>ProjectParaDetails=(List<Object[]>)request.getAttribute("ProjectParaDetails");
List<Object[]>VerificationMethodList = (List<Object[]>)request.getAttribute("VerificationMethodList");
List<Object[]>productTreeList = (List<Object[]>)request.getAttribute("productTreeList");
String lablogo=(String)request.getAttribute("lablogo");
String drdologo=(String)request.getAttribute("drdologo");
Object[] DocTempAtrr=(Object[])request.getAttribute("DocTempAttributes");
Object[]LabList=(Object[])request.getAttribute("LabList");

String productTreeMainId =(String)request.getAttribute("productTreeMainId");

String subsystem="";
if(productTreeList!=null && productTreeList.size()>0){
	
	List<Object[]>subSystem = productTreeList.stream().filter(e->e[0].toString().equalsIgnoreCase(productTreeMainId)).collect(Collectors.toList());
	subsystem =subSystem!=null && subSystem.size()>0? subSystem.get(0)[2].toString().toUpperCase():"";
}

%>





  <!-- Modal Container -->
  <div id="myModal" class="modal-container" >
    <div class="bg-primary modalheader" style="justify-content: start;color:red;">
    	<p style="margin-top:0.3rem; margin-bottom:0.4rem;"><b> </b></p>
     <!--  <span class="modal-close"  onclick="closeModal()">&times;</span> -->
    </div>
    <div class="modalcontent" >
  <!--     <p style="font-weight: 600;text-align: justify; cursor: pointer;"onclick="getFunctionalRequirements()">
		Functional Requirements &nbsp; <i class="fa fa-download" aria-hidden="true" style="color:green;"></i>
 		</p>
      <p style="font-weight: 600;text-align: justify; cursor: pointer;"onclick="getPerformanceRequirements()">
		Performance  Requirements &nbsp; <i class="fa fa-download" aria-hidden="true" style="color:green;"></i>
 		</p>
     
      <p style="font-weight: 600;text-align: justify; cursor: pointer;"onclick="getOperationalRequirements()">
		Operational Requirements &nbsp; <i class="fa fa-download" aria-hidden="true" style="color:green;"></i>
 		</p>
      -->
     

    </div>
    <div class="modalfooter">
      <button class="btn" style="padding: 0px !important;font-weight: 500" onclick="closeModal()">Close</button>
    </div>
  </div>


<script>
function openModal() {
	/*   document.getElementById('myModal').style.display = 'block';
	  document.getElementById('modalbtn').style.display = 'none'; */
		$('#myModal').show();
	 
	    setTimeout(() => { 
			   closeModal()
		}, 6000);

	}

	function closeModal() {
	/*   document.getElementById('myModal').style.display = 'none';
	 */  $('#myModal').hide();
	 
	 /*  document.getElementById('modalbtn').style.display = 'block'; */
	 	
	}
	
	
	function getFunctionalRequirements(){
		   var chapterCount = 0;
	       var mainContentCount = 0;
	        var leftSideNote = '<%if(DocTempAtrr!=null && DocTempAtrr[12]!=null) {%><%=DocTempAtrr[12].toString().replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", "") %> <%} else{%>-<%}%>';

			<% List<Object[]> subMainReqList =RequirementList!=null?  RequirementList.stream()
			.filter(e->e[15]!=null&&e[14].toString().equalsIgnoreCase("3"))
			.sorted(Comparator.comparing(e -> Integer.parseInt(e[14].toString())))
			.collect(Collectors.toList()): new ArrayList<>() ;%>
			
			<%if(subMainReqList==null || subMainReqList.size()==0){%>
			alert("No Functional Requirements specified for this Project")
			event.preventDefault();
			return false;
			<%}%>
			
	        
	       var docDefinition = {
	    		   content: [
	    		   {
	                    text: htmlToPdfmake('<h4 class="heading-color ">FUNCTIONAL REQUIREMENTS <br><br> FOR  <br><br>  </h4>'),
	                    style: 'DocumentName',
	                    alignment: 'center',
	                    fontSize: 18,
	                    margin: [0, 200, 0, 20],
	                
	    		  	
	                },
	                <% if (lablogo != null) { %>
	                {
	                    image: 'data:image/png;base64,<%= lablogo %>',
	                    width: 95,
	                    height: 95,
	                    alignment: 'center',
	                    margin: [0, 20, 0, 30]
	                },
	                <% } %>
	                
	                {
	                    text: htmlToPdfmake('<h5><% if (LabList != null && LabList[1] != null) { %> <%= LabList[1].toString().replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", "") + "(" + LabList[0].toString().replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", "") + ")" %> <% } else { %> '-' <% } %></h5>'),
	                    alignment: 'center',
	                    fontSize: 16,
	                    bold: true,
	                    margin: [0, 20, 0, 20]
	                },
	                {
	                    text: htmlToPdfmake('<h6>Government of India, Ministry of Defence<br>Defence Research & Development Organization </h6>'),
	                    alignment: 'center',
	                    fontSize: 14,
	                    bold: true,
	                    margin: [0, 10, 0, 10]
	                },
	                {
	                    text: htmlToPdfmake('<h6><%if(LabList!=null && LabList[2]!=null && LabList[3]!=null && LabList[5]!=null){ %><%=LabList[2]+" , "+LabList[3].toString()+", PIN-"+LabList[5].toString() %><%}else{ %>-<%} %></h6>'),
	                    alignment: 'center',
	                    fontSize: 14,
	                    bold: true,
	                    margin: [0, 10, 0, 10],
	                    pageBreak: 'after',
	                },
	                {
	                    toc: {
	                        title: { text: 'INDEX', style: 'header'}
	                    }
	                },
					<%if(RequirementList!=null && !RequirementList.isEmpty()) {
	   				
	   				%>
	   			   {
	                    text: '',
	                    style: 'chapterHeader',
	                    pageBreak: 'before'
	                },
					
	
	    				<%
	    				String ReqName="";
	    				int subReqCount=0;
	    				for(Object[]obj1:subMainReqList) {
	    					int snCount=0;
	    				%>
	    				<%if(obj1[1]!=null) {%>
						{
		                	text: htmlToPdfmake('<%if(obj1[1]!=null){ %><%=++subReqCount %> .  <%=obj1[1].toString()%> <%}else{ %>-<%} %>'),	
		                    margin: [5, 5, 5, 5],
		                    tocItem: true,
		                },

					<%} %>

	    					{
	    	                    table: {
	    	                        headerRows: 1,
	    	                        widths: ['20%', '30%', '50%'],
	    	                        body: [
	    	                            // Table header
	    	                            [
	    	                                { text: 'SN', style: 'tableHeader' },
	    	                                { text: 'Attribute', style: 'tableHeader' },
	    	                                { text: 'Content', style: 'tableHeader' },
	    	                            ],
	    	                            // Populate table rows

	    	                            [
	    	                                { text: '<%= ++snCount %>', style: 'tableData',alignment: 'center' },
	    	                                { text: 'ID', style: 'tableData' },
	    	                                { text: '<%=obj1[1] %>', style: 'tableData' },
	    	                            ],

	    	                            [
	    	                                { text: '<%= ++snCount %>', style: 'tableData',alignment: 'center' },
	    	                                { text: 'QR Para', style: 'tableData' },
	    	                                { text: '<%if(obj1[12]!=null) { String [] a=obj1[12].toString().split(", "); for(String s:a){ %> <%=ProjectParaDetails.stream().filter(e->e[0].toString().equalsIgnoreCase(s)).map(e->e[3].toString()).collect(Collectors.joining("")) %> \n <%}}else{ %> - <%} %>', style: 'tableData' },
	    	                            ],
	    	                            
	    	                            [
	    	                                { text: '<%= ++snCount %>', style: 'tableData',alignment: 'center' },
	    	                                { text: 'Priority', style: 'tableData' },
	    	                                { text: '<%if(obj1[5]!=null) {%> <%=obj1[5] %> <%}else{%>-<%} %>', style: 'tableData' },
	    	                            ],
	    	                            
	    	                            [
	    	                                { text: '<%= ++snCount %>', style: 'tableData',alignment: 'center' },
	    	                                { text: 'Criticality', style: 'tableData' },
	    	                                { text: '<%if(obj1[21]!=null) {%> <%=obj1[21] %> <%}else{%>-<%} %>', style: 'tableData' },
	    	                            ],
	    	                            
	    	                            [
	    	                                { text: '<%= ++snCount %>', style: 'tableData',alignment: 'center' },
	    	                                { text: 'Type', style: 'tableData' },
	    	                                { text: '<%if(obj1[6]!=null) {%> <%if(obj1[6].toString().equalsIgnoreCase("D")) {%>Desirable<%} %> <%if(obj1[6].toString().equalsIgnoreCase("E")) {%>Essential<%} %> <%}else {%>-<%} %>', style: 'tableData' },
	    	                            ],

	    	                            <%-- [
	    	                                { text: htmlToPdfmake(setImagesWidth(document.getElementById('description<%=mainReqCount+"."+subReqCount %>').innerHTML, 500)), colSpan: 3 },
	    	                            ], --%>
	    	                            
	    	                           	[
	    	                                { stack: [htmlToPdfmake(setImagesWidth('<%=++snCount %>.Description: <%if(obj1[4]!=null){ %> <%=obj1[4].toString().replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", "") %> <%}else{ %>-<%} %>', 500))], colSpan: 3 }
	    	                            ],
	    	                            
	    	                            [
	    	                                { text: '<%= ++snCount %>', style: 'tableData',alignment: 'center' },
	    	                                { text: 'Remarks', style: 'tableData' },
	    	                                { text: '<%if(obj1[7]!=null) {%> <%=obj1[7] %> <%}else{%>-<%} %>', style: 'tableData' },
	    	                            ],

	    	                            [
	    	                                { text: '<%= ++snCount %>', style: 'tableData',alignment: 'center' },
	    	                                { text: 'Constraints', style: 'tableData' },
	    	                                { text: '<%if(obj1[9]!=null) {%> <%=obj1[9] %> <%}else{%>-<%} %>', style: 'tableData' },
	    	                            ],

	    	                           [
	    	                                { text: '<%= ++snCount %>', style: 'tableData',alignment: 'center' },
	    	                                { text: 'Demonstration', style: 'tableData' },
	    	                                { text: htmlToPdfmake('<% if(obj1[16] != null) { %>'
	    	                                	    + '<% List<Object[]> DemonList = VerificationMethodList.stream().filter(e -> e[1].toString().equalsIgnoreCase("1")).collect(Collectors.toList()); %>'
	    	                                	    + '<% String[] a = obj1[16].toString().split(", "); %>'
	    	                                	    + '<% for (int i = 0; i < a.length; i++) { %>'
	    	                                	    + '<%= a[i] %> . <%= DemonList.get(Integer.parseInt(a[i].substring(1)) - 1)[3].toString() %><br>'
	    	                                	    + '<% } %>'
	    	                                	    + '<% } else { %>-<% } %>'), style: 'tableData' },
	    	                            ],

	    	                            [
	    	                                { text: '<%= ++snCount %>', style: 'tableData',alignment: 'center' },
	    	                                { text: 'Test Type', style: 'tableData' },
	    	                                { text: htmlToPdfmake('<%if(obj1[17]!=null) { %>'
	    	                                		+ '<% List<Object[]>TestList1=VerificationMethodList.stream().filter(e->e[1].toString().equalsIgnoreCase("2")).collect(Collectors.toList()); %>'
	    	                                		+ '<%String [] a=obj1[17].toString().split(", "); %>'
	    	                                		+ '<%for(int i=0;i<a.length;i++){ %>'
	    												
	    	                                		 + '<%=	a[i] +" . "+ TestList1.get(Integer.parseInt(a[i].substring(1))-1)[3].toString() %><br>'
	    	                                		+ '<%} %>'
	    	                                		+ '<%}else{%>-<%} %>'), style: 'tableData' },
	    	                            ],
	    	                            [
	    	                                { text: '<%= ++snCount %>', style: 'tableData',alignment: 'center' },
	    	                                { text: 'Test Stage', style: 'tableData' },
	    	                                { text: '<%if(obj1[24]!=null) {%> <%=obj1[24] %> <%}else{%>-<%} %>', style: 'tableData' },
	    	                            ],
	    	                            [
	    	                                { text: '<%= ++snCount %>', style: 'tableData',alignment: 'center' },
	    	                                { text: 'Design/Analysis', style: 'tableData' },
	    	                                { text: htmlToPdfmake('<%if(obj1[18]!=null) { %>'
	    	                                		+ '<% List<Object[]>AnalysisList=VerificationMethodList.stream().filter(e->e[1].toString().equalsIgnoreCase("3")).collect(Collectors.toList()); %>'
	    	                                		+ '<% String [] a=obj1[18].toString().split(", "); %>'
	    	                                		+ '<% for(int i=0;i<a.length;i++){ %>'
	    												
	    	                                			+ '<%=	a[i] +" . "+ AnalysisList.get(Integer.parseInt(a[i].substring(1))-1)[3].toString() %><br>'
	    	                                		+ '<%} %>'
	    											+ '<%}else{%>-<%} %>'), style: 'tableData' },
	    	                            ],

	    	                            [
	    	                                { text: '<%= ++snCount %>', style: 'tableData',alignment: 'center' },
	    	                                { text: 'Inspection', style: 'tableData' },
	    	                                { text: htmlToPdfmake('<%if(obj1[19]!=null) { %>'
	    	                                		+ '<% List<Object[]>InspectionList1=VerificationMethodList.stream().filter(e->e[1].toString().equalsIgnoreCase("4")).collect(Collectors.toList()); %>'
	    	                                		+ '<% String [] a=obj1[19].toString().split(", "); %>'
	    	                                		+ '<% for(int i=0;i<a.length;i++){ %>'
	    												
	    	                                		+ '<%=	a[i] +" . "+ InspectionList1.get(Integer.parseInt(a[i].substring(1))-1)[3].toString() %><br>'
	    	                                		+ '<%} %>'
	    	                                		+ '<%}else{%>-<%} %>'), style: 'tableData' },
	    	                            ],

	    	                            [
	    	                                { text: '<%= ++snCount %>', style: 'tableData',alignment: 'center' },
	    	                                { text: 'Special Methods', style: 'tableData' },
	    	                                { text: htmlToPdfmake('<%if(obj1[20]!=null) { %>'
	    	                                		+ '<% List<Object[]>specialList=VerificationMethodList.stream().filter(e->e[1].toString().equalsIgnoreCase("5")).collect(Collectors.toList()); %>'
	    	                                		+ '<% String [] a=obj1[20].toString().split(", "); %>'
	    	                                		+ '<% for(int i=0;i<a.length;i++){ %>'
	    												
	    	                                		+ '<%=	a[i] +" . "+ specialList.get(Integer.parseInt(a[i].substring(1))-1)[3].toString() %><br>'
	    	                                		+ '<%} %>'
	    	                                		+ '<%}else{%>-<%} %>'), style: 'tableData' },
	    	                            ],
	    	                            
	    	                      <%--       [
	    	                                { text: '<%= ++snCount %>', style: 'tableData',alignment: 'center' },
	    	                                { text: 'Link Sub-Systems', style: 'tableData' },
	    	                                { text: '<%if(obj1[23]!=null) { String [] a=obj1[23].toString().split(", "); for(String s:a){ %> <%=productTreeList.stream().filter(e->e[0].toString().equalsIgnoreCase(s)).map(e->e[2].toString()).collect(Collectors.joining("")) %> \n <%}}else{ %> - <%} %>', style: 'tableData' },
	    	                            ], --%>
	    	                            
	    	                            

	    	                        ]
	    	                    },
	    	                    layout: {

	    	                        hLineWidth: function(i, node) {
	    	                            return (i === 0 || i === node.table.body.length) ? 1 : 0.5;
	    	                        },
	    	                        vLineWidth: function(i) {
	    	                            return 0.5;
	    	                        },
	    	                        hLineColor: function(i) {
	    	                            return '#aaaaaa';
	    	                        },
	    	                        vLineColor: function(i) {
	    	                            return '#aaaaaa';
	    	                        }
	    	                    }
	    	                },
	    	                { text: '\n',},
	    				
	    				<%}%>
	    	
	    			
	    	
	    				<% } %>
	                
	                
	                ],
	                
	                footer: function(currentPage, pageCount) {
	                    if (currentPage > 2) {
	                        return {
	                            stack: [
	                            	{
	                                    canvas: [{ type: 'line', x1: 30, y1: 0, x2: 565, y2: 0, lineWidth: 1 }]
	                                },
	                                {
	                                    columns: [
	                                       
	                                        { text: currentPage.toString() + ' of ' + pageCount, alignment: 'right', margin: [0, 0, 30, 0], fontSize: 8 }
	                                    ]
	                                },
	                                { text: 'Restricted', alignment: 'center', fontSize: 8, margin: [0, 5, 0, 0], bold: true }
	                            ]
	                        };
	                    }
	                    return '';
	                },
	                header: function (currentPage) {
	                    return {
	                        stack: [
	                            
	                            {
	                                columns: [
	                                    {
	                                        // Left: Lab logo
	                                        image: '<%= lablogo != null ? "data:image/png;base64," + lablogo : "" %>',
	                                        width: 30,
	                                        height: 30,
	                                        alignment: 'left',
	                                        margin: [35, 10, 0, 20]
	                                    },
	                                    {
	                                        // Center: Text
	                                        text: 'Restricted',
	                                        alignment: 'center',
	                                        fontSize: 10,
	                                        bold: true,
	                                        margin: [0, 10, 0, 0]
	                                    },
	                                 {
	                                        // Right: DRDO logo
	                                        image: '<%= drdologo != null ? "data:image/png;base64," + drdologo : "" %>',
	                                        width: 30,
	                                        height: 30,
	                                        alignment: 'right',
	                                        margin: [0, 10, 20, 20]
	                                    }
	                                ]
	                            },
	                            
	                        ]
	                    };
	                },
	                background: function(currentPage) {
	                    return [
	                        {
	                            image: generateRotatedTextImage(leftSideNote),
	                            width: 100, // Adjust as necessary for your content
	                            absolutePosition: { x: -20, y: 40 }, // Position as needed
	                        }
	                    ];
	                },
	                info: {
	        	        title: 'Functional Requirement',  // Set document name here
	        	      
	        	    },
	                styles: {
	                	  DocumentName: { fontSize: 18, bold: true, margin: [0, 0, 0, 10] },
	                      chapterHeader: { fontSize: 16, bold: true, margin: [0, 0, 0, 10] },
	                      chapterNote: { fontSize: 13, bold: true, margin: [0, 10, 0, 10]},
	                      chapterSubHeader: { fontSize: 13, bold: true, margin: [10, 10, 0, 10]},
	                      tableHeader: { fontSize: 12, bold: true, fillColor: '#f0f0f0', alignment: 'center', margin: [10, 5, 10, 5], fontWeight: 'bold' },
	                      tableData: { fontSize: 11.5, margin: [0, 5, 0, 5] },
	                      chapterSubSubHeader: { fontSize: 12, bold: true, margin: [15, 10, 10, 10] },
	                      subChapterNote: { margin: [15, 15, 0, 10] },
	                      header: { alignment: 'center', bold: true},
	                }
	       };
	       pdfMake.createPdf(docDefinition).open();
	}
	function getOperationalRequirements(){
		   var chapterCount = 0;
	       var mainContentCount = 0;
	        var leftSideNote = '<%if(DocTempAtrr!=null && DocTempAtrr[12]!=null) {%><%=DocTempAtrr[12].toString().replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", "") %> <%} else{%>-<%}%>';
	   	<% List<Object[]> OperationalReqList = RequirementList!=null? RequirementList.stream()
		.filter(e->e[15]!=null&&e[14].toString().equalsIgnoreCase("6"))
		.sorted(Comparator.comparing(e -> Integer.parseInt(e[14].toString())))
		.collect(Collectors.toList()):new ArrayList<>()  ;%>
		
		<% if(OperationalReqList==null || OperationalReqList.size()==0){ %>
		
		alert("No Operational Requirements specified for this Project")
		event.preventDefault();
		return false;
			<%}%>
	       var docDefinition = {
	    		   content: [
	    		   {
	                    text: htmlToPdfmake('<h4 class="heading-color ">OPERATIONAL REQUIREMENTS <br><br> FOR  <br><br>PROJECT  </h4>'),
	                    style: 'DocumentName',
	                    alignment: 'center',
	                    fontSize: 18,
	                    margin: [0, 200, 0, 20],
	    		  	
	                },
	                <% if (lablogo != null) { %>
	                {
	                    image: 'data:image/png;base64,<%= lablogo %>',
	                    width: 95,
	                    height: 95,
	                    alignment: 'center',
	                    margin: [0, 20, 0, 30]
	                },
	                <% } %>
	                
	                {
	                    text: htmlToPdfmake('<h5><% if (LabList != null && LabList[1] != null) { %> <%= LabList[1].toString().replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", "") + "(" + LabList[0].toString().replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", "") + ")" %> <% } else { %> '-' <% } %></h5>'),
	                    alignment: 'center',
	                    fontSize: 16,
	                    bold: true,
	                    margin: [0, 20, 0, 20]
	                },
	                {
	                    text: htmlToPdfmake('<h6>Government of India, Ministry of Defence<br>Defence Research & Development Organization </h6>'),
	                    alignment: 'center',
	                    fontSize: 14,
	                    bold: true,
	                    margin: [0, 10, 0, 10]
	                },
	                {
	                    text: htmlToPdfmake('<h6><%if(LabList!=null && LabList[2]!=null && LabList[3]!=null && LabList[5]!=null){ %><%=LabList[2]+" , "+LabList[3].toString()+", PIN-"+LabList[5].toString() %><%}else{ %>-<%} %></h6>'),
	                    alignment: 'center',
	                    fontSize: 14,
	                    bold: true,
	                    margin: [0, 10, 0, 10],
	                    pageBreak: 'after',
	                },
	                {
	                    toc: {
	                        title: { text: 'INDEX', style: 'header'}
	                    }
	                },
					<%if(RequirementList!=null && !RequirementList.isEmpty()) {
	   				
	   				%>
	   			   {
	                    text: 'Operational Requirements',
	                    style: 'chapterHeader',
	                    pageBreak: 'before'
	                },
					
	    			
	    				<%
	    				String ReqName="";
	    				int subReqCount=0;
	    				for(Object[]obj1:OperationalReqList) {
	    					int snCount=0;
	    				%>
	    				<%if(obj1[1]!=null) {%>
						{
		                	text: '<%if(obj1[1]!=null){ %><%=++subReqCount %> .  <%=obj1[1].toString().replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", "") %> <%}else{ %>-<%} %>',	
		                    margin: [5, 5, 5, 5],
		                    tocItem: true,
		                },

					<%} %>

	    					{
	    	                    table: {
	    	                        headerRows: 1,
	    	                        widths: ['20%', '30%', '50%'],
	    	                        body: [
	    	                            // Table header
	    	                            [
	    	                                { text: 'SN', style: 'tableHeader' },
	    	                                { text: 'Attribute', style: 'tableHeader' },
	    	                                { text: 'Content', style: 'tableHeader' },
	    	                            ],
	    	                            // Populate table rows

	    	                            [
	    	                                { text: '<%= ++snCount %>', style: 'tableData',alignment: 'center' },
	    	                                { text: 'ID', style: 'tableData' },
	    	                                { text: '<%=obj1[1] %>', style: 'tableData' },
	    	                            ],

	    	                            [
	    	                                { text: '<%= ++snCount %>', style: 'tableData',alignment: 'center' },
	    	                                { text: 'QR Para', style: 'tableData' },
	    	                                { text: '<%if(obj1[12]!=null) { String [] a=obj1[12].toString().split(", "); for(String s:a){ %> <%=ProjectParaDetails.stream().filter(e->e[0].toString().equalsIgnoreCase(s)).map(e->e[3].toString()).collect(Collectors.joining("")) %> \n <%}}else{ %> - <%} %>', style: 'tableData' },
	    	                            ],
	    	                            
	    	                            [
	    	                                { text: '<%= ++snCount %>', style: 'tableData',alignment: 'center' },
	    	                                { text: 'Priority', style: 'tableData' },
	    	                                { text: '<%if(obj1[5]!=null) {%> <%=obj1[5] %> <%}else{%>-<%} %>', style: 'tableData' },
	    	                            ],
	    	                            
	    	                            [
	    	                                { text: '<%= ++snCount %>', style: 'tableData',alignment: 'center' },
	    	                                { text: 'Criticality', style: 'tableData' },
	    	                                { text: '<%if(obj1[21]!=null) {%> <%=obj1[21] %> <%}else{%>-<%} %>', style: 'tableData' },
	    	                            ],
	    	                            
	    	                            [
	    	                                { text: '<%= ++snCount %>', style: 'tableData',alignment: 'center' },
	    	                                { text: 'Type', style: 'tableData' },
	    	                                { text: '<%if(obj1[6]!=null) {%> <%if(obj1[6].toString().equalsIgnoreCase("D")) {%>Desirable<%} %> <%if(obj1[6].toString().equalsIgnoreCase("E")) {%>Essential<%} %> <%}else {%>-<%} %>', style: 'tableData' },
	    	                            ],

	    	                            <%-- [
	    	                                { text: htmlToPdfmake(setImagesWidth(document.getElementById('description<%=mainReqCount+"."+subReqCount %>').innerHTML, 500)), colSpan: 3 },
	    	                            ], --%>
	    	                            
	    	                           	[
	    	                                { stack: [htmlToPdfmake(setImagesWidth('<%=++snCount %>.Description: <%if(obj1[4]!=null){ %> <%=obj1[4].toString().replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", "") %> <%}else{ %>-<%} %>', 500))], colSpan: 3 }
	    	                            ],
	    	                            
	    	                            [
	    	                                { text: '<%= ++snCount %>', style: 'tableData',alignment: 'center' },
	    	                                { text: 'Remarks', style: 'tableData' },
	    	                                { text: '<%if(obj1[7]!=null) {%> <%=obj1[7] %> <%}else{%>-<%} %>', style: 'tableData' },
	    	                            ],

	    	                            [
	    	                                { text: '<%= ++snCount %>', style: 'tableData',alignment: 'center' },
	    	                                { text: 'Constraints', style: 'tableData' },
	    	                                { text: '<%if(obj1[9]!=null) {%> <%=obj1[9] %> <%}else{%>-<%} %>', style: 'tableData' },
	    	                            ],

	    	                           [
	    	                                { text: '<%= ++snCount %>', style: 'tableData',alignment: 'center' },
	    	                                { text: 'Demonstration', style: 'tableData' },
	    	                                { text: htmlToPdfmake('<% if(obj1[16] != null) { %>'
	    	                                	    + '<% List<Object[]> DemonList = VerificationMethodList.stream().filter(e -> e[1].toString().equalsIgnoreCase("1")).collect(Collectors.toList()); %>'
	    	                                	    + '<% String[] a = obj1[16].toString().split(", "); %>'
	    	                                	    + '<% for (int i = 0; i < a.length; i++) { %>'
	    	                                	    + '<%= a[i] %> . <%= DemonList.get(Integer.parseInt(a[i].substring(1)) - 1)[3].toString() %><br>'
	    	                                	    + '<% } %>'
	    	                                	    + '<% } else { %>-<% } %>'), style: 'tableData' },
	    	                            ],

	    	                            [
	    	                                { text: '<%= ++snCount %>', style: 'tableData',alignment: 'center' },
	    	                                { text: 'Test Type', style: 'tableData' },
	    	                                { text: htmlToPdfmake('<%if(obj1[17]!=null) { %>'
	    	                                		+ '<% List<Object[]>TestList1=VerificationMethodList.stream().filter(e->e[1].toString().equalsIgnoreCase("2")).collect(Collectors.toList()); %>'
	    	                                		+ '<%String [] a=obj1[17].toString().split(", "); %>'
	    	                                		+ '<%for(int i=0;i<a.length;i++){ %>'
	    												
	    	                                		 + '<%=	a[i] +" . "+ TestList1.get(Integer.parseInt(a[i].substring(1))-1)[3].toString() %><br>'
	    	                                		+ '<%} %>'
	    	                                		+ '<%}else{%>-<%} %>'), style: 'tableData' },
	    	                            ],
	    	                            [
	    	                                { text: '<%= ++snCount %>', style: 'tableData',alignment: 'center' },
	    	                                { text: 'Test Stage', style: 'tableData' },
	    	                                { text: '<%if(obj1[24]!=null) {%> <%=obj1[24] %> <%}else{%>-<%} %>', style: 'tableData' },
	    	                            ],
	    	                            [
	    	                                { text: '<%= ++snCount %>', style: 'tableData',alignment: 'center' },
	    	                                { text: 'Design/Analysis', style: 'tableData' },
	    	                                { text: htmlToPdfmake('<%if(obj1[18]!=null) { %>'
	    	                                		+ '<% List<Object[]>AnalysisList=VerificationMethodList.stream().filter(e->e[1].toString().equalsIgnoreCase("3")).collect(Collectors.toList()); %>'
	    	                                		+ '<% String [] a=obj1[18].toString().split(", "); %>'
	    	                                		+ '<% for(int i=0;i<a.length;i++){ %>'
	    												
	    	                                			+ '<%=	a[i] +" . "+ AnalysisList.get(Integer.parseInt(a[i].substring(1))-1)[3].toString() %><br>'
	    	                                		+ '<%} %>'
	    											+ '<%}else{%>-<%} %>'), style: 'tableData' },
	    	                            ],

	    	                            [
	    	                                { text: '<%= ++snCount %>', style: 'tableData',alignment: 'center' },
	    	                                { text: 'Inspection', style: 'tableData' },
	    	                                { text: htmlToPdfmake('<%if(obj1[19]!=null) { %>'
	    	                                		+ '<% List<Object[]>InspectionList1=VerificationMethodList.stream().filter(e->e[1].toString().equalsIgnoreCase("4")).collect(Collectors.toList()); %>'
	    	                                		+ '<% String [] a=obj1[19].toString().split(", "); %>'
	    	                                		+ '<% for(int i=0;i<a.length;i++){ %>'
	    												
	    	                                		+ '<%=	a[i] +" . "+ InspectionList1.get(Integer.parseInt(a[i].substring(1))-1)[3].toString() %><br>'
	    	                                		+ '<%} %>'
	    	                                		+ '<%}else{%>-<%} %>'), style: 'tableData' },
	    	                            ],

	    	                            [
	    	                                { text: '<%= ++snCount %>', style: 'tableData',alignment: 'center' },
	    	                                { text: 'Special Methods', style: 'tableData' },
	    	                                { text: htmlToPdfmake('<%if(obj1[20]!=null) { %>'
	    	                                		+ '<% List<Object[]>specialList=VerificationMethodList.stream().filter(e->e[1].toString().equalsIgnoreCase("5")).collect(Collectors.toList()); %>'
	    	                                		+ '<% String [] a=obj1[20].toString().split(", "); %>'
	    	                                		+ '<% for(int i=0;i<a.length;i++){ %>'
	    												
	    	                                		+ '<%=	a[i] +" . "+ specialList.get(Integer.parseInt(a[i].substring(1))-1)[3].toString() %><br>'
	    	                                		+ '<%} %>'
	    	                                		+ '<%}else{%>-<%} %>'), style: 'tableData' },
	    	                            ],
	    	                            
	    	                       <%--      [
	    	                                { text: '<%= ++snCount %>', style: 'tableData',alignment: 'center' },
	    	                                { text: 'Link Sub-Systems', style: 'tableData' },
	    	                                { text: '<%if(obj1[23]!=null) { String [] a=obj1[23].toString().split(", "); for(String s:a){ %> <%=productTreeList.stream().filter(e->e[0].toString().equalsIgnoreCase(s)).map(e->e[2].toString()).collect(Collectors.joining("")) %> \n <%}}else{ %> - <%} %>', style: 'tableData' },
	    	                            ], --%>
	    	                            
	    	                            

	    	                        ]
	    	                    },
	    	                    layout: {

	    	                        hLineWidth: function(i, node) {
	    	                            return (i === 0 || i === node.table.body.length) ? 1 : 0.5;
	    	                        },
	    	                        vLineWidth: function(i) {
	    	                            return 0.5;
	    	                        },
	    	                        hLineColor: function(i) {
	    	                            return '#aaaaaa';
	    	                        },
	    	                        vLineColor: function(i) {
	    	                            return '#aaaaaa';
	    	                        }
	    	                    }
	    	                },
	    	                { text: '\n',},
	    				
	    				<%}%>
	    	
	    			
	    	
	    				<% } %>
	                
	                
	                ],
	                background: function(currentPage) {
	                    return [
	                        {
	                            image: generateRotatedTextImage(leftSideNote),
	                            width: 100, // Adjust as necessary for your content
	                            absolutePosition: { x: -20, y: 40 }, // Position as needed
	                        }
	                    ];
	                },
	                footer: function(currentPage, pageCount) {
	                    if (currentPage > 2) {
	                        return {
	                            stack: [
	                            	{
	                                    canvas: [{ type: 'line', x1: 30, y1: 0, x2: 565, y2: 0, lineWidth: 1 }]
	                                },
	                                {
	                                    columns: [
	                                       
	                                        { text: currentPage.toString() + ' of ' + pageCount, alignment: 'right', margin: [0, 0, 30, 0], fontSize: 8 }
	                                    ]
	                                },
	                                { text: 'Restricted', alignment: 'center', fontSize: 8, margin: [0, 5, 0, 0], bold: true }
	                            ]
	                        };
	                    }
	                    return '';
	                },
	                header: function (currentPage) {
	                    return {
	                        stack: [
	                            
	                            {
	                                columns: [
	                                    {
	                                        // Left: Lab logo
	                                        image: '<%= lablogo != null ? "data:image/png;base64," + lablogo : "" %>',
	                                        width: 30,
	                                        height: 30,
	                                        alignment: 'left',
	                                        margin: [35, 10, 0, 20]
	                                    },
	                                    {
	                                        // Center: Text
	                                        text: 'Restricted',
	                                        alignment: 'center',
	                                        fontSize: 10,
	                                        bold: true,
	                                        margin: [0, 10, 0, 0]
	                                    },
	                                 {
	                                        // Right: DRDO logo
	                                        image: '<%= drdologo != null ? "data:image/png;base64," + drdologo : "" %>',
	                                        width: 30,
	                                        height: 30,
	                                        alignment: 'right',
	                                        margin: [0, 10, 20, 20]
	                                    }
	                                ]
	                            },
	                            
	                        ]
	                    };
	                },
	                
	                styles: {
	                	  DocumentName: { fontSize: 18, bold: true, margin: [0, 0, 0, 10] },
	                      chapterHeader: { fontSize: 16, bold: true, margin: [0, 0, 0, 10] },
	                      chapterNote: { fontSize: 13, bold: true, margin: [0, 10, 0, 10]},
	                      chapterSubHeader: { fontSize: 13, bold: true, margin: [10, 10, 0, 10]},
	                      tableHeader: { fontSize: 12, bold: true, fillColor: '#f0f0f0', alignment: 'center', margin: [10, 5, 10, 5], fontWeight: 'bold' },
	                      tableData: { fontSize: 11.5, margin: [0, 5, 0, 5] },
	                      chapterSubSubHeader: { fontSize: 12, bold: true, margin: [15, 10, 10, 10] },
	                      subChapterNote: { margin: [15, 15, 0, 10] },
	                      header: { alignment: 'center', bold: true},
	                }
	       };
	       pdfMake.createPdf(docDefinition).open();
	}

	function getPerformanceRequirements(){
		   var chapterCount = 0;
	       var mainContentCount = 0;
	        var leftSideNote = '<%if(DocTempAtrr!=null && DocTempAtrr[12]!=null) {%><%=DocTempAtrr[12].toString().replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", "") %> <%} else{%>-<%}%>';
	   	<% List<Object[]> PerformanceList =RequirementList!=null?  RequirementList.stream()
		.filter(e->e[15]!=null&&e[14].toString().equalsIgnoreCase("4"))
		.sorted(Comparator.comparing(e -> Integer.parseInt(e[14].toString())))
		.collect(Collectors.toList()): new ArrayList<>();%>
		
		<% if(subMainReqList==null || subMainReqList.size()==0){ %>
		console.log(<%=subMainReqList.size()%>)
		alert("No Performance Requirements specified for this Project")
		event.preventDefault();
		return false;
			<%}%>
	       var docDefinition = {
	    		   content: [
	    		   {
	                    text: htmlToPdfmake('<h4 class="heading-color ">PERFORMANCE REQUIREMENTS <br><br> FOR  <br><br>PROJECT  </h4>'),
	                    style: 'DocumentName',
	                    alignment: 'center',
	                    fontSize: 18,
	                    margin: [0, 200, 0, 20],
	                    
	    		  	
	                },
	                <% if (lablogo != null) { %>
	                {
	                    image: 'data:image/png;base64,<%= lablogo %>',
	                    width: 95,
	                    height: 95,
	                    alignment: 'center',
	                    margin: [0, 20, 0, 30]
	                },
	                <% } %>
	                
	                {
	                    text: htmlToPdfmake('<h5><% if (LabList != null && LabList[1] != null) { %> <%= LabList[1].toString().replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", "") + "(" + LabList[0].toString().replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", "") + ")" %> <% } else { %> '-' <% } %></h5>'),
	                    alignment: 'center',
	                    fontSize: 16,
	                    bold: true,
	                    margin: [0, 20, 0, 20]
	                },
	                {
	                    text: htmlToPdfmake('<h6>Government of India, Ministry of Defence<br>Defence Research & Development Organization </h6>'),
	                    alignment: 'center',
	                    fontSize: 14,
	                    bold: true,
	                    margin: [0, 10, 0, 10]
	                },
	                {
	                    text: htmlToPdfmake('<h6><%if(LabList!=null && LabList[2]!=null && LabList[3]!=null && LabList[5]!=null){ %><%=LabList[2]+" , "+LabList[3].toString()+", PIN-"+LabList[5].toString() %><%}else{ %>-<%} %></h6>'),
	                    alignment: 'center',
	                    fontSize: 14,
	                    bold: true,
	                    margin: [0, 10, 0, 10],
	                    pageBreak: 'after',
	                },
	                {
	                    toc: {
	                        title: { text: 'INDEX', style: 'header'}
	                    }
	                },
					<%if(RequirementList!=null &&  !RequirementList.isEmpty()) {
	   				
	   				%>
	   			   {
	                    text: 'Performance Requirements',
	                    style: 'chapterHeader',
	                    pageBreak: 'before'
	                },
					
	    			
	    				<%
	    				String ReqName="";
	    				int subReqCount=0;
	    				for(Object[]obj1:PerformanceList) {
	    					int snCount=0;
	    				%>
	    				<%if(obj1[1]!=null) {%>
						{
		                	text: '<%if(obj1[1]!=null){ %><%=++subReqCount %> .  <%=obj1[1].toString().replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", "") %> <%}else{ %>-<%} %>',	
		                    margin: [5, 5, 5, 5],
		                    tocItem: true,
		                },

					<%} %>

	    					{
	    	                    table: {
	    	                        headerRows: 1,
	    	                        widths: ['20%', '30%', '50%'],
	    	                        body: [
	    	                            // Table header
	    	                            [
	    	                                { text: 'SN', style: 'tableHeader' },
	    	                                { text: 'Attribute', style: 'tableHeader' },
	    	                                { text: 'Content', style: 'tableHeader' },
	    	                            ],
	    	                            // Populate table rows

	    	                            [
	    	                                { text: '<%= ++snCount %>', style: 'tableData',alignment: 'center' },
	    	                                { text: 'ID', style: 'tableData' },
	    	                                { text: '<%=obj1[1] %>', style: 'tableData' },
	    	                            ],

	    	                            [
	    	                                { text: '<%= ++snCount %>', style: 'tableData',alignment: 'center' },
	    	                                { text: 'QR Para', style: 'tableData' },
	    	                                { text: '<%if(obj1[12]!=null) { String [] a=obj1[12].toString().split(", "); for(String s:a){ %> <%=ProjectParaDetails.stream().filter(e->e[0].toString().equalsIgnoreCase(s)).map(e->e[3].toString()).collect(Collectors.joining("")) %> \n <%}}else{ %> - <%} %>', style: 'tableData' },
	    	                            ],
	    	                            
	    	                            [
	    	                                { text: '<%= ++snCount %>', style: 'tableData',alignment: 'center' },
	    	                                { text: 'Priority', style: 'tableData' },
	    	                                { text: '<%if(obj1[5]!=null) {%> <%=obj1[5] %> <%}else{%>-<%} %>', style: 'tableData' },
	    	                            ],
	    	                            
	    	                            [
	    	                                { text: '<%= ++snCount %>', style: 'tableData',alignment: 'center' },
	    	                                { text: 'Criticality', style: 'tableData' },
	    	                                { text: '<%if(obj1[21]!=null) {%> <%=obj1[21] %> <%}else{%>-<%} %>', style: 'tableData' },
	    	                            ],
	    	                            
	    	                            [
	    	                                { text: '<%= ++snCount %>', style: 'tableData',alignment: 'center' },
	    	                                { text: 'Type', style: 'tableData' },
	    	                                { text: '<%if(obj1[6]!=null) {%> <%if(obj1[6].toString().equalsIgnoreCase("D")) {%>Desirable<%} %> <%if(obj1[6].toString().equalsIgnoreCase("E")) {%>Essential<%} %> <%}else {%>-<%} %>', style: 'tableData' },
	    	                            ],

	    	                            <%-- [
	    	                                { text: htmlToPdfmake(setImagesWidth(document.getElementById('description<%=mainReqCount+"."+subReqCount %>').innerHTML, 500)), colSpan: 3 },
	    	                            ], --%>
	    	                            
	    	                           	[
	    	                                { stack: [htmlToPdfmake(setImagesWidth('<%=++snCount %>.Description: <%if(obj1[4]!=null){ %> <%=obj1[4].toString().replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", "") %> <%}else{ %>-<%} %>', 500))], colSpan: 3 }
	    	                            ],
	    	                            
	    	                            [
	    	                                { text: '<%= ++snCount %>', style: 'tableData',alignment: 'center' },
	    	                                { text: 'Remarks', style: 'tableData' },
	    	                                { text: '<%if(obj1[7]!=null) {%> <%=obj1[7] %> <%}else{%>-<%} %>', style: 'tableData' },
	    	                            ],

	    	                            [
	    	                                { text: '<%= ++snCount %>', style: 'tableData',alignment: 'center' },
	    	                                { text: 'Constraints', style: 'tableData' },
	    	                                { text: '<%if(obj1[9]!=null) {%> <%=obj1[9] %> <%}else{%>-<%} %>', style: 'tableData' },
	    	                            ],

	    	                           [
	    	                                { text: '<%= ++snCount %>', style: 'tableData',alignment: 'center' },
	    	                                { text: 'Demonstration', style: 'tableData' },
	    	                                { text: htmlToPdfmake('<% if(obj1[16] != null) { %>'
	    	                                	    + '<% List<Object[]> DemonList = VerificationMethodList.stream().filter(e -> e[1].toString().equalsIgnoreCase("1")).collect(Collectors.toList()); %>'
	    	                                	    + '<% String[] a = obj1[16].toString().split(", "); %>'
	    	                                	    + '<% for (int i = 0; i < a.length; i++) { %>'
	    	                                	    + '<%= a[i] %> . <%= DemonList.get(Integer.parseInt(a[i].substring(1)) - 1)[3].toString() %><br>'
	    	                                	    + '<% } %>'
	    	                                	    + '<% } else { %>-<% } %>'), style: 'tableData' },
	    	                            ],

	    	                            [
	    	                                { text: '<%= ++snCount %>', style: 'tableData',alignment: 'center' },
	    	                                { text: 'Test Type', style: 'tableData' },
	    	                                { text: htmlToPdfmake('<%if(obj1[17]!=null) { %>'
	    	                                		+ '<% List<Object[]>TestList1=VerificationMethodList.stream().filter(e->e[1].toString().equalsIgnoreCase("2")).collect(Collectors.toList()); %>'
	    	                                		+ '<%String [] a=obj1[17].toString().split(", "); %>'
	    	                                		+ '<%for(int i=0;i<a.length;i++){ %>'
	    												
	    	                                		 + '<%=	a[i] +" . "+ TestList1.get(Integer.parseInt(a[i].substring(1))-1)[3].toString() %><br>'
	    	                                		+ '<%} %>'
	    	                                		+ '<%}else{%>-<%} %>'), style: 'tableData' },
	    	                            ],
	    	                            [
	    	                                { text: '<%= ++snCount %>', style: 'tableData',alignment: 'center' },
	    	                                { text: 'Test Stage', style: 'tableData' },
	    	                                { text: '<%if(obj1[24]!=null) {%> <%=obj1[24] %> <%}else{%>-<%} %>', style: 'tableData' },
	    	                            ],
	    	                            [
	    	                                { text: '<%= ++snCount %>', style: 'tableData',alignment: 'center' },
	    	                                { text: 'Design/Analysis', style: 'tableData' },
	    	                                { text: htmlToPdfmake('<%if(obj1[18]!=null) { %>'
	    	                                		+ '<% List<Object[]>AnalysisList=VerificationMethodList.stream().filter(e->e[1].toString().equalsIgnoreCase("3")).collect(Collectors.toList()); %>'
	    	                                		+ '<% String [] a=obj1[18].toString().split(", "); %>'
	    	                                		+ '<% for(int i=0;i<a.length;i++){ %>'
	    												
	    	                                			+ '<%=	a[i] +" . "+ AnalysisList.get(Integer.parseInt(a[i].substring(1))-1)[3].toString() %><br>'
	    	                                		+ '<%} %>'
	    											+ '<%}else{%>-<%} %>'), style: 'tableData' },
	    	                            ],

	    	                            [
	    	                                { text: '<%= ++snCount %>', style: 'tableData',alignment: 'center' },
	    	                                { text: 'Inspection', style: 'tableData' },
	    	                                { text: htmlToPdfmake('<%if(obj1[19]!=null) { %>'
	    	                                		+ '<% List<Object[]>InspectionList1=VerificationMethodList.stream().filter(e->e[1].toString().equalsIgnoreCase("4")).collect(Collectors.toList()); %>'
	    	                                		+ '<% String [] a=obj1[19].toString().split(", "); %>'
	    	                                		+ '<% for(int i=0;i<a.length;i++){ %>'
	    												
	    	                                		+ '<%=	a[i] +" . "+ InspectionList1.get(Integer.parseInt(a[i].substring(1))-1)[3].toString() %><br>'
	    	                                		+ '<%} %>'
	    	                                		+ '<%}else{%>-<%} %>'), style: 'tableData' },
	    	                            ],

	    	                            [
	    	                                { text: '<%= ++snCount %>', style: 'tableData',alignment: 'center' },
	    	                                { text: 'Special Methods', style: 'tableData' },
	    	                                { text: htmlToPdfmake('<%if(obj1[20]!=null) { %>'
	    	                                		+ '<% List<Object[]>specialList=VerificationMethodList.stream().filter(e->e[1].toString().equalsIgnoreCase("5")).collect(Collectors.toList()); %>'
	    	                                		+ '<% String [] a=obj1[20].toString().split(", "); %>'
	    	                                		+ '<% for(int i=0;i<a.length;i++){ %>'
	    												
	    	                                		+ '<%=	a[i] +" . "+ specialList.get(Integer.parseInt(a[i].substring(1))-1)[3].toString() %><br>'
	    	                                		+ '<%} %>'
	    	                                		+ '<%}else{%>-<%} %>'), style: 'tableData' },
	    	                            ],
	    	                            
	    	                        <%--     [
	    	                                { text: '<%= ++snCount %>', style: 'tableData',alignment: 'center' },
	    	                                { text: 'Link Sub-Systems', style: 'tableData' },
	    	                                { text: '<%if(obj1[23]!=null) { String [] a=obj1[23].toString().split(", "); for(String s:a){ %> <%=productTreeList.stream().filter(e->e[0].toString().equalsIgnoreCase(s)).map(e->e[2].toString()).collect(Collectors.joining("")) %> \n <%}}else{ %> - <%} %>', style: 'tableData' },
	    	                            ], --%>
	    	                            
	    	                            

	    	                        ]
	    	                    },
	    	                    layout: {

	    	                        hLineWidth: function(i, node) {
	    	                            return (i === 0 || i === node.table.body.length) ? 1 : 0.5;
	    	                        },
	    	                        vLineWidth: function(i) {
	    	                            return 0.5;
	    	                        },
	    	                        hLineColor: function(i) {
	    	                            return '#aaaaaa';
	    	                        },
	    	                        vLineColor: function(i) {
	    	                            return '#aaaaaa';
	    	                        }
	    	                    }
	    	                },
	    	                { text: '\n',},
	    				
	    				<%}%>
	    	
	    			
	    	
	    				<% } %>
	                
	                
	                ],
	                background: function(currentPage) {
	                    return [
	                        {
	                            image: generateRotatedTextImage(leftSideNote),
	                            width: 100, // Adjust as necessary for your content
	                            absolutePosition: { x: -20, y: 40 }, // Position as needed
	                        }
	                    ];
	                },
	                footer: function(currentPage, pageCount) {
	                    if (currentPage > 2) {
	                        return {
	                            stack: [
	                            	{
	                                    canvas: [{ type: 'line', x1: 30, y1: 0, x2: 565, y2: 0, lineWidth: 1 }]
	                                },
	                                {
	                                    columns: [
	                                       
	                                        { text: currentPage.toString() + ' of ' + pageCount, alignment: 'right', margin: [0, 0, 30, 0], fontSize: 8 }
	                                    ]
	                                },
	                                { text: 'Restricted', alignment: 'center', fontSize: 8, margin: [0, 5, 0, 0], bold: true }
	                            ]
	                        };
	                    }
	                    return '';
	                },
	                header: function (currentPage) {
	                    return {
	                        stack: [
	                            
	                            {
	                                columns: [
	                                    {
	                                        // Left: Lab logo
	                                        image: '<%= lablogo != null ? "data:image/png;base64," + lablogo : "" %>',
	                                        width: 30,
	                                        height: 30,
	                                        alignment: 'left',
	                                        margin: [35, 10, 0, 20]
	                                    },
	                                    {
	                                        // Center: Text
	                                        text: 'Restricted',
	                                        alignment: 'center',
	                                        fontSize: 10,
	                                        bold: true,
	                                        margin: [0, 10, 0, 0]
	                                    },
	                                 {
	                                        // Right: DRDO logo
	                                        image: '<%= drdologo != null ? "data:image/png;base64," + drdologo : "" %>',
	                                        width: 30,
	                                        height: 30,
	                                        alignment: 'right',
	                                        margin: [0, 10, 20, 20]
	                                    }
	                                ]
	                            },
	                            
	                        ]
	                    };
	                },
	                
	                styles: {
	                	  DocumentName: { fontSize: 18, bold: true, margin: [0, 0, 0, 10] },
	                      chapterHeader: { fontSize: 16, bold: true, margin: [0, 0, 0, 10] },
	                      chapterNote: { fontSize: 13, bold: true, margin: [0, 10, 0, 10]},
	                      chapterSubHeader: { fontSize: 13, bold: true, margin: [10, 10, 0, 10]},
	                      tableHeader: { fontSize: 12, bold: true, fillColor: '#f0f0f0', alignment: 'center', margin: [10, 5, 10, 5], fontWeight: 'bold' },
	                      tableData: { fontSize: 11.5, margin: [0, 5, 0, 5] },
	                      chapterSubSubHeader: { fontSize: 12, bold: true, margin: [15, 10, 10, 10] },
	                      subChapterNote: { margin: [15, 15, 0, 10] },
	                      header: { alignment: 'center', bold: true},
	                }
	       };
	       pdfMake.createPdf(docDefinition).open();
	}

	//subs sytemLinked Req
	
	function getSubSystemRequirements(){
		   var chapterCount = 0;
	       var mainContentCount = 0;
	        var leftSideNote = '<%if(DocTempAtrr!=null && DocTempAtrr[12]!=null) {%><%=DocTempAtrr[12].toString().replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", "") %> <%} else{%>-<%}%>';
	   	<% List<Object[]> ReqSubSystemList = RequirementList!=null? RequirementList.stream()
		.filter(e->e[23]!=null&& Arrays.asList(e[23].toString().split(", ")).contains(productTreeMainId))
		.sorted(Comparator.comparing(e -> Integer.parseInt(e[14].toString())))
		.collect(Collectors.toList()):new ArrayList<>()  ;%>
		
		<% if(ReqSubSystemList==null || ReqSubSystemList.size()==0){ %>
		
		alert("This subsystem do not Linked with any System Requirements for this Project")
		event.preventDefault();
		return false;
			<%}%>
	       var docDefinition = {
	    		   content: [
	    		   {
	                    text: htmlToPdfmake('<h4 class="heading-color ">SYSTEM LINKED REQUIREMENTS <br><br> FOR  <br><br>SUB-SYTEM<br><br> <%=subsystem%> </h4>'),
	                    style: 'DocumentName',
	                    alignment: 'center',
	                    fontSize: 18,
	                    margin: [0, 200, 0, 20],
	                },
	                <% if (lablogo != null) { %>
	                {
	                    image: 'data:image/png;base64,<%= lablogo %>',
	                    width: 95,
	                    height: 95,
	                    alignment: 'center',
	                    margin: [0, 20, 0, 30]
	                },
	                <% } %>
	                
	                {
	                    text: htmlToPdfmake('<h5><% if (LabList != null && LabList[1] != null) { %> <%= LabList[1].toString().replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", "") + "(" + LabList[0].toString().replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", "") + ")" %> <% } else { %> '-' <% } %></h5>'),
	                    alignment: 'center',
	                    fontSize: 16,
	                    bold: true,
	                    margin: [0, 20, 0, 20]
	                },
	                {
	                    text: htmlToPdfmake('<h6>Government of India, Ministry of Defence<br>Defence Research & Development Organization </h6>'),
	                    alignment: 'center',
	                    fontSize: 14,
	                    bold: true,
	                    margin: [0, 10, 0, 10]
	                },
	                {
	                    text: htmlToPdfmake('<h6><%if(LabList!=null && LabList[2]!=null && LabList[3]!=null && LabList[5]!=null){ %><%=LabList[2]+" , "+LabList[3].toString()+", PIN-"+LabList[5].toString() %><%}else{ %>-<%} %></h6>'),
	                    alignment: 'center',
	                    fontSize: 14,
	                    bold: true,
	                    margin: [0, 10, 0, 10],
	                    pageBreak: 'after',
	                },
	                {
	                    toc: {
	                        title: { text: 'INDEX', style: 'header'}
	                    }
	                },
					<%if(ReqSubSystemList!=null && !ReqSubSystemList.isEmpty()) {
	   				
	   				%>
	   			   {
	                    text: 'System Linked Requirements',
	                    style: 'chapterHeader',
	                    pageBreak: 'before'
	                },
					
	    			
	    				<%
	    				String ReqName="";
	    				int subReqCount=0;
	    				for(Object[]obj1:ReqSubSystemList) {
	    					int snCount=0;
	    				%>
	    				<%if(obj1[1]!=null) {%>
						{
		                	text: '<%if(obj1[1]!=null){ %><%=++subReqCount %> .  <%=obj1[1].toString().replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", "") %> <%}else{ %>-<%} %>',	
		                    margin: [5, 5, 5, 5],
		                    tocItem: true,
		                },

					<%} %>

	    					{
	    	                    table: {
	    	                        headerRows: 1,
	    	                        widths: ['20%', '30%', '50%'],
	    	                        body: [
	    	                            // Table header
	    	                            [
	    	                                { text: 'SN', style: 'tableHeader' },
	    	                                { text: 'Attribute', style: 'tableHeader' },
	    	                                { text: 'Content', style: 'tableHeader' },
	    	                            ],
	    	                            // Populate table rows

	    	                            [
	    	                                { text: '<%= ++snCount %>', style: 'tableData',alignment: 'center' },
	    	                                { text: 'ID', style: 'tableData' },
	    	                                { text: '<%=obj1[1] %>', style: 'tableData' },
	    	                            ],

	    	                            [
	    	                                { text: '<%= ++snCount %>', style: 'tableData',alignment: 'center' },
	    	                                { text: 'QR Para', style: 'tableData' },
	    	                                { text: '<%if(obj1[12]!=null) { String [] a=obj1[12].toString().split(", "); for(String s:a){ %> <%=ProjectParaDetails.stream().filter(e->e[0].toString().equalsIgnoreCase(s)).map(e->e[3].toString()).collect(Collectors.joining("")) %> \n <%}}else{ %> - <%} %>', style: 'tableData' },
	    	                            ],
	    	                            
	    	                            [
	    	                                { text: '<%= ++snCount %>', style: 'tableData',alignment: 'center' },
	    	                                { text: 'Priority', style: 'tableData' },
	    	                                { text: '<%if(obj1[5]!=null) {%> <%=obj1[5] %> <%}else{%>-<%} %>', style: 'tableData' },
	    	                            ],
	    	                            
	    	                            [
	    	                                { text: '<%= ++snCount %>', style: 'tableData',alignment: 'center' },
	    	                                { text: 'Criticality', style: 'tableData' },
	    	                                { text: '<%if(obj1[21]!=null) {%> <%=obj1[21] %> <%}else{%>-<%} %>', style: 'tableData' },
	    	                            ],
	    	                            
	    	                            [
	    	                                { text: '<%= ++snCount %>', style: 'tableData',alignment: 'center' },
	    	                                { text: 'Type', style: 'tableData' },
	    	                                { text: '<%if(obj1[6]!=null) {%> <%if(obj1[6].toString().equalsIgnoreCase("D")) {%>Desirable<%} %> <%if(obj1[6].toString().equalsIgnoreCase("E")) {%>Essential<%} %> <%}else {%>-<%} %>', style: 'tableData' },
	    	                            ],

	    	                            <%-- [
	    	                                { text: htmlToPdfmake(setImagesWidth(document.getElementById('description<%=mainReqCount+"."+subReqCount %>').innerHTML, 500)), colSpan: 3 },
	    	                            ], --%>
	    	                            
	    	                           	[
	    	                                { stack: [htmlToPdfmake(setImagesWidth('<%=++snCount %>.Description: <%if(obj1[4]!=null){ %> <%=obj1[4].toString().replaceAll("'", "\\\\'").replaceAll("\"", "\\\\\"").replaceAll("\n", "<br>").replaceAll("\r", "") %> <%}else{ %>-<%} %>', 500))], colSpan: 3 }
	    	                            ],
	    	                            
	    	                            [
	    	                                { text: '<%= ++snCount %>', style: 'tableData',alignment: 'center' },
	    	                                { text: 'Remarks', style: 'tableData' },
	    	                                { text: '<%if(obj1[7]!=null) {%> <%=obj1[7] %> <%}else{%>-<%} %>', style: 'tableData' },
	    	                            ],

	    	                            [
	    	                                { text: '<%= ++snCount %>', style: 'tableData',alignment: 'center' },
	    	                                { text: 'Constraints', style: 'tableData' },
	    	                                { text: '<%if(obj1[9]!=null) {%> <%=obj1[9] %> <%}else{%>-<%} %>', style: 'tableData' },
	    	                            ],

	    	                           [
	    	                                { text: '<%= ++snCount %>', style: 'tableData',alignment: 'center' },
	    	                                { text: 'Demonstration', style: 'tableData' },
	    	                                { text: htmlToPdfmake('<% if(obj1[16] != null) { %>'
	    	                                	    + '<% List<Object[]> DemonList = VerificationMethodList.stream().filter(e -> e[1].toString().equalsIgnoreCase("1")).collect(Collectors.toList()); %>'
	    	                                	    + '<% String[] a = obj1[16].toString().split(", "); %>'
	    	                                	    + '<% for (int i = 0; i < a.length; i++) { %>'
	    	                                	    + '<%= a[i] %> . <%= DemonList.get(Integer.parseInt(a[i].substring(1)) - 1)[3].toString() %><br>'
	    	                                	    + '<% } %>'
	    	                                	    + '<% } else { %>-<% } %>'), style: 'tableData' },
	    	                            ],

	    	                            [
	    	                                { text: '<%= ++snCount %>', style: 'tableData',alignment: 'center' },
	    	                                { text: 'Test Type', style: 'tableData' },
	    	                                { text: htmlToPdfmake('<%if(obj1[17]!=null) { %>'
	    	                                		+ '<% List<Object[]>TestList1=VerificationMethodList.stream().filter(e->e[1].toString().equalsIgnoreCase("2")).collect(Collectors.toList()); %>'
	    	                                		+ '<%String [] a=obj1[17].toString().split(", "); %>'
	    	                                		+ '<%for(int i=0;i<a.length;i++){ %>'
	    												
	    	                                		 + '<%=	a[i] +" . "+ TestList1.get(Integer.parseInt(a[i].substring(1))-1)[3].toString() %><br>'
	    	                                		+ '<%} %>'
	    	                                		+ '<%}else{%>-<%} %>'), style: 'tableData' },
	    	                            ],
	    	                            [
	    	                                { text: '<%= ++snCount %>', style: 'tableData',alignment: 'center' },
	    	                                { text: 'Test Stage', style: 'tableData' },
	    	                                { text: '<%if(obj1[24]!=null) {%> <%=obj1[24] %> <%}else{%>-<%} %>', style: 'tableData' },
	    	                            ],
	    	                            [
	    	                                { text: '<%= ++snCount %>', style: 'tableData',alignment: 'center' },
	    	                                { text: 'Design/Analysis', style: 'tableData' },
	    	                                { text: htmlToPdfmake('<%if(obj1[18]!=null) { %>'
	    	                                		+ '<% List<Object[]>AnalysisList=VerificationMethodList.stream().filter(e->e[1].toString().equalsIgnoreCase("3")).collect(Collectors.toList()); %>'
	    	                                		+ '<% String [] a=obj1[18].toString().split(", "); %>'
	    	                                		+ '<% for(int i=0;i<a.length;i++){ %>'
	    												
	    	                                			+ '<%=	a[i] +" . "+ AnalysisList.get(Integer.parseInt(a[i].substring(1))-1)[3].toString() %><br>'
	    	                                		+ '<%} %>'
	    											+ '<%}else{%>-<%} %>'), style: 'tableData' },
	    	                            ],

	    	                            [
	    	                                { text: '<%= ++snCount %>', style: 'tableData',alignment: 'center' },
	    	                                { text: 'Inspection', style: 'tableData' },
	    	                                { text: htmlToPdfmake('<%if(obj1[19]!=null) { %>'
	    	                                		+ '<% List<Object[]>InspectionList1=VerificationMethodList.stream().filter(e->e[1].toString().equalsIgnoreCase("4")).collect(Collectors.toList()); %>'
	    	                                		+ '<% String [] a=obj1[19].toString().split(", "); %>'
	    	                                		+ '<% for(int i=0;i<a.length;i++){ %>'
	    												
	    	                                		+ '<%=	a[i] +" . "+ InspectionList1.get(Integer.parseInt(a[i].substring(1))-1)[3].toString() %><br>'
	    	                                		+ '<%} %>'
	    	                                		+ '<%}else{%>-<%} %>'), style: 'tableData' },
	    	                            ],

	    	                            [
	    	                                { text: '<%= ++snCount %>', style: 'tableData',alignment: 'center' },
	    	                                { text: 'Special Methods', style: 'tableData' },
	    	                                { text: htmlToPdfmake('<%if(obj1[20]!=null) { %>'
	    	                                		+ '<% List<Object[]>specialList=VerificationMethodList.stream().filter(e->e[1].toString().equalsIgnoreCase("5")).collect(Collectors.toList()); %>'
	    	                                		+ '<% String [] a=obj1[20].toString().split(", "); %>'
	    	                                		+ '<% for(int i=0;i<a.length;i++){ %>'
	    												
	    	                                		+ '<%=	a[i] +" . "+ specialList.get(Integer.parseInt(a[i].substring(1))-1)[3].toString() %><br>'
	    	                                		+ '<%} %>'
	    	                                		+ '<%}else{%>-<%} %>'), style: 'tableData' },
	    	                            ],
	    	                            
	    	                        <%--     [
	    	                                { text: '<%= ++snCount %>', style: 'tableData',alignment: 'center' },
	    	                                { text: 'Link Sub-Systems', style: 'tableData' },
	    	                                { text: '<%if(obj1[23]!=null) { String [] a=obj1[23].toString().split(", "); for(String s:a){ %> <%=productTreeList.stream().filter(e->e[0].toString().equalsIgnoreCase(s)).map(e->e[2].toString()).collect(Collectors.joining("")) %> \n <%}}else{ %> - <%} %>', style: 'tableData' },
	    	                            ], --%>
	    	                            
	    	                            

	    	                        ]
	    	                    },
	    	                    layout: {

	    	                        hLineWidth: function(i, node) {
	    	                            return (i === 0 || i === node.table.body.length) ? 1 : 0.5;
	    	                        },
	    	                        vLineWidth: function(i) {
	    	                            return 0.5;
	    	                        },
	    	                        hLineColor: function(i) {
	    	                            return '#aaaaaa';
	    	                        },
	    	                        vLineColor: function(i) {
	    	                            return '#aaaaaa';
	    	                        }
	    	                    }
	    	                },
	    	                { text: '\n',},
	    				
	    				<%}%>
	    	
	    			
	    	
	    				<% } %>
	                
	                
	                ],
	                background: function(currentPage) {
	                    return [
	                        {
	                            image: generateRotatedTextImage(leftSideNote),
	                            width: 100, // Adjust as necessary for your content
	                            absolutePosition: { x: -20, y: 40 }, // Position as needed
	                        }
	                    ];
	                },
	                footer: function(currentPage, pageCount) {
	                    if (currentPage > 2) {
	                        return {
	                            stack: [
	                            	{
	                                    canvas: [{ type: 'line', x1: 30, y1: 0, x2: 565, y2: 0, lineWidth: 1 }]
	                                },
	                                {
	                                    columns: [
	                                       
	                                        { text: currentPage.toString() + ' of ' + pageCount, alignment: 'right', margin: [0, 0, 30, 0], fontSize: 8 }
	                                    ]
	                                },
	                                { text: 'Restricted', alignment: 'center', fontSize: 8, margin: [0, 5, 0, 0], bold: true }
	                            ]
	                        };
	                    }
	                    return '';
	                },
	                header: function (currentPage) {
	                    return {
	                        stack: [
	                            
	                            {
	                                columns: [
	                                    {
	                                        // Left: Lab logo
	                                        image: '<%= lablogo != null ? "data:image/png;base64," + lablogo : "" %>',
	                                        width: 30,
	                                        height: 30,
	                                        alignment: 'left',
	                                        margin: [35, 10, 0, 20]
	                                    },
	                                    {
	                                        // Center: Text
	                                        text: 'Restricted',
	                                        alignment: 'center',
	                                        fontSize: 10,
	                                        bold: true,
	                                        margin: [0, 10, 0, 0]
	                                    },
	                                 {
	                                        // Right: DRDO logo
	                                        image: '<%= drdologo != null ? "data:image/png;base64," + drdologo : "" %>',
	                                        width: 30,
	                                        height: 30,
	                                        alignment: 'right',
	                                        margin: [0, 10, 20, 20]
	                                    }
	                                ]
	                            },
	                            
	                        ]
	                    };
	                },
	                info: {
	        	        title: 'Linked Requirements',  // Set document name here
	        	      
	        	    },
	                styles: {
	                	  DocumentName: { fontSize: 18, bold: true, margin: [0, 0, 0, 10] },
	                      chapterHeader: { fontSize: 16, bold: true, margin: [0, 0, 0, 10] },
	                      chapterNote: { fontSize: 13, bold: true, margin: [0, 10, 0, 10]},
	                      chapterSubHeader: { fontSize: 13, bold: true, margin: [10, 10, 0, 10]},
	                      tableHeader: { fontSize: 12, bold: true, fillColor: '#f0f0f0', alignment: 'center', margin: [10, 5, 10, 5], fontWeight: 'bold' },
	                      tableData: { fontSize: 11.5, margin: [0, 5, 0, 5] },
	                      chapterSubSubHeader: { fontSize: 12, bold: true, margin: [15, 10, 10, 10] },
	                      subChapterNote: { margin: [15, 15, 0, 10] },
	                      header: { alignment: 'center', bold: true},
	                }
	       };
	       pdfMake.createPdf(docDefinition).open();
	}

	
	/* get Requirements for sub sytem  */
	
	const setImagesWidth = (htmlString, width) => {
	    const container = document.createElement('div');
	    container.innerHTML = htmlString;
	  
	    const images = container.querySelectorAll('img');
	    images.forEach(img => {
	      img.style.width = width + 'px';
	      img.style.textAlign = 'center';
	    });
	  
	    const textElements = container.querySelectorAll('p, h1, h2, h3, h4, h5, h6, span, div, td, th, table, figure, hr, ul, li');
	    textElements.forEach(element => {
	      if (element.style) {
	        element.style.fontFamily = '';
	        element.style.margin = '';
	        element.style.marginTop = '';
	        element.style.marginRight = '';
	        element.style.marginBottom = '';
	        element.style.marginLeft = '';
	        element.style.lineHeight = '';
	        element.style.height = '';
	        element.style.width = '';
	        element.style.padding = '';
	        element.style.paddingTop = '';
	        element.style.paddingRight = '';
	        element.style.paddingBottom = '';
	        element.style.paddingLeft = '';
	        element.style.fontSize = '';
	        element.id = '';
	      }
	    });
	  
	    const tables = container.querySelectorAll('table');
	    tables.forEach(table => {
	      if (table.style) {
	        table.style.borderCollapse = 'collapse';
	        table.style.width = '100%';
	      }
	  
	      const cells = table.querySelectorAll('th, td');
	      cells.forEach(cell => {
	        if (cell.style) {
	          cell.style.border = '1px solid black';
	  
	          if (cell.tagName.toLowerCase() === 'th') {
	            cell.style.textAlign = 'center';
	          }
	        }
	      });
	    });
	  
	    return container.innerHTML;
	}; 
	  
	  function splitTextIntoLines(text, maxLength) {
		  const lines = [];
		  let currentLine = '';

		  for (const word of text.split(' ')) {
		    if ((currentLine + word).length > maxLength) {
		      lines.push(currentLine.trim());
		      currentLine = word + ' ';
		    } else {
		      currentLine += word + ' ';
		    }
		  }
		  lines.push(currentLine.trim());
		  return lines;
		}

		// Generate rotated text image with line-wrapped text
		function generateRotatedTextImage(text) {
		  const maxLength = 260;
		  const lines = splitTextIntoLines(text, maxLength);

		  const canvas = document.createElement('canvas');
		  const ctx = canvas.getContext('2d');

		  // Set canvas dimensions based on anticipated text size and rotation
		  canvas.width = 200;
		  canvas.height = 1560;

		  // Set text styling
		  ctx.font = '14px Roboto';
		  ctx.fillStyle = 'rgba(128, 128, 128, 1)'; // Gray color for watermark

		  // Position and rotate canvas
		  ctx.translate(80, 1480); // Adjust position as needed
		  ctx.rotate(-Math.PI / 2); // Rotate 270 degrees

		  // Draw each line with a fixed vertical gap
		  const lineHeight = 20; // Adjust line height if needed
		  lines.forEach((line, index) => {
		    ctx.fillText(line, 0, index * lineHeight); // Position each line below the previous
		  });

		  return canvas.toDataURL();
		}
	
</script>
</body>
</html>