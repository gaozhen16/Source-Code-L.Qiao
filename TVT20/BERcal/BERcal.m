function [ErrBit_UE,ErrBit_mbm,ErrBit_sig]=DECODEmeth135(Symbol,mbm_det1,sig_det,tx_bin,support_est,opt)
switch Symbol
    %% TLSSCS
    case 'TLSSCS'
        %% 
        support_num=length(support_est);
        Tx_ant_dec=opt.index_mr_single;       %��������ѡ��
        [sum_act_user,sub_matrix,sub_matrix_correct]=find_equal(support_est,opt.index_user_single,opt.S);
        %%
        if sum_act_user==0
            ErrBit_UE=(opt.S-sum_act_user)*opt.T*(log2(opt.M)+log2(opt.M_order));
            ErrBit_mbm=0;
            ErrBit_sig=0;
        else
            Tx_ant_bin=zeros(opt.S,log2(opt.M),opt.T);
            Rx_ant_bin=zeros(support_num,log2(opt.M),opt.T);
            for jjjj=1:opt.T
                Tx_ant_bin(:,:,jjjj)=de2bi(Tx_ant_dec(:,jjjj),log2(opt.M),'left-msb');%����ѡ�����
                Rx_ant_bin(:,:,jjjj) = de2bi(mbm_det1(:,jjjj),log2(opt.M),'left-msb');%���ֵ
            end
            sub_matrix_correct=sub_matrix_correct(1:sum_act_user);
            sub_matrix=sub_matrix(1:sum_act_user);
            ErrBit_UE=(opt.S-sum_act_user)*opt.T*(log2(opt.M)+log2(opt.M_order));%%yes  yes   yes
            %% ��ȷ�������û���mbmѡ���жϴ�����Ŀ
            error_Tx_ant = Tx_ant_dec(sub_matrix_correct,:) - mbm_det1(sub_matrix,:);
            ErrNum_mbm= nnz(error_Tx_ant); %��ȷ�û������������ܺ� %������������ܺ�
            ErrBit_mbm =  nnz(Rx_ant_bin(sub_matrix,:,:)-Tx_ant_bin(sub_matrix_correct,:,:));%��ȷ�û��������������
            %% err_bit_mbm
            %% ���
            if opt.QAM_en==1 % ����QAM
                rx_dec = qamdemod(sig_det/opt.Normuliza,opt.M_order);
            elseif opt.PSK_en==1% ����PSK
                rx_dec = pskdemod(sig_det,opt.M_order);
            end
            UECorrectEstSig=rx_dec(sub_matrix(1:sum_act_user),:);
            UECorrectRealSig=opt.tx_data(sub_matrix_correct(1:sum_act_user),:);
            ErrNum_sig=nnz(UECorrectEstSig - UECorrectRealSig);
            UECorrectrx_bin =  de2bi(UECorrectEstSig,log2(opt.M_order),'left-msb');
            tx_bin_com = [];
            for pp=1:opt.T
                tx_bin_com = [tx_bin_com;tx_bin(sub_matrix_correct(1:sum_act_user),:,pp)];
            end
            ErrBit_sig =  nnz(UECorrectrx_bin-tx_bin_com);
        end
        %%  BSAMP-SICSSP
    case 'BSAMP-SICSSP'
        support_num=length(support_est);
        Tx_ant_dec=opt.index_mr_single;       %��������ѡ��
        [sum_act_user,sub_matrix,sub_matrix_correct]=find_equal(support_est,opt.index_user_single,opt.S);
        if sum_act_user==0
            ErrBit_UE=(opt.S-sum_act_user)*opt.T*(log2(opt.M)+log2(opt.M_order));
            ErrBit_mbm=0;
            ErrBit_sig=0;
        else
            Tx_ant_bin=zeros(opt.S,log2(opt.M),opt.T);
            Rx_ant_bin=zeros(support_num,log2(opt.M),opt.T);
            for jjjj=1:opt.T
                Tx_ant_bin(:,:,jjjj)=de2bi(Tx_ant_dec(:,jjjj),log2(opt.M),'left-msb');%����ѡ�����
                Rx_ant_bin(:,:,jjjj) = de2bi(mbm_det1(:,jjjj),log2(opt.M),'left-msb');%���ֵ
            end
            sub_matrix_correct=sub_matrix_correct(1:sum_act_user);
            sub_matrix=sub_matrix(1:sum_act_user);
            ErrBit_UE=(opt.S-sum_act_user)*opt.T*(log2(opt.M)+log2(opt.M_order));%%yes  yes   yes
            %% ��ȷ�������û���mbmѡ���жϴ�����Ŀ
            error_Tx_ant = Tx_ant_dec(sub_matrix_correct,:) - mbm_det1(sub_matrix,:);
            ErrNum_mbm= nnz(error_Tx_ant); %��ȷ�û������������ܺ� %������������ܺ�
            ErrBit_mbm =  nnz(Rx_ant_bin(sub_matrix,:,:)-Tx_ant_bin(sub_matrix_correct,:,:));%��ȷ�û��������������
            %% err_bit_mbm
            %% ���
            if opt.QAM_en==1 % ����QAM
                rx_dec = qamdemod(sig_det/opt.Normuliza,opt.M_order);
            elseif opt.PSK_en==1% ����PSK
                rx_dec = pskdemod(sig_det,opt.M_order);
            end
            UECorrectEstSig=rx_dec(sub_matrix(1:sum_act_user),:);
            UECorrectRealSig=opt.tx_data(sub_matrix_correct(1:sum_act_user),:);
            ErrNum_sig=nnz(UECorrectEstSig - UECorrectRealSig);
            UECorrectrx_bin =  de2bi(UECorrectEstSig,log2(opt.M_order),'left-msb');
            tx_bin_com = [];
            for pp=1:opt.T
                tx_bin_com = [tx_bin_com;tx_bin(sub_matrix_correct(1:sum_act_user),:,pp)];
            end
            ErrBit_sig =  nnz(UECorrectrx_bin-tx_bin_com);
        end
    case 'SAGE'
        %% Ԥ����
        support_num=length(support_est);
        Tx_ant_dec=opt.index_mr_single;       %��������ѡ��
        [sum_act_user,sub_matrix,sub_matrix_correct]=find_equal(support_est,opt.index_user_single,opt.S);
        %%
        if sum_act_user==0
            ErrBit_UE=(opt.S-sum_act_user)*opt.T*(log2(opt.M)+log2(opt.M_order));
            ErrBit_mbm=0;
            ErrBit_sig=0;
        else
            Tx_ant_bin=zeros(opt.S,log2(opt.M),opt.T);
            Rx_ant_bin=zeros(support_num,log2(opt.M),opt.T);
            for jjjj=1:opt.T
                Tx_ant_bin(:,:,jjjj)=de2bi(Tx_ant_dec(:,jjjj),log2(opt.M),'left-msb');%����ѡ�����
                Rx_ant_bin(:,:,jjjj) = de2bi(mbm_det1(:,jjjj),log2(opt.M),'left-msb');%���ֵ
            end
            sub_matrix_correct=sub_matrix_correct(1:sum_act_user);
            sub_matrix=sub_matrix(1:sum_act_user);
            ErrBit_UE=(opt.S-sum_act_user)*opt.T*(log2(opt.M)+log2(opt.M_order));%%yes  yes   yes
            %% ��ȷ�������û���mbmѡ���жϴ�����Ŀ
            error_Tx_ant = Tx_ant_dec(sub_matrix_correct,:) - mbm_det1(sub_matrix,:);
            ErrNum_mbm= nnz(error_Tx_ant); %��ȷ�û������������ܺ� %������������ܺ�
            ErrBit_mbm =  nnz(Rx_ant_bin(sub_matrix,:,:)-Tx_ant_bin(sub_matrix_correct,:,:));%��ȷ�û��������������
            %% err_bit_mbm
            %% ���
            if opt.QAM_en==1 % ����QAM
                rx_dec = qamdemod(sig_det/opt.Normuliza,opt.M_order);
            elseif opt.PSK_en==1% ����PSK
                rx_dec = pskdemod(sig_det,opt.M_order);
            end
            UECorrectEstSig=rx_dec(sub_matrix(1:sum_act_user),:);
            UECorrectRealSig=opt.tx_data(sub_matrix_correct(1:sum_act_user),:);
            ErrNum_sig=nnz(UECorrectEstSig - UECorrectRealSig);
            UECorrectrx_bin =  de2bi(UECorrectEstSig,log2(opt.M_order),'left-msb');
            tx_bin_com = [];
            for pp=1:opt.T
                tx_bin_com = [tx_bin_com;tx_bin(sub_matrix_correct(1:sum_act_user),:,pp)];
            end
            ErrBit_sig =  nnz(UECorrectrx_bin-tx_bin_com);
        end
        %% BSAMP-GSP
    case 'BSAMP-GSP'
        %% Ԥ����
        support_num=length(support_est);
        Tx_ant_dec=opt.index_mr_single;       %��������ѡ��
        [sum_act_user,sub_matrix,sub_matrix_correct]=find_equal(support_est,opt.index_user_single,opt.S);
        %%
        if sum_act_user==0
            ErrBit_UE=(opt.S-sum_act_user)*opt.T*(log2(opt.M)+log2(opt.M_order));
            ErrBit_mbm=0;
            ErrBit_sig=0;
        else
            Tx_ant_bin=zeros(opt.S,log2(opt.M),opt.T);
            Rx_ant_bin=zeros(support_num,log2(opt.M),opt.T);
            for jjjj=1:opt.T
                Tx_ant_bin(:,:,jjjj)=de2bi(Tx_ant_dec(:,jjjj),log2(opt.M),'left-msb');%����ѡ�����
                Rx_ant_bin(:,:,jjjj) = de2bi(mbm_det1(:,jjjj),log2(opt.M),'left-msb');%���ֵ
            end
            sub_matrix_correct=sub_matrix_correct(1:sum_act_user);
            sub_matrix=sub_matrix(1:sum_act_user);
            ErrBit_UE=(opt.S-sum_act_user)*opt.T*(log2(opt.M)+log2(opt.M_order));%%yes  yes   yes
            %% ��ȷ�������û���mbmѡ���жϴ�����Ŀ
            error_Tx_ant = Tx_ant_dec(sub_matrix_correct,:) - mbm_det1(sub_matrix,:);
            ErrNum_mbm= nnz(error_Tx_ant); %��ȷ�û������������ܺ� %������������ܺ�
            ErrBit_mbm =  nnz(Rx_ant_bin(sub_matrix,:,:)-Tx_ant_bin(sub_matrix_correct,:,:));%��ȷ�û��������������
            %% err_bit_mbm
            %% ���
            if opt.QAM_en==1 % ����QAM
                rx_dec = qamdemod(sig_det/opt.Normuliza,opt.M_order);
            elseif opt.PSK_en==1% ����PSK
                rx_dec = pskdemod(sig_det,opt.M_order);
            end
            UECorrectEstSig=rx_dec(sub_matrix(1:sum_act_user),:);
            UECorrectRealSig=opt.tx_data(sub_matrix_correct(1:sum_act_user),:);
            ErrNum_sig=nnz(UECorrectEstSig - UECorrectRealSig);
            UECorrectrx_bin =  de2bi(UECorrectEstSig,log2(opt.M_order),'left-msb');
            tx_bin_com = [];
            for pp=1:opt.T
                tx_bin_com = [tx_bin_com;tx_bin(sub_matrix_correct(1:sum_act_user),:,pp)];
            end
            ErrBit_sig =  nnz(UECorrectrx_bin-tx_bin_com);
        end
        %% OracleLS
    case 'OracleLS'
        ErrBit_UE=0;
        ErrBit_mbm=0;
        if opt.QAM_en==1 % ����QAM
            rx_dec = qamdemod(sig_det/opt.Normuliza,opt.M_order);
        elseif opt.PSK_en==1% ����PSK
            rx_dec = pskdemod(sig_det,opt.M_order);
        end
        UECorrectrx_bin =  de2bi(rx_dec,log2(opt.M_order),'left-msb');
        tx_bin_com = [];
        for pp=1:opt.T
            tx_bin_com = [tx_bin_com;tx_bin(:,:,pp)];
        end
        ErrBit_sig=nnz(UECorrectrx_bin-tx_bin_com);
%     case 'OracleLSWMM'
%         ErrBit_UE=0;
%         ErrBit_mbm=0;
%         if opt.QAM_en==1 % ����QAM
%             rx_dec = qamdemod(sig_det/opt2.Normuliza,opt2.M_order);
%         elseif opt.PSK_en==1% ����PSK
%             rx_dec = pskdemod(sig_det,opt2.M_order);
%         end
%         UECorrectrx_bin =  de2bi(rx_dec,log2(opt2.M_order),'left-msb');
%         tx_bin_com = [];
%         for pp=1:opt.T
%             tx_bin_com = [tx_bin_com;opt2.tx_bin2(:,:,pp)];
%         end
%         ErrBit_sig=nnz(UECorrectrx_bin-tx_bin_com);
end
end
