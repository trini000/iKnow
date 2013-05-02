
//»¥³âËø
pthread_mutex_t mutex;
pthread_mutex_init();		//pthread_mutex_destroy();
pthread_mutex_lock();		//pthread_mutex_unlock();
pthread_mutex_trylock();



DBCommon
RegisterUser

DBOTT
RegisterDevice




/* todo
1.	RegisterUser, if MaxDeviceNum decreased

?? 	Use hash for better performance. Currently using map or vector, doesn't have much difference, slow lookup.
	http://stackoverflow.com/questions/133569/hashtable-in-c




*/