function [r,code] = check_dict(current,next,dictionary)
% check_dict checks the cuurent and next elements of the LZW encoded image
% in the dictionary, if found it returns flag of 1 and the code of the
% concatenated, if not returns flag of 0 and code of current element
% 
% created by : Ahmed Mohamed Ayman
% date : 13 April 2017
% 
% inputs : column vector of current element
%          column vector of next element
%          list of saved elements (dictionary)
%
% outputs : result whether element exists in dictionary or not
%           code of the found element

n_dict = numel(dictionary); % get number of dictioray elements
concat = [current ; next];  % concatenate current with next element
r = 0;
code = -1;

for i=1:n_dict
    
    e = dictionary{i};
    
    % checking the concatenation of the current and next element
    if numel(concat) == numel(e)
        if concat == e
            code = i-1;
            r = 1;
            return;
        end
        
        
    % getting the code of the current element
    elseif numel(current) == numel(e)
        if current == e
            code = i-1;
        end
    end
end

end
