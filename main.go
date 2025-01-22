package main

import (
	"fmt"
	"log"
	"net/http"
	"time"
)

type Message struct {
	Name        string
	Id          int
	Description string
}

func main() {
	handler := http.NewServeMux()

	handler.HandleFunc("/", homeHandler)
	handler.HandleFunc("/events", handleEvent)

	if err := http.ListenAndServe(":8080", handler); err != nil {
		log.Println(err)
	}
}

func homeHandler(w http.ResponseWriter, r *http.Request) {
	w.Write([]byte("Hello World"))
}

func handleEvent(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Access-Control-Allow-Origin", "*")
	w.Header().Set("Access-Control-Expose-Headers", "Content-Type")

	w.Header().Set("Content-Type", "text/event-stream")
	w.Header().Set("Cache-Control", "no-cache")
	w.Header().Set("Connection", "keep-alive")

	i := 0
	for i > -1 {
		i++

		message := fmt.Sprintf("https://picsum.photos/id/%d/200/300", i)

		fmt.Fprintf(w, "id: %d\nevent: message\ndata: %v\n\n", i, message)

		time.Sleep(15 * time.Second)

		w.(http.Flusher).Flush()
	}

	closeNotify := w.(http.CloseNotifier).CloseNotify()
	<-closeNotify
}
