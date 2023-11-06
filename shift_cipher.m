function [text,key]=shift_cipher(text,task,alphabet,letters_position)
% Corey Dec
% Final Project, F22
%
% text is a string to work with,
% task is a string ('e' for encrypt or 'd' for decrypt)
% that determines which action is completed, 
% alphabet is a string with all the letters being used,
% letters_position is a struct where for some letter k in alphabet,
% letters_position.(k) = p where p is the position of k, and 
% key is an integer that determines by how many places each letter is
% shifted that satisfies 0 <= key < length(alphabet)


    
    if task== 'e'
        text=lower(clean_text(text,''));
        
        key_desc=['Input an integer (0 <= k < ', string(length(alphabet)), ') for a key (type "r" for a random key): '];
        key_desc=strjoin(key_desc);
        key=input(key_desc,'s');

        if key=='r'
           key=randi([0,length(alphabet)-1]);
        else
           key=str2num(key);
        end
        
        for k=1:length(alphabet)
            letter=alphabet(k);
            position=letters_position.(letter);

            % Modular math
            if position+key>length(alphabet)
                position_new=mod(position+key,length(alphabet));
            else
                position_new=position+key;
            end

            letter_new=upper(alphabet(position_new));

            text=strrep(text,letter,letter_new);
        end

    elseif task== 'd'
        text=upper(clean_text(text,' '));
        
        key_desc=['Input an integer (0 <= k < ', string(length(alphabet)), ') for a key: '];
        key_desc=strjoin(key_desc);
        key=input(key_desc);
        
        for k=1:length(alphabet)
            
            letter=alphabet(k);
            position=letters_position.(letter);
            position_new=position-key

            % Modular math
            
            if position_new<1
                position_new=mod(position_new,length(alphabet));

            end
            
            if position_new==0
                position_new=length(alphabet);
            end
            
            letter_new=lower(alphabet(position_new));

            text=strrep(text,upper(letter),letter_new);
        end        
    end

    return
    
end