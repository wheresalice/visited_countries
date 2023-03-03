package main

import (
	"github.com/charmbracelet/log"
	"golang.org/x/net/html"
	"gopkg.in/yaml.v2"
	"net/http"
	"os"
)

var foundCountries []string
var parsedCountries []country

type country struct {
	Name string `yaml:"name"`
}

func findCountries() {
	resp, err := http.Get("https://travelerscenturyclub.org/countries-and-territories/")
	if err != nil {
		log.Fatal(err)
	}
	defer resp.Body.Close()

	doc, err := html.Parse(resp.Body)
	if err != nil {
		log.Fatal(err)
	}

	var f func(*html.Node)
	f = func(n *html.Node) {
		if n.Type == html.ElementNode && n.Data == "li" && n.Parent.Parent.Data == "td" {
			log.Debug(n.FirstChild.Data)
			foundCountries = append(foundCountries, n.FirstChild.Data)
		}
		for c := n.FirstChild; c != nil; c = c.NextSibling {
			f(c)
		}
	}
	f(doc)
}

func parseYaml(f string) {
	data, err := os.ReadFile(f)
	if err != nil {
		log.Fatal(err)
	}
	yaml.Unmarshal(data, &parsedCountries)
}

func extraFoundCountries() {
	var c []string
	for i := range foundCountries {
		found := false
		for j := range parsedCountries {
			if foundCountries[i] == parsedCountries[j].Name {
				found = true
			}
		}
		if found == false {
			c = append(c, foundCountries[i])
		}
	}
	for i := range c {
		log.Info("+ " + c[i])
	}
}

func extraParsedCountries() {
	var c []string
	for i := range parsedCountries {
		found := false
		for j := range foundCountries {
			if parsedCountries[i].Name == foundCountries[j] {
				found = true
			}
		}
		if found == false {
			c = append(c, parsedCountries[i].Name)
		}
	}
	for i := range c {
		log.Info("- " + c[i])
	}
}

func main() {
	//log.SetLevel(log.DebugLevel)

	findCountries()
	log.Debug(foundCountries)

	parseYaml("../data/countries.yaml")
	log.Debug(parsedCountries)

	extraFoundCountries()
	extraParsedCountries()

}
