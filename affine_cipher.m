function [text,key]=affine_cipher(text,task,alphabet,letter_position)
% Corey Dec
% Final Project, F22 
%
% This function encrypts/decrypts affine ciphers, which has the following
% encryption (e) and decryption (d) rules where x is an element in the
% plaintext, y is an element of the ciphertext, and L is the length of the 
% alphabet being used:
% 
% e: ax + b mod(L)
% d: a^(-1)(y-b) mod(L)
%
% text is a string to work with,
% task is a string ('e' for encrypt or 'd' for decrypt)
% that determines which action is completed, 
% alphabet is a string with all the letters being used,
% letters_position is a struct where for some letter k in alphabet,
% letters_position.(k) = p where p is the position of k, and 
% key is vector in the form of [a,a^(-1),b] where a,b are integers such that
% a^(-1) exists in mod(L)

elements_w_inv=[];
inverses=[];

% Impliments group theory: ensures that the domain of a for the function
% obeys group laws (i.e. inverses). Inputting an a without an inverse would
% lead to a cipher with no solution. 
for x=1:length(alphabet)
    for y=x:length(alphabet)
        if x*y == 1 || mod(x*y,length(alphabet)) == 1
            elements_w_inv=[elements_w_inv,x];
            inverses=[inverses,y];
            break
        end
    end
end

ewi=num2str(elements_w_inv);

rule_def=['Consider the encryption rule e: ax + b mod(',num2str(length(alphabet)),').'];
disp(rule_def)

a_def=['Define a such that it is an integer with an inverse (a=',ewi,') (type "r" for a random a value): '];
a=input(a_def,'s');

b_def=['Define b such that it is an integer (0 <= b < ', num2str(length(alphabet)),') (type "r" for a random b value): '];
b=input(b_def,'s');

if  a=='r'
    r=randi([1,length(elements_w_inv)]);
    a=elements_w_inv(r);
else
    a=str2num(a);
end

if  b=='r'
    b=randi([1,length(alphabet)]);
else
    b=str2num(b);
end

for search=1:length(elements_w_inv)
    if elements_w_inv(search) == a
        a_inv=inverses(search);
        break
    end
end


key=[a,a_inv,b];

if task == 'e'
    text=lower(clean_text(text,''));    
    
    for k=1:length(alphabet)        
        
        letter=alphabet(k);
        position=letter_position.(letter);
        
        position_current=a*position+b;
        
        % Applies modular math
        if position_current > mod(position_current,length(alphabet))
            position_current=mod(position_current,length(alphabet))
        end
        if position_current == 0
            position_current=length(alphabet);
        end
        
        letter_new=upper(alphabet(position_current));
        text=strrep(text,letter,letter_new);
        
    end
    
elseif task == 'd'
    text=upper(clean_text(text,' '));
                
    for k=1:length(alphabet)
        
        letter=alphabet(k);
        position=letter_position.(letter); 
        position_current=(a_inv)*(position-b);
        
        if position_current>length(alphabet)
            position_current=mod(position_current,length(alphabet));
                
        end
        
        if position_current<1
            position_current=mod(position_current,length(alphabet));

        end
            
        if position_current==0
            position_current=length(alphabet);
            
        end
        letter_new=alphabet(position_current);
        text=strrep(text,upper(letter),letter_new);       
    
    end    
    return    
    
end
end