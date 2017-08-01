package com.bitbox.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;

import com.bitbox.dto.MinutesDTO;
import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.Image;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

@Service
public class PdfService {
	
	public String makePDF(MinutesDTO minutes , String group_title){
		String url = "/bitbox/minutesView?seq="+minutes.getMin_seq()+"&group="+group_title+"&page=0";
		String fileName = "";
		String dir = "C:\\dev\\pdf\\";
		fileName = "Min"+group_title+".pdf";
		
		File directory = new File(dir);
	    if(!directory.exists()) directory.mkdirs(); //파일경로 없으면 생성
	     
	     Document document = new Document();
	       try {
			PdfWriter.getInstance(document, new FileOutputStream(dir+"/"+fileName));
			document.open();
			BaseFont objBaseFont = BaseFont.createFont("H2HDRM.TTF", BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
			
			Paragraph title = new Paragraph("회의록", new Font(objBaseFont, 18, Font.BOLD));
			title.setAlignment(Paragraph.ALIGN_CENTER); // 가운데 정렬
			
			Image line = Image.getInstance("Ironic-twist.png");
			line.setAlignment(Image.ALIGN_CENTER);
			  
	        PdfPTable table1 = new PdfPTable(new float[] { 1f, 2f });
	 
	        PdfPCell c1 = new PdfPCell(new Paragraph("그룹명", new Font(objBaseFont, 12 , Font.BOLD)));
	        c1.setHorizontalAlignment(Element.ALIGN_CENTER); 
	        c1.setMinimumHeight(20f);
	        c1.setBackgroundColor(BaseColor.GRAY);
	        table1.addCell(c1);

	        c1 = new PdfPCell(new Paragraph("참가자", new Font(objBaseFont, 12 , Font.BOLD)));
	        c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	        c1.setMinimumHeight(20f);
	        c1.setBackgroundColor(BaseColor.GRAY);
	        table1.addCell(c1);
	        
	        c1 = new PdfPCell(new Paragraph(group_title, new Font(objBaseFont, 10)));
	        c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	        c1.setFixedHeight(40f);
	        table1.addCell(c1);
	        
	        c1 = new PdfPCell(new Paragraph(minutes.getMin_attendee(), new Font(objBaseFont, 10)));
	        c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	        c1.setMinimumHeight(40f);
	        table1.addCell(c1);
	        
	        c1 = new PdfPCell(new Paragraph("회의주제", new Font(objBaseFont, 12 , Font.BOLD)));
	        c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	        c1.setMinimumHeight(20f);
	        c1.setBackgroundColor(BaseColor.GRAY);
	        table1.addCell(c1);
	        
	        c1 = new PdfPCell(new Paragraph("회의내용", new Font(objBaseFont, 12 , Font.BOLD)));
	        c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	        c1.setMinimumHeight(20f);
	        c1.setBackgroundColor(BaseColor.GRAY);
	        table1.addCell(c1);
	        
	        c1 = new PdfPCell(new Paragraph(minutes.getMin_subject(), new Font(objBaseFont, 10)));
	        c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	        c1.setMinimumHeight(120f);
	        table1.addCell(c1);
	        
	        c1 = new PdfPCell(new Paragraph(minutes.getMin_content(), new Font(objBaseFont, 10)));
	        c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	        c1.setMinimumHeight(120f);
	        table1.addCell(c1);
	        
	        PdfPTable table2 = new PdfPTable(2);
	        
	        c1 = new PdfPCell(new Paragraph("의견사항", new Font(objBaseFont, 12 , Font.BOLD)));
	        c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	        c1.setMinimumHeight(20f);
	        c1.setBackgroundColor(BaseColor.GRAY);
	        table2.addCell(c1);
	        
	        c1 = new PdfPCell(new Paragraph("확정내용", new Font(objBaseFont, 12 , Font.BOLD)));
	        c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	        c1.setMinimumHeight(20f);
	        c1.setBackgroundColor(BaseColor.GRAY);
	        table2.addCell(c1);
	        
	        c1 = new PdfPCell(new Paragraph(minutes.getMin_opinion(), new Font(objBaseFont, 10)));
	        c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	        c1.setMinimumHeight(90f);
	        table2.addCell(c1);
	        
	        c1 = new PdfPCell(new Paragraph(minutes.getMin_decide(), new Font(objBaseFont, 10)));
	        c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	        c1.setMinimumHeight(90f);
	        table2.addCell(c1);
	        
	        PdfPTable table3 = new PdfPTable(2);
	        
	        c1 = new PdfPCell(new Paragraph("추후일정", new Font(objBaseFont, 12 , Font.BOLD)));
	        c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	        c1.setMinimumHeight(20f);
	        c1.setBackgroundColor(BaseColor.GRAY);
	        table3.addCell(c1);
	        
	        c1 = new PdfPCell(new Paragraph("준비사항", new Font(objBaseFont, 12 , Font.BOLD)));
	        c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	        c1.setMinimumHeight(20f);
	        c1.setBackgroundColor(BaseColor.GRAY);
	        table3.addCell(c1);
	        
	        c1 = new PdfPCell(new Paragraph(minutes.getMin_schedule(), new Font(objBaseFont, 10)));
	        c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	        c1.setMinimumHeight(90f);
	        table3.addCell(c1);
	        
	        c1 = new PdfPCell(new Paragraph(minutes.getMin_prepare(), new Font(objBaseFont, 10)));
	        c1.setHorizontalAlignment(Element.ALIGN_CENTER);
	        c1.setMinimumHeight(90f);
	        table3.addCell(c1);
	        
	        Paragraph date = new Paragraph(minutes.getMin_date(), new Font(objBaseFont, 12, Font.BOLD));
			date.setAlignment(Paragraph.ALIGN_RIGHT); // right정렬
	        
	        document.add(title);
	        document.add(line);
	        document.add(table1);
	        document.add(table2);
	        document.add(table3);
	        document.add(date);
	        document.close();
		} catch (DocumentException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	       
	       
	    return url;
	}
	
}
