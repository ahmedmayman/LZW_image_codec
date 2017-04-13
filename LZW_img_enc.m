function [enc_img] = LZW_img_enc(img)
% LZW_img_enc is a Lempel Ziv Welch image encoder
% input : binarized image of N elements
% output : encoded image using the LZW method
%
% created by : Ahmed Mohamed Ayman
% date : 13 April 2017
%
% initial Alphabet dictionary is 0,1 logical 1-bit values
% dictionary format is a cell array
% dictionary = [ 0 ]
%              [ 1 ]
%              [ 0 ; 0 ]
%              [ 0 ; 0 ; 1 ]
%              [.....]
% the first two elements are the initial alphabet 0 and 1
% next element of code n will be concatenated as column vector
% in the example, the elements are 2:00, 3:001, .....

dictionary{1} = 0;        % initial dictionary
dictionary{2} = 1;        % initial dictionary
dictionary = dictionary'; % in column format

n_img = numel(img);       % number of elements (bits) in the input image
% current output encoding bits
enc_bits = numel(de2bi(numel(dictionary) - 1));

n = 1;        % initial index
enc_img = []; % output encoded image

%%
while ( n+1 <= n_img )
        
    % update current and next element
    current_element = img(n);
    next_element = img(n+1);
    
    
    % check the dictionary for the nth element concatenated with (n+1)th
    % element and return the result
    % - 1 if exists
    % - 0 if not
    
    [r,code] = check_dict(current_element,next_element,dictionary);
    % r : returns whether the current element concatenated with the next element
    % is in the dictionary
    % code : returns code of the concatenated element if found in dictionary and
    % the code of current element if concatenated not found
    
    
    if r
        
        temp_current_element = current_element;
        temp_next_element = next_element;
        
        while r
            
            current_element = temp_current_element; % update current element as being last element found in the dictionary
            next_element = temp_next_element;
            
            temp_current_element = [temp_current_element ; temp_next_element];
            
            %update index
            if n+1 < n_img
                n = n + 1;
            else
                [r,code] = check_dict(temp_current_element,[],dictionary); % get the code for the last element
                % update output
                enc_img = [ enc_img ; logical(de2bi(code,enc_bits,'left-msb')') ]; % print code of the current element
                return;
            end
            
            temp_next_element = img(n+1); % acquire next bit
            
            % check for the current element concatenated with the next
            % element in the dictionary
            [r,code] = check_dict(temp_current_element,temp_next_element,dictionary);
            
        end
 
        % now current element is the last found in the dictionary
        
        % update output
        enc_img = [ enc_img ; logical(de2bi(code,enc_bits,'left-msb')') ]; % print code of the current element
        
        % update the dictionary
        new_element = [ temp_current_element ; temp_next_element ];
        dictionary = update_dict(new_element,dictionary);
        enc_bits = numel(de2bi(numel(dictionary) - 1));       % current output encoding bits
        
        %update index
        if n+1 < n_img
            n = n + 1;
        else
            [r,code] = check_dict(temp_next_element,[],dictionary); % get the code for the last element
            % update output
            enc_img = [ enc_img ; logical(de2bi(code,enc_bits,'left-msb')') ]; % print code of the current element
            return;
        end
        
    else
        % now current element is the last found in the dictionary
        
        % update output
        enc_img = [ enc_img ; logical(de2bi(code,enc_bits,'left-msb')') ]; % print code of the current element
        
        % update the dictionary
        new_element = [ current_element ; next_element ];
        dictionary = update_dict(new_element,dictionary);
        enc_bits = numel(de2bi(numel(dictionary) - 1));       % current output encoding bits
        
        %update index
        if n+1 < n_img
            n = n + 1;
        else
            [r,code] = check_dict(next_element,[],dictionary); % get the code for the last element
            % update output
            enc_img = [ enc_img ; logical(de2bi(code,enc_bits,'left-msb')') ]; % print code of the current element
            return;
        end
       
    end
    
end

end
