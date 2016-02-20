module SnippetsHelper
  def html_kind(kind)
     k = kind.downcase

     case k
     when "ruby"
       {color: "panel-ruby", icon: fa_icon('diamond'), text: "Ruby" }
     when "html"
       {color: "panel-html", icon: fa_icon('html5'), text: "HTML" }
     when "javascript"
       {color: "panel-javascript", icon: "js", text: "JavaScript" }
     when "css"
       {color: "panel-css", icon: fa_icon('css3'), text: "CSS" }
     else
       {color: "panel-default", icon: ""}
     end

   end
end
