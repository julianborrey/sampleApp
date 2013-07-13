module ApplicationHelper

   #helper function to return the title of a page
   #returns a base title unless more is specified
   def full_title(page_title)
      base_title = "Ruby on Rails Tute - Sample App";
      
      #we have made a base title, now chose the return value
      if page_title.empty? #if no page specified
         return base_title; #we return the base title
      else #otherwisew we return the rendered string below
         return "#{base_title} | #{page_title}"
      end
   end


end
