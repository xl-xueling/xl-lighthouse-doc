## 集群模式cluster-config.json配置优化

cluster-config.json文件包括XL-LightHouse自身配置参数和其依赖组件的配置参数。为了方便起见，将各组件常用配置参数统一放在cluster-config.json文件中。

如需进行相关优化，请修改"操作节点"下的${LDP_HOME}/bin/config/cluster-config.json文件，执行重启操作(restart-all.sh)即可生效！

如果您使用自定存储引擎或rpc组件，忽略以下hbase/hadoop/ice的配置，将相关内存平均分配给其他进程。

##  cluster-config.json快速配置参考

如果您对于各组件优化缺乏相关经验，可以按照自身服务器配置情况，直接拷贝以下配置即可！

### 单节点16G内存配置参考
```
{
  "lighthouse": {
    "timezone": "Asia/Shanghai",
    "ice_xmx_memory": "600M",
    "ice_xms_memory": "600M",
    "tasks_driver_memory": "500M",
    "tasks_executor_memory": "800M",
    "tasks_direct_memory": "256M",
    "tasks_num_executors": 6,
    "tasks_executor_cores": 2,
    "insights_xmx_memory": "300M",
    "insights_xms_memory": "300M"
  },
  "zookeeper": {
    "xmx_memory": "260M",
    "xms_memory": "260M"
  },
  "hadoop": {
    "namenode_xmx_memory": "480M",
    "namenode_xms_memory": "480M",
    "datanode_xmx_memory": "600M",
    "datanode_xms_memory": "600M",
    "secondarynamenode_xmx_memory": "480M",
    "secondarynamenode_xms_memory": "480M",
    "resourcemanager_xmx_memory": "480M",
    "resourcemanager_xms_memory": "480M",
    "nodemanager_xmx_memory": "480M",
    "nodemanager_xms_memory": "480M",
    "yarn.scheduler.maximum-allocation-mb": "160000",
    "yarn.nodemanager.resource.memory-mb": "168000",
    "yarn.scheduler.maximum-allocation-vcores": "32",
    "yarn.nodemanager.resource.cpu-vcores": "32"
  },
  "hbase": {
    "master_xmx_memory": "480M",
    "master_xms_memory": "480M",
    "master_direct_memory": "400M",
    "regionserver_xmx_memory": "1300M",
    "regionserver_xms_memory": "1300M",
    "regionserver_direct_memory": "400M"
  },
  "kafka": {
    "xmx_memory": "300M",
    "xms_memory": "300M"
  },
  "redis": {
    "max_memory": "200M"
  },
  "mysql": {
    "max_connections": "151",
    "innodb_buffer_pool_size": "500M",
    "tmp_table_size": "8M",
    "max_heap_table_size": "8M"
  }
}
```
### 单节点32G内存配置参考

+ cluster-config.json配置
```
{
	"lighthouse": {
		"timezone": "Asia/Shanghai",
		"ice_xmx_memory": "1300M",
		"ice_xms_memory": "1300M",
		"tasks_driver_memory": "800M",
		"tasks_executor_memory": "1500M",
		"tasks_direct_memory": "256M",
		"tasks_num_executors": 6,
		"tasks_executor_cores": 2,
		"insights_xmx_memory": "512M",
		"insights_xms_memory": "512M"
	},
	"zookeeper": {
		"xmx_memory": "480M",
		"xms_memory": "480M"
	},
	"hadoop": {
		"namenode_xmx_memory": "1280M",
		"namenode_xms_memory": "1280M",
		"datanode_xmx_memory": "1280M",
		"datanode_xms_memory": "1280M",
		"secondarynamenode_xmx_memory": "1280M",
		"secondarynamenode_xms_memory": "1280M",
		"resourcemanager_xmx_memory": "1280M",
		"resourcemanager_xms_memory": "1280M",
		"nodemanager_xmx_memory": "1280M",
		"nodemanager_xms_memory": "1280M",
		"yarn.scheduler.maximum-allocation-mb": "160000",
		"yarn.nodemanager.resource.memory-mb": "168000",
		"yarn.scheduler.maximum-allocation-vcores": "32",
		"yarn.nodemanager.resource.cpu-vcores": "32"
	},
	"hbase": {
		"master_xmx_memory": "1280M",
		"master_xms_memory": "1280M",
		"master_direct_memory": "512M",
		"regionserver_xmx_memory": "5600M",
		"regionserver_xms_memory": "5600M",
		"regionserver_direct_memory": "800M"
	},
	"kafka": {
		"xmx_memory": "800M",
		"xms_memory": "800M"
	},
	"redis": {
		"max_memory": "1024M"
	},
    "mysql": {
        "max_connections": "151",
        "innodb_buffer_pool_size": "500M",
        "tmp_table_size": "16M",
        "max_heap_table_size": "16M"
    }
}
```

### 单节点64G内存配置参考

+ cluster-config.json配置
```
{
	"lighthouse": {
		"timezone": "Asia/Shanghai",
		"ice_xmx_memory": "1500M",
		"ice_xms_memory": "1500M",
		"tasks_driver_memory": "1024M",
		"tasks_executor_memory": "1800M",
		"tasks_direct_memory": "256M",
		"tasks_num_executors": 7,
		"tasks_executor_cores": 2,
		"insights_xmx_memory": "1024M",
		"insights_xms_memory": "1024M"
	},
	"zookeeper": {
		"xmx_memory": "512M",
		"xms_memory": "512M"
	},
	"hadoop": {
		"namenode_xmx_memory": "2560M",
		"namenode_xms_memory": "2560M",
		"datanode_xmx_memory": "2560M",
		"datanode_xms_memory": "2560M",
		"secondarynamenode_xmx_memory": "2560M",
		"secondarynamenode_xms_memory": "2560M",
		"resourcemanager_xmx_memory": "2560M",
		"resourcemanager_xms_memory": "2560M",
		"nodemanager_xmx_memory": "2560M",
		"nodemanager_xms_memory": "2560M",
		"yarn.scheduler.maximum-allocation-mb": "160000",
		"yarn.nodemanager.resource.memory-mb": "168000",
		"yarn.scheduler.maximum-allocation-vcores": "32",
		"yarn.nodemanager.resource.cpu-vcores": "32"
	},
	"hbase": {
		"master_xmx_memory": "2560M",
		"master_xms_memory": "2560M",
		"master_direct_memory": "1024M",
		"regionserver_xmx_memory": "11200M",
		"regionserver_xms_memory": "11200M",
		"regionserver_direct_memory": "1600M"
	},
	"kafka": {
		"nodes_size": 3,
		"xmx_memory": "1600M",
		"xms_memory": "1600M"
	},
	"redis": {
		"max_memory": "1600M"
	},
	"mysql": {
        "max_connections": "151",
        "innodb_buffer_pool_size": "500M",
        "tmp_table_size": "16M",
        "max_heap_table_size": "16M"
    }
}
```
### 单节点128G内存配置参考

+ cluster-config.json配置
```
{
	"lighthouse": {
		"timezone": "Asia/Shanghai",
		"ice_xmx_memory": "2048M",
		"ice_xms_memory": "2048M",
		"tasks_driver_memory": "1500M",
		"tasks_executor_memory": "2000M",
		"tasks_direct_memory": "256M",
		"tasks_num_executors": 8,
		"tasks_executor_cores": 2,
		"insights_xmx_memory": "4096M",
		"insights_xms_memory": "4096M"
	},
	"zookeeper": {
		"xmx_memory": "1920M",
		"xms_memory": "1920M"
	},
	"hadoop": {
		"namenode_xmx_memory": "2560M",
		"namenode_xms_memory": "2560M",
		"datanode_xmx_memory": "5120M",
		"datanode_xms_memory": "5120M",
		"secondarynamenode_xmx_memory": "2560M",
		"secondarynamenode_xms_memory": "2560M",
		"resourcemanager_xmx_memory": "2560M",
		"resourcemanager_xms_memory": "2560M",
		"nodemanager_xmx_memory": "5120M",
		"nodemanager_xms_memory": "5120M",
		"yarn.scheduler.maximum-allocation-mb": "160000",
		"yarn.nodemanager.resource.memory-mb": "168000",
		"yarn.scheduler.maximum-allocation-vcores": "32",
		"yarn.nodemanager.resource.cpu-vcores": "32"
	},
	"hbase": {
		"master_xmx_memory": "2560M",
		"master_xms_memory": "2560M",
		"master_direct_memory": "1024M",
		"regionserver_xmx_memory": "22400M",
		"regionserver_xms_memory": "22400M",
		"regionserver_direct_memory": "3200M"
	},
	"kafka": {
		"xmx_memory": "3200M",
		"xms_memory": "3200M"
	},
	"redis": {
		"max_memory": "3200M"
	},
	"mysql": {
        "max_connections": "200",
        "innodb_buffer_pool_size": "1024M",
        "tmp_table_size": "32M",
        "max_heap_table_size": "32M"
    }
}
```

### 单节点256G内存配置参考

+ cluster-config.json配置
```
{
	"lighthouse": {
		"timezone": "Asia/Shanghai",
		"ice_xmx_memory": "4096M",
		"ice_xms_memory": "4096M",
		"tasks_driver_memory": "2048M",
		"tasks_executor_memory": "2000M",
		"tasks_direct_memory": "256M",
		"tasks_num_executors": 12,
		"tasks_executor_cores": 2,
		"insights_xmx_memory": "4096M",
		"insights_xms_memory": "4096M"
	},
	"zookeeper": {
		"xmx_memory": "3840M",
		"xms_memory": "3840M"
	},
	"hadoop": {
		"namenode_xmx_memory": "5120M",
		"namenode_xms_memory": "5120M",
		"datanode_xmx_memory": "5120M",
		"datanode_xms_memory": "5120M",
		"secondarynamenode_xmx_memory": "5120M",
		"secondarynamenode_xms_memory": "5120M",
		"resourcemanager_xmx_memory": "5120M",
		"resourcemanager_xms_memory": "5120M",
		"nodemanager_xmx_memory": "5120M",
		"nodemanager_xms_memory": "5120M",
		"yarn.scheduler.maximum-allocation-mb": "160000",
		"yarn.nodemanager.resource.memory-mb": "168000",
		"yarn.scheduler.maximum-allocation-vcores": "32",
		"yarn.nodemanager.resource.cpu-vcores": "32"
	},
	"hbase": {
		"master_xmx_memory": "2560M",
		"master_xms_memory": "2560M",
		"master_direct_memory": "1024M",
		"regionserver_xmx_memory": "44800M",
		"regionserver_xms_memory": "44800M",
		"regionserver_direct_memory": "6400M"
	},
	"kafka": {
		"xmx_memory": "5120M",
		"xms_memory": "5120M"
	},
	"redis": {
		"max_memory": "6400M"
	},
	"mysql": {
        "max_connections": "200",
        "innodb_buffer_pool_size": "1024M",
        "tmp_table_size": "32M",
        "max_heap_table_size": "32M"
    }
}
```