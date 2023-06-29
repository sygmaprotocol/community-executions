# community-multisig-executions
This repository is used to keep track of executing function calls on `Sygma` mainnet community multisig.
The idea is to have a file describing a set of functions that we want to execute on a specific chain for mainnet environment. This way, when opening a new PR, we can describe required calls across all supported domains (networks).

The flow is described below:
 - decide what function calls need to be executed on the mainnet multisig
 - create a PR and populate it with required data to be review by the `Sygma` team
 - add proposal context in PR description
 - after agreeing that everything is as it should be, execute the calls on mainnet
 - after execution add tx hash to file(s) and merge the PR to mark that everything went well and is working as intended on the mainnet

### Create new proposal

The script takes the following command-line arguments:

```bash
./proposal.sh <root_folder> <directory1> <directory2> ... <num_migrations>
```

- `<root_folder>` : Specify the root folder representing the supported chain architectures. Valid values are evm and substrate.
- `<chain1> <chain2>` : Specify one or more directories representing the chain names where the migration files will be created.
- `<num_migrations>` (optional): Specify the number of migrations to be created per chain name. If omitted, a single migration will be created.
