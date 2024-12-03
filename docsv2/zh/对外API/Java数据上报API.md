## SDK引用

+ 请使用2.2.8或以上版本（建议使用MvnRepository中的最新版本）

```
<dependency>
    <groupId>com.dtstep.lighthouse</groupId>
    <artifactId>lighthouse-shaded-client</artifactId>
    <version>2.2.8</version>
</dependency>
```

## 数据上报API说明

###  Lighthouse.init(String locators)

1、参数信息

+ locators，LightHouse-RPC服务注册中心配置参数。

2、接口作用

+ 用于调用方与LightHouse-RPC服务之间连接初始化。

### LightHouse.stat(String token,final String secretKey,Map<String,Object> paramMap,long timestamp)

1、参数信息

+ token，统计组标识；
+ secretKey，统计组秘钥，请在“工程列表 - 工程管理 - 统计组 - 更多 - 秘钥”栏目中获取；
+ paramMap，原始消息参数信息；
+ timestamp，消息事件13位时间戳，系统依据该时间戳划分统计窗口；

2、接口作用

+ 用于上报统计原始消息信息。

### LightHouse.stat(String token,final String secretKey,Map<String,Object> paramMap,int repeat, long timestamp)

1、参数信息
+ token，统计组标识；
+ secretKey，统计组秘钥，请在“工程列表 - 工程管理 - 统计组 - 更多 - 秘钥”栏目中获取；
+ paramMap，原始消息参数信息；
+ repeat，统计消息重复上报次数，默认为1；
+ timestamp，消息事件13位时间戳，系统依据该时间戳划分统计窗口；

2、接口作用

+ 用于上报统计原始消息信息，repeat参数表示同样的消息重复上报几次。

## 调用示例

```
package com.dtstep.lighthouse.core.test.api;

import com.dtstep.lighthouse.client.LightHouse;
import com.dtstep.lighthouse.common.random.RandomID;
import org.junit.Test;

import java.util.HashMap;
import java.util.concurrent.ThreadLocalRandom;

public class RpcStatTest {

    static {
        try{
            //修改rpc服务注册中心地址,集群模式为一主一从，默认为部署集群的前两个节点IP,使用逗号分割，单机模式为当前节点IP
            //LightHouse.init("10.206.6.11:4061,10.206.6.12:4061");//集群模式初始化
            LightHouse.init("10.206.6.31:4061");//单机模式初始化
        }catch (Exception ex){
            ex.printStackTrace();
        }
    }
    
    @Test
    public void orderStat() throws Exception {
        long t = System.currentTimeMillis();
        for(int i=0;i<6657;i++){
            HashMap<String,Object> paramMap = new HashMap<>();
            paramMap.put("order_id", RandomID.id(6));
            paramMap.put("biz", RandomID.id(2));
            paramMap.put("user_id", RandomID.id(6));
            Double d = ThreadLocalRandom.current().nextDouble(1000);
            paramMap.put("amount",String.format("%.3f", d));//防止上面随机数出现科学计数法
            LightHouse.stat("N4C:order_stat","YEWU3tGjNQL1AevvC9FjNj9SCuvzpYPmLY5akKYz",paramMap,t);
        }
        System.out.println("send ok!");
        Thread.sleep(300000);//client为异步发送，防止进程结束时内存中部分消息没有发送出去
    }
}
```

## 补充说明

+ 本SDK提供基础验签机制，如果您对SDK使用安全性方面有更高要求，可以在本SDK的基础上额外增加数据加密或签名验证等处理流程。
