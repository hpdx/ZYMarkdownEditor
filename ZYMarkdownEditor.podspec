
Pod::Spec.new do |s|  
  s.name             = "ZYMarkdownEditor"  
  s.version          = "1.0.0"  
  s.summary          = "A markdown editor with grammar hightlight and code map for iOS."   
                        
  s.homepage         = "https://github.com/LZTuna/ZYMarkdownEditor"  
  
  s.license          = 'MIT'  
  s.author           = { "LZTuna" => "lztuna04@gmail.com" }  
  s.source           = { :git => "https://github.com/LZTuna/ZYMarkdownEditor.git", :tag => s.version.to_s }  
  
  
  s.platform     = :ios, "7.0" 
   
  s.requires_arc = true  
  
  s.source_files = "ZYMarkdownEditor’,’ZYMarkdownEditor/**/*.{h,m}"  

  s.frameworks = "Foundation", "UIKit"

  s.dependency  "YYText"
  
end