# Workxp

A Ruby interface to the WorkXP API.

在OAuth2::Client的基础上封装了WorkXP API，使用OAuth2的Token创建Workxp::Client，返回JSON格式数据。

## Installation

Add this line to your application's Gemfile:

    gem 'workxp'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install workxp

## Usage

```shell
client = Workxp::Client.new token: 'oauth2 token', refresh_token: 'oauth2 refresh token', 
                            expires_at: 1.month.from_now, sub_domain: 'your subdomain',
                            app_key: 'app key', app_secret: 'app secret'
                                              
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
