package cmd

import (
	"context"
	"fmt"
	"log"
	"os"

	"github.com/docker/docker/api/types/container"
	"github.com/docker/docker/client"
	"github.com/spf13/cobra"
)

var masterCmd = &cobra.Command{
	Use:   "master",
	Short: "Manage the master MySQL server",
	Run: func(cmd *cobra.Command, args []string) {
		cli, err := client.NewClientWithOpts(client.FromEnv, client.WithAPIVersionNegotiation())
		if err != nil {
			log.Fatalf("failed to create docker client: %v", err)
			os.Exit(1)
		}
		defer cli.Close()

		response, err := cli.ContainerCreate(context.Background(), &container.Config{
			Image: "mysql-repl-master",
			Cmd:   []string{"--server-id=1"},
		}, nil, nil, nil, "")
		if err != nil {
			log.Fatalf("failed to list containers: %v", err)
			os.Exit(1)
		}

		fmt.Println(response)
	},
}
