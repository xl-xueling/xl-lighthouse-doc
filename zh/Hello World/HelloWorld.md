##  XL-LightHouse接入只需要三步操作
- 1、在Web页面创建统计组，配置相应的元数据结构；
- 2、在Web页面创建统计项；
- 3、调用SDK上报原数据消息；

然后就可以在Web页面查看统计数据了。

##  范例一：首页ICON区域用户行为数据统计
<img src="https://lighthousedp-1300542249.cos.ap-nanjing.myqcloud.com/4301-2/1.png"  width="300px" height="200px" />

该区域包含3个Tab，每个Tab有多个业务ICON图标，用户手动滑动可切换Tab，假设针对该ICON区域我们有如下数据指标需求：

```
点击量：
1、每5分钟_点击量
2、每5分钟_各ICON_点击量
3、每小时_点击量
4、每小时_各ICON_点击量
5、每天_总点击量
6、每天_各Tab_总点击量
7、每天_各ICON_总点击量

点击UV:
1、每5分钟_点击UV
2、每小时_点击UV
3、每小时_各ICON_点击UV
4、每天_总点击UV
5、每天_各ICON_总点击UV
```

+ 定义元数据结构：

| 字段 | 字段类型 | 描述 |  |
| --- | --- | --- | --- |
| user_id | string | 用户标识 |  |
| tab_id | string | Tab栏 | tab1、tab2、tab3 |
| icon_id | string | 美食团购、酒店民宿、休闲玩乐、打车 ...|  |

+ 上报元数据时机
  用户点击ICON图标时上报相应埋点数据

+ 配置统计项

<img src="https://lighthousedp-1300542249.cos.ap-nanjing.myqcloud.com/4301-2/2.png"  width="800px" height="400px" />

+ 模拟数据接入
```
@Test
    public void iconTest() throws Exception {
        //连接RPC模块注册中心，默认为RPC部署(lighthouse-ice)的前两个节点
      LightHouse.init("10.206.7.15:4061,10.206.7.5:4061");
        for(int i=0;i<1000;i++){
            HashMap<String,Object> paramMap = new HashMap<>();
            paramMap.put("user_id","user-" + ThreadLocalRandom.current().nextInt(500));
            paramMap.put("tab_id","tab_" + ThreadLocalRandom.current().nextInt(3));
            paramMap.put("icon_id","icon_" + ThreadLocalRandom.current().nextInt(30));
            //参数1对应统计组token，参数2对应统计组秘钥，参数3是消息事件的13位时间戳 
			LightHouse.stat("homepage_icon_click","f1ghKrnIQaRpbWOX0HOO2EaOXQ19ymXD",paramMap,System.currentTimeMillis());
        }
		 //注意：stat方法为异步发送，如果进程直接退出可能会导致部分消息没有发送出去，所以这里加一个sleep。
        Thread.sleep(10 * 1000);
		System.out.println("send ok!");
    }
```
+  查看统计结果

<img src="https://lighthousedp-1300542249.cos.ap-nanjing.myqcloud.com/4301-2/3.png"  width="800px" height="400px" />


## 范例二：移动支付订单数据统计

<img src="https://lighthousedp-1300542249.cos.ap-nanjing.myqcloud.com/4301-2/4.png"  width="250px" height="450px" />

关于订单相关的统计指标是非常多的，如果单个统计组不能满足所有统计需求时，可将各需求拆分成多个统计组实现。我选择两类常见的指标进行阐述：
一是订单金额、下单用户数相关数据统计，二是订单状态相关数据统计。

##### 1、 支付成功订单数据统计

+ 统计需求梳理

```
订单量：
1、每10分钟_订单量
2、每10分钟_各商户_订单量
3、每10分钟_各省份_订单量
4、每10分钟_各城市_订单量
5、每小时_订单量
6、每天_订单量
7、每天_各商户_订单量
8、每天_各省份_订单量
9、每天_各城市_订单量
10、每天_各价格区间_订单量
11、每天_各应用场景_订单量

交易金额：
1、每10分钟_成交金额
2、每10分钟_各商户_成交金额top100
3、每10分钟_各省份_成交金额
4、每10分钟_各城市_成交金额
5、每小时_成交金额
6、每小时_各商户_成交金额
7、每天_成交金额
8、每天_各商户_成交金额
9、每天_各省份_成交金额
10、每天_各城市_成交金额
11、每天_各应用场景_成交金额

下单用户数：
1、每10分钟_下单用户数
2、每10分钟_各商户_下单用户数
3、每10分钟_各省份_下单用户数
4、每10分钟_各城市_下单用户数
5、每小时_下单用户数
6、每天_下单用户数
7、每天_各商户_下单用户数
8、每天_各省份_下单用户数
9、每天_各城市_下单用户数
10、每天_各价格区间_下单用户数
11、每天_各应用场景_下单用户数
```
+ 定义元数据


| 字段 | 字段类型 | 描述 |  |
| --- | --- | --- | --- |
| userId | string | 用户ID |  |
| orderId | string | 订单ID |  |
| province | string | 用户所在省份 |  |
| city | string | 用户所在城市 |  |
| dealerId | string | 商户ID |  |
| scene | string | 支付场景 | 电商、外卖、餐饮、娱乐、游戏 ... |
| amount | numeric | 订单金额 |  |

+ 消息上报时机
  用户支付成功后上报原始消息数据。

+ 配置统计消息

<img src="https://lighthousedp-1300542249.cos.ap-nanjing.myqcloud.com/4301-2/5.png"  width="800px" height="450px" />


##### 2、 订单支付状态数据监控

我这里假设订单有四种状态：支付成功、支付失败、超时未支付、订单取消。

```
订单量：
1、每10分钟_各状态_订单量
2、每10分钟_各商户_各状态_订单量
1、每天_各状态_订单量
2、每天_各商户_各状态_订单量

订单异常率:
1、每10分钟_订单异常率
2、每10分钟_各商户_订单异常率
3、每小时_订单异常率
4、每天_订单异常率
5、每天_各商户_订单异常率

支付失败用户数统计:
1、每5分钟_支付失败用户数
```

+ 定义元数据

| 字段 | 字段类型 | 描述 |  |
| --- | --- | --- | --- |
| userId | string | 用户ID |  |
| province | string | 用户所在省份 |  |
| city | string | 用户所在城市 |  |
| dealerId | string | 商户ID |  |
| orderId | string | 订单ID |  |
| state | string | 订单支付状态 | 1:支付成功、2：支付失败、3：超时未支付 4：订单取消 |

+ 消息上报时机

该类订单支付状态变更的需求可分为两种上报时机：
1、订单状态发生变化时上报，使用该上报方式一笔订单可能对应多条状态变更消息。
2、订单确定最终状态时上报，使用该上报方式一笔订单只对应一条状态变更消息。
**上报时机的选择决定了统计原始消息数据本身，也决定了统计项的配置方式和最终的统计结果。**

+ 跨周期统计问题

关于此类“状态变更业务场景”的数据统计会涉及跨统计周期的问题，XL-LightHouse的每一条元数据消息都需要一个时间戳参数，内部的运算逻辑也完全基于这个时间戳来划分时间窗口。在这种“状态变更业务场景”中使用时，状态变更可能会横跨不同的统计周期，比如我们要计算“每小时_异常支付订单数量”这个数据指标，订单创建消息可能是在10点，订单支付失败的消息可能是在12点，这个时候如果您的业务期望这个异常值统计在订单创建的统计周期内，就传订单创建的时间戳。如果是期望统计在订单异常消息的统计周期内，就传异常消息本身的时间戳。

+ 配置统计项
  本例选择上述第一种上报时机。
  <img src="https://lighthousedp-1300542249.cos.ap-nanjing.myqcloud.com/4301-2/6.png"  width="800px" height="500px" />

+ 模拟数据发送
```
    private static final String userId_RandomId = RandomID.id(10);
    private static final String dealerId_RandomId = RandomID.id(5);
    private static final AreaSource areaSource = AreaSource.getInstance();
    private static final String[] sceneArray = new String[]{"游戏","娱乐","电商","外卖","餐饮","教育","医疗"};
    
    @Test
    public void orderStatTest() throws Exception {
        //连接RPC模块注册中心，默认为RPC服务(lighthouse-ice)部署的前两个节点（一主一从）
        LightHouse.init("10.206.7.15:4061,10.206.7.5:4061");
        for(int i=0;i<1000;i++){
            HashMap<String,Object> paramMap = new HashMap<>();
            paramMap.put("userId",userId_RandomId +"_" + ThreadLocalRandom.current().nextLong(100L));
            String cityStr = areaSource.randomCity(",");
            String [] cityArray = cityStr.split(",");
            paramMap.put("province",cityArray[0]);
            paramMap.put("city",cityArray[1]);
            paramMap.put("dealerId",dealerId_RandomId + "_" + ThreadLocalRandom.current().nextInt(50));
            paramMap.put("scene",sceneArray[ThreadLocalRandom.current().nextInt(7)]);
            double amount = ThreadLocalRandom.current().nextDouble(1,9999);
            paramMap.put("amount",String.format("%.2f", amount));
            paramMap.put("orderId","order_"+i);
 //参数1对应统计组token，参数2对应统计组秘钥，参数3是消息事件的13位时间戳 。
 LightHouse.stat("order_stat","AZ6ReXXskkRQuzcq33urcwWwPhpMqp1n",paramMap,System.currentTimeMillis());
        }
        //注意：stat方法为异步发送，如果进程直接退出可能会导致部分消息没有发送出去，所以这里加一个sleep。
        Thread.sleep(10 * 1000);
        System.out.println("send ok!");
    }
```

+ 查看统计结果

<img src="https://lighthousedp-1300542249.cos.ap-nanjing.myqcloud.com/4301-2/7.png"  width="800px" height="420px" />

## 注意：
1、如果使用单元测试发送完统计消息后进程直接退出，请务必加一个Thread.sleep(10 * 1000)，否则部分内存中的消息可能没有发送出去而影响统计结果。
2、系统内置的监控功能（集群监控和首页报表）都是基于系统处理消息的时间戳，与原始消息指定的时间戳不同，所以两者的统计结果不完全一致。比如：调用SDK的stat方法上报消息时，如果指定的是昨天的时间戳，则对应统计指标的值都是计算在昨天的统计周期内，但集群监控的统计周期是当前时间。
3、本系统只提供Java版本SDK，jvm类语言开发的服务可直接调用，其他非JVM语言可以自己搭建一套消息队列服务，然后再通过消费队列数据的形式接入本服务。
 

