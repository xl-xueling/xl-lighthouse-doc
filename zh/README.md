<br>
<div align="center">
	<img src="https://lighthousedp-1300542249.cos.ap-nanjing.myqcloud.com/screenshot_v2/26.jpg" width="220px;">
</div>

<p align="center">
A general-purpose streaming big data statistics system.<br>
Easier to use, supports a larger amount of data, and can complete more statistical indicators faster.
</p>

[![LICENSE](https://img.shields.io/github/license/xl-xueling/xl-lighthouse.svg)](https://github.com/xl-xueling/xl-lighthouse/blob/master/LICENSE)
[![Language](https://img.shields.io/badge/language-Java-blue.svg)](https://www.java.com)
[![repository](https://img.shields.io/badge/build-passing-blue.svg)](https://github.com/xl-xueling/xl-lighthouse)
[![website](https://img.shields.io/badge/website-dtstep.com-blue)](https://dtstep.com)
[![GitHub release](https://img.shields.io/github/tag/xl-xueling/xl-lighthouse.svg?label=release)](https://github.com/xl-xueling/xl-lighthouse/releases)
[![GitHub release date](https://img.shields.io/github/release-date/xl-xueling/xl-lighthouse.svg)](https://github.com/xl-xueling/xl-lighthouse/releases)

<p align="center"><font size="4">一键部署，一行代码接入，无需大数据研发运维经验，轻松驾驭海量数据实时统计。</font></p>
<p align="center"><font size="4">支撑百万量级数据指标，帮助企业低成本搭建数据化运营体系。</font></p>
<p align="center"><font size="4">除大数据版本外，同时支持单机版！</font></p>

### 概述

* XL-LightHouse是针对繁杂的数据统计需求而开发的一套集成了数据写入、数据运算和数据可视化等一系列功能，支持超大数据量，支持超高并发的【通用型流式大数据统计系统】。
* XL-LightHouse目前已涵盖了各种流式数据统计场景，包括count、sum、max、min、avg、distinct、topN/lastN等多种运算，支持多维度计算，支持分钟级、小时级、天级多个时间粒度的统计，支持自定义统计周期的配置。
* XL-LightHouse内置丰富的转化类函数、支持表达式解析，可以满足各种复杂的条件筛选和逻辑判断。
* XL-LightHouse提供了完善的可视化查询功能，对外提供API查询接口，此外还包括数据指标管理、权限管理、统计限流等多种功能。
* XL-LightHouse支持时序性数据的存储和查询。

### 项目特点

通用型流式数据统计或许是唯一一种有可能支撑百万量级数据指标，而成本仍可控制在企业可承受范围之内的技术。
目前业内广泛采用的以实时计算、离线计算、OLAP为主的技术方案都太过于臃肿和笨重，如果替换为以通用型流式数据统计为主，以其他技术方案为辅的实现方式可大幅降低企业成本。XL-LightHouse期望使用更为轻巧和实用的技术方案应对繁琐的数据统计问题。

+  XL-LightHouse最核心的优势在于：依据流式统计的运算特点而设计，并对每一种运算单元进行反复优化，使得每一种运算单元可以以非常低的成本，无限制复用；
+  可以短时间内快速实现庞大量级数据指标，而这是Flink、Spark、ClickHouse、Doris之类技术所不能比拟的；
+  一套系统三种用途，可作为：通用型流式大数据统计系统、数据指标管理系统和数据指标可视化系统。
+  对单个流式统计场景的数据量无限制，可以非常庞大，也可以非常稀少，既可以使用它完成十亿级用户量APP的DAU统计、十几万台服务器的运维监控、一线互联网大厂数据量级的日志统计、也可以用它来统计一天只有零星几次的接口调用量、耗时状况；
+  支持高并发查询统计结果；
+  轻量级使用，一键部署、一行代码接入、普通工程人员即可轻松驾驭；

---
**目前已完成对所有基本功能的严格测试，可以放心使用。可添加本人微信，提供免费一对一技术支持。遇到任何问题，及时提Issue，本人会第一时间处理。**

---

### 可以用来做什么？

XL-LightHouse可应用在企业生产的众多环节，可以帮助职场人从容应对大量琐碎、重复性的数据统计工作，减少不必要的时间浪费，提高工作效率。

以电商企业来说：
+ 可以为企业决策层提供其所关注的平台交易额、交易量、下单用户数、订单平均金额等指标；
+ 可以为产品经理提供其所负责产品模块的pv、uv和点击率等指标；
+ 可以为运营人员提供关注的拉新用户量，站内广告点击量、点击收益等指标；
+ 可以为开发人员提供其关注的接口调用量、异常量、耗时情况等指标；
+ 可以为算法工程师提供其关注的模型训练时长、模型准确率，模型上线后的效果评测等指标；
+ 可以为运维人员提供其关注的是线上集群的CPU、内存、负载状况等监控指标；
+ 可以为UI设计师提供其关注的不同设计方案的点击转化对比情况；
+ 可以为数据分析师提供全面的数据指标更准确判断业务短板、业务走势、辅助决策层有针对性的制定营销计划；
+ 可以轻松实现对各类复杂业务逻辑各主要环节的数据监控，及时发现问题并辅助问题排查。

更多示例可参考：

- [即时通讯场景演示](https://dtstep.com/zh/scene/01.html)
- [技术类场景演示](https://dtstep.com/zh/scene/02.html)
- [电商类场景演示](https://dtstep.com/zh/scene/03.html)
- [资讯类场景演示](https://dtstep.com/zh/scene/04.html)

### 单机版本

XL-LightHouse除了大数据版本外，同时支持单机版。单机模式成本低廉，最低配置只需要一台4核8G的云服务器，部署运维更加简单！

适用场景：

+ 面向中小企业或中小型业务团队使用；

+ 面向"用完即弃"的使用场景；

有些时候对数据指标的需求，往往只在某个特定的阶段。比如：新接口上线要进行接口性能优化；线上业务出现数据异常问题需要排查；数据库读写压力突然暴涨，需要确定异常请求的来源等等，
对于此类问题排查，流式统计可以起到至关重要的作用。但问题排查一般不需要持续很长时间，可能一两周甚至两三天。这种情况可以使用XL-LightHouse单机版。一键部署，轻量级使用，问题排查完，将XL-LightHouse删除即可。

+ 用于初步体验XL-LightHouse或作为二次开发的联调测试环境；

### Hello World

- [ICON点击数据统计](https://dtstep.com/zh/helloworld/01.html)
- [电商订单数据统计](https://dtstep.com/zh/helloworld/02.html)
- [订单支付状态数据统计](https://dtstep.com/zh/helloworld/03.html)

### XL-LightHouse与Flink和ClickHouse之类技术对比

-  [系统介绍](https://dtstep.com/zh/architecture/01.html)
-  [与Flink和ClickHouse之类技术对比](https://dtstep.com/zh/architecture/02.html)

###  版本记录

-  [安装包下载](https://dtstep.com/zh/versions/02.html)
-  [版本记录](https://dtstep.com/zh/versions/02.html)

###  技术支持

为了保障XL-LightHouse项目更好的满足用户使用，对所有使用者提供以下技术支持。

1、对较为严重可能造成数据泄露风险的漏洞都会第一时间修复；

2、影响基本功能使用的问题都会第一时间修复；

3、使用过程中遇到任何问题请及时提Issue，如有必要可提交相关日志给开发者，开发者将会提供必要的技术支持；

###  一键部署

-  [一键部署](https://dtstep.com/zh/deploy/01.html)

###  Web端演示站点

演示站点：http://119.91.203.220:19232/     测试账号：admin，密码：123456

###  Web端部分功能预览

![XL-LightHouse](https://lighthousedp-1300542249.cos.ap-nanjing.myqcloud.com/screenshot_v2/5.jpg)
![XL-LightHouse](https://lighthousedp-1300542249.cos.ap-nanjing.myqcloud.com/screenshot_v2/22.jpg)
![XL-LightHouse](https://lighthousedp-1300542249.cos.ap-nanjing.myqcloud.com/screenshot_v2/23.jpg)
![XL-LightHouse](https://lighthousedp-1300542249.cos.ap-nanjing.myqcloud.com/screenshot_v2/7.jpg)
![XL-LightHouse](https://lighthousedp-1300542249.cos.ap-nanjing.myqcloud.com/screenshot_v2/8.jpg)
![XL-LightHouse](https://lighthousedp-1300542249.cos.ap-nanjing.myqcloud.com/screenshot_v2/9.jpg?t=2)
![XL-LightHouse](https://lighthousedp-1300542249.cos.ap-nanjing.myqcloud.com/screenshot_v2/11.jpg)
