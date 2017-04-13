function dec_img = LZW_img_dec(enc_img)
% LZW_img_dec is a Lempel Ziv Welch image decoder
% input : encoded image vector of N elements
% output : decoded image vectpr using the LZW method
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

n_enc_img = numel(enc_img); % number of elements (bits) in the input image
enc_bits = 2;               % current output encoding bits

n = 2;        % initial index
dec_img = []; % initial output image

%%
% initialize current and next element, always 1-bit and 2-bit respectively
current_code = bi2de(enc_img(1));
next_code = bi2de(enc_img(2:3)','left-msb');

while( n+enc_bits-1 <= n_enc_img )
    
    % get current and next element from dictionary
    current_element = dictionary{current_code+1};
    
    % working around the special case where next_code is still not in the
    % dictionary
    if next_code+1 <= numel(dictionary)
        next_element = dictionary{next_code+1};
        
        % update dictionary
        new_element = [ current_element ; next_element(1) ];
        [dictionary,new_code] = update_dict(new_element,dictionary);
    else
        next_element = [ current_element ; current_element(1)];
        
        % update dictionary
        [dictionary,new_code] = update_dict(next_element,dictionary);
    end
    
    % update output
    dec_img = [ dec_img ; current_element ];
    
    %update index
    if n+enc_bits-1 < n_enc_img
        n = n + enc_bits;
    else
        % update output
        dec_img = [ dec_img ; next_element ];
        return;
    end
    
    enc_bits = numel(de2bi(new_code+1));       % current input encoding bits
    
    % update current and next code
    current_code = next_code;
    next_code = bi2de(enc_img(n:n+enc_bits-1)','left-msb');
end

end
