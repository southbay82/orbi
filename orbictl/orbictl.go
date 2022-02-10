package main

import (
	"crypto/tls"
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
)

func main() {
	fmt.Println("Welcome to Orbi Control")
	log.Println("Logging into Orbi Router...")

	var user = "admin"
	var pass = "secret"
	var loginurl = "https://192.168.1.1/reboot.htm"
	// var rebooturl = "https://192.168.1.1/apply.cgi?/reboot_waiting.htm%20timestamp=8870567231"

	tr := &http.Transport{
		TLSClientConfig: &tls.Config{InsecureSkipVerify: true},
	}
	client := &http.Client{Transport: tr}
	req, err := http.NewRequest("GET", loginurl, nil)
	//req, err := http.NewRequest("POST", rebooturl, nil)
	if err != nil {
		log.Fatalln(err)
	}

	req.SetBasicAuth(user, pass)
	if err != nil {
		log.Fatalln(err)
	}

	resp, err := client.Do(req)
	if err != nil {
		log.Fatalln(err)
	}

	defer resp.Body.Close()

	body, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		log.Fatalln(err)
	}

	for _, cookie := range resp.Cookies() {
		log.Println("Found a cookie named:", cookie.Name)
	}

	log.Println(string(body))
	log.Println("Rebooting Orbi Router, Please Wait...")

}
