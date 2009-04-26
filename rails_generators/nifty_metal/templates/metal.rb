require 'sinatra'
require 'xmlrpc/marshal'
require 'aws/s3'


Sinatra::Application.set(:run => false, :environment =>  :production)
Api = Sinatra::Application unless defined? Api

before do
  response['Content-Type'] = 'text/xml'  
end

post '/xmlrpc' do
  #puts request.body
  xml = request.body.string
  
  call = XMLRPC::Marshal.load_call(xml)
      
  
  # method = call[0].gsub(/blogger\.(.*)/, '\1').gsub(/([A-Z])/, '_\1').downcase
  # convert metaWeblog.getPost to get_post
  method = call[0].gsub(/metaWeblog\.(.*)/, '\1').gsub(/([A-Z])/, '_\1').downcase
  
  if method == "blogger.get_users_blogs"
    method = "get_users_blogs"
  end
  
  if method == "blogger.get_user_info"
    method = "get_user_info"
  end
  
  
  puts method
  
  response['Content-Type'] = 'text/xml'  
  send(method, call)
end


def get_post(xmlrpc_call)
  if authorized?(xmlrpc_call[1])
    begin
      page = Page.find(xmlrpc_call[1][0])
    rescue ActiveRecord::RecordNotFound
      page = Page.find(xmlrpc_call[1][0].gsub(/^.*pages\/(\d+)[^\d].*$/, '\1'))
    end
    XMLRPC::Marshal.dump_response(post.to_metaweblog)
  end
end

def get_recent_posts(xmlrpc_call)
  if authorized?(xmlrpc_call[1])
    pages = Page.find(:all, :limit => 10, :order => "created_at DESC")
    XMLRPC::Marshal.dump_response(posts.map{|p| p.to_metaweblog})
  end
end

def new_post(xmlrpc_call)
  if authorized?(xmlrpc_call[1])
    data = xmlrpc_call[1]
    # blog_id = data[0]; user = data[1]; pass = data[2]
    post_data = data[3]
    page = Page.create(:name => post_data["title"], :body => post_data["description"])
    XMLRPC::Marshal.dump_response(page.to_metaweblog)
  end
end

def edit_post(xmlrpc_call)
  if authorized?(xmlrpc_call[1])
    data = xmlrpc_call[1]
    page = Page.find(data[0])
    # user = data[1]; pass = data[2]
    post_data = data[3]
    page.update_attributes!(:name => post_data["title"], :body => post_data["description"])
    XMLRPC::Marshal.dump_response(post.to_metaweblog)
  end
end

def get_categories(xmlrpc_call)
  if authorized?(xmlrpc_call[1])
    tags = Tag.find(:all)
    XMLRPC::Marshal.dump_response(tags.map{ |t| {:categoryId => t.id, :parentId => 0, :description => t.name, :categoryName => t.name, :htmlUrl => "http://" + APP_CONFIG['domain'] + "/pages?tag=#{t.name}", :rssUrl => "http://" + APP_CONFIG['domain'] + "/pages.rss?tag=#{t.name}" } } )
  end
end

def new_media_object(xmlrpc_call)
  if authorized?(xmlrpc_call[1])
    post_data = xmlrpc_call[1][3]
    name = post_data["name"].gsub(/\//,'')
    access_keys = YAML.load_file("#{RAILS_ROOT}/config/s3.yml")[ENV["RAILS_ENV"]]
    AWS::S3::Base.establish_connection! :access_key_id => access_keys['access_key_id'], :secret_access_key => access_keys['secret_access_key']        

    AWS::S3::S3Object.store(name, post_data["bits"], APP_CONFIG['name'], :access => :public_read)
    XMLRPC::Marshal.dump_response({
      :file => name,
      :url => "http://s3.amazonaws.com/#{APP_CONFIG['name']}/#{name}"
    })
  end
end

def get_users_blogs(xmlrpc_call)
  if authorized?(xmlrpc_call[1])
    XMLRPC::Marshal.dump_response([{ :url => "http://" + APP_CONFIG['domain'], :blogid => "1", :blogName => APP_CONFIG['name'] }])
  end
end

def get_user_info(xmlrpc_call)
  if user = authorized?(xmlrpc_call[1])
    XMLRPC::Marshal.dump_response([{ :userid => user.id, :url => "http://" + APP_CONFIG['domain'], :lastname => user.login, :firstname => "", :email => user.email }])
  end
end

protected 

def authorized?(data)
  User.authenticate(data[1], data[2])
end