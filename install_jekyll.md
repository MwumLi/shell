## jekyll的安装  
	
		$ gem install jekyll
Jekyll 需要以下的 gems: directory_watcher,liquid,open4,maruku和classifier。这些组件将会在 gem 的安装命令之后自动安装。  
在Ubuntu下默认安装了gem1.9.1  
其它系统请自行安装  

如果你在 gem 的安装过程中遇到错误，你可能需要安装 ruby1.9.1 的编译扩展组件的头文件。如果是 Debian 系统，你可以这样做：  

	$ sudo apt-get install ruby1.9.1-dev  

ed Hat、CentOS 或 Fedora 系统，你可以这样做：  

	$ sudo yum install ruby-devel  

在 NearlyFreeSpeech 上，你需要：  
		
	USER_INSTALL=true gem install jekyll  
果你在 Windows 操作系统上遇到像 Faild to build gem native extension 这样的错误，你可能需要安装 RubyInstaller DevKit  

 OSX 上，你可能需要升级 RubyGems:  
 
	$ sudo gem update --system   
 如果你见到 missing headers 这样的错误，你可能还需要为 Xcode 安装命令行工具，你可以从 [这里][https://developer.apple.com/downloads/index.action] 下载。  

## RDiscount  
如果你希望使用 RDiscount 来渲染 markdown，而不是 Maruku,只要确保 RDiscount 被正确地安装：  

	$ sudo gem install rdiscount  
然后运行 Jekyll，并使用以下的参数选项：  

	$ jekyll --rdiscount  
你可以在你的 _config.yml 中写入如下代码，从而不必指定标志  

	markdown: rdiscount  

## Pygments  
如果你希望在你的文章中通过 highlight 标签实现代码高亮，你需要安装 Pygments。

在 Unbutu 和 Debian 上:  

	sudo pat-get install python-pygments  
在 Fedora 和 CentOS 上:

	sudo yum install python-pygments
在 Gentoo 上:

	sudo emerge -av dev-python/pygments 
安装pygments:   

	sudo apt-get install python-pygments  
生成pygments里面的高亮css文件: pygmentize -f html -S default > pygments.css  
把生成的pygments.css移到你的css文件夹里，在post模板里引用一下  
修改配置文件_config.xml,添加 highlighter: pygments    
使用时代码包含在{% highlight language%}和{% endhighlight %}之间    
参数language可以从http://pygments.org/docs/lexers/获得    

## 使用
一个获取最简单 Jekyll 模板并生成静态页面的方法  

	$ jekyll new myblog
	$ cd myblog 
	$ jekyll serve  
	# =>Now browse to http://localhost:4000  
就是这么简单。从现在开始，你可以通过创建文章、改变头信息来控制模板和输出、修改 Jekyll 设置来使你的站点变得更有趣～  

### 运行jekyll开发服务器  
 一个开发服务器将会运行在 http://localhost:4000/  
 
	$ jekyll serve  
如果你想脱离终端在后台运行  

	$ jekyll serve --detach  
如果你想关闭服务器，可以使用`kill -9 1234`命令，"1234" 是进程号（PID）.  
如果你找不到进程号，那么就用`ps aux | grep jekyll`命令来查看，然后关闭服务器。

如果你想查看变更并且自动再生成  

	$ jekyll serve --watch  

## 错误  
执行rails  server的时候报错：/var/lib/gems/1.9.1/gems/execjs-1.4.0/lib/execjs/runtimes.rb:51:in `autodetect': Could not find a JavaScript runtime. See https://github.com/sstephenson/execjs for a list of available runtimes. (ExecJS::RuntimeUnavailable)
 
	from /var/lib/gems/1.9.1/gems/execjs-1.4.0/lib/execjs.rb:5:in `<module:ExecJS>'
	from /var/lib/gems/1.9.1/gems/execjs-1.4.0/lib/execjs.rb:4:in `<top (required)>'
	from /var/lib/gems/1.9.1/gems/coffee-script-2.2.0/lib/coffee_script.rb:1:in `require'
原因：没有js运行时环境
解决办法：安装js运行时环境(sudo apt-get install nodejs  )
