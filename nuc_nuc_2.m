function [nuc_coord,a,numb_frame,metadata]=nuc_nuc(fname,fname_folder2,fname_file,thr1,thr2,thr3)

%%%%MASTER m-FILE>>crop_nuc.m%%%%%%%%%%%
%%%%%%%%%%%%Extract each img from .dv%%%
result=bfopen(fname);
metadata=result{1,2};
a=result{1,1};
s=size(a); 
numb_frame=s(1,1); %s(1,1):#offrame
nuc_coord=cell(numb_frame,1);%make rooms for coordinates of nuclei.(ea room=frame)

  for n=1:numb_frame/2 %just for now, run for green channel
   
      img0 = a{n,1}; %%final matrix(512x512)img
      %figure,imshow(img1,[])
       min_value=double(min(min(img0)));  %line6-9: correction
       max_value=double(max(max(img0)));
       img1=mat2gray(img0,[min_value  max_value]);
    %%%%%%%%%%%segmenting area with the int over the threshold(mean)%%%%%%%
    imgg=imgaussfilt(img1,8);%%(img,sigma)%%defalt8
    gth0=graythresh(imgg);%otsu
% %         %%%% at low confluency%%%
        if n<13
        gth=gth0*thr1;
        gth1=gth/gth0;
        %1fr>2.3 25fr>1.5
        elseif n>12 && n<20
        gth=gth0*thr2;
        gth2=gth/gth0;
        else n>19
        gth=gth0*thr3;
        gth3=gth/gth0;
        end 
         
% % %     %%%% at high confluency%%%
%         if n<13
%         gth=gth*1.7; %2.5
%         %%%%%%%%%%%%% 1fr>2.3 25fr>1.5
%         elseif n>12 && n<20
%         gth=gth*1.7; %1.9
%         else n>19
%         gth=gth*1.7; %1.5
%         end
    
    ibw=im2bw(imgg,gth);
    %%%%%%Find cells%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    stats=regionprops('table',ibw,'Centroid','Area');
        ct=stats.Centroid;
        area= stats.Area;
        del=find(area<800);

        ct(del,:)=[]; %new data
        area(del)=[];
     nuc_coord{n,1}=ct;%%output data
 
    %%%%%%%if you want to look indiv img selection%%%%%%%%%%%%%%%%%%%%%%%%%
%          figure,
%          subplot(1,2,1),imshow(ibw);   
%          subplot(1,2,2),imshow(img1,[])
%          x=ct(:,1);
%          y=ct(:,2);
%          hold on, plot(x,y,'*-')
%             A = [1:length(ct)]'; B = num2str(A); numb = cellstr(B);
%             dx = 0.1; dy = 0.1; % displacement so the text does not overlay the data points
%          hold on, text(x+dx, y+dy, numb, 'color', 'r');

    %%%%%% save 1st frame with labling for selected nuclei%%%%%%%%%%%%%%%%%%%%%%%%%%
      if n==1
         figure,
         subplot(1,2,1),imshow(ibw);   
         subplot(1,2,2),imshow(img1,[])
         x=ct(:,1);
         y=ct(:,2);
         hold on, plot(x,y,'*-')
            A = [1:length(ct)]'; B = num2str(A); numb = cellstr(B);
            dx = 0.1; dy = 0.1; % displacement so the text does not overlay the data points
         hold on, text(x+dx, y+dy, numb, 'color', 'r');
        fname_save=[fname_folder2 fname_file '.bmp']
        saveas(gcf,fname_save)
      end  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

  end
 all_gth=[gth1 gth2 gth3];    
    
end






%  end


