function cleaned_text=clean_text(text,include)
% Corey Dec
% Final Project, F22
%
% Cleans a string, deleting special characters that are not specified to be
% be included. 
%
% text is a string to be cleaned, and 
% include is a string of characters to include in cleaned_text

deleting=['!','@','#','$','%','^','&','*','(',')','_','+','-','=','`','~','[',']','{','}','\','|',';',':','"',"'",',','.','/','<','>','?',' ','1234567890'];
deleting=erase(deleting,include);

cleaned_text=erase(text,deleting);

return
end