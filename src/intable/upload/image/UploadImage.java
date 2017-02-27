package intable.upload.image;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import intable.store.dao.StoreDao;

@WebServlet("/store/upload/image")
public class UploadImage extends HttpServlet {
	
	private static final long serialVersionUID = 2060384502063181758L;
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		System.out.println("UploadImage.doPost()");
		
		HashMap<String, String> login = request.getSession().getAttribute("login") instanceof HashMap<?, ?>
				
				? (HashMap<String, String>) request.getSession().getAttribute("login")
				
				: null;
		
		if (login == null || !(login.get("issonnim").equals("false"))) {
			
			String endUrl = request.getSession().getAttribute("endUrl") == null
					
					? "/" : request.getSession().getAttribute("endUrl").toString();
			
			response.sendRedirect(endUrl);
		}
		
		try {
			
			if (ServletFileUpload.isMultipartContent(request)) {
				
				DiskFileItemFactory factory = new DiskFileItemFactory();
				
				ServletFileUpload upload = new ServletFileUpload(factory);
				
				List<FileItem> items = null;
				
				items = upload.parseRequest(request);
				
				Iterator<FileItem> iterator = items.iterator();
				
				while (iterator.hasNext()) {
					
					FileItem item = iterator.next();
					
					if (!item.isFormField() && item.getSize() > 0) {
						
						File dir = new File(getServletContext().getRealPath("/") + "upload/image/" + login.get("store_id"));
						
						File file = new File(dir + "/" + item.getFieldName() + ".jpg");
						
						if (file.exists()) {
							
							file.delete();
							
						} else {
							
							dir.mkdirs();
							
						}
						
						item.write(file);
						
					}
					
				}
				
				login.put("signed_store_id", login.get("store_id"));
				login.put("signed_store_email", login.get("email"));
				login.put("signed_store_password", login.get("password"));
				login.put("imageuri1", "/upload/image/" + login.get("store_id") + "/" + login.get("store_id") + ".1.jpg");
				login.put("imageuri2", "/upload/image/" + login.get("store_id") + "/" + login.get("store_id") + ".2.jpg");
				login.put("imageuri3", "/upload/image/" + login.get("store_id") + "/" + login.get("store_id") + ".3.jpg");
				login.put("imageuri4", "/upload/image/" + login.get("store_id") + "/" + login.get("store_id") + ".4.jpg");
				login.put("imageuri5", "/upload/image/" + login.get("store_id") + "/" + login.get("store_id") + ".5.jpg");
				
				StoreDao storeDao = new StoreDao();
				
				if (storeDao.do_update(login)) {
					
					StringBuilder script = new StringBuilder();
					
					script.append("<script>");
					script.append("opener.location.reload();");
					script.append("opener.alert(\"업로드 성공\");");
					script.append("window.open(\"\",\"_self\");");
					script.append("window.close();");
					script.append("</script>");
					
					response.getWriter().write(script.toString());
					
				} else {
					
					StringBuilder script = new StringBuilder();
					
					script.append("<script>");
					script.append("opener.alert(\"업로드 실패\");");
					script.append("history.back();");
					script.append("</script>");
					
					response.getWriter().write(script.toString());
					
				}
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
}
