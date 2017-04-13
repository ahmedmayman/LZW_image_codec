function [d_new,n] = update_dict(element,dictionary)
% update_dict updates the dictionary adding the new element and returning
% the new dictionary after addition and code of newest element
%
% created by : Ahmed Mohamed Ayman
% date : 13 April 2017
%
% inputs : column vector element
%          column vector dictionary
%
% outputs : column vector new dictionary
%           newest code

n = numel(dictionary);          % getting the code for the new element
d_new = [dictionary ; element]; % concatenating the new element

end
