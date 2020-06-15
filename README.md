## 安装

在您 Ruby 应用程序的 Gemfile 文件中，添加如下一行代码：

```ruby
gem 'baklib_api', git: 'https://github.com/tanmer/baklib_api.git'
```
然后，在应用程序所在的目录下，可以运行 bundle 安装依赖包：

    $ bundle

或者，可以使用 Ruby 的包管理器 gem 进行安装：

    $ gem install baklib_api

## 初始化
在使用SDK之前，您需要一个有效的 `Token` 授权

可以通过如下步骤获得：

1. 点击[注册](https://sso.baklib.com/sign_up)开通baklib账号
2. 如果已有账号，进入插件中心，开通 `API` 插件功能。点击[这里](https://api.baklib.com/overview_doc)查看 `Token` 和 `ClientId` 获取方式
在`config/initializers`文件夹下面添加`baklib_api.rb`配置文件

**注意：** 用户应当妥善保存 `Token` ，一旦发生泄露，请立刻到[个人后台](https://sso.baklib.com/tokens)更新。

在使用 Ruby SDK 之前，需要初始化环境，并且设置 `Token`
```ruby
#!/usr/bin/env ruby
require 'baklib_api'
BaklibApi::Config.setup do |config|
  config.token = '<YOUR_BAKLIB_TOKEN>'
  config.client_id = '<BAKLIB_CLIENT_ID>'
end
```

如果您使用的是 Ruby on Rails 框架，我们建议您在应用初始化启动的过程中，调用上述方法即可，操作如下：

1. 在应用初始化脚本加载的目录中新建一个文件：YOUR_RAILS_APP/config/initializers/baklib_api.rb

2. 编辑 YOUR_RAILS_APP/config/initializers/baklib_api.rb 文件内容如下：

```ruby
require 'baklib_api'
BaklibApi::Config.setup do |config|
  config.token = '<YOUR_BAKLIB_TOKEN>'
  config.client_id = '<BAKLIB_CLIENT_ID>'
end
```
这样，您就可以在您的 RAILS_APP 中使用 baklib Ruby SDK 提供的其他任意方法了。

### 注意
以下文档教程均以 Ruby on Rails 框架为基础，并仅列出部分方法的用例

### 栏目相关

**可调用方法**

1. `BaklibApi::Models::Channel.list`
3. `BaklibApi::Models::Channel.create`
2. `BaklibApi::Models::Channel#destroy`
4. `BaklibApi::Models::Channel#update`
5. `BaklibApi::Models::Channel#articles`
6. `BaklibApi::Models::Channel#create_article`

创建栏目代码:

```ruby
BaklibApi::Models::Channel.create(name: 'test')
```

查看当前栏目的文章：
```ruby
channel = BaklibApi::Models::Channel.list.first
articles = channel.articles
```

### 文章相关

**可调用方法**

3. `BaklibApi::Models::Article.create`
2. `BaklibApi::Models::Article#destroy`
4. `BaklibApi::Models::Article#update`

创建文章代码:

说明： 目前文章仅支持传输`markdown`格式和`paragraph`格式，默认为`paragraph`格式, 
```ruby
BaklibApi::Models::Article.create(name: 'test', channel_id: channel.id, content_type: 'paragraph', content: 'test content')
```

或者直接在某个栏目先创建文章

```ruby
channel = BaklibApi::Models::Channel.list.first
channel.create_article(name: 'article_name', content: 'content test')
```
