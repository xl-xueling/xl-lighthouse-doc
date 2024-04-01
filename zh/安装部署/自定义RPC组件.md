#### 自定义RPC组件

1、配置/opt/soft/lighthouse-x.x.x/bin/templates/lighthouse/conf/ldp-site.xml，将如下信息修改为外置数据库的配置信息
如果您希望使用外置RPC服务，需要首先扩展相应实现，参考：[自定义RPC组件](/zh/自定义扩展/自定义RPC组件.md)；
如果选择自定义rpc组件，程序默认不再部署kafka消息队列服务，则请提供自己搭建的kafka集群配置信息。
```
 <property>
        <name>kafka.bootstrap.servers</name>
        <value>10.206.6.16:9092,10.206.6.31:9092,10.206.6.45:9092</value>
    </property>
    <property>
        <name>kafka.topic.name</name>
        <value>lighthouse-topic-v1</value>
    </property>
```

2、配置/opt/soft/lighthouse-2.1.0/bin/common/const.sh。
```
# 修改该参数值为false
_DEPLOY_LIGHTHOUSE_ICE=false
```

3、修改bin/config/sourcelist文件，注释掉kafka的配置
```
#kafka=https://ldp-soft-1300542249.cos.accelerate.myqcloud.com/kafka_2.12-2.8.2.tgz
```

4、执行部署程序，自动连接所配置的数据库，并进行初始化！

```
# 执行一键部署命令
> /usr/soft/lighthouse-x.x.x/bin/easy-deploy.sh
```