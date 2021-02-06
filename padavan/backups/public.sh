# cd $WORK_PATH/trunk 执行在这个目录下

# 1.修改一些默认参数 ./user/shared/defaults.h（需要不同设备不同拷贝到相应sh文件就好)

user_name='admin'                        # 用户名
user_password=$user_name                 # 用户密码
lan_ip='192.168.3'                       # lan 地址 192.168.3.1 一定别写后面的 .1
wifi_password='1234567890'               # wifi密码,密码8位
default_path='./user/shared/defaults.h'  # 默认文件配置目录

echo '修改用户名'
sed -i 's/#define\s*SYS_USER_ROOT\s*"admin"/#define  SYS_USER_ROOT     "'$user_name'"/g' $default_path

echo '修改密码'
sed -i 's/#define\s*DEF_ROOT_PASSWORD\s*"admin"/#define  DEF_ROOT_PASSWORD     "'$user_password'"/g' $default_path

echo '修改Lan ip'
sed -i "s/192.168.2/$lan_ip/g" $default_path

echo '修改Wif密码'
sed -i "s/1234567890/$wifi_password/g" $default_path

# 2. 删除预设项
################################################################################################
# 因不同型号配置功能不一样，所以先把配置项删除，如果你自己要添加其他的，也要写上删除这一条，切记！！！
################################################################################################
# Default
sed -i '/CONFIG_FIRMWARE_INCLUDE_DROPBEAR/d' .config            # 删除配置项 dropbear SSH
sed -i '/CONFIG_FIRMWARE_INCLUDE_DROPBEAR_FAST_CODE/d' .config  # 删除配置项 dropbear symmetrica
sed -i '/CONFIG_FIRMWARE_INCLUDE_DROPBEAR_FAST_CODE/d' .config  # 删除配置项 OpenSSH 
sed -i "/CONFIG_FIRMWARE_INCLUDE_DDNS_SSL/d"  .config           #  HTTPS support for DDNS client
sed -i "/CONFIG_FIRMWARE_INCLUDE_HTTPS/d"  .config              #  HTTPS support

# C大
sed -i '/CONFIG_FIRMWARE_INCLUDE_MENTOHUST/d' .config    # 删除配置项 MENTOHUST
sed -i '/CONFIG_FIRMWARE_INCLUDE_SCUTCLIENT/d' .config   # 删除配置项 SCUTCLIENT
sed -i '/CONFIG_FIRMWARE_INCLUDE_SHADOWSOCKS/d' .config  # 删除配置项 SS plus+
sed -i '/CONFIG_FIRMWARE_INCLUDE_SSSERVER/d' .config     # 删除配置项 SS server
sed -i '/CONFIG_FIRMWARE_INCLUDE_DNSFORWARDER/d' .config # 删除配置项 DNS-FORWARDER
sed -i '/CONFIG_FIRMWARE_INCLUDE_ADBYBY/d' .config       # 删除配置项 adbyby plus+
sed -i '/CONFIG_FIRMWARE_INCLUDE_TUNSAFE/d' .config      # 删除配置项 TUNSAFE
sed -i '/CONFIG_FIRMWARE_INCLUDE_ALIDDNS/d' .config      # 删除配置项 阿里 DDNS
sed -i '/CONFIG_FIRMWARE_INCLUDE_SMARTDNS/d' .config     # 删除配置项 smartDns
sed -i '/CONFIG_FIRMWARE_INCLUDE_SRELAY/d' .config       # 删除配置项 srelay 代理

# 3. 添加公共自定义功能，设备单个的到设备 sh文件中添加
######################################################################
# 以下选项是定义你需要的功能（y=集成,n=忽略），重新写入到.config文件
######################################################################

# 科学
echo "CONFIG_FIRMWARE_INCLUDE_SHADOWSOCKS=y" >> .config  # SS plus+
echo "CONFIG_FIRMWARE_INCLUDE_SSSERVER=n" >> .config     # SS server
#echo "CONFIG_FIRMWARE_INCLUDE_V2RAY=n" >> .config #集成v2ray执行文件（3.8M左右)，如果不集成，会从网上下载下来执行，不影响正常使用
#echo "CONFIG_FIRMWARE_INCLUDE_TROJAN=n" >> .config #集成trojan执行文件(1.1M左右)，如果不集成，会从网上下载下来执行，不影响正常使用

#  代理
echo "CONFIG_FIRMWARE_INCLUDE_TUNSAFE=n" >> .config      # TUNSAFE
echo "CONFIG_FIRMWARE_INCLUDE_KUMASOCKS=y" >> .config    # KUMA
echo "CONFIG_FIRMWARE_INCLUDE_SRELAY=n" >> .config       # srelay
echo "CONFIG_FIRMWARE_INCLUDE_IPT2SOCKS=n" >> .config    # IPT2
#echo "CONFIG_FIRMWARE_INCLUDE_MICROSOCKS=y" >> .config  # MICRO

# 文件
#echo "CONFIG_FIRMWARE_INCLUDE_CADDY=y" >> .config #在线文件管理服务
#echo "CONFIG_FIRMWARE_INCLUDE_CADDYBIN=n" >> .config #集成caddu执行文件，此文件有13M,请注意固件大小。如果不集成，会从网上下载下来执行，不影响正常使用

# 广告
echo "CONFIG_FIRMWARE_INCLUDE_ADBYBY=y" >> .config        # adbyby plus+
#echo "CONFIG_FIRMWARE_INCLUDE_KOOLPROXY=y" >> .config    # KP广告过滤
# echo "CONFIG_FIRMWARE_INCLUDE_ADGUARDHOME=y" >> .config # ADG 

# DNS 有关
echo "CONFIG_FIRMWARE_INCLUDE_DNSFORWARDER=n" >> .config # DNS-FORWARDER
echo "CONFIG_FIRMWARE_INCLUDE_SMARTDNS=y" >> .config     # smartdns
echo "CONFIG_FIRMWARE_INCLUDE_SMARTDNSBIN=y" >> .config  # smartdns二进制文件


# 穿透
echo "CONFIG_FIRMWARE_INCLUDE_FRPC=y" >> .config         # 内网穿透FRPC
echo "CONFIG_FIRMWARE_INCLUDE_FRPS=y" >> .config         # 内网穿透FRPS
echo "CONFIG_FIRMWARE_INCLUDE_ALIDDNS=y" >> .config      # 阿里DDNS

# 其他
echo "CONFIG_FIRMWARE_INCLUDE_MENTOHUST=n" >> .config    # MENTOHUST 锐捷认证
echo "CONFIG_FIRMWARE_INCLUDE_SCUTCLIENT=n" >> .config   # SCUT校园网客户端 

# Default

### Include dropbear SSH. ~0.3MB
echo "CONFIG_FIRMWARE_INCLUDE_DROPBEAR=y" >> .config

### Make the dropbear symmetrical ciphers and hashes faster. ~0.06MB
echo "CONFIG_FIRMWARE_INCLUDE_DROPBEAR_FAST_CODE=y" >> .config

### Include OpenSSH instead of dropbear. openssl ~1.2MB, openssh ~1.0MB
echo "CONFIG_FIRMWARE_INCLUDE_OPENSSH=n" >> .config

### Include HTTPS support for DDNS client. openssl ~1.2MB
echo "CONFIG_FIRMWARE_INCLUDE_DDNS_SSL=y" >> .config

### Include HTTPS support. openssl ~1.2MB
echo "CONFIG_FIRMWARE_INCLUDE_HTTPS=y" >> .config
