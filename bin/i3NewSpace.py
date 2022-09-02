#!/usr/bin/env python3
from i3ipc import Connection

def main() -> None:
    i3 = Connection()
    workspaces = i3.get_workspaces()
    newest = max(workspace.num for workspace in workspaces )
    next = newest + 1
    i3.command(f"workspace {next}")

if __name__ == "__main__":
    main()
