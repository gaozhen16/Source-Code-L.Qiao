function [sort_index] = MMV_Block_sub_sort_ql_v1(y,Block_len,M)
%
%
%
    y_reshape = reshape(y,Block_len,[]);  %Ϊ���ȶ��Զ�����reshape
    
    y_sum_abs_ = sum(abs(y_reshape).^2,2);
    y_sum_abs=sum(reshape(y_sum_abs_,M,[]),1);
%     y_sum_abs=pp*y_sum_abs_;
    [tmp, sort_index] = sort(abs(y_sum_abs), 'descend');  %index�����ǵ�1��K���û������
end