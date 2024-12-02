## 概述

![XL-LightHouse](https://ldp-dtstep-1300542249.cos.ap-guangzhou.myqcloud.com/readme/01.jpg)

* XL-LightHouse是面向企业"繁杂"的数据统计需求而开发的一套集成了数据写入、数据运算和数据可视化等一系列功能，支持超大数据量，支持超高并发的【通用型流式大数据统计系统】。
* XL-LightHouse涵盖各种流式数据统计场景，包括count、sum、max、min、avg、distinct、topN/lastN等多种运算，支持多维度计算，支持分钟级、小时级、天级多个时间粒度的统计，支持自定义统计周期的配置。
* XL-LightHouse内置丰富的转化类函数、支持表达式解析，可满足各种复杂的条件筛选和逻辑判断。
* XL-LightHouse提供了完善的可视化查询功能，对外提供API查询接口，此外还包括数据指标管理、统计限流、权限管理、用户管理等多种功能。
* XL-LightHouse支持时序性数据的存储和查询。

## 项目优势

通用型流式大数据统计或许是唯一一种有可能支撑百万量级数据指标，而成本仍可控制在企业可承受范围之内的技术。
XL-LightHouse是开源社区世界范围内第一个也是目前唯一一个通用型流式大数据统计系统，面向企业至上而下所有职能人员共同使用，期望帮助企业以极低的成本，搭建起"遍布全身"的数据化运营体系。目前业内广泛采用的以实时计算、离线计算、OLAP为主的技术方案都太过于臃肿和笨重，如果替换为以通用型流式数据统计为主，以其他技术方案为辅的实现方式可大幅降低企业成本。XL-LightHouse期望使用更为轻巧和实用的技术方案应对繁琐的数据统计问题。


+  依据流式统计的运算特点而设计，并对每一种运算单元进行反复优化，使得每一种运算单元可以以非常低的成本，无限制复用；
+  可以短时间内快速实现庞大量级数据指标，而这是Flink、Spark、ClickHouse、Doris之类技术所不能比拟的；
+  一套系统三种用途，可作为：通用型流式大数据统计系统、数据指标管理系统和数据指标可视化系统。
+  对单个流式统计场景的数据量无限制，可以非常庞大，也可以非常稀少，既可以使用它完成十亿级用户量APP的DAU统计、几十万台服务器的运维监控、一线互联网大厂数据量级的日志统计、一线电商企业的订单统计、也可以用它来统计一天只有零星几次的接口调用量、耗时状况；
+  有完善的API，支持高并发查询统计结果；
+  支持数据备份、支持一键导入历史数据、可以方便的执行集群扩容、缩容、迁移等操作；
+  支持自定义存储引擎；
+  前端基于最新版ArcoDesign(React版本)开发，页面清爽大气，操作体验非常好；
+  所有代码100%开源，方便进行二次开发；
+  轻量级开箱即用，一键部署、一行代码接入、不管是单机版本还是大数据版本，系统运维都非常简单，普通工程人员即可轻松驾驭；

## 可以用来做什么？

XL-LightHouse可应用在企业生产的众多环节，可以帮助职场人从容应对大量琐碎、重复性的数据统计工作，减少不必要的时间浪费，提高工作效率。

以电商企业来说：
+ 可以为企业决策层提供其所关注的平台交易额、交易量、下单用户数、订单平均金额、人均消费金额等指标；
+ 可以为产品经理提供其所负责产品模块的pv、uv和点击率等指标；
+ 可以为运营人员提供关注的拉新用户量、各访问渠道用户量、站内各个广告位的点击量、点击用户数、点击收益等指标；
+ 可以为开发人员提供其关注的接口调用量、异常量、耗时情况等指标，可以辅助进行压力测试；
+ 可以为算法工程师提供其关注的模型训练时长、模型上线后的效果评测等指标，可以辅助进行ABTest；
+ 可以为运维人员提供其关注的是线上集群的CPU、内存、负载状况、IO、请求数、流量传输大小、网络丢包率、404错误量等监控指标；
+ 可以为UI设计师提供其关注的不同设计方案的点击转化对比情况；
+ 可以为数据分析师提供全面的数据指标更准确判断业务短板、业务走势、辅助决策层有针对性制定营销计划；
+ 可以轻松实现对各类复杂业务逻辑各主要环节的数据监控，及时发现问题并辅助问题排查。
+ 可以快速建立数据指标之间的交叉验证体系，轻松佐证数据指标的准确性。
+ 可以面向物联网及工业互联网场景实现各类设备上报数据相关指标统计和监控。

更多示例可参考：

- [即时通讯场景演示](https://dtstep.com/zh/scene/01.html)
- [技术类场景演示](https://dtstep.com/zh/scene/02.html)
- [电商类场景演示](https://dtstep.com/zh/scene/03.html)
- [资讯类场景演示](https://dtstep.com/zh/scene/04.html)

### Hello World

- [ICON点击数据统计](https://dtstep.com/zh/helloworld/01.html)
- [电商订单数据统计](https://dtstep.com/zh/helloworld/02.html)
- [订单支付状态数据统计](https://dtstep.com/zh/helloworld/03.html)

### XL-LightHouse与Flink和ClickHouse之类技术对比

-  [系统介绍](https://dtstep.com/zh/architecture/01.html)
-  [与Flink和ClickHouse之类技术对比](https://dtstep.com/zh/architecture/02.html)

###  版本记录

-  [安装包下载](https://dtstep.com/zh/versions/02.html)
-  [开源版本（最新：v2.2.9）](https://dtstep.com/zh/versions/02.html)
-  [商业版本（最新：v2.2.9-pro.3）](https://dtstep.com/zh/commercial/01.html)

###  日常运维

-  [一键部署](https://dtstep.com/zh/deploy/01.html)
-  [一键升级](https://dtstep.com/zh/management/06.html)
-  [数据备份](https://dtstep.com/zh/management/07.html)
-  [日常运维](https://dtstep.com/zh/management/03.html)

##  开发者承诺

为了保障XL-LightHouse项目更好的满足用户使用，开发者向所有使用者郑重承诺：

1、对较为严重可能造成数据泄露或数据丢失风险的漏洞都会第一时间修复；

2、影响基本功能使用的问题都会第一时间修复；

3、使用过程中遇到任何问题请及时提Issue，如有必要可提交相关日志给开发者，开发者将会提供必要的技术支持；

4、所有程序100%开源，开发者不会在程序中主观刻意添加任何形式的"后门"或"漏洞"，开发者绝不会窃取使用方业务数据以及试图通过控制使用方自身服务器资源的方式获取利益。

5、企业、机构内部使用或个人使用XL-LightHouse源程序、相关设计方案以及XL-Formula标准，无需授权，不收取任何费用，并且永远不收取任何费用。

6、商业版本是在开源版本的基础上额外新增功能，开源版本所有已提供的功能不会有任何使用层面的限制（比如不会限制数据量、集群规模、统计指标数量、Web系统访问人数等等）。

7、本项目长期维护。

敬请大家放心使用，如有疑问，请随时联系开发者咨询~

##  开源版本Web端部分功能预览

![XL-LightHouse](https://lighthousedp-1300542249.cos.ap-nanjing.myqcloud.com/screenshot_v2/32.jpg)
![XL-LightHouse](https://lighthousedp-1300542249.cos.ap-nanjing.myqcloud.com/screenshot_v2/5.jpg)
![XL-LightHouse](https://lighthousedp-1300542249.cos.ap-nanjing.myqcloud.com/screenshot_v2/34.jpg)
![XL-LightHouse](https://lighthousedp-1300542249.cos.ap-nanjing.myqcloud.com/screenshot_v2/23.jpg)
![XL-LightHouse](https://lighthousedp-1300542249.cos.ap-nanjing.myqcloud.com/screenshot_v2/7.jpg)
![XL-LightHouse](https://lighthousedp-1300542249.cos.ap-nanjing.myqcloud.com/screenshot_v2/8.jpg)
![XL-LightHouse](https://lighthousedp-1300542249.cos.ap-nanjing.myqcloud.com/screenshot_v2/33.jpg)
![XL-LightHouse](https://lighthousedp-1300542249.cos.ap-nanjing.myqcloud.com/screenshot_v2/9.jpg?t=2)
![XL-LightHouse](https://lighthousedp-1300542249.cos.ap-nanjing.myqcloud.com/screenshot_v2/24.jpg)
![XL-LightHouse](https://lighthousedp-1300542249.cos.ap-nanjing.myqcloud.com/screenshot_v2/11.jpg)
![XL-LightHouse](https://lighthousedp-1300542249.cos.ap-nanjing.myqcloud.com/screenshot_v2/37.jpg)

##  商业版本Web端部分功能预览

XL-LightHouse商业版提供更加强大和便利的数据统计分析功能，目前已支持折线图、面积图、柱状图、饼状图、漏斗图、表格等多种展示形式，支持各种日期筛选和维度筛选组件的搭配使用。每个数据指标可根据个人需求任意选择展示形式，不需要SQL开发，只需页面配置，即可轻松实现美观大方的数据展示效果。
此外XL-LightHouse向商业版用户提供功能完善、性能强大、业内领先的通用型监控告警实现方案。

商业版价格十分优惠，详见项目网站介绍，欢迎采购！

![XL-LightHouse](https://lighthousedp-1300542249.cos.ap-nanjing.myqcloud.com/screenshot_v2/38.jpg)
![XL-LightHouse](https://lighthousedp-1300542249.cos.ap-nanjing.myqcloud.com/screenshot_v2/53.jpeg)
![XL-LightHouse](https://lighthousedp-1300542249.cos.ap-nanjing.myqcloud.com/screenshot_v2/54.jpeg)
![XL-LightHouse](https://lighthousedp-1300542249.cos.ap-nanjing.myqcloud.com/screenshot_v2/52.jpeg)
![XL-LightHouse](https://lighthousedp-1300542249.cos.ap-nanjing.myqcloud.com/screenshot_v2/51.jpeg)

## 联系开发者

如果您有任何问题、意见或建议，请您添加以下微信。

![XL-LightHouse](https://lighthousedp-1300542249.cos.ap-nanjing.myqcloud.com/contact/contact_20240627_084143.jpg)


