clear all;close all;
file_path ='E:\20220601影像處理課檔案\hall\';%取得目標資料夾路徑
img_path_list = dir(strcat(file_path,'*.bmp'));%讀取該資料夾的所有.bmp檔
img_num = length(img_path_list);%獲取目標影象的總數量
%設定欲處理的參數
img_num=20;
row=240;
col=360;
dW=5;
%處裡檔案(輸入資料img_num和img_path_list，輸出資料outdata)
outdata=uint8(zeros(img_num,row,col));
for i=1:img_num
	%取得影像資料
	img_name=img_path_list(i).name;
	img=imread(strcat(file_path,img_name));
	%統一影像規格
	img_size=imresize(img,[row,col]);
	%將影像處理成灰階
	img_gray=rgb2gray(img_size);
	%將影像疊再一起
	outdata(i,:,:)=img_gray(:,:);
end
%傅立葉轉換
tem=zeros(img_num,col);
OUTPUT=zeros(img_num,row,col);
for i=1:row
	tem(:,:)=outdata(:,i,:);
	FFT_IMG=fft2(tem);
	FFT_IMG_SH=fftshift(FFT_IMG);
	for s=1:img_num%遮擋影像低頻部分
		if(s>(img_num/2-dW)&&s<(img_num/2+dW))
			FFT_IMG_SH(s,:)=0;
		end
	end
	for s=1:col%遮擋影像低頻部分
		if(s>(col/2-dW)&&s<(col/2+dW))
			FFT_IMG_SH(:,s)=0;
		end
	end
	FFT_IMG=ifftshift(FFT_IMG_SH);
	tem=ifft2(FFT_IMG);
	%消除複數，並反轉影像顏色
	OUT=imcomplement(uint8(abs(tem)));
	OUTPUT(:,i,:)=OUT;
end
%輸出顯示
for i=1:99
	for j=1:img_num
		OUTPUT2(:,:)=uint8(OUTPUT(j,:,:));
		imshow(OUTPUT2);
	end
end
%OUTPUT2(:,:)=uint8(OUTPUT(15,:,:));
%imshow(OUTPUT2);