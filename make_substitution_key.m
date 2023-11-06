function key=make_substitution_key(alphabet)
% Corey Dec
% Final Project, F22
%
% Generates a random permunation for the key of the substitution cipher. 
%
% alphabet is a string of letters to work with

key=[];
       
positions_temp=linspace(1,length(alphabet),length(alphabet));
for r=1:length(alphabet)
            
    pos_rand=randi([1,length(positions_temp)]);
    element_position=positions_temp(pos_rand);
    key=[key,alphabet(element_position)];            
    positions_temp(pos_rand)=[];
            
end

return

end
