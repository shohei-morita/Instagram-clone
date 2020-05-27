server '54.250.131.167', user:'app', roles:%w{app db web}
set :ssh_options, keys:'/usr/local/ssh/id_rsa'
