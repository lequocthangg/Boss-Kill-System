/////// Edit Boi Blowes


new Float: ViTriBoss[][] = {
	{-1497.0468,770.5491,11.3180}
};
enum bossinfo
    {Float: BossPosX, Float: BossPosY, Float: BossPosZ, BossID, BossTrangThai, BossTime, BossMau}
new conboss[bossinfo];

CMD:xoaboss(playerid, parmas[])
{
	if(PlayerInfo[playerid][pAdmin] < 4) return SendClientMessage(playerid, COLOR_RED, "Ban khong the dung lenh nay");
	if(conboss[BossTrangThai] == 0) return SendClientMessage(playerid, COLOR_RED, "Boss Chua Duoc Tao");
 	DestroyDynamicObject(conboss[BossID]);
 	conboss[BossTrangThai] = 0;
 	SendClientMessageToAll(COLOR_RED, "Boss Da Bien Mat");
	return true;
}
CMD:taoboss(playerid, params[]) {
	if(PlayerInfo[playerid][pAdmin] != 4) return true;
	if(conboss[BossTrangThai] == 1) return SendClientMessage(playerid, COLOR_RED, "Boss Dang Duoc San Lung");
	new rand = random(sizeof(ViTriBoss));
	conboss[BossPosX]	= ViTriBoss[rand][0];
	conboss[BossPosY]	= ViTriBoss[rand][1];
	conboss[BossPosZ]	= ViTriBoss[rand][2];
	conboss[BossTrangThai] = 1;
	conboss[BossMau] = 100000;
	conboss[BossID] = CreateDynamicObject(3434, conboss[BossPosX], conboss[BossPosY], conboss[BossPosZ], 0.0, 0.0, 0.0);
	SendClientMessageToAll(COLOR_RED, "Boss Da Xuat Hien");
	return true;
}
public OnPlayerShootDynamicObject(playerid, weaponid, objectid, Float:x, Float:y, Float:z) {
	if(objectid == conboss[BossID]) {
	    if(conboss[BossTrangThai] != 1) return true;
		new gString[128];
		new satthuong = random(100);
		if(weaponid == 31) satthuong += 200;
		else satthuong += 50;
		conboss[BossMau] -= satthuong;
		format(gString,sizeof(gString), "~y~BOSS:~d~HAI TAC~n~~y~MAU CON LAI:~g~%d", conboss[BossMau]);
		GameTextForPlayer(playerid, gString, 1000, 4);
		new rand = random(12);
		switch(rand) {
		    case 0: {
		    }
		    case 1: {
		    	CreateExplosion(conboss[BossPosX], conboss[BossPosY], conboss[BossPosZ], 6, 10.0);
		    }
		    case 2: {
		        CreateExplosion(conboss[BossPosX], conboss[BossPosY], conboss[BossPosZ], 6, 10.0);
		    }
		    case 3: {
				new ngau = random(4);
                if(ngau == 0) conboss[BossPosX] += 2;
                if(ngau == 1) conboss[BossPosY] += 2;
                if(ngau == 2) conboss[BossPosZ] += 2;
                if(ngau == 3 && conboss[BossPosY]!= 770.5491) conboss[BossPosY] = 770.5491;
		        MoveDynamicObject(conboss[BossID], conboss[BossPosX], conboss[BossPosY], conboss[BossPosZ], 1.5);
		    }
		    case 4: {
		    }
		    case 5: {
		        CreateExplosion(conboss[BossPosX], conboss[BossPosY], conboss[BossPosZ], 6, 10.0);
		    }
		    case 6: {
		    }
		    case 7: {
		        CreateExplosion(conboss[BossPosX], conboss[BossPosY], conboss[BossPosZ], 6, 10.0);
		    }
		    case 8: {
		    }
		    case 9: {
		        CreateExplosion(conboss[BossPosX], conboss[BossPosY], conboss[BossPosZ], 6, 10.0);
		    }
		    case 10: {
		        CreateExplosion(conboss[BossPosX], conboss[BossPosY], conboss[BossPosZ], 6, 10.0);
		    }
		    case 11: {
		    }
		}
		if(conboss[BossMau] <= 0) {
		    DestroyDynamicObject(conboss[BossID]);
		    conboss[BossTrangThai] = 0;
		    GameTextForPlayer(playerid, "~g~Ban Da Tieu Diet Boss", 1000, 4);
			new amount = 100000 + random(150000);
		    GivePlayerCash(playerid, amount);
			GivePlayerValidWeapon(playerid, 25, 300);
            PlayerInfo[playerid][pExp] += 1;
			format(gString,sizeof(gString), "Ban Nhan Duoc: %d + Shotgun Và 1EXP vi da giet duoc boss", amount);
		    SendClientMessage(playerid, COLOR_YELLOW, gString);
		}
	}
	return true;
}
