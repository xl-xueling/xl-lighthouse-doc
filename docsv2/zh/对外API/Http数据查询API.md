本篇文章介绍如何使用Http版本API查询各数据指标的统计结果，在调用API之前请首先确保与部署服务器的4061端口和18101端口网络互通。

## 创建调用方

在使用本功能前，请您首先参考 [调用方管理](/web/11.md) 创建调用方，调用方管理提供API接口的访问授权校验、调用量监控等相关功能！

在已创建完成调用方并已申请相应元素访问授权的前提下，再进行以下操作！


## 数据查询API说明

以下使用lighthouse-ips代指您的LightHouse部署节点IP。如果为集群模式，可使用集群的所有节点IP，推荐使用轮询请求方式避免热点问题，如果为单机模式则为当前部署节点IP。

### 按照批次时间查询单个维度的统计结果

1、接口地址

+ http://lighthouse-ips:18101/api/rpc/v1/dataQuery

2、Header参数

```
Caller-Name:调用方名称
Caller-Key：调用方秘钥
```
+ callerName: 调用方名称；
+ callerKey: 调用方秘钥，在“调用方列表 - 选择相应调用方 - 管理 - 秘钥”栏目中获取；

3、包体参数格式

```
{"batchList":[1725498000000,1725494400000,1725490800000,1725487200000,1725483600000],"dimensValue":"山东省","statId":"1100607"}
```

+ statId: 统计项ID，所需要查询统计结果的数据指标的ID；
+ dimensValue，单个维度信息，没有维度的统计指标请传null；
+ batchList，批次时间（数组结构），请使用13位时间戳；

### 按照时间范围查询单个维度的统计结果

1、接口地址

+ http://lighthouse-ips:18101/api/rpc/v1/dataDurationQuery

2、Header参数

```
Caller-Name:调用方名称
Caller-Key：调用方秘钥
```

+ callerName: 调用方名称；
+ callerKey: 调用方秘钥，在“调用方列表 - 选择相应调用方 - 管理 - 秘钥”栏目中获取；

3、包体参数格式

```
{"dimensValue":"山东省","endTime":1729439999999,"startTime":1729353600000,"statId":"1100607"}
```

+ statId: 统计项ID，所需要查询统计结果的数据指标的ID；
+ dimensValue，单个维度信息，没有维度的统计指标请传null；
+ startTime: 查询开始时间，请使用13位时间戳；
+ endTime: 查询结束时间，请使用13位时间戳；

### 按照批次时间批量查询多个维度的统计结果

1、接口地址

+ http://lighthouse-ips:18101/api/rpc/v1/dataQueryWithDimensList

2、Header参数

```
Caller-Name:调用方名称
Caller-Key：调用方秘钥
```
+ callerName: 调用方名称；
+ callerKey: 调用方秘钥，在“调用方列表 - 选择相应调用方 - 管理 - 秘钥”栏目中获取；

3、包体参数

```
{"batchList":[1725498000000,1725494400000,1725490800000,1725487200000,1725483600000],"dimensValueList":["21","72","36"],"statId":"1100613"}
```

+ statId: 统计项ID，所需要查询统计结果的数据指标的ID；
+ dimensValueList，维度信息列表；
+ batchList，批次时间（数组结构），请使用13位时间戳；

### 按照时间范围批量查询多个维度的统计结果

1、接口地址
+ http://lighthouse-ips:18101/api/rpc/v1/dataDurationQueryWithDimensList

2、Header参数
```
Caller-Name:调用方名称
Caller-Key：调用方秘钥
```
+ callerName: 调用方名称；
+ callerKey: 调用方秘钥，在“调用方列表 - 选择相应调用方 - 管理 - 秘钥”栏目中获取；

3、包体参数格式如下
```
{"dimensValueList":["21","72","36"],"endTime":1729439999999,"startTime":1729353600000,"statId":"1100613"}
```

+ statId: 统计项ID，所需要查询统计结果的数据指标的ID；
+ dimensValueList，维度信息列表；
+ startTime: 查询开始时间，请使用13位时间戳；
+ endTime: 查询结束时间，请使用13位时间戳；

### 按照批次时间查询Limit统计结果

1、接口地址

+ http://lighthouse-ips:18101/api/rpc/v1/limitQuery

2、Header参数

```
Caller-Name:调用方名称
Caller-Key：调用方秘钥
```
+ callerName: 调用方名称；
+ callerKey: 调用方秘钥，在“调用方列表 - 选择相应调用方 - 管理 - 秘钥”栏目中获取；

3、包体参数格式
```
{"batchTime":1729415100000,"statId":"1100617"}
```
+ statId: 统计项ID，所需要查询统计结果的数据指标的ID；
+ batchTime，批次时间；

## 部分参数说明

### startTime、endTime参数
+ 查询统计结果的起止时间，系统自动计算起止时间范围内的所有批次数据并返回，请使用13位时间戳。

### batchTime、batchList参数

系统按照统计项TimeParam参数划分统计周期，使用每个统计周期时间窗口的开始时间作为统计周期的批次时间，在传递batchTime、batchList相关参数时，请使用13位时间戳。
batchTime为一个批次时间，batchList为数组结构，可传入多个批次时间。

示例如下：

+ 比如统计某业务每分钟访问PV，则2024-05-02 13:15:00代表2024-05-02 13:15:00 至 2024-05-02 13:16:00的统计数据对应的批次时间。

+ 统计业务每2小时访问UV,则2024-05-02 14:00:00代表2024-05-02 14:00:00 至 2024-05-02 16:00:00的统计数据对应的批次时间。

+ 统计业务每天的订单量,则2024-05-02 00:00:00代表2024-05-02 00:00:00 至 2024-05-02 23:59:59的统计数据对应的批次时间。

### dimensValue、dimensValueList参数

dimensValue为字符串类型，传递单个纬度值，dimensValueList为数组结构，传递一个或多个纬度值。

示例如下：

+ 查询业务每天订单金额，

```
<stat-item title="每天_订单金额" stat="sum(amount)" />
```

该统计项没有统计维度，则dimensValue传值null。

+ 查询每个各省份订单金额。

```
<stat-item title="每天_各省份_订单金额" stat="sum(amount)" dimens="provinceId"/>
```
该示例维度参数为省份，请传省份参数信息，格式示例：10101 或 10102。

+ 查询每个省份各个业务线的订单金额，该示例为维度查询，请按照

```
<stat-item title="每天_各省份_各业务线_订单金额" stat="sum(amount)" dimens="province;biz"/>
```

该示例维度参数为省份和业务线，请按照province;biz的格式拼接维度参数，格式示例：山东省;手机业务 或 河北省;外卖业务，务必按照dimens中的各维度字段的顺序进行排列并使用分号分割。

## 调用示例

### 使用JavaAPI调用dataDurationQueryWithDimensList接口

```
    @Test
    public void testDataDurationQueryWithDimensList() throws Exception {
        String apiUrl = "http://10.206.6.31:18101/api/rpc/v1/dataDurationQueryWithDimensList";
        Map<String,Object> requestMap = new HashMap<>();
        requestMap.put("statId","1100613");
        List<String> list = List.of("21","72","36");
        requestMap.put("dimensValueList",list);
        requestMap.put("startTime", DateUtil.getDayStartTime(System.currentTimeMillis()));
        requestMap.put("endTime", DateUtil.getDayEndTime(System.currentTimeMillis()));
        String requestParams = JsonUtil.toJSONString(requestMap);
        System.out.println("requestParams:" + JsonUtil.toJSONString(requestParams));
        RequestBody body = RequestBody.create(MediaType.parse("application/json"),requestParams);
        Request request = new Request.Builder()
                .header("Caller-Name",callerName)
                .header("Caller-Key",callerKey)
                .url(apiUrl)
                .post(body)
                .build();
        try (Response response = client.newCall(request).execute()) {
            if (!response.isSuccessful()) {
                throw new IOException("Unexpected code " + response);
            }
            System.out.println(response.body().string()) ;
        }
    }
```

### 使用Postman模拟调用

+ 设置Header参数
  ![XL-LightHouse](https://ldp-dtstep-1300542249.cos.ap-guangzhou.myqcloud.com/api/2.jpg)

+ 设置包体参数，使用Post请求方式
  ![XL-LightHouse](https://ldp-dtstep-1300542249.cos.ap-guangzhou.myqcloud.com/api/1.jpg)

## 补充说明

+ 本SDK提供基础验签机制，如果您对SDK使用安全性方面有更高要求，可以在本SDK的基础上额外增加数据加密或签名验证等处理流程。
+ 本文的范例代码请参考单元测试：com.dtstep.lighthouse.core.test.api.HttpDataQueryTest
