function [text,key]=substitution_cipher(text,task,letters_position,alphabet,alphabet_frequency)
% Corey Dec
% Final Project, F22
%
% This function encrypts/decrypts substitution ciphers, which has the
% encryption rule of assigning some letter of the plaintext, x, to some letter
% in the ciphertext, y. Interactive decryption assumes that the language is
% english.
%
% Note that shift and affine ciphers are special cases of the substitution
% cipher, so this function can/should be used to decrypt those ciphers when their
% keys are unknown
%
% text is a string to work with,
% task is a string ('e' for encrypt or 'd' for decrypt)
% that determines which action is completed, 
% alphabet is a string containing all the letters being used, 
% letters_position is a struct where for some letter k in alphabet,
% letters_position.(k) = p where p is the position of k, 
% alphabet_frequency a vector where alphabet_frequency(j) refers to the
% frequency of occurance of k = alphabet(j) in the language, and
% key is a string where the encryption of alphabet(k)=key(k)

disp('key is a string where the encryption of alphabet(k)=key(k)')

if task=='e'
    
    text=clean_text(text,'');
        
    key=input('Input key (type "r" for a random key): ','s');
    
    if lower(key)=='r'
        key=make_substitution_key(alphabet);
    end
    
    key=upper(key);
    
    for k=1:length(alphabet)
        char=alphabet(k);
        text=strrep(text,char,key(k));
        
    end
    
elseif task == 'd'
    
    text=upper(clean_text(text,' '));
    
    key=input('Input key (type "?" for interactive solver): ','s');
    
    if key == "?"  
        char_text=clean_text(text,'');
        cipher_char=upper(alphabet);
        cipher_freq=[];
        cipher_letter_freq=[];
                
        for k=1:length(cipher_char)
            letter=cipher_char(k);
            cipher_letter_freq=[cipher_letter_freq,count(char_text,letter)/length(char_text)];
            cipher_freq=[cipher_freq,cipher_letter_freq];
        
        end
        
        text2=text;
        status=' ';
        while status~='!'
            disp(text2);
            freq_analysis=table(alphabet',alphabet_frequency',cipher_char',cipher_letter_freq')
            status=input('Letter being changed (enter "!" when finished): ','s');
            if status == '!'
                break
            end
            let_new=input('New letter: ','s');            
            text2=strrep(text2,status,let_new);
            
        end
            
        text=text2;
      
               
    else
        key=upper(key);
        for k=1:length(key)            
            
            text=strrep(text,key(k),alphabet(k));
            
        end               
    end
    
end
return
end