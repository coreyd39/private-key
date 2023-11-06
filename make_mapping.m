function let2num=make_mapping(letters)
% Corey Dec
% Final Project, F22
%
% Creates a struct data structure where for some k in letters, 
% let2num.k = n where n is the position of k in letters
% 
% Does not function with special letters, i.e. accented spanish letters
% 
% letters is a string with the letters of the alphabet being used

cells=num2cell(ones(length(letters),1))';

for k=1:length(letters)
    cells(1,k)={letters(k)};
end

vals=(1:length(letters));

cells(2,:)=num2cell(vals);

let2num=struct(cells{:});

return