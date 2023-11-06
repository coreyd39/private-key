% Corey Dec
% Final Project, F22
%
% Encrypts/Decrypts messages in a variety of classical ciphers, including
% substitution and vigenere ciphers.
% Program allows for automatic generation of keys as well as automatic and
% interactive decryption solvers for certain ciphers.
% Due to Matlab's limitations of the struct data structure (see
% make_mapping.m for more information), the program only functions with
% languages made up of non-numeric character found in ASCII. While the
% consequence is that the program currently works with english, it has been
% written in an arbitrary fashion should the limitation be bypassed in the 
% future and other languages and their letter frequencies be added to the 
% catalog. 

clear
clc

% Initializing important data structures and variables

% Languages: adding new ones requires the letters and the frequency of them
% in that language
    
english='abcdefghijklmnopqrstuvwxyz';
english_freq=[.082,.015,.028,.043,.127,.022,.02,.061,.07,.002,.008,.04,.024,.067,.075,.019,.001,.06,.063,.091,.028,.01,.023,.001,.02,.001];
languages=[english];
language_freq=[english_freq];
    

% List of known ciphers

cipher_list={'affine','shift','substitution','vigenere'};
    
    
% Write a disclaimer explaining what languages and ciphers 
% The program can work with

task=' ';

% the functional part MUST REVISIT
while task~='f'
    
    text=input('Insert a text (type "f" to finish): ','s');
    
    if text=='f'
        break
    end
    
    language=input("Language is plaintext written in (you're using english): ");
    
    alphabet=english;
    alphabet_freq=english_freq;
    letters_position=make_mapping(alphabet);
            
    % Re-evaluate prompts once program is more complete
    disp("To encrypt a plaintext, type 'e',") 
    disp("To decrypt a cipher text, type 'd',") 
    task=lower(input("Otherwise, type 'f' to finish the program: ",'s'));
    
    if task == 'f'
        break
    end
    
    disp('This program can work with affine (a), shift (c), substitution (s), and vigenere (v) ciphers \n\n')
    cipher=input('Insert the letter of the type of cipher to work with: ','s');
        
    if cipher== 'a'
        [text,key]=affine_cipher(text,task,alphabet,letters_position);
    elseif cipher=='c'
        [text,key]=shift_cipher(text,task,alphabet,letters_position);
    elseif cipher=='s'
        [text,key]=substitution_cipher(text,task,letters_position,alphabet,alphabet_frequency);
    elseif cipher=='v'
        [text,key]=vigenere_cipher(text,task,alphabet,letter_position,alphabet_frequency)
    end
    
    
    if task=='e'
        disp('New ciphertext is: ')
        disp(text)
        disp('With key = \n')
        disp(key)
        
    elseif task=='d'
        disp('New plaintext is: \n\n')
        disp(text)
        disp=('With key = ')
        disp(key)
    end      
end

disp('This concludes the coding process. Thank you for using this program.')

    


