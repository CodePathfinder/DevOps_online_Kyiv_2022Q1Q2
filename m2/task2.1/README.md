# Module 2. Virtualization and Cloud Basic

## TASK 2.1

### PART 1. HYPERVISORS

1. What are the most popular hypervisors for infrastructure virtualization?

TBA

2. Briefly describe the main differences of the most popular hypervisors.

TBA

### PART 2. WORK WITH VIRTUALBOX

1. First run VirtualBox and Virtual Machine (VM).

- Creation new and clone of the existing VM

![clone-existing-VM](images/clone-existing-VM.png)

- Keyboard shortcuts - HOST (`ctrl right`) key combinations examples:

| command    | description                    |
| :--------- | :----------------------------- |
| HOST + Del | equivalent of Ctrl + Alt + Del |
| HOST + F   | go to full screen              |
| HOST + C   | enable scaled mode             |
| HOST + Q   | close virtual machine          |
| HOST + T   | take snapshot                  |
| HOST + E   | take screenshot                |
| HOST + P   | stop/pause                     |
| HOST + R   | reboot/reset                   |
| HOST + S   | settings                       |

- Create a group of two VM

![Group of two VMs](images/group-of-two-VMs.png)

- Branched tree of snapshots

![Branched tree of snapshots](images/branched-tree-of-snapshots.png)

- Export VM (saving .ova file to disk)

![Export VM](images/exporting-vm.png)

- Import VM from .ova file

![Import VM: appliance settings](images/import-vm-appliance-settings.png)

![Import VM: completed](images/import-vm-completed.png)

2. Configuration of virtual machines

2.2 Configure the USB to connect the USB ports of the host machine to the VM[1, ch.3.11].

- Mount shared folder

![Mount shared folder](images/manual-mount-shared-folder.png)

- Network modes

TBA

Networking Modes Tests:

| mode        | VM -> Host | VM <- Host | VM1 <-> VM2 | VM -> Net | VM <- NET |
| :---------- | :--------: | :--------: | :---------: | :-------: | :-------: |
| NAT         |     +      |  port fwd  | :---------- |     +     | :-------- |
| Bridged     |     +      |     +      | :---------- |     +     | :-------- |
| Internal    |     -      |     -      |      +      |     -     | :-------- |
| Host-Only   | :--------- | :--------- | :---------- | :-------- | :-------- |
| NAT network | :--------- | :--------- | :---------- | :-------- | :-------- |

Add static IP address to VM (internal network):

`ifconfig enp0s3 192.168.1.10 netmask 255.255.255.0 up`

See IP routing table:

`route -n`

Ping example: `ping -c 5 reqres.in`

3. Work with CLI through VBoxManage.

#### Basic commands of VBoxManage examined and played with (selectively):

- `VBoxManage list vms`
- `VBoxManage showvminfo Ubuntu_srv_01`
- `VBoxManage startvm Ubuntu_srv_01`
- `VBoxManage controlvm Ubuntu_srv_01 pause` (resume/reset/poweroff//usbattach|usbdetach <uuid|address/>)

- `VBoxManage snapshot Ubuntu_srv_02 take` (delete|restore <snapshot>)
- `VBoxManage snapshot Ubuntu_srv_02 list`
- `VBoxManage clonevm Ubuntu_srv_01 --name=Ubuntu_srv_03 --register --snapshot="docker-group-added"`

- `VBoxManage createvm --name Ubuntu_srv_04 --ostype Ubuntu_64 --register`

- `VBoxManage modifyvm Ubuntu_srv_02 --name Ubuntu_srv_05`
  (--groups <group>
  --ostype <ostype>
  --memory <memorysize>
  --usb on|off
  --usbrename <oldname> <newname>)

- `VBoxManage unregistervm Ubuntu_srv_33 --delete`
- `VBoxManage export Ubuntu_srv_05 -o ub5.ova --vsys 0`
- `VBoxManage import ub5.ova --dry-run`

- `VBoxManage sharedfolder add <vmname> --name=<sharedfoldername> --hostpath=<hostpath>`
- `VBoxManage sharedfolder remove <vmname> --name=<sharedfoldername>`
- `VBoxManage metrics setup --period 1 --samples 5 host CPU/Load,RAM/Usage`
- `VBoxManage metrics list` (query)

### PART 3. WORK WITH VAGRANT

- Vagrant up ('ubuntu/focal64')

![Vagrant up](images/vagrant-ubuntu-up.png)

- Vagrant ssh ('ubuntu/focal64'). Record the date and time by executing the date command

![Vagrant ssh](images/vagrant-ubuntu-ssh.png)

#### Vagrant commands examined and played with:

### Vagrant commands

- `vagrant up`
- `vagrant reload`
- `vagrant ssh-config `
- `vagrant ssh`
- `vagrant halt`
- `vagrant suspend`
- `vagrant status`
- `vagrant destroy`

TBA

= SSH connect by MobaXterm
= 8. Create your own Vagrant box [7]
= 9. (optional) Create a test environment from a few servers. Servers' parameters are chosen independently by the student.
