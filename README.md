Execute the following to fetch SmithMassagerMaple, SmithMassagerC, and to build all the necessary dependencies,

```bash
nix-shell
cd SmithMassagerC
make
make install
```
After the above command there should be a directory under
`SmithMassagerC/install` which contains the shared `lib/` and `include/`
files. In addition you should also see a `bin/`
directory which contains the binary file `smith-massager`, this file simply
takes a prime number, generate an interesting Smith form, and then executes
Smith Massager algorithm. You can try executing it by,

```bash
./SmithMassagerC/install/bin/smith-massager 107
```

Now to build with maple support you must have already installed maple, an example of
executing Smith Massager would be,
```bash
nix-shell --arg mapleDir "\"PATH_TO_MAPLE\""
cd SmithMassagerC
make
make install
cd ../SmithMassagerMaple
maple SmithMassager/SmithMassager.mpl
```
