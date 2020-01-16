% serial communication for wire sensor
clear
clc

%% init port

wireSensor_serial=serial('com3');
wireSensor_serial.ReadAsyncMode='continuous';
wireSensor_serial.BytesAvailableFcnCount=9;
wireSensor_serial.BytesAvailableFcnMode='byte';
wireSensor_serial.BytesAvailableFcn={@readFcn_callBack,wireSensor_serial};

%% open port

try
    fopen(wireSensor_serial);
catch
    disp('串口打开失败,fclose(instrfind)?');
    return;
end;

%% date communication (write & read)

while 1
    keyValue=input('measure lengths , [Y] or [N] :?','s');
    if(keyValue=='Y')
        % sendData from 2# to 7# wire sensor
        sendData=['06';'03';'00';'00';'00';'02';'c5';'bc';
            '07';'03';'00';'00';'00';'02';'c4';'6d';
            '08';'03';'00';'00';'00';'02';'c4';'92';
            '09';'03';'00';'00';'00';'02';'c5';'43';
            '0a';'03';'00';'00';'00';'02';'c5';'70';
            '0b';'03';'00';'00';'00';'02';'c4';'a1';];
        
        % sendData_test=['06';'03';'00';'00';'00';'02';'c5';'bc'];
        
        % 16进制 2 10进制
        sendData=hex2dec(sendData);
        % 写入串口
        % fwrite(wireSensor_serial,sendData_test,'uint8');
        
        for i=1:6
            fwrite(wireSensor_serial,sendData(i*8-7:i*8),'uint8');
            % 延时0.05s
            pause(0.05);
        end
        continue;
    else
        break;
    end
end

%% close port

fclose(wireSensor_serial);
delete(wireSensor_serial);
