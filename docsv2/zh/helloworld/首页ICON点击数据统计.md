## 范例场景描述

<img src="https://lighthousedp-1300542249.cos.ap-nanjing.myqcloud.com/4301-2/1.png" width="300px" height="200px" />

首页ICON区域是各业务线的主要流量入口，以某外卖电商为例该区域包含3个Tab，每个Tab有多个业务ICON图标，用户手动滑动可切换Tab，假如针对该ICON区域我们有如下数据指标需求：

```
点击量：
1、每5分钟_总点击量
2、每5分钟_各ICON_点击量
3、每小时_总点击量
4、每小时_各ICON_点击量
5、每天_总点击量
6、每天_各Tab_总点击量
7、每天_各ICON_总点击量
8、每天_各APP版本_总点击量

点击UV:
1、每5分钟_总点击UV
2、每小时_总点击UV
3、每小时_各ICON_点击UV
4、每天_总点击UV
5、每天_各ICON_总点击UV
6、每天_各APP版本_总点击UV
```

## 定义元数据结构

| 字段 | 字段类型 | 描述 | 示例 |
| --- | --- | --- | --- |
| user_id | string | 用户标识 |  |
| tab_id | string | Tab栏 | tab1、tab2、tab3 |
| version | string | App版本号 |  |
| icon_id | string | 美食团购、酒店民宿、休闲玩乐、打车 ...|  |


## 原始消息上报时机

在用户点击ICON图标时上报相应点击埋点数据。

## 配置统计项

```
Template：<stat-item  title="每5分钟_总点击量" stat="count()"  />
TimeParam: 5-minute

Template：<stat-item  title="每5分钟_各icon_点击量" stat="count()" dimens="icon_id" />
TimeParam: 5-minute

Template：<stat-item  title="每小时_总点击量" stat="count()" />
TimeParam: 1-hour

Template：<stat-item  title="每小时_各icon_点击量" stat="count()" dimens="icon_id" />
TimeParam: 1-hour

Template：<stat-item  title="每天_各Tab_总点击量" stat="count()" dimens="tab_id"  /> 
TimeParam: 1-day

Template：<stat-item  title="每天_各icon_总点击量" stat="count()" dimens="icon_id" />
TimeParam: 1-day

Template：<stat-item  title="每天_各App版本_总点击量" stat="count()" dimens="version"  />
TimeParam: 1-day

Template：<stat-item  title="每5分钟_总点击uv" stat="bitcount(user_id)"  />
TimeParam: 5-minute

Template：<stat-item  title="每小时_总点击uv" stat="bitcount(user_id)"  />
TimeParam: 1-hour

Template：<stat-item  title="每天_总点击uv" stat="bitcount(user_id)"   />
TimeParam: 1-day

Template：<stat-item  title="每天_各ICON_点击uv" stat="bitcount(user_id)" dimens="icon_id"  />
TimeParam: 1-day

Template：<stat-item  title="每天_各App版本_点击uv" stat="bitcount(user_id)" dimens="version"  />
TimeParam: 1-day
```

![XL-LightHouse](https://lighthousedp-1300542249.cos.ap-nanjing.myqcloud.com/screenshot_v2/18.jpg)

## 模拟数据接入

```
@Test
    public void iconTest() throws Exception {
      //连接RPC模块注册中心，集群版本默认为RPC部署(lighthouse-ice)的前两个节点（一主一从），单机版本只使用一个节点即可。
      LightHouse.init("10.206.7.15:4061,10.206.7.5:4061");
        for(int i=0;i<1000;i++){
            HashMap<String,Object> paramMap = new HashMap<>();
            paramMap.put("user_id","user-" + ThreadLocalRandom.current().nextInt(500));
            paramMap.put("tab_id","tab_" + ThreadLocalRandom.current().nextInt(3));
            paramMap.put("icon_id","icon_" + ThreadLocalRandom.current().nextInt(30));
            //参数1对应统计组token，参数2对应统计组秘钥，参数3是消息事件的13位时间戳 
			LightHouse.stat("Gjd:homepage_icon_click_stat","f1ghKrnIQaRpbWOX0HOO2EaOXQ19ymXD",paramMap,System.currentTimeMillis());
        }
		 //注意：stat方法为异步发送，如果进程直接退出可能会导致部分消息没有发送出去，所以这里加一个sleep。
        Thread.sleep(10 * 1000);
		System.out.println("send ok!");
    }
```
## 查看统计结果

![XL-LightHouse](https://lighthousedp-1300542249.cos.ap-nanjing.myqcloud.com/screenshot_v2/17.jpg)

## 其他说明

- 如果使用单元测试发送完统计消息后进程直接退出，所以测试时请务必加一个Thread.sleep(10 * 1000)，否则部分内存中的消息可能没有发送出去而影响统计结果。
- 系统内置的监控功能（集群监控和首页报表）都是基于系统处理消息的时间戳，与原始消息指定的时间戳不同，所以两者的统计结果不完全一致。比如：调用SDK的stat方法上报消息时，如果指定的是昨天的时间戳，则对应统计指标的值都是计算在昨天的统计周期内，但集群监控的统计周期是当前时间。