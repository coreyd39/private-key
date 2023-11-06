function [text,key]=vigenere_cipher(text,task,alphabet,letter_position,alphabet_frequency)
% Corey Dec
% Final Project, F22
%
% DISCLAIMER: The only tested, functional part of this program is the encryption. 
%
% The purpose of the function is to encrypt/decrypt vigenere ciphers, 
% which have the following encryption (e) and decryption (d) rules where 
% x is an element in the plaintext, y is an element of the ciphertext, 
% and km is the m'th element of the key string :
% 
% e: x + km 
% d: y - km
%
% This function has interactive decoding capabilities for unknown
% vigenere ciphers, requiring user input to read a generated table of
% values to choose the best length of the predicted key. To determine
% whether or not the predicted key, kp, is correct, rerun the function with
% task = 'd' and input kp as the decryption key.
%
% text is a string to work with,
% task is a string ('e' for encrypt or 'd' for decrypt)
% that determines which action is completed, 
% alphabet is a string with all the letters being used,
% letters_position is a struct where for some letter k in alphabet,
% letters_position.(k) = p where p is the position of k,
% alphabet_frequency a vector where alphabet_frequency(j) refers to the
% frequency of occurance of k = alphabet(j) in the language, and
% key is vector in the form of [] where a,b are integers such that
% a^(-1) exists in mod(L).

text=clean_text(text,'');

if task=='e'
    
    text=lower(text);
    
    % Establishes character key
    key=input('Insert a key word (type "r" for a random key): ','s');

    if key=="r"
        m=input('Insert a length for key word (or type "r" for a random length): ','s');

        if m=='r'
            m=randi([2,10]);
        else 
            m=str2num(m);
        end

        positions_r=randi([1,length(alphabet)],[1,m]);

        key=[];
        for k=1:m
            key=[k, alphabet(positions_r(k))];

        end
    else
        m=length(key);
    end
    
    % Establishes numeric key
    key_position=[];
    for j=1:length(key)
        char=key(j);
        key_position=[key_position,letter_position.(char)];
    end
        
    sub_positions=[];
    cells_char={};
    str_list=[];
    
    % Creates lists of position values 
    for k=1:m
        
        text_positions=k:m:length(text);      
        text_char=text(text_positions);
        
        positions=[];
        for j=1:length(text_char)
            
            positions=[positions,letter_position.(text_char(j))];
            
        end
        
        positions=positions+letter_position.(key(m));
        
        characters=[];
        for i=1:length(positions)
            if positions(i)>length(alphabet)
                positions(i)=mod(positions(i),length(alphabet));
            end
            characters=[characters,alphabet(positions(i))];
        end
        
        cells_char=cellstr(characters);
        str_list=[str_list,cells_char]
                
    end    
    
    str_unsorted=[];
    for s=1:length(str_list)
        str_unsorted=[str_unsorted,cell2mat(str_list(s))];
    end
    
    
    
    textv2=[];  
    for k=1:m  
        
        chars=k:m:length(str_unsorted);
        textv2=[textv2,str_unsorted(chars)];
        
    end
    
    text=textv2;
    
elseif task=='d' 
    
    text=upper(text);
    
    % Establishes character key
    key=input('Insert a key word (type "u" if key is unknown): ','s');
    
    if key=='u'
        % Does not check for a key length of 1, as that would be a shift
        % cipher
        %
        % Function provides an estimate key, so the out put may not be
        % correct. Rerun the program and experiment with different sizes of
        % m to find the correct key. 
        coincidences=zeros(1,19)
        for k=2:length(alphabet)
            track=0;
            filter_position=1;
            for j=k+1:length(text)
                if text(k)==text(filter_position)
                    track=track+1;
                end
            end
            coincidences(k-1)=track;
        end
        
        vals=2:length(alphabet);
        coincidence_table=table(vals,coincidences)
        
        m=input('Enter a predicted length of key: ');
        
        key=[];
        for k=1:m
           substring=text(k:m:length(text));
           freq=[];
           for j=1:length(alphabet)
               letter=alphabet(j);
               occurances=count(substring,letter);
               freq=[freq,occurances/length(substring)];
           end
           
           products=[];
           previous_largest=0;
           km_position=0;
           for g=0:length(alphabet)-1
               segment=freq(g+1:length(freq));
               freq_temp=freq;
               freq_temp(g+1:length(freq))=[];
               g_freq=[segement,freq_temp];
               
               products=[products,g_freq];
               
               if max(products)>previous_largest
                   previous_largest=max(products);
                   km_position=g+1;
                   
               end
                              
           end
           
           key=[key,letter_position(km_position)];
           
        end
        
        return
    end
                
else        
        m=length(key);
        
        % Establishes numeric key
        key_position=[];
        for j=1:length(key)
            key_position=[key_position,letter_positions.(key(j))];
        end

        sub_positions=[];
        cells_char={};

        % Creates lists of position values
        for k=1:m

            text_positions=k:m:length(text);      
            text_char=text(text_positions);

            positions=[];
            for j=1:length(text_char)

                positions=[positions,letter_position.(text_char(j))];

            end

            positions=positions-letter_position(key(m));

            characters=[];
            for i=1:length(positions)
                if positions(i)<1
                    positions(i)=mod(positions(i),length(alphabet));
                end
                if positions(i)==0
                    positions(i)=length(alphabet);
                end
                characters=[characters,alphabet(positions(i))];
            end

            cells_char(k,:)=cellstr(characters); 

        end    

        text=[];    
        for k=1:length(cells_char(1,:));

            text=[text,cells_char(:,k)];

        end                
    end   
end