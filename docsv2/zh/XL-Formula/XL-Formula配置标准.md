## 简介

XL-Formula是一种用于描述流式统计运算方式的配置标准，它代表着一种通用型流式统计系统的实现方法，更深层次它代表着一种以通用型流式统计技术为切入点，低成本实现企业数据化运营的理念。

该配置标准语法简洁、功能强大、解析效率高、便于理解和使用。

* XL-Formula涵盖了各种流式数据统计运算场景，包括count、sum、max、min、avg、bitcount等多种运算。
* XL-Formula支持单维度、多维度计算。
* XL-Formula支持秒级、分钟级、小时级、天级多种时间粒度的统计，支持自定义统计周期的配置。
* XL-Formula支持滚动窗口和滑动窗口的数据统计。
* XL-Formula支持多种运算函数的组合使用。
* XL-Formula可以满足各种复杂的条件筛选和逻辑判断。
* XL-Formula支持topN/lastN运算。
* XL-Formula内置丰富的转化类函数，支持系统变量、日期变量的插入使用。
* XL-Formula支持时序性数据存储和计算。
* XL-Formula支持统计结果有效期设置。

## 组成结构

XL-Formula基于"统计组-统计项"的层级结构管理所有统计需求，每一个统计需求对应一个统计项，统计组是基于同一份元数据的多个统计项的合称。元数据配置是用于描述统计组原始消息的数据结构，统计项配置包括统计模板配置、统计周期配置和数据有效期配置。

## 元数据配置

元数据配置是用于描述统计组原始消息的数据结构，包括字段名、字段类型、字段描述。为了便于理解下面基于电商实时订单统计场景为例进行辅助说明。

假设该场景有如下统计需求：
```
>统计每分钟、每小时、每天的订单量
>统计每分钟、每小时、每天的订单总金额
>统计每天、每个业务的订单总金额
>统计每天、每个城市的订单总金额
>统计每天的订单平均金额
>统计每天、每个业务的订单平均金额
>统计每天、每个商户的订单总金额，并按照订单总金额计算topN商户
>统计每分钟、每小时、每天的下单用户数
>统计每天、每个业务的下单用户数
>统计每天、每个商品的下单用户数
>统计每天的人均支付金额
>统计每天、每个业务的人均支付金额
>统计每天、每个商品的购买量
>统计每天、各价格区间订单比例
>统计每天、每个业务、各价格区间订单比例
>统计每天、每个业务、各一级/二级商品分类的成交金额
>统计每天、每个业务、各一级/二级商品分类的下单用户数
>统计每天、每个业务、每个商品的总成交金额，并按照成交额计算每个业务下的topN商品
```
上述指标包括：订单量、订单金额、平均订单金额、下单用户数、人均支付金额，统计维度包括：时间维度、业务维度、城市、商户、商品、订单价格区间等维度。

由于订单和商品是一对多关系，将上述统计需求拆分成两个统计组实现，所对应的元数据配置如下：

1、订单维度元数据配置（一个订单对应一条元数据消息，下文使用“元数据1”代表该份元数据）：

| 字段 | 字段类型 | 描述说明
| --- | --- | ---
| orderId | string | 订单id|
| province | string | 用户省份|
| city | string | 用户城市|
| userId | string | 用户id|
| sellerId | string | 商户id|
| amount | numeric | 订单总金额|


样本数据如下：
![xl-lighthouse](https://ldp-dtstep-1300542249.cos.ap-guangzhou.myqcloud.com/xl-formula/3.jpg)

2、商品维度元数据配置（根据订单中的商品数量，一个订单对应一条或多条元数据消息，下文使用"元数据2"代表该份元数据）：

| 字段 | 字段类型 | 描述说明
| --- | --- | ---
| orderId | string | 订单id|
| province | string | 用户省份|
| city | string | 用户城市|
| userId | string | 用户id|
| biz | string | 业务类型|
| category | string | 商品分类|
| sellerId | string | 商户id|
| productId | string | 商品id|
| productAmount | numeric | 商品成交金额|

样本数据如下：
![xl-lighthouse](https://ldp-dtstep-1300542249.cos.ap-guangzhou.myqcloud.com/xl-formula/2.jpg)


## 统计模板

### 统计模板的构成
统计模板是基于XML格式的文本配置信息，包括如下属性：
* title：统计项名称，必要属性，可根据需要设置。
* stat：统计表达式配置，必要属性，用于指定统计项的计算规则，由一个或多个统计运算单元组成，多个统计运算单元之间可进行算术运算。
* dimens：维度表达式配置，可选属性，用于指定统计项的维度信息，可指定0个或多个维度，多个维度之间使用指定分割符分割。
* limit：结果筛选表达式配置，可选属性，用于topN/lastN运算。

### 统计运算单元

统计运算单元的配置格式为：function_name(related_column,filter_unit1,filter_unit2,...)其中：
function_name为统计运算单元名称，用于表示当前统计运算的类型，包括：次数运算单元、求和运算单元、最大值运算单元、最小值运算单元、平均值运算单元、时序运算单元和基数运算单元，运算单元的种类可自定义扩展。
related_column为统计运算关联参数，与统计运算单元类型有关，次数运算的关联参数值默认为1，不需要额外指定；求和运算关联参数为指定进行求和运算的字段，其值为数值类型；最大值运算关联参数为指定进行求最大值运算的字段，其值为数值类型；最小值运算关联参数为指定进行求最小值运算的字段，其值为数值类型；平均值运算关联参数为指定进行求平均值运算的字段，其值为数值类型；基数运算关联参数为指定进行基数运算的字段，其值为字符串类型；时序运算关联参数为指定进行时序运算的字段，其值为数值类型。
filter_unit为筛选参数，筛选参数是结果为布尔类型的表达式，用于对原始消息进行过滤判定，每个统计运算单元可根据需要指定0个或多个筛选参数，多个筛选参数之间为逻辑与运算关系，每个筛选参数由一个或多个筛选条件组成，多个筛选条件之间使用逻辑运算符连接。

1、count运算

+ 语法：count(filterParam1,filterParam2,..)
+ 说明：次数运算单元，参数为用于条件筛选的0个或多个布尔类型的表达式，每个表达式之间使用逗号分割。

```
> 基于”元数据1“实现如下需求：
统计订单量：count()
统计北京地区订单量：count(province == 'beijing')
统计金额超过100元的订单量:count(amount > '100')
```

2、bitcount运算

+ 语法：bitcount(relatedColumn,filterParam1,filterParam2,..)
+ 说明：基数统计运算单元，基数运算是指distinct运算（非重复值数量统计），relatedColumn为用于基数统计的关联字段(必要参数)，后面可以跟0个或多个布尔类型的表达式，每个表达式之间使用逗号分割。

```
> 基于元数据1实现如下需求：
统计下单用户量：bitcount(userId)
统计北京地区下单用户量：bitcount(userId,province == 'beijing')
支付金额超过100元的用户量：bitcount(userId,amount > '100')
```
```
> 基于元数据2实现如下需求：
统计3c业务下单用户量：bitcount(userId,biz == '3c')
统计3c业务有成交的商品数量：bitcount(productId,biz == '3c')
```

3、sum运算

+ 语法：sum(relatedColumn,filterParam1,filterParam2,...)
+ 说明：求和运算函数，relatedColumn为用于求和计算的关联字段(必要参数,且其值必须为数值类型)，后面可以跟0个或多个用于条件筛选的布尔类型表达式，每个表达式之间使用逗号分割。

```
> 基于元数据1实现如下需求：
1、统计订单总金额：sum(amount)
2、统计北京和上海订单总金额：sum(amount,province == 'beijing'|| province == 'shanghai')
```
```
> 基于元数据2实现如下需求：
1、统计除3c业务外总成交额：sum(productAmount,biz != '3c')
2、统计北京地区3c业务外总成交额：sum(productAmount,province == 'beijing',biz == '3c')
```

4、max运算

+ 语法：max(relatedColumn,filterParam1,filterParam2,...)
+ 说明：最大值运算函数，relatedColumn为用于求最大值计算的关联字段(必要参数,且其值必须为数值类型)，后面可以跟0个或多个用于条件筛选的布尔类型表达式，每个表达式之间使用逗号分割。

```
> 基于元数据1实现如下需求：
统计订单最大金额：max(amount)
```
```
> 基于元数据2实现如下需求：
统计3c业务的最大成交金额：max(productAmount,biz == '3c')
```

5、min运算

+ 语法：min(relatedColumn,filterParam1,filterParam2,...)
+ 说明：最小值运算函数，relatedColumn为用于求最小值计算的关联字段(必要参数,且其值必须为数值类型)，后面可以跟0个或多个用于条件筛选的布尔类型表达式，每个表达式之间使用逗号分割。

```
> 基于元数据1实现如下需求：
统计订单最小金额：min(amount)
```
```
> 基于元数据2实现如下需求：
统计3c业务的最小成交金额：min(productAmount,biz == '3c')
```
6、avg运算

+ 语法：avg(relatedColumn,filterParam1,filterParam2,...)
+ 说明：平均值运算函数，relatedColumn为用于求平均值计算的关联字段(必要参数,且其值必须为数值类型)，后面可以跟0个或多个用于条件筛选的布尔类型表达式，每个表达式之间使用逗号分割。

```
> 基于元数据1实现如下需求：
统计订单平均金额：avg(amount)
统计北京地区的订单平均金额：avg(amount,province == 'beijing')
```
```
> 基于元数据2实现如下需求：
统计3c业务的平均商品金额：avg(productAmount,biz == '3c')
统计北京地区非3c业务平均金额：avg(productAmount,province=='beijing',biz != '3c')
```

7、seq运算

+ 语法：seq(relatedColumn,filterParam1,filterParam2,...)
+ 说明：时序性数据存储，relatedColumn为用于时序性数据的取值字段(必要参数,且其值必须为数值类型)，后面可以跟0个或多个用于条件筛选的布尔类型表达式，使用逗号分割。seq函数用于时序性数据的存储和查询，除了用户指定的条件筛选逻辑外，seq不对批次内原始数据做任何计算，只提供结果存储和查询。如果一个批次类用户发送了多条原始数据，则随机取一条保存。seq函数不能与其他统计函数组合使用。

seq函数用于时序型数据场景，比如常见的服务器监控类指标。

```
>示例：
采集服务器负载：seq(load_average)
```

### 统计运算单元组合

XL-Formula支持通过加减乘除四则运算将多个统计运算组合使用。

```
> 基于元数据1实现如下需求：
1、订单平均金额
sum(amount)/count()
2、金额超过100元的订单占比
count(amount > '100')/count()
3、平均用户消费金额
sum(amount)/bitcount(userId)
4、北京地区订单量占比
count(province=='beijing')/count()
5、北京地区下单用户数占比
bitcount(userId,province=='beijing')/bitcount(userId)
6、非北京地区的下单用户比例
bitcount(userId,province!='beijing')/bitcount(userId)
7、北京和上海的订单总金额
sum(amount,province == 'beijing') + sum(amount,province == 'shanghai')
8、北京和上海地区成交金额占总金额的比例
(sum(amount,province == 'beijing') + sum(amount,province == 'shanghai'))/sum(amount)
```
```
> 基于元数据2实现如下需求：
1、3c业务总成交额占比
sum(productAmount,biz=='3c')/sum(productAmount)
2、食品和饮料业务的总成交额
sum(productAmount,biz=='food') + sum(productAmount,biz=='drinks')
3、统计手机类别的人均消费金额
sum(productAmount,category=='cellphone')/bitcount(userId,category=='cellphone')
```
### 多过滤条件逻辑运算
XL-Formula支持多过滤条件的灵活组合，可以实现各种复杂的条件筛选和逻辑判断。
```
> 基于元数据2实现如下需求：
1、食品业务和饮料业务销售额占比
sum(productAmount,biz =='food'||biz =='drinks')/sum(productAmount)
2、北京地区3c业务的人均消费金额
sum(productAmount,province =='beijing' && biz == '3c')/bitcount(userId,province =='beijing' && biz == '3c')
3、北京地区食品业务和上海地区食品业务的总成交金额
sum(productAmount,province =='beijing' && biz == 'food') + sum(amount,province =='shanghai' && biz == 'food')
等价于：
sum(productAmount,（province =='beijing' && biz == 'food')||(province =='shanghai' && biz == 'food')) 
等价于：
sum(productAmount,（province =='beijing'|| province =='shanghai'),biz =='food') 
```
### 维度运算
XL-Formula支持单维度和多维度数据统计，多个维度之间使用分号分割。
```
> 基于元数据1实现如下需求：
1、统计每个城市的订单总金额
<stat-item title="各城市_订单总金额" stat="sum(amount)" dimens="city"/>
2、统计各个城市订单金额超过100元的比例
<stat-item title="各城市_大于100元订单占比" stat="count(amount>100)/count()" dimens="city"/>
3、统计每个商户的订单总金额
<stat-item title="各商户_订单总金额" stat="sum(amount)" dimens="sellerId"/>

> 基于元数据2实现如下需求：
1、统计每个业务的订单总金额
<stat-item title="各业务_订单总金额" stat="sum(productAmount)" dimens="biz"/>
2、统计北京市和上海市各业务的订单总金额
<stat-item title="北京上海_各业务_订单总金额" stat="sum(productAmount,province == 'beijing') + sum(productAmount,province == 'shanghai')" dimens="biz"/>
3、统计每个业务的下单用户数
<stat-item title="各业务_下单用户数" stat="bitcount(userId)" dimens="biz"/>
4、统计各个城市各个业务的下单用户数
<stat-item title="各城市_各业务_下单用户数" stat="bitcount(userId)" dimens="city;biz"/>
5、统计各个城市各个业务的下单总金额
<stat-item title="各城市_各业务_下单总金额" stat="sum(productAmount)" dimens="city;biz"/>
6、统计各个业务、各个商品类别总成交金额
<stat-item title="各业务_各商品类别_总成交金额" stat="sum(productAmount)" dimens="biz;category"/>
7、统计每个城市、各个业务、各个类别的下单用户数
<stat-item title="各城市_各业务_各类别_下单用户数" stat="bitcount(userId)" dimens="city;biz;category"/>
8、统计各个业务的平均订单金额
<stat-item title="各业务_平均金额" stat="avg(productAmount)" dimens="biz"/>
```
说明：对于有级联关系的维度比如常见的：省份和城市，汽车领域的品牌和车系、商品类别的一级分类、二级分类等等，如果希望xl-lighthouse页面筛选时显示出级联关系，方便筛选操作，需配置多个级联维度，注意需要保持维度级联关系的顺序，如下：
```
统计每个城市的订单总金额
<stat-item title="各城市_订单总金额" stat="sum(amount)" dimens="province;city"/>
```
### 内置转化类函数
内置转化类函数的作用在于将统计原始消息的相关字段进行特定转化操作后再进行统计运算。转化类函数是对XL-Formula功能的进一步补充，以扩大其适用范围，尽可能覆盖更全面的流式数据统计场景。转化类函数可用于统计表达式和维度表达式中。
XL-Formula目前支持的内置函数如下，后续将根据使用反馈情况，进一步扩充内置函数库。

| 函数名称 | 说明 | 格式 | 返回值类型 | 示例 |
| --- | --- | --- | --- | --- |
| left |从左端截取字符串 | left(str,len) | string | left('abcde','2')   ->  ab |
| right |从右端截取字符串  | right(str,len) | string | right('abcde','2')  ->  de |
| substr | 字符串截取 | substr(str,start,end) | string | substr('abcde','2','4') -> cd |
| isEmpty | 判定是否为空(空字符串或Null) | isEmpty(str) | string | isEmpty('abcde') -> false |
| isNull | 判定是否为Null | isNull(str) | string | isNull('abcde') -> false |
| isNumeric | 判定是否为数字 | isNumeric(str) | string | isNumeric('11.05') -> true |
| startWith | 以...开始 | startWith(str1,str2) | boolean | startWith('abcd','ab')  -> true |
| endsWith | 以...结束 | endsWith(str,str2) | boolean | endsWith('abcd','bc') -> false |
| len | 字符串长度 | len(str) | number | len('abcde') -> 5 |
| toLower | 将字母转化为小写 | toLower(str) | string | toLower('Abc') -> 'abc' |
| toUpper | 将字母转化为大写 | toUpper(str) | string | toUpper('aBC') -> 'ABC' |
| concat |字符串拼接  | concat(str1,str2) | string | concat('ab','cd')  ->  abcd |
| section | 数值区间计算 | section(num,str) | string | section('20','10,50,100') -> [10-50] |
| contains | 字符串是否包含... | contains(str1,str2) | boolean | contains('abcd','bc') -> true |
| trim | 去掉首尾的空格 | trim(str) | string | trim('  abc ') -> abc |
| dateParse | 将日期字符串转化为时间戳 | dateParse(dateStr,formatStr) | long | dateParse('2020-12-12 10:00:00','yyyy-MM-dd HH:mm:ss') -> 1607738400000 |
| dateFormat | 将时间戳转化为日期字符串 | dateFormat(timestamp,formatStr) | string | dateFormat('1607738400000','yyyy-MM-dd HH:mm:ss') -> '2020-12-12 10:00:00' |
| isIn | 是否属于 | isIn(str1,str2) | boolean | isIn('1','1,2,3') -> true |
| reverse | 字符串反转 | reverse(str) | string | reverse('abc') -> cba |
| replace | 字符串替换 | replace(originStr,str1,str2) | string | replace('abcde','ab','cd') -> cdcde |
| md5 | MD5计算 | md5(str) | string | md5('abc') -> 900150983cd24fb0d6963f7d28e17f72 |
| split | split计算 | split(str1,str2,index) | string | split('key003#abc','#','0') -> key003|
| hashcode | hashcode计算 | hashcode(str) | int | hashcode('abc') -> 96354 |

```
> 基于元数据1实现如下需求：
1、计算每天不同价格区间的订单数量
<stat-item title="各价格区间_订单数量" stat="count()" dimens="section(amount,'100,500,1000,5000')"/>
2、计算每天不同价格区间的下单用户数
<stat-item title="各价格区间_下单用户数" stat="bitcount(userId)" dimens="section(amount,'100,500,1000,5000')"/>
3、计算北京和上海地区的订单量
<stat-item title="北京上海"_订单量" stat="count(isIn(province,'beijing,shanghai'))"/>

> 基于元数据2实现如下需求：
1、计算各个业务、不同价格区间的订单量
假设区间为0~100元，100~200元，200~500元，500~1000元，1000元以上各区间的订单数量
<stat-item title="各业务_各价格区间_下单用户数" stat="bitcount(orderId)" dimens="biz;section(productAmount,'100,200,500,1000')"/>
2、计算商品分类信息为空的订单数量
<stat-item title="商品分类为空的订单数量" stat="bitcount(orderId,isEmpty(category))"/>
```

### limit运算
条件筛选表达式是用于计算topN和lastN场景，为了更加贴合流式统计应用场景，XL-Formula中的limit运算与SQL规范中limit稍有不同，SQL规范中的Limit是计算"topN条记录"，而XL-Formula中的limit是计算"topN条维度"，也就是说limit属性必须搭配dimens属性使用。limit计算包括topN和lastN运算。
```
> 基于元数据1实现如下需求：
1、统计总交易额top10的省份：
<stat-item title="每天_交易额top10省份" stat="sum(amount)" dimens="province" limit="top10"/>
2、计算每天、平均订单金额最低的省份
<stat-item title="每天_各省份_平均订单金额last10省份" stat="sum(amount)/count()" dimens="province" 
limit="last10"/>


> 基于元数据2实现如下需求：
3、统计每天、下单用户数top10的商户
<stat-item title="每天_交易额top10商户" stat="sum(productAmount)" dimens="dealerId" limit="top10"/>
4、统计每天、每个业务销售额最高的商品top10商品
<stat-item title="每天_成交金额top10商品" stat="sum(productAmount)" dimens="productId" limit="top10"/>
5、统计每天、每个业务销售额最高的商品top100商品
#XL-LightHouse暂不支持该种配置方式
<stat-item title="每天_各业务_成交金额top100商品" stat="sum(productAmount)" dimens="biz;productId" 
limit="biz;top100"/>
```
## 统计周期

XL-Formula支持秒级、分钟级、小时级、天级多个时间粒度的数据统计，支持滚动窗口和滑动窗口的数据统计
XL-LightHouse项目为了操作的方便性，将统计周期和数据有效期设计成单独的下拉框筛选框，没有和统计模板混在一起，用户可以根据自己的实际需要选择统计周期。
```
示例：
#说明：xl-lighthouse项目暂不支持滑动窗口配置方式
1、统计每分钟的订单量（滚动窗口）
<stat-item title="每分钟_订单量" stat="count()"/>
TimeParam:1-minute
1、统计每5分钟的订单量（滚动窗口）
<stat-item title="每5分钟_订单量" stat="count()"/>
TimeParam:5-minute
2、统计每小时的订单量（滚动窗口）
<stat-item title="每小时_订单量" stat="count()"/>
TimeParam:1-hour
2、统计每2小时的订单量（滚动窗口）
<stat-item title="每2小时_订单量" stat="count()"/>
TimeParam:2-hour
3、统计每天的订单量（滚动窗口）
<stat-item title="每天_订单量" stat="count()"/>
TimeParam:1-day
4、统计每分钟的下单用户量（滚动窗口）
<stat-item title="每分钟_下单用户量" stat="bitcount(userId)"/>
TimeParam:1-minute
5、统计每天的下单用户量（滚动窗口）
<stat-item title="每分钟_下单用户量" stat="bitcount(userId)"/>
TimeParam:1-day
6、统计最近5分钟的总成交金额（滑动窗口）
<stat-item title="最近5分钟_总成交金额" stat="sum(amount)"/>
TimeParam:recent-5-minute
7、统计最近30分钟的下单用户量(滑动窗口)
<stat-item title="最近30分钟_下单用户量" stat="bitcount(userId)"/>
TimeParam:recent-30-minute
8、统计各业务最近30分钟的下单用户量（滑动窗口）
<stat-item title="最近30分钟_各业务_下单用户量" stat="bitcount(userId)" dimens="biz"/>
TimeParam:recent-30-minute
```
## 数据有效期
数据有效期是统计数据的过期机制，避免因为数据过多对服务产生影响。用户可以根据实际需要对每个统计需求的结果设置过期时间，为避免不必要的资源浪费，建议在满足业务需要的前提下设置尽量短的数据有效期，尤其是针对一些细粒度、维度数量较多的统计项。

## XL-LightHouse项目暂时不支持相关功能点
- 1、XL-LightHouse暂时不支持滑动窗口数据统计；
- 2、XL-LightHouse暂时不支持秒级粒度的数据统计；
- 3、XL-LightHouse的limit运算目前只支持直接取topN或lastN条维度，limit运算暂时不支持指定维度下的limit运算。
  我将在后续版本中支持以上功能！

## 版权声明

XL-Formula可以帮助企业快速的搭建起一套较为完善的、稳定可靠的数据化运营体系，具有较高的实际应用价值。

为保障创作者合法权益以及支持XL-Formula标准的进一步补充和完善，现针对XL-Formula标准使用作如下声明：

- 企业或机构内部使用包含XL-Formula标准的产品或服务不受任何限制。
- 企业、机构或个人销售直接或间接包含XL-Formula标准的产品或服务需要向本人支付一定比例的授权费用（0.2% ~ 2%）。

为避免不必要的版权纠纷，在销售相关产品或服务前请您务必查阅[版权声明](/docs/110073/)！