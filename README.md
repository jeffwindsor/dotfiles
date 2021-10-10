# Dotfiles

<ul>
    <li>The dotfiles are packaged into "configuration" folders representing:</li>
    <ul>
        <li>general configuration files, associated with a specific context, like an application</li>
        <li>machine configuration files specific to a machine with the following conventions:</li>
            <ul>
              <li>package name prefix of <b>machine-</b></li>
              <li>contains a list of config packages for the machine in the subfolder <b>./.local/config/machine</b></li>
              <li>contains a machine setup script in the subfolder <b>./local/scripts/setup/machine</b></li>
            </ul>
        <li>operating system specific configuration files specific to an operating system</li>
      <ul><li>contains a machine setup script in the subfolder <b>./local/scripts/setup/os</b></li></ul>
    </ul>
    <li>Adding a configuration folder, smart links the entire tree of files inside the folder into the $HOME directory</li>
<pre>$ ./add {config-folder-name}</pre>
  <li>Removing a configuration folder, removes the smart links for the folders tree from the $HOME directory</li>
<pre>$ ./remove {config-folder-name}</pre>
  <li>The packages are meant to be combined to obtain a full "config" for a machine + operating system</li>
  <li>Configuring a Machine</li>
<pre>$ ./config {machine-config-folder-name}</pre>
  <ul>    
    <li>meant to work on machine configuration folders</li>
    <li>reads a list of config folders from the <b>{machine-config-folder-name}/.local/config/machine</b> file</li>
    <li>removes and then adds</li>
  </ul>
  <li>Currently uses [gnu stow](https://linux.die.net/man/8/stow) for smart linking</li>
</ul>
