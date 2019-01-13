// endpoints.go
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
