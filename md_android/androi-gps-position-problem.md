     
# 1.彻底解决Android GPS没法定位这一顽固问题
https://www.cnblogs.com/zhchoutai/p/8469896.html 发布于 2018-02-25 17:18


 [大家去网上搜索Android定位location为null没法定位问题。预计有一大堆文章介绍怎样来解决。可是最后大家发现基本没用。]{style="font-size: 18px"}]{style="font-family: Times New Roman"}

本文将从Android定位实现原理来深入分析没法定位原因并提出真正的解决方式。

在分析之前，我们肯定得先看看android官方提供的定位SDK。



## 1.1默认Android GPS定位实例

### 1.1.1获取LocationManager: 
  
```java
mLocationManager = (LocationManager) getSystemService(Context.LOCATION_SERVICE);
```
 
###  1.1.2选择Location Provider： 
 
 Android系统存在多种provider,各自是  
>    (1)GPS_PROVIDER:         
>      这个就是手机里有GPS芯片，然后利用该芯片就能利用卫星获得自己的位置信息。可是在室内，GPS定位基本没用，非常难定位的到。
>      
>     (2)NETWORK_PROVIDER：
>     这个就是利用网络定位，一般是利用手机基站和WIFI节点的地址来大致定位位置，
>     这样的定位方式取决于server，即取决于将基站或WIF节点信息翻译成位置信息的server的能力。因为眼下大部分Android手机没有安装google官方的location
>      manager库。大陆网络也不同意。即没有server来做这个事情，自然该方法基本上没法实现定位。
> 
>     (3)PASSIVE_PROVIDER: 
>     被动定位方式。这个意思也比較明显。就是用现成的，当其它应用使用定位更新了定位信息。系统会保存下来。该应用接收到消息后直接读取就能够了。比方假设系统中已经安装了百度地图，高德地图(室内能够实现精确定位)。你仅仅要使用它们定位过后。再使用这样的方法在你的程序肯定是能够拿到比較精确的定位信息。 
  
用户能够直接指定某一个provider 
 
```java
String provider = mLocationManager.getProvider(LocationManager.GPS_PROVIDER);
```
     
也能够提供配置，由系统依据用户的配置为用户选择一个最接近用户需求的provider  

```java
Criteria crite = new Criteria();  
crite.setAccuracy(Crite.ACCURACY_FINE); //精度
crite.setPowerRequirement(Crite.POWER_LOW); //功耗类型选择
String provider = mLocationManager.getBestProvider(crite, true); 
```

### 1.1.3获取Location   
```java
Location location = mLocationManager.getLocation(provider);  
```
 
然后你会发现，这个返回的location永远为null,你自然没法定位。然后网上到处是咨询为啥获得的location为null,相同网络到处是解决问题的所谓解决方式。


# 1.2所谓解决方式 
   网上有人说。一開始location是非常有可能是null的，这是由于程序还从来没有请求过，仅仅需又一次请求更新location，并注冊监听器以接收更新后的location信息。

```java
LocationListener locationListener = new LocationListener() {
        @Override
        public void onStatusChanged(String provider, int status, Bundle extras) {
        }
        @Override
        public void onProviderEnabled(String provider) {
        }

        @Override
        public void onProviderDisabled(String provider) {
        }

        @Override
        public void onLocationChanged(Location location) {
            longitude = location.getLongitude();
            latitude  = location.getLatitude();
            Log.d(TAG,"Location longitude:"+ longitude +" latitude: "+ latitude );
        }
};
mLocationManager.requestLocationUpdates(serviceProvider, 10000, 1, this);
```

 然后你发现onLocationChanged永远不会被调用，你仍然没法获取定位信息。


## 1.3  为什么就没法获取到location呢？  
   
事实上在上面我已经提到了，全部上面的解决的方案都没有解决根本问题，那就是当你在室内开发时。你的手机根本就没法获取位置信息，你叫系统怎样将位置信息通知给你的程序。 
所以要从根本上解决问题，就要解决位置信息获取问题。刚刚也提到了，仅仅有NETWORK_PROVIDER这样的模式才是室内定位可靠的方式，仅仅只是因为大陆的怪怪网络，且大部分厂商也不会用google的服务，这样的定位方式默认是没法用的。那怎么办？好办，找个替代的服务商就能够了，百度的位置信息sdk就能够解决问题。

它的基本原理在上面已经提到过了，就是搜集你的wifi节点信息和你的手机基站信息来定位。
 

## 1.4真正的解决方式，使用百度位置定位SDK 
 

### 1.4.1SDK下载： 

    http://pan.baidu.com/s/1i3xGMih 

      
  当然大家能够在官网下载，这样能够下载到最新的sdk  
 http://lbsyun.baidu.com/sdk/download 

### 1.4.2SDK使用： 
> >  申请百度的服务密钥。详细操作步骤见官网： 
>
> >  
> >   [http://api.map.baidu.com/lbsapi/cloud/geosdk.htm](http://api.map.baidu.com/lbsapi/cloud/geosdk.htm) 
>
> >   2．将上面下载的sdk文件locSDK_4.1.jar复制到你项目的libs下 
>
> >  3.  改动AndroidManifest文件，在该文件中加入例如以下配置 

```html
        <service
            android:name="com.baidu.location.f"
            android:enabled="true"
            android:process=":remote" >
        </service>
        <meta-data
            android:name="com.baidu.lbsapi.API_KEY"
            android:value="xxxxx " />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
```
      
上面meta-data中value的值改为你自己的密钥

##  代码里调用sdk：
 

```java
public class LocationUtil {
    private final static boolean DEBUG = true;
    private final static String TAG = "LocationUtil";
    private static LocationUtil mInstance;
    private BDLocation mLocation = null;
    private MLocation  mBaseLocation = new MLocation();

    public static LocationUtil getInstance(Context context) {
        if (mInstance == null) {
            mInstance = new LocationUtil(context);
        }
        return mInstance;
    }

    Context mContext;
    String mProvider;
    public BDLocationListener myListener = new MyLocationListener();
    private LocationClient mLocationClient;
    
    public LocationUtil(Context context) {
        mLocationClient = new LocationClient(context.getApplicationContext());
        initParams();
        mLocationClient.registerLocationListener(myListener);
    }

    public void startMonitor() {
        if (DEBUG) Log.d(TAG, "start monitor location");
        if (!mLocationClient.isStarted()) {
            mLocationClient.start();
        }
        if (mLocationClient != null && mLocationClient.isStarted()) {
            mLocationClient.requestLocation();
        } else {
             Log.d("LocSDK3", "locClient is null or not started");
        }
    }

    public void stopMonitor() {
        if (DEBUG) Log.d(TAG, "stop monitor location");
        if (mLocationClient != null && mLocationClient.isStarted()) {
            mLocationClient.stop();
        }
    }
    
    public BDLocation getLocation() {
        if (DEBUG) Log.d(TAG, "get location");
        return mLocation;
    }
    
    public MLocation getBaseLocation() {
        if (DEBUG) Log.d(TAG, "get location");
        return mBaseLocation;
    }
    
    private void initParams() {
        LocationClientOption option = new LocationClientOption();
        option.setOpenGps(true);
        //option.setPriority(LocationClientOption.NetWorkFirst);
        option.setAddrType("all");//返回的定位结果包括地址信息
        option.setCoorType("bd09ll");//返回的定位结果是百度经纬度,默认值gcj02
        option.setScanSpan(5000);//设置发起定位请求的间隔时间为5000ms
        option.disableCache(true);//禁止启用缓存定位
        option.setPoiNumber(5);    //最多返回POI个数   
        option.setPoiDistance(1000); //poi查询距离        
        option.setPoiExtraInfo(true); //是否须要POI的电话和地址等具体信息        
        mLocationClient.setLocOption(option);
    }


    public class MyLocationListener implements BDLocationListener {
        @Override
        public void onReceiveLocation(BDLocation location) {
            if (location == null) {
                return ;
            }
            mLocation = location;
            mBaseLocation.latitude = mLocation.getLatitude();
            mBaseLocation.longitude = mLocation.getLongitude();
            
            StringBuffer sb = new StringBuffer(256);
            sb.append("time : ");
            sb.append(location.getTime());
            sb.append("\nerror code : ");
            sb.append(location.getLocType());
            sb.append("\nlatitude : ");
            sb.append(location.getLatitude());
            sb.append("\nlontitude : ");
            sb.append(location.getLongitude());
            sb.append("\nradius : ");
            sb.append(location.getRadius());
            sb.append("\ncity : ");
            sb.append(location.getCity());
            if (location.getLocType() == BDLocation.TypeGpsLocation){
                sb.append("\nspeed : ");
                sb.append(location.getSpeed());
                sb.append("\nsatellite : ");
                sb.append(location.getSatelliteNumber());
            } else if (location.getLocType() == BDLocation.TypeNetWorkLocation){
                sb.append("\naddr : ");
                sb.append(location.getAddrStr());
            }
            if (DEBUG) Log.d(TAG, "" + sb);
        }

        public void onReceivePoi(BDLocation poiLocation) {
        }
    }
    
    public class MLocation {
        public double latitude;
        public double longitude;
    }
}
```

 当然别忘了在setting里将gps定位打开 

 