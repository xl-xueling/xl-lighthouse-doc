## 单机模式standalone-config.json配置优化

standalone-config.json文件包括XL-LightHouse自身配置参数和其依赖组件的配置参数。为了方便起见，将各组件常用配置参数统一放在cluster-config.json文件中。

如需进行相关优化，请修改"操作节点"下的${LDP_HOME}/bin/config/standalone-config.json文件，执行重启操作(restart-all.sh)即可生效！

如果您使用自定存储引擎，忽略以下mysql的配置，将相关内存平均分配给其他进程。

## standalone-config.json快速配置参考

如果您对于各组件优化缺乏相关经验，可以按照自身服务器配置情况，直接拷贝以下配置即可！

### 单节点8G内存配置参考
+ standalone-config.json配置
```
{
  "lighthouse": {
    "timezone": "Asia/Shanghai",
    "standalone_xmx_memory": "500M",
    "standalone_xms_memory": "500M",
    "insights_xmx_memory": "256M",
    "insights_xms_memory": "256M"
  },
  "redis": {
    "max_memory": "220M"
  },
  "mysql": {
    "max_connections": "50",
    "innodb_buffer_pool_size": "600M",
    "tmp_table_size": "8M",
    "max_heap_table_size": "8M"
  }
}
```

### 单节点16G内存配置参考

+ standalone-config.json配置
```
{
  "lighthouse": {
    "timezone": "Asia/Shanghai",
    "standalone_xmx_memory": "1000M",
    "standalone_xms_memory": "1000M",
    "insights_xmx_memory": "512M",
    "insights_xms_memory": "512M"
  },
  "redis": {
    "max_memory": "450M"
  },
  "mysql": {
    "max_connections": "80",
    "innodb_buffer_pool_size": "1300M",
    "tmp_table_size": "10M",
    "max_heap_table_size": "10M"
  }
}
```

### 单节点32G内存配置参考

+ standalone-config.json配置
```
{
  "lighthouse": {
    "timezone": "Asia/Shanghai",
    "standalone_xmx_memory": "2000M",
    "standalone_xms_memory": "2000M",
    "insights_xmx_memory": "1024M",
    "insights_xms_memory": "1024M"
  },
  "redis": {
    "max_memory": "900M"
  },
  "mysql": {
    "max_connections": "100",
    "innodb_buffer_pool_size": "2600M",
    "tmp_table_size": "16M",
    "max_heap_table_size": "16M"
  }
}
```


### 单节点64G内存配置参考

+ standalone-config.json配置
```
{
  "lighthouse": {
    "timezone": "Asia/Shanghai",
    "standalone_xmx_memory": "3000M",
    "standalone_xms_memory": "3000M",
    "insights_xmx_memory": "1024M",
    "insights_xms_memory": "1024M"
  },
  "redis": {
    "max_memory": "1800M"
  },
  "mysql": {
    "max_connections": "151",
    "innodb_buffer_pool_size": "5200M",
    "tmp_table_size": "16M",
    "max_heap_table_size": "16M"
  }
}
```
### 单节点128G内存配置参考

+ standalone-config.json配置
```
{
  "lighthouse": {
    "timezone": "Asia/Shanghai",
    "standalone_xmx_memory": "3000M",
    "standalone_xms_memory": "3000M",
    "insights_xmx_memory": "1024M",
    "insights_xms_memory": "1024M"
  },
  "redis": {
    "max_memory": "3600M"
  },
  "mysql": {
    "max_connections": "151",
    "innodb_buffer_pool_size": "10000M",
    "tmp_table_size": "32M",
    "max_heap_table_size": "32M"
  }
}
```

### 单节点256G内存配置参考

+ standalone-config.json配置
```
{
  "lighthouse": {
    "timezone": "Asia/Shanghai",
    "standalone_xmx_memory": "5000M",
    "standalone_xms_memory": "5000M",
    "insights_xmx_memory": "2048M",
    "insights_xms_memory": "2048M"
  },
  "redis": {
    "max_memory": "7200M"
  },
  "mysql": {
    "max_connections": "200",
    "innodb_buffer_pool_size": "20000M",
    "tmp_table_size": "64M",
    "max_heap_table_size": "64M"
  }
}
```