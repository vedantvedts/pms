package com.vts.pfms.utils;

import java.io.File;

import org.springframework.stereotype.Component;

import com.itextpdf.io.font.constants.StandardFonts;
import com.itextpdf.kernel.font.PdfFont;
import com.itextpdf.kernel.font.PdfFontFactory;
import com.itextpdf.kernel.geom.Rectangle;
import com.itextpdf.kernel.pdf.EncryptionConstants;
import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfPage;
import com.itextpdf.kernel.pdf.PdfReader;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.kernel.pdf.WriterProperties;
import com.itextpdf.kernel.pdf.canvas.PdfCanvas;
import com.itextpdf.kernel.pdf.extgstate.PdfExtGState;
import com.itextpdf.layout.Canvas;
import com.itextpdf.layout.element.Paragraph;
import com.itextpdf.layout.property.TextAlignment;
import com.itextpdf.layout.property.VerticalAlignment;

@Component
public class PMSFileUtils {

	
	public void addWatermarktoPdf(PdfDocument doc,String EmpName, String EmpNo) throws Exception
	{
		
		String WMText = "";
        for(int i=1;i<=25;i++)
        {
     	   WMText = WMText+EmpName+" "+EmpNo+" "; 
        }
        String WMTextLine=WMText;
        WMTextLine +="\n";
        WMTextLine +="\n";
        WMTextLine += WMText;
		
		try (PdfDocument pdfDoc = doc) {
		    PdfFont helvetica = PdfFontFactory.createFont(StandardFonts.TIMES_ROMAN);
		    for (int pageNum = 1; pageNum <= pdfDoc.getNumberOfPages(); pageNum++) {
		        PdfPage page = pdfDoc.getPage(pageNum);
		        PdfCanvas canvas = new PdfCanvas(page.newContentStreamBefore(), page.getResources(), pdfDoc);
	
		        PdfExtGState gstate = new PdfExtGState();
		        gstate.setFillOpacity(.25f);
		        canvas = new PdfCanvas(page);
		        canvas.saveState();
		        canvas.setExtGState(gstate);
		        try (Canvas canvas2 = new Canvas(canvas,  page.getPageSize())) {
			        Paragraph watermark = new Paragraph(WMTextLine)
			                   .setFont(helvetica)
			                   .setFontSize(10)
			                   .setPaddings(10, 10,10, 10);
		            
		      
			        Rectangle pageSize = page.getPageSize();
			        
			       if(pageSize.getRight() < pageSize.getTop())
			       {
				        float rotationRad = (float) Math.toRadians(55);
				        canvas2.showTextAligned(watermark, pageSize.getLeft(),pageSize.getBottom(), pageNum, TextAlignment.LEFT, VerticalAlignment.MIDDLE , rotationRad);
				        rotationRad = (float) Math.toRadians(-55);
				        canvas2.showTextAligned(watermark, pageSize.getLeft(),pageSize.getTop(), pageNum, TextAlignment.LEFT, VerticalAlignment.MIDDLE , rotationRad);
			       }
			       else
			       {
			    	   float rotationRad = (float) Math.toRadians(35);
				       canvas2.showTextAligned(watermark, pageSize.getLeft(),pageSize.getBottom(), pageNum, TextAlignment.LEFT, VerticalAlignment.MIDDLE , rotationRad);
				       rotationRad = (float) Math.toRadians(-35);
				       canvas2.showTextAligned(watermark, pageSize.getLeft(),pageSize.getTop(), pageNum, TextAlignment.LEFT, VerticalAlignment.MIDDLE , rotationRad);
			       }
		        }
		     
		        canvas.restoreState();
		    }
		 }
		
		
	}
	
	
	public void createEncryptedPdf(String filePath, String password) throws Exception {
        try (PdfWriter pdfWriter = new PdfWriter(filePath,
                new WriterProperties().setStandardEncryption(password.getBytes(), password.getBytes(),
                        EncryptionConstants.ALLOW_PRINTING, EncryptionConstants.ENCRYPTION_AES_128));){
        	
        }
    }
	
	
	public void addWatermarktoPdf1(String pdffilepath,String newfilepath,String watermarkString) throws Exception
	{
		File pdffile = new File(pdffilepath);
		File tofile = new File(newfilepath);
		
		try (PdfDocument doc = new PdfDocument(new PdfReader(pdffile), new PdfWriter(tofile))) {
		    PdfFont helvetica = PdfFontFactory.createFont(StandardFonts.TIMES_ROMAN);
		    for (int pageNum = 1; pageNum <= doc.getNumberOfPages(); pageNum++) {
		        PdfPage page = doc.getPage(pageNum);
		        PdfCanvas canvas = new PdfCanvas(page.newContentStreamBefore(), page.getResources(), doc);
	
		        PdfExtGState gstate = new PdfExtGState();
		        gstate.setFillOpacity(.08f);
		        canvas = new PdfCanvas(page);
		        canvas.saveState();
		        canvas.setExtGState(gstate);
		        try (Canvas canvas2 = new Canvas(canvas,  page.getPageSize())) {
		            double rotationDeg = 50d;
		            double rotationRad = Math.toRadians(rotationDeg);
		            Paragraph watermark = new Paragraph(watermarkString.toUpperCase())
		                    .setFont(helvetica)
		                    .setFontSize(100f)
		                    .setTextAlignment(TextAlignment.CENTER)
		                    .setVerticalAlignment(VerticalAlignment.MIDDLE)
		                    .setRotationAngle(rotationRad)
		                    .setFixedPosition(150, 110, page.getPageSize().getWidth());
		            canvas2.add(watermark);
		        }
		        canvas.restoreState();
		    }
		 }
		
		pdffile.delete();
		tofile.renameTo(pdffile);
		
	}
	
	
}
