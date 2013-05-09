
//互斥锁
pthread_mutex_t mutex;
pthread_mutex_init();		//pthread_mutex_destroy();
pthread_mutex_lock();		//pthread_mutex_unlock();
pthread_mutex_trylock();



DBCommon
RegisterUser

DBOTT
RegisterDevice

std::map<std::string /* sn */, std::vector<std::string> /* productName vector */> entitleMap;
for (int i=0; i < iNumOfDevice; i++)
{
	struct DeviceEntitleInfo de;
	char cid[30];

	sprintf_s(cid, 30, "sn%d", i);
	de.sn = cid;

	std::vector<std::string> strVec;
	for (int j=0; j < iNumOfEntitles; j++)
	{
		sprintf_s(cid, 30, "product%d", j);
		de.productName = cid;
		strVec.push_back(de.productName);
	}
	entitleMap[de.sn] = strVec;
}

struct DeviceEntitleInfo1
{
	std::string sn;					// 设备唯一编号（DVB：CardSN；IPTV/OTT STB：SN）
	std::string productName;		// 产品名称

	bool operator== (const DeviceEntitleInfo1& key) const
	{
		if(sn == key.sn && productName == key.productName)
			return true;
		return false;
	}
	
	bool operator< (const DeviceEntitleInfo1& key) const
	{
		int resultSN = strcmp(sn.c_str(), key.sn.c_str());
		if(resultSN < 0)
			return true;
		else if (0 == resultSN)
			return (strcmp(productName.c_str(), key.productName.c_str()) < 0);
		else
			return false;
	}
};


/* todo
1.	RegisterUser, if MaxDeviceNum decreased

?? 	Use hash for better performance. Currently using map or vector, doesn't have much difference in setup, slow lookup for vector tho.
	list?
	http://stackoverflow.com/questions/133569/hashtable-in-c


	int (*Check)(int x);		//dynamically load?
	int Check(int x);			//load at compile time/run time?


*/