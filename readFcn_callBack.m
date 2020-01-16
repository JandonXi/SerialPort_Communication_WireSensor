function readFcn_callBack(~,~,wireSensor_serial)
bytesNum=get(wireSensor_serial,'BytesAvailable');
recData=fread(wireSensor_serial,bytesNum,'uchar');
hexData=dec2hex(recData(4:7));
hexData=reshape(hexData.',1,[]);
length=hex2dec(hexData);
disp(length/1000);
end