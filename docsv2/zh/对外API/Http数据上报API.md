本篇文章介绍如何使用Http版本API上报统计原始消息，在调用API之前请首先确保与部署服务器的4061端口和18101端口网络互通。

## 数据上报API说明

Http受限于数据传输特性，它的上报效率相对于JavaRPC要低，对于大批量的原始消息上报推荐您选择JavaSDK（后续xl-lighthouse会分别提供C语言和Go语言版本的SDK）。

Http上报方案的优点在于接入比较简单灵活，适合中小企业或业务接入（一般来说每秒上报3~5万条原始消息内的业务，Http请求方式都足以支撑），如果您选择Http方式，建议使用批量上报接口。

以下使用lighthouse-ips代指您的LightHouse部署节点的IP。如果为集群模式，可使用集群的所有节点IP，推荐使用轮询请求方式避免热点问题，如果为单机模式则为当前部署节点IP。

### 单条消息上报接口

1、接口地址

+ http://lighthouse-ips:18101/api/rpc/v1/stat

2、包体参数格式（请使用Post请求方式，以下格式参数放在包体中）

```json
{
    "params": {
        "amount": "235.954",
        "biz": "Ac",
        "order_id": "O64fA6",
        "user_id": "CaKXwO"
    },
    "secretKey": "YEWU3tGjNQL1AevvC9FjNj9SCuvzpYPmLY5akKYz",
    "timestamp": 1729334972612,
    "token": "N4C:order_stat"
}
```

### 批量消息上报接口

1、接口地址

+ http://lighthouse-ips:18101/api/rpc/v1/stats

批量上报接口一般每次请求传输数据量在50k ~ 100k之间较为适中，如果您每条消息平均约为100Byte，则建议您每次请求上报约500~1000条原始记录。每次传输数据量太大，容易导致网络阻塞，传输太小则会频繁建立Http连接，影响上报效率，您可以根据自身情况进行调整。

2、包体参数格式（请使用Post请求方式，以下格式参数放在包体中）


```json
[{
    "params": {
        "amount": "959.589",
        "biz": "eR",
        "order_id": "ZqrGWY",
        "user_id": "f2ZWg3"
    },
    "secretKey": "YEWU3tGjNQL1AevvC9FjNj9SCuvzpYPmLY5akKYz",
    "timestamp": 1729335961033,
    "token": "N4C:order_stat"
}, {
    "params": {
        "amount": "96.575",
        "biz": "91",
        "order_id": "KlPtEZ",
        "user_id": "yqTv7t"
    },
    "secretKey": "YEWU3tGjNQL1AevvC9FjNj9SCuvzpYPmLY5akKYz",
    "timestamp": 1729335961033,
    "token": "N4C:order_stat"
}, {
    "params": {
        "amount": "868.763",
        "biz": "G6",
        "order_id": "A1tqqe",
        "user_id": "td6s5I"
    },
    "secretKey": "YEWU3tGjNQL1AevvC9FjNj9SCuvzpYPmLY5akKYz",
    "timestamp": 1729335961033,
    "token": "N4C:order_stat"
}]
```

## 调用示例

+ Java代码模拟Http单条消息上报接口

```
@Test
    public void testStat() throws Exception {
        String apiUrl = "http://10.206.6.31:18101/api/rpc/v1/stat";
        long t = System.currentTimeMillis();
        for(int i=0;i<1676;i++){
            Map<String,Object> requestMap = new HashMap<>();
            requestMap.put("token","N4C:order_stat");
            requestMap.put("secretKey","YEWU3tGjNQL1AevvC9FjNj9SCuvzpYPmLY5akKYz");
            requestMap.put("timestamp",t);
            Map<String,Object> paramsMap = new HashMap<>();
            paramsMap.put("order_id", RandomID.id(6));
            paramsMap.put("biz", RandomID.id(2));
            paramsMap.put("user_id", RandomID.id(6));
            Double d = ThreadLocalRandom.current().nextDouble(1000);
            paramsMap.put("amount",String.format("%.3f", d));//防止上面随机数出现科学计数法
            requestMap.put("params",paramsMap);
            String requestParams = JsonUtil.toJSONString(requestMap);
            System.out.println("Send Params:" + JsonUtil.toJSONString(requestParams));
            String response = OkHttpUtil.post(apiUrl,requestParams);
            System.out.println("Send Index:" + i + ",response:" + response);
        }
        System.out.println("Send OK!");
    }
```

+ Java代码模拟Http批量消息上报接口

```
    @Test
    public void testStats() throws Exception{
        long t = System.currentTimeMillis();
        String apiUrl = "http://10.206.6.31:18101/api/rpc/v1/stats";
        for(int m=0;m<100;m++){
            List<Map<String,Object>> requestList = new ArrayList<>();
            for(int n=0;n<300;n++){
                Map<String,Object> requestMap = new HashMap<>();
                requestMap.put("token","N4C:order_stat");
                requestMap.put("secretKey","YEWU3tGjNQL1AevvC9FjNj9SCuvzpYPmLY5akKYz");
                requestMap.put("timestamp",t);
                Map<String,Object> paramsMap = new HashMap<>();
                paramsMap.put("order_id", RandomID.id(6));
                paramsMap.put("biz", RandomID.id(2));
                paramsMap.put("user_id", RandomID.id(6));
                Double d = ThreadLocalRandom.current().nextDouble(1000);
                paramsMap.put("amount",String.format("%.3f", d));//防止上面随机数出现科学计数法
                requestMap.put("params",paramsMap);
                requestList.add(requestMap);
            }
            String requestParams = JsonUtil.toJSONString(requestList);
            System.out.println("Send Params:" + JsonUtil.toJSONString(requestParams));
            String response = OkHttpUtil.post(apiUrl,requestParams);
            System.out.println("Send Index:" + m + ",response:" + response);
        }
        System.out.println("Send OK!");
    }
```

+ 使用Postman模拟调用

![XL-LightHouse](https://lighthousedp-1300542249.cos.ap-nanjing.myqcloud.com/screenshot_v2/47.jpg)


## 补充说明

+ 本SDK提供基础验签机制，如果您对SDK使用安全性方面有更高要求，可以在本SDK的基础上额外增加数据加密或签名验证等处理流程。
+ 本文的范例代码请参考单元测试：com.dtstep.lighthouse.core.test.api.HttpStatTest