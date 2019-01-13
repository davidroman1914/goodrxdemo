# goodrxdemo |

Below you will find the make target that are available, you only really need two of them `make infra-up` and `make infra-down`. 

Start by calling the `make help` 
```
    build                          Build The Go Server App.
    deploy                         Deploying The Go Server App.
    destroy                        Destorying The Go Server App.
    get-elb-dns                    Return The ELB DNS.
    get-pub-ip                     Return The Public IP.
    infra-down                     Destroy AWS Infrastructure.
    infra-up                       Create AWS Infrastructure.
```

### Make infra-up 
When running this target, Terraform will spin up an EC2 and an ELB.  Inside of the `app/` directory you will find a `GOLANG` server that greets you. For Devability it's important to be able to run your app locally or remotely, for this reason `Docker` is used. 

Inside of the `infra/` directory there is a `scripts/setup.sh` file that checkouts our app from github and calls make to run the app for us. 
```
    git clone https://github.com/davidroman1914/goodrxdemo.git && \
    cd goodrxdemo && \
    cd goserver && \
    sudo make deploy
``` 

Once the ELB has initialized and has gone through the health checks we should be able to see our app. I normally give it 25 seconds. If we need to get the ELB DNS name we can do that by
``` 
make get-elb-dns

This will return something like:
    goserver-terraform-elb-102402541.us-west-2.elb.amazonaws.com
```
Then we're able to hit our endpoints such as: 
```
    http://goserver-terraform-elb-102402541.us-west-2.elb.amazonaws.com
    http://goserver-terraform-elb-102402541.us-west-2.elb.amazonaws.com/hello/david
```

### SSH-ing 

If want to SSH in we can do that by 
```
    ssh -i infra/keys/goodrx ubuntu@[IP]
```
We can at anytime get the public ip by 
```
    make get-pub-ip
```

    
### Make infra-down 
When running this target, Terraform will spin down an EC2 and an ELB. 
