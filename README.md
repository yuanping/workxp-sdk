# Workxp

A Ruby interface to the [WorkXP API](https://github.com/yuanping/workxp-api).

在OAuth2::Client的基础上封装了WorkXP API，使用OAuth2的Token创建Workxp::Client，返回Hash或Array。  
获取OAuth2 Token可以使用 [omniauth-workxp](https://github.com/liuqi1024/omniauth-workxp) Gem。

## Installation

Add this line to your application's Gemfile:

    gem 'workxp'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install workxp

## Usage

```shell
client = Workxp::Client.new token: 'oauth2 token', 
                    refresh_token: 'oauth2 refresh token', 
                       expires_at: 1.month.from_now, 
                       sub_domain: 'your subdomain',
                          app_key: 'app key', 
                       app_secret: 'app secret',
                       user_agent: 'WorkXP iOS客户端'
                            
```

获得所有联系人，以Hash的方式传参数

    client.contacts #=> [{"id": 37, name: 'YuanPing', ...}]
    client.contacts "begin" => '2014-06-01T10:00:00+0800', "end" => '2014-07-01T10:00:00+0800', "page" => 2
    
通过ID取某一个联系人信息

    client.contact '37'  #=> {"id": 37, name: 'YuanPing', ...}

创建、更新一个联系人

    contact_hash = {name: 'Pan', type: 'Person', contact_methods: [{type: 'ContactPhone', key: 'mobile', value: '13800138000'}]}
    client.create_contact contact_hash.to_json
    #=> {"id": 38, name: 'Pan', ...}
    
    client.update_contact '38', contact_hash.to_json
    
删除联系人    

    client.delete_contact '38'
    
## API List
联系人
```shell
contacts(opts={})
contact(id)
create_contact(json)
update_contact(id, json)
delete_contact(id)
```

机会
```shell
deals(opts={})
deal(id)
create_deal(json)
update_deal(id, json)
delete_deal(id)
```

项目(kase) 账户信息(account) 分类(category) 任务(task) 事件(note) 的接口与联系人与机会接口的命名规则相同。  

其它接口：
```shell
deletions(opts={})

task_categories(opts={})
groups
tags

# create_attachment '/path/file.png', 'image/png'
create_attachment(file_path, file_type)

# search_activities term: 'test'
search_activities(opts={})

activities(opts={})

```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request