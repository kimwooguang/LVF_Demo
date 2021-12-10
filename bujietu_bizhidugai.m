clc;
clear;
close all;

%%

batch_num='11';
% col_num=[
% 778  4054%2-3
% % 786  4167
% % 778 4023
%
% ];

b_filter=1;
%����ƽ����������׵Ŀ�Ⱥܴ�:��Χ��1~65����:1��26��65
filter_window=1;
%�ص����������Ĳ���:��Χ��1900~2500����
limit = 2250;
%���޸Ķ�ȡ�ļ�·��
data_file='C:\Users\CP\Desktop\table\matlab_lvguangpian_10\11\';
%���޸�����
Date = '2021111111';
%���޸ı����·��
disk = 'E';
%ѡ�������ͼƬ
test = 1000;
%�̶�����·��
pathp = [disk,':\LVF_Data\',Date,'_Pra_Rat_Res'];
%�̶������ļ���
mkdir (pathp);
%�̶������·��
savepath = [pathp,'\'];
%��ȡ����λ��
xxxx1=1000;
xxxx2=2500;
% data_file='F:\ʵ��123456789101112131415161718192021\lvf��ʮ��20210714\';

%��ȡ�ļ����б�
files_list = dir(fullfile(data_file));
for diri=3:size(files_list,1)
    %���뵽�ļ��б����·��
    card_datapath = files_list(diri,1).name;
    if isempty(strfind(card_datapath,'.xlsx'))==1
        
        % filepath = 'C:\Users\CGCP\Desktop\lvf_test_data\3-1\';
        filepath=[data_file,card_datapath,'\'];
        
        %% ����ͼƬ�ü������У�Ѱ��
        wl=400:50:1000;
        pos=[];
        vwidths=[];
        kk=wl(1,2)-wl(1,1);
        bb=wl(1,1)-kk;
        
        %         figure;
        %         hold on;
        figure;
        hold on;
        
        
        vi=(i-bb)/kk;
        %���������Ĳ���
        I=imread(strcat(filepath,num2str(test),'.tif'));
        [h,w]=size(I);
        %ѡ�������λ��
        I = I(1:limit,:);
        x1=100;%����һ����
        n=50;
        nx=floor((w-200)/(n-1));%������
        xi=x1:nx:w-100;
        %             I=I(:,col_num(1,1):col_num(1,2));
        for ii=1:n
            Ii=I(:,xi(ii):xi(ii)+100);
            sIi=sum(Ii,2);
            if b_filter==1
                windowSize = filter_window;
                b = (1/windowSize)*ones(1,windowSize);
                a = 1;
                sIi = filter(b,a,sIi);
            end
            %% Ѱ��
            
            %             [sI,posi,widths,locs,pks]=xunfeng(I,wl,vi);
            %             plot(sI,'-','color',[rand,rand,rand]);
            
            
            %             vwidths=[vwidths,widths];
            %             pos=[pos posi];
            [num loc] = findpeaks(sIi);
            [a_num,a_loc] = max(num);                          %��ȫ����ֵ�����ҳ�����һ��a_num��������λ��a_loc
            location_in_x_1 = loc(a_loc);                      %���ķ�ֵ��Ӧ��λ��
            num(a_loc) = 0;                                    %���ҳ���ȫ����ֵ�����У������ķ�ֵ��ֵΪ0
            num_del_max = num;
            [b_num,b_loc] = max(num);                          %��ʣ�µķ�ֵ�е����ֵ
            location_in_x_2 = loc(b_loc);
            
            plot(sIi)%�ҵڶ���ķ�ֵ��Ӧ��λ��
            %��ȡ��һ��͵ڶ���Ĳ���ȡ����������е㣬���������������Զ��ѡ���һ������
            if abs(location_in_x_1 - location_in_x_2) > 20 && abs(sIi(location_in_x_1)  - sIi(location_in_x_2)) > 30000
                plot((location_in_x_1+location_in_x_2)/2,(sIi(location_in_x_1)+sIi(location_in_x_2))/2,'r*');
            else
                plot(location_in_x_1,sIi(location_in_x_1),'r*');
            end
            %plot(location_in_x_1,sIi(location_in_x_1),'r*');
            
            
            %                 x = 1 : 1 : h;
            %                 y = sIi;
            %                 plot(y,'-','color',[rand,rand,rand]);
            %                 yy = sort(y);
            %                 xx = find(y == yy(end));
            %                 plot(xx,yy(end),'r*');
            
        end
        for i= wl
            
            vi=(i-bb)/kk;
            I=imread(strcat(filepath,num2str(i),'.tif'));
            %             I=I(:,col_num(1,1):col_num(1,2));
            I = I(1:limit,:);
            sI=sum(I,2);
            [h,w]=size(I);
            
            
            n=20;
            t1=floor(w/3);%����һ����
            nt=floor((w/3)/(n-1));%������
            ti=t1:nt:floor(2*w/3);
            
            %             wl=400:100:1000;
            %             pos5t=zeros(size(wl,2),5);
            %             parall_kbrr=zeros(size(wl,2),4);
            
            %% Ѱ��
            for ii=1:n
                Ii=I(:,ti(ii):ti(ii)+100);
                sIi=sum(Ii,2);
                if b_filter==1
                    windowSize = filter_window;
                    b = (1/windowSize)*ones(1,windowSize);
                    a = 1;
                    sIi = filter(b,a,sIi);
                end
                
                [num loc] = findpeaks(sIi);
                [a_num,a_loc] = max(num);                          %��ȫ����ֵ�����ҳ�����һ��a_num��������λ��a_loc
                location_in_x_1 = loc(a_loc);                      %���ķ�ֵ��Ӧ��λ��
                num(a_loc) = 0;                                    %���ҳ���ȫ����ֵ�����У������ķ�ֵ��ֵΪ0
                num_del_max = num;
                [b_num,b_loc] = max(num);                          %��ʣ�µķ�ֵ�е����ֵ
                location_in_x_2 = loc(b_loc);
                
                %��ȡ��һ��͵ڶ���Ĳ���ȡ����������е㣬���������������Զ��ѡ���һ������
                if abs(location_in_x_1 - location_in_x_2) > 20 && abs(sIi(location_in_x_1)  - sIi(location_in_x_2)) > 30000
                    pos5t(vi,ii) = (location_in_x_1+location_in_x_2)/2;
                else
                    pos5t(vi,ii) = location_in_x_1;
                end
                
            end
            
            
            
            
            
            
            
            
        end
        clear i1 ii jj;
        
        figure;
        hold on;
        for i1=1:size(pos5t,1)
            % ������
            pni = polyfit(ti,pos5t(i1,:),1);
            pos_fiti = polyval(pni,ti);
            di=abs(pos_fiti-pos5t(i1,:));
            rri=norm(pos_fiti-mean(pos5t(i1,:)))^2/norm(pos5t(i1,:)-mean(pos5t(i1,:)))^2;
            parall_kbrr(i1,:)=[pni(1,1) pni(1,2) rri max(di)];
            plot(ti,pos5t(i1,:),'-o','color',[rand rand rand]);
        end
        hold off;
        xlabel('column number');
        ylabel('pos_i');
        title([card_datapath,32,'��������λ']);
        %         saveas(gcf,[savepath,card_datapath,'_Ratio_pos1-pos5.bmp']);
        
        
        
        %���������ͼȡ50����
        x1=100;%����һ����
        n=50;
        nx=floor((w-200)/(n-1));%������
        xi=x1:nx:w-100;
        
        %50���㰴���ֱ����ķ�λ
        pos_nt=zeros(size(wl,2),n);
        for ii=1:size(wl,2)
            for jj=1:n
                pos_nt(ii,jj)=parall_kbrr(ii,1)*xi(1,jj)+parall_kbrr(ii,2);
            end
        end
        clear i ii jj sIi;
        
        %50����Ѱ��Ѱ�ķ�λ
        pos_nx=zeros(size(wl,2),n);
        for i=wl
            vi=(i-bb)/kk;
            
            I=imread(strcat(filepath,num2str(i),'.tif'));
            %             I=I(:,col_num(1,1):col_num(1,2));
            I = I(1:limit,:);
            %% Ѱ��
            for ii=1:n
                Ii=I(:,xi(ii):xi(ii)+100);
                sIi=sum(Ii,2);
                if b_filter==1
                    windowSize = filter_window;
                    b = (1/windowSize)*ones(1,windowSize);
                    a = 1;
                    sIi = filter(b,a,sIi);
                end
                
                [num loc] = findpeaks(sIi);
                [a_num,a_loc] = max(num);                          %��ȫ����ֵ�����ҳ�����һ��a_num��������λ��a_loc
                location_in_x_1 = loc(a_loc);                      %���ķ�ֵ��Ӧ��λ��
                num(a_loc) = 0;                                    %���ҳ���ȫ����ֵ�����У������ķ�ֵ��ֵΪ0
                num_del_max = num;
                [b_num,b_loc] = max(num);                          %��ʣ�µķ�ֵ�е����ֵ
                location_in_x_2 = loc(b_loc);
                
                %��ȡ��һ��͵ڶ���Ĳ���ȡ����������е㣬���������������Զ��ѡ���һ������
                if abs(location_in_x_1 - location_in_x_2) > 20 && abs(sIi(location_in_x_1)  - sIi(location_in_x_2)) > 30000
                    pos_nx(vi,ii)=(location_in_x_1+location_in_x_2)/2;
                else
                    pos_nx(vi,ii)=location_in_x_1;
                end
                
            end
        end
        
        
        pos_nxnt15=[]; %abs(yi-y')>15�Ĳ���
        pos_ntnx=pos_nt-pos_nx;
        figure;
        hold on;
        for i=1:size(pos_nx,1)
            plot(xi,pos_ntnx(i,:),'color',[rand rand rand]);
            %             if abs(max(pos_nxnt(i,:))-min(pos_nxnt(i,:)))>15
            %                 pos_nxnt15(end+1)=i*100+300;
            %             end
        end
        hold off;
        xlabel('column number');
        ylabel('pos_nt-pos_nx');
        leg = legend('400','450','500','550','600','650','700','750','800','850','900','950','1000');
        set(leg,'Location','NorthEastOutside');
        title([card_datapath,32,'pos(nt)-pos(nx)']);
        saveas(gcf,[savepath,card_datapath,'_Ratio_pos_nt-pos_nx.bmp']);
        savefig([savepath,card_datapath,'_Ratio_pos_nt-pos_nx.fig']);
        
        aa_max=max(pos_ntnx');
        aa_min=min(pos_ntnx');
        
        
        
        figure;
        hold on;
        for aaa=1:size(xi,2)
            if xi(1,aaa)<=xxxx1 && xi(1,aaa+1)>xxxx1
                xxxxleft=aaa;
            end
            if xi(1,aaa)<xxxx2 && xi(1,aaa+1)>=xxxx2
                xxxxright=aaa;
            end
        end
        
        for i=1:size(pos_ntnx,1)
            plot(xi(1,xxxxleft:xxxxright),pos_ntnx(i,xxxxleft:xxxxright),'color',[rand rand rand]);
            if abs(max(pos_ntnx(i,xxxxleft:xxxxright))-min(pos_ntnx(i,xxxxleft:xxxxright)))>15
                pos_nxnt15(end+1)=i*kk+bb;
            end
        end
        hold off;
        xlabel('column number');
        ylabel('pos_nt-pos_nx');
        leg1 = legend('400','450','500','550','600','650','700','750','800','850','900','950','1000');
        set(leg1,'Location','NorthEastOutside');
        
        title([card_datapath,32,'pos(nt)-pos(nx)',32,'xxxx']);
        %         saveas(gcf,[savepath,card_datapath,'_Ratio_pos_nx-pos_nt_xxxx.bmp']);
        %         savefig([savepath,card_datapath,'_Ratio_pos_nx-pos_nt_xxxx.fig']);
        
        %         xi_posnx_posnt=[xi(1,xxxxleft:xxxxright);pos_nxnt(:,xxxxleft:xxxxright)];
        %         save([filepath,'\',batch_num,'_',card_datapath,'_xi_posnx_posnt.mat'],'xi_posnx_posnt');
        
        figure;
        for i=1:size(pos_nx,1)
            plot(wl,aa_max-aa_min,'b-o');
        end
        xlabel('wavelength');
        ylabel('max-min   (pos_nt-pos_nx)');
        title([card_datapath,32,'max-min   (pos(nt)-pos(nx))']);
        saveas(gcf,[savepath,card_datapath,'_Ratio_max-min_(pos_nt-pos_nx).bmp']);
        savefig([savepath,card_datapath,'_Ratio_max-min_(pos_nt-pos_nx).fig']);
        
        %����xslx
        xlswrite([savepath,card_datapath,'_Ratio_max-min.xlsx'],{'wavelength';'max';'min';'max-min';'max(max-min)'},card_datapath,'A1');
        str_num=wl;
        xlswrite([savepath,card_datapath,'_Ratio_max-min.xlsx'],str_num,card_datapath,'B1');
        
        xlswrite([savepath,card_datapath,'_Ratio_max-min.xlsx'],aa_max,card_datapath,'B2');
        xlswrite([savepath,card_datapath,'_Ratio_max-min.xlsx'],aa_min,card_datapath,'B3');
        xlswrite([savepath,card_datapath,'_Ratio_max-min.xlsx'],aa_max-aa_min,card_datapath,'B4');
        xlswrite([savepath,card_datapath,'_Ratio_max-min.xlsx'],max(aa_max-aa_min),card_datapath,'B5');
%        figure('Renderer', 'painters', 'Position', [0 0 1920 950]);
%                     t = tiledlayout(13,1);
        N=13; % ���100
 





%         figure('Renderer', 'painters', 'Position', [0 0 1920 950]);
%         a=imread('E:\LVF_Data\2021111111_Pra_Rat_Res\2-6_false400.bmp');
%         imshow(a);
%         b=imread('E:\LVF_Data\2021111111_Pra_Rat_Res\2-6_false450.bmp');
%         figure;
%         imshow(b);
%         c = [a;b];
%         figure;
%         imshow(c);
        img = zeros((240*13),4864);
        lim = 120;
        yyt = zeros(13,50);
        yyx = zeros(13,50);
        figure;
        for i = wl
            vi = (i - 350)/50;
            I=imread(strcat(filepath,num2str(i),'.tif'));
            %I=I(:,col_num(1,1):col_num(1,2));
            %             img(((vi - 1) * lim*2)+1:(vi*(lim*2)),:) = I(pos_nx(vi,1)-lim:pos_nx(vi,1)+lim-1,:);
            %
            %             imshow(uint8(img));
            img(((vi - 1) * lim*2)+1:(vi*(lim*2)),:) = I(pos_nx(vi,1)-lim:pos_nx(vi,1)+lim-1,:);

            imshow(uint8(img));

            yyt(vi,:) = ((vi - 1) * lim*2)+pos_nt((i - 350)/50,:)-(pos_nt((i - 350)/50,1)-120);
            yyx(vi,:) = ((vi - 1) * lim*2)+pos_nx((i - 350)/50,:)-(pos_nx((i - 350)/50,1)-120);


            %             saveas(gcf,[savepath,card_datapath,'_false',num2str(i),'.tif']);

        end
        hold on;
        plot(xi,yyt,'bo');
        plot(xi,yyx,'r*');
        saveas(gcf,[savepath,card_datapath,'_false','400-1000_pingxing','.bmp']);
        clear i I sI;
        
        %���쳣�׵����η�λ
        for i=pos_nxnt15  %1:size(pos_nxnt15,2)
            
            vi=(i-bb)/kk;
            I=imread(strcat(filepath,num2str(i),'.tif'));
            %I=I(:,col_num(1,1):col_num(1,2));
            sI=sum(I,2);
            
            figure;
            imshow(I);
            hold on;
            plot(xi,pos_nt(vi,:),'bo');
            plot(xi,pos_nx(vi,:),'r*');
            hold off;
            xlabel('column number');
            ylabel('pos');
            title([num2str(i),'nm']);
            %             saveas(gcf,[filepath,'\',card_datapath,'_false',num2str(i),'.bmp']);
        end
        
        
        
        
        
    end
    
end















