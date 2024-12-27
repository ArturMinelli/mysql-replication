package cmd

import (
	"os"

	"github.com/spf13/cobra"
)

var rootCmd = &cobra.Command{
	Use:   "mysql-repl",
	Short: "mysql-repl is a tool to manage MySQL replication",
}

func Execute() {
	rootCmd.AddCommand(masterCmd)

	if err := rootCmd.Execute(); err != nil {
		os.Exit(1)
	}

	os.Exit(0)
}
