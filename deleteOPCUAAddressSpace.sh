#!/bin/sh
c8y inventory find --query "c8y_OpcuaServerId eq '2164341' and type eq c8y_OpcuaNode" --includeAll  | c8y inventory delete 
