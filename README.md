# goodrxdemo |


##Quick step up, we will need to add the access, secret key in `vars.tf`.
```
variable "AWS_ACCESS_KEY" {
  type    = "string"
  default = ""
}

variable "AWS_SECRET_KEY" {
  type    = "string"
  default = ""
}

```


Below you will find the make targets that are available, you only really need two of them `make infra-up` and `make infra-down`. 

If you want a list of all the targets `make help` 
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
When running this target, Terraform will spin up an EC2 and an ELB.  Inside of the `app/` directory you will find a `GOLANG` server that greets you. Below is the code itself which is also in `goserver/app/src/main.go`

``` 
package main

import (
	"fmt"
	"io"
	"log"
	"net/http"
	"github.com/gorilla/mux"
)

func HelloHandler(w http.ResponseWriter, r *http.Request) {

	w.WriteHeader(http.StatusOK)
	vars := mux.Vars(r)

	greetings, err := getGreeting(vars["key"])
	if err != nil {
		log.Println(`Failed to get a username: %v`, err)
	}
	io.WriteString(w, greetings)
}

func getGreeting(userGreeting string) (string, error) {

	if len(userGreeting) == 0 {
		return "<h1>No one to greet! :(<h1>", nil // if we choose we can format an error and handle it.
	}
	return fmt.Sprintf(`<h1>Hello, %v!!!! :)<h1>`, userGreeting), nil
}

func main() {
	r := mux.NewRouter()
	r.HandleFunc("/hello/{key}", HelloHandler)
	r.HandleFunc("/hello", HelloHandler)
	r.HandleFunc("/", HelloHandler)

	log.Fatal(http.ListenAndServe("0.0.0.0:31381", r))
}
```

For Devability it's important to be able to run your app locally or remotely, for this reason `Docker` is used. 

Inside of the `infra/` directory there is a `scripts/setup.sh` file that checkouts our app from github and calls `make` to run the app for us. 
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
