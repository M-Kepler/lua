function HexStringTofile(hexstr)
	local fileDir="./"..os.time()..".jpg"
	local bytesfile = io.open(fileDir, "wb");
	if nil == bytesfile then
		print("Can not open output file to write!\n");
		os.exit();
	end
	--Convert hex string to bytes
	for i = 1, string.len(hexstr) - 1, 2 do
		local doublebytestr = string.sub(hexstr, i, i+1);
		local n = tonumber(doublebytestr, 16);
		if 0 == n then
			bytesfile:write('\00');
		else
			bytesfile:write(string.format("%c", n));
		end
	end
end

local msg = "439624bb120045bc8738db0a42bf348ed4e941c032b1fbb967ac4e295aedbfd14be014da1aa60e62b31c3dfe6d73569bf2e303468a46f4b63964f074fb7bf923cbfa1899ec216f92a108c4291232eb07c874f1cfb639ada46ef008406434d580a975fcc5c6aeca5be54addf57a4d0f9d9533c76a04d836f1ef07ad9e27651e5a8dadfa52aa6cd9f685fe6fac89f0487ca2131d253660ef954ed24f97929ec8459be38aa4e4c823e6f412dd25be0d50a5f61a86bc144717ebefc75b34a977a0082349bf97e157c7e122770bbe7fdd20b95b9464d0a0f9f48ca1a349d7d927331deef78a80ac060a149411db6c12f4407fe5ee7760021e3222d6f1711176d871f0"
HexStringTofile(msg)

