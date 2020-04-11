package org.cardcutter.java;

import de.l3s.boilerpipe.BoilerpipeProcessingException;
import de.l3s.boilerpipe.extractors.ArticleExtractor;
import de.l3s.boilerpipe.sax.HTMLHighlighter;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
import org.xml.sax.SAXException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.StringReader;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;

@WebServlet
public class CardCutterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        // normally 15
        // in editing mode it is 28
        String urlstring = request.getRequestURI();
        String urlparam = new StringBuilder(urlstring).delete(0,15).toString();
        urlparam = urlparam.replace("https:/", "https://"); //REQUIRED FOR WEB VERSION
        urlparam = urlparam.replace("http:/", "http://"); // REQUIRED FOR WEB VERSION

        request.setAttribute("url", urlparam);

        try {

            // Raw text
            URL url = new URL(urlparam);
            ArticleExtractor ae = ArticleExtractor.getInstance();
            HTMLHighlighter hh = HTMLHighlighter.newExtractingInstance();

            String rawtext = ArticleExtractor.getInstance().getText(new URL(urlparam));
            request.setAttribute("text", rawtext);
            System.out.println(rawtext);

            // Citation Creation
            String title;
            String author = "";
            String source;
            String date = "no date";

            String htmlh = hh.process(url, ae);
            Document doc = Jsoup.parse(htmlh);
            try {
                Elements headingElems = doc.getElementsByTag("h1");
                title = headingElems.get(0).text();
            } catch (Exception e) {
                title = "";
            }

            String line;

            BufferedReader reader = new BufferedReader(new StringReader(rawtext));
            boolean gotAuthor = false;
            boolean gotDate = false;
            try {
                while ((line = reader.readLine()) != null) {
                    if (line.startsWith("By") && !gotAuthor) {
                        String[] splitln = line.split(" ");
                        for(int j = 1; j < splitln.length; j++) author += " " + splitln[j];
                        System.out.println("got author: " + author);

                        gotAuthor = true;
                        if(author.split(" ").length > 3) {
                            System.out.println("author bad");
                            gotAuthor = false;
                            author = "";
                        }
                    }
                    if ((line.startsWith("January")
                            || line.startsWith("February")
                            || line.startsWith("March")
                            || line.startsWith("April")
                            || line.startsWith("May")
                            || line.startsWith("June")
                            || line.startsWith("July")
                            || line.startsWith("August")
                            || line.startsWith("September")
                            || line.startsWith("October")
                            || line.startsWith("November")
                            || line.startsWith("December")) && !gotDate) {
                        date = line;
                        gotDate = true;
                    }
                }
            } catch(IOException e) {
                e.printStackTrace();
            }

            String[] urlsplit = urlparam.split("\\.");
            if(urlparam.contains("www")) source = urlsplit[1];
            else source = urlsplit[0].split("//")[1];

            if(!author.equals("")) author = author +  ". ";
            String citation = author + "\"" + title + "\" " + source + ". " + date + ". " + urlparam;

            request.setAttribute("citation", citation);
        } catch (MalformedURLException e) {
            request.setAttribute("text", "Please choose a url");
        } catch (BoilerpipeProcessingException e) {
            request.setAttribute("text", "unable to process url:" + urlparam + ". sorry :(");
            e.printStackTrace();
        } catch (SAXException e) {
            e.printStackTrace();
        }

        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/cutcards.jsp");
        rd.forward(request, response);

    }


}
