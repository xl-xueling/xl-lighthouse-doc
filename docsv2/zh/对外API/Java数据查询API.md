本篇文章介绍如何使用Java版本API查询各数据指标的统计结果。

## 创建调用方

在使用本功能前，请您首先参考 [调用方管理](/web/11.md) 创建调用方，调用方管理提供API接口的访问授权校验、调用量监控等相关功能！

在已创建完成调用方并已申请相应元素访问授权的前提下，再进行以下操作！

## SDK引用

+ 请使用2.2.8或以上版本（建议使用MvnRepository中的最新版本）
```
<dependency>
    <groupId>com.dtstep.lighthouse</groupId>
    <artifactId>lighthouse-shaded-client</artifactId>
    <version>2.2.8</version>
</dependency>
```

## 数据查询API说明

### LightHouse.dataDurationQuery(String callerName, String callerKey, int statId, String dimensValue, long startTime, long endTime)

1、参数信息

+ callerName: 调用方名称；
+ callerKey: 调用方秘钥，在“调用方列表 - 选择相应调用方 - 管理 - 秘钥”栏目中获取；
+ statId: 统计项ID，所需要查询统计结果的数据指标的ID；
+ dimensValue，单个维度信息，没有维度的统计指标请传null；
+ startTime: 查询开始时间，请使用13位时间戳；
+ endTime: 查询结束时间，请使用13位时间戳；

2、接口作用

+ 通过指定维度和时间范围查询统计结果，本接口用于指定时间范围查询单个纬度值的统计结果或没有纬度值的筛选项的统计结果。

### LightHouse.dataQuery(String callerName, String callerKey, int statId, String dimensValue, List\<Long\> batchList)

1、参数信息

+ callerName: 调用方名称；
+ callerKey: 调用方秘钥，在“调用方列表 - 选择相应调用方 - 管理 - 秘钥”栏目中获取；
+ statId: 统计项ID，所需要查询统计结果的数据指标的ID；
+ dimensValue，单个维度信息，没有维度的统计指标请传null；
+ batchList，批次时间（数组结构），请使用13位时间戳；

2、接口作用

+ 通过指定维度和批次时间查询统计结果数据，本接口用于指定批次时间查询单个纬度值的统计结果或没有纬度值的筛选项的统计结果。

### LightHouse.dataDurationQueryWithDimensList(String callerName, String callerKey, int statId, List\<String\> dimensValueList, long startTime,long endTime)

1、参数信息

+ callerName: 调用方名称；
+ callerKey: 调用方秘钥，在“调用方列表 - 选择相应调用方 - 管理 - 秘钥”栏目中获取；
+ statId: 统计项ID，所需要查询统计结果的数据指标的ID；
+ dimensValueList，维度信息列表；
+ startTime: 查询开始时间，请使用13位时间戳；
+ endTime: 查询结束时间，请使用13位时间戳；

2、接口作用

+ 批量查询多条维度的统计结果数据，本接口用于指定时间范围查询多个纬度值的统计结果。

### LightHouse.dataQueryWithDimensList(String callerName, String callerKey, int statId, List\<String\> dimensValueList, List\<Long\> batchList)

1、参数信息

+ callerName: 调用方名称；
+ callerKey: 调用方秘钥，在“调用方列表 - 选择相应调用方 - 管理 - 秘钥”栏目中获取；
+ statId: 统计项ID，所需要查询统计结果的数据指标的ID；
+ dimensValueList，维度信息列表；
+ batchList，批次时间（数组结构），请使用13位时间戳；

2、接口作用

+ 批量查询多条维度的统计结果数据，本接口用于指定批次时间查询多个纬度值的统计结果。

### LightHouse.limitQuery(String callerName, String callerKey, int statId, Long batchTime)

1、参数信息

+ callerName: 调用方名称；
+ callerKey: 调用方秘钥，在“调用方列表 - 选择相应调用方 - 管理 - 秘钥”栏目中获取；
+ statId: 统计项ID，所需要查询统计结果的数据指标的ID；
+ batchTime，批次时间；

2、接口作用

+ 按照批次时间，查询Limit的统计结果。

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
<stat-item title="每天_各省份_各业务线_订单金额" stat="sum(amount)" dimens="province;biz;"/>
```

该示例维度参数为省份和业务线，请按照province;biz的格式拼接维度参数，格式示例：山东省;手机业务 或 河北省;外卖业务，务必按照dimens中的各维度字段的顺序进行排列并使用分号分割。

## 补充说明

+ 本SDK提供基础验签机制，如果您对SDK使用安全性方面有更高要求，可以在本SDK的基础上额外增加数据加密或签名验证等处理流程；
+ 每次api接口调用返回记录数上限为10万条数据，如果您的查询场景超过该上限，请分成多次查询；
+ 本文示例代码您可以参考项目源码中的单元测试：com.dtstep.lighthouse.core.test.api.RpcDataQueryTest；