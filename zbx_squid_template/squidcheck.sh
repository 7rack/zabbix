#!/bin/bash
VERSION="1.0"
SQUIDCLIENT="/opt/squid/bin/squidclient -h 127.0.0.1 -p 80 -U noc@example.com -W yourpassword"

function usage()
{
        echo "squidcheck  version: $VERSION"
        echo "usage:"
        echo "  $0 http_requests              - Number of HTTP requests received"
        echo "  $0 clients                    - Number of clients accessing cache"
        echo "  $0 icp_received               - Number of ICP messages received"
        echo "  $0 icp_sent                   - Number of ICP messages sent"
        echo "  $0 icp_queued                 - Number of queued ICP replies"
        echo "  $0 htcp_received              - Number of HTCP messages received"
        echo "  $0 htcp_sent                  - Number of HTCP messages sent"
        echo "  $0 req_fail_ratio             - Request failure ratio"
        echo "  $0 avg_http_req_per_min       - Average HTTP requests per minute since start"
        echo "  $0 avg_icp_msg_per_min        - Average ICP messages per minute since start"
        echo "  $0 request_hit_ratio          - Request Hit Ratios"
        echo "  $0 byte_hit_ratio_5           - Byte Hit Ratio 5 mins"
        echo "  $0 byte_hit_ratio_60          - Byte Hit Ratio 60 mins"
        echo "  $0 request_mem_hit_ratio_5    - Request Memory Hit Ratios 5 mins"
        echo "  $0 request_mem_hit_ratio_60   - Request Memory Hit Ratios 60 mins"
        echo "  $0 request_disk_hit_ratio_5   - Request Disk Hit Ratios 5 mins"
        echo "  $0 request_disk_hit_ratio_60  - Request Disk Hit Ratios 60 mins"
        echo "  $0 servicetime_httpreq        - HTTP Requests (All)"
        echo "  $0 process_mem                - Process Data Segment Size via sbrk"
        echo "  $0 cpu_usage                  - CPU Usage"
        echo "  $0 cache_size_disk            - Storage Swap size"
        echo "  $0 cache_size_mem             - Storage Mem size"
        echo "  $0 mean_obj_size              - Mean Object Size"
        echo "  $0 filedescr_max              - Maximum number of file descriptors"
        echo "  $0 filedescr_avail            - Available number of file descriptors"
}

########
# Main #
########

if [[ $# !=  1 ]];then
        #No Parameter
        usage
        exit 0
fi
case $1 in
"http_requests")
    	value="`${SQUIDCLIENT} mgr:info|grep 'Number of HTTP requests received:'|cut -d':' -f2| tr -d ' \t'`"
        rval=$?;;
"clients")
    	value="`${SQUIDCLIENT} mgr:info|grep 'Number of clients accessing cache:'|cut -d':' -f2| tr -d ' \t'`"
        rval=$?;;
"icp_received")
        value="`${SQUIDCLIENT} mgr:info|grep 'Number of ICP messages received:'|cut -d':' -f2| tr -d ' \t'`"
        rval=$?;;
"icp_sent")
        value="`${SQUIDCLIENT} mgr:info|grep 'Number of ICP messages sent:'|cut -d':' -f2| tr -d ' \t'`"
        rval=$?;;
"icp_queued")
        value="`${SQUIDCLIENT} mgr:info|grep 'Number of queued ICP replies:'|cut -d':' -f2| tr -d ' \t'`"
        rval=$?;;
"htcp_received")
        value="`${SQUIDCLIENT} mgr:info|grep 'Number of HTCP messages received:'|cut -d':' -f2| tr -d ' \t'`"
        rval=$?;;
"htcp_sent")
        value="`${SQUIDCLIENT} mgr:info|grep 'Number of HTCP messages sent:'|cut -d':' -f2| tr -d ' \t'`"
        rval=$?;;
"req_fail_ratio")
        value="`${SQUIDCLIENT} mgr:info|grep 'Request failure ratio:'|cut -d':' -f2| tr -d ' \t'`"
        rval=$?;;
"avg_http_req_per_min")
        value="`${SQUIDCLIENT} mgr:info|grep 'Average HTTP requests per minute since start:'|cut -d':' -f2| tr -d ' \t'`"
        rval=$?;;
"avg_icp_msg_per_min")
        value="`${SQUIDCLIENT} mgr:info|grep 'Average ICP messages per minute since start:'|cut -d':' -f2| tr -d ' \t'`"
        rval=$?;;
"request_hit_ratio")
        value="`${SQUIDCLIENT} mgr:info|grep 'Request Hit Ratios:'|cut -d':' -f3|cut -d',' -f1|tr -d ' %'`"
        rval=$?;;
"byte_hit_ratio_5")
        value="`${SQUIDCLIENT} mgr:info|grep 'Byte Hit Ratios:'|  cut -d':' -f3|cut -d',' -f1|tr -d ' %'`"
        rval=$?;;
"byte_hit_ratio_60")
        value="`${SQUIDCLIENT} mgr:info|grep 'Byte Hit Ratios:'|  cut -d':' -f4 | tr -d ' %'`"
        rval=$?;;
"request_mem_hit_ratio_5")
        value="`${SQUIDCLIENT} mgr:info|grep 'Request Memory Hit Ratios:' | cut -d':' -f3|cut -d',' -f1|tr -d ' %'`"
        rval=$?;;
"request_mem_hit_ratio_60")
        value="`${SQUIDCLIENT} mgr:info|grep 'Request Memory Hit Ratios:' | cut -d':' -f4 | tr -d ' %'`"
        rval=$?;;
"request_disk_hit_ratio_5")
        value="`${SQUIDCLIENT} mgr:info|grep 'Request Disk Hit Ratios:'| cut -d':' -f3|cut -d',' -f1|tr -d ' %'`"
        rval=$?;;
"request_disk_hit_ratio_60")
        value="`${SQUIDCLIENT} mgr:info|grep 'Request Disk Hit Ratios:'| cut -d':' -f4 | tr -d ' %'`"
        rval=$?;;
"servicetime_httpreq")
        value="`${SQUIDCLIENT} mgr:info|grep 'HTTP Requests (All):'|cut -d':' -f2|tr -s ' '|awk '{print $1}'`"
        rval=$?;;
"process_mem")
        value="`${SQUIDCLIENT} mgr:info|grep 'Process Data Segment Size via sbrk'|cut -d':' -f2|awk '{print $1}'`"
        rval=$?;;
"cpu_usage")
        value="`${SQUIDCLIENT} mgr:info|grep 'CPU Usage:'|cut -d':' -f2|tr -d '%'|tr -d ' \t'`"
        rval=$?;;
"cache_size_disk")
        value="`${SQUIDCLIENT} mgr:info|grep 'Storage Swap size:'|cut -d':' -f2|awk '{print $1}'`"
        rval=$?;;
"cache_size_mem")
        value="`${SQUIDCLIENT} mgr:info|grep 'Storage Mem size:'|cut -d':' -f2|awk '{print $1}'`"
        rval=$?;;
"mean_obj_size")
        value="`${SQUIDCLIENT} mgr:info|grep 'Mean Object Size:'|cut -d':' -f2|awk '{print $1}'`"
        rval=$?;;
"filedescr_max")
        value="`${SQUIDCLIENT} mgr:info|grep 'Maximum number of file descriptors:'|cut -d':' -f2|awk '{print $1}'`"
        rval=$?;;
"filedescr_avail")
        value="`${SQUIDCLIENT} mgr:info|grep 'Available number of file descriptors:'|cut -d':' -f2|awk '{print $1}'`"
        rval=$?;;
*)
        usage
        exit 1;;
esac

if [ "$rval" -eq 0 -a -z "$value" ]; then
        rval=1
fi

if [ "$rval" -ne 0 ]; then
        echo "ZBX_NOTSUPPORTED"
fi

echo $value
