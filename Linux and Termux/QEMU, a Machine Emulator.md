## QEMU, a Machine Emulator
### Install QEMU
```
sudo apt update
sudo apt install qemu qemu-system qemu-utils libvirt-daemon-system libvirt-clients bridge-utils virt-manager
```
### Install GTK
```
sudo apt-get install libgtk-3-dev
```
### Prepare a ISO image
### Create a virtual disk image where the operating system will be installed
```
qemu-img create -f /qcow2 amd64_vm.qcow2 20G
```
This creates a 20GB disk image. You can adjust the size as needed.
### Use QEMU to start the installation process. 
```
qemu-system-x86_64 -m 2G -smp 2 -cdrom Desktop/TinyCore-current.iso -boot d -hda /root/amd64_vm.qcow2 -accel tcg,thread=multi -cpu max -serial mon:stdio
```
- -m 2G specifies the amount of memory for the VM.
- -smp 2 specifies the number of CPU cores for the VM.
- -cdrom Desktop/TinyCore-current.iso specifies the installation ISO.
- -hda amd64_vm.qcow2 specifies the virtual disk.
- -accel tcg,thread=multi enables multi-threaded TCG (Tiny Code Generator) acceleration.
- -cpu max emulates the maximum supported CPU for better performance.
### Following on-screen guides, command line not supportted.
### Run the VM
Once the installation is complete, you can start the VM without the installation ISO
```
qemu-system-x86_64 -m 2G -smp 2 -hda /root/amd64_vm.qcow2 -accel tcg,thread=multi -cpu max -vnc :1
```
or built-in serial console
```
qemu-system-x86_64 -m 2G -smp 2 -hda /root/amd64_vm.qcow2 -accel tcg,thread=multi -cpu max -serial mon:stdio
```
You'll see
```
tc@box:$
```
### Optional: Use Virt-Manager
For a more user-friendly interface, you can use virt-manager
```
sudo virt-manager
```
### Optional: function  `qemu64tc` in `.bashrc`
```
# Function to check if the VNC server is running
is_vnc_running() {
    pgrep -f "vncserver.*:1" > /dev/null
}


qemu64tc() {
    # Ensure we have the right number of arguments
    if [ "$#" -lt 4 ]; then
        echo "Usage: qemu64tc -m <memory> -s <smp> --ss | --v1"
        return 1
    fi

    # Parse the arguments
    while [[ $# -gt 0 ]]; do
        case $1 in
            -m)
                MEMORY="$2"
                shift 2
                ;;
            -s)
                SMP="$2"
                shift 2
                ;;
            --ss)
                MODE="ss"
                shift
                ;;
            --v1)
                MODE="v1"
                shift
                ;;
            *)
                echo "Usage: qemu64tc -m <memory> -s <smp> --ss | --v1"
                return 1
                ;;
        esac
    done

    # Check if memory and SMP are set
    if [ -z "$MEMORY" ] || [ -z "$SMP" ] || [ -z "$MODE" ]; then
        echo "Usage: qemu64tc -m <memory> -s <smp> --ss | --v1"
        return 1
    fi

    # Check if the VNC server is running
    if ! is_vnc_running; then
        echo "VNC server not running. Starting VNC server..."
        vncserver-start
        # Optionally, wait for a short time to ensure the server is started
        sleep 2
    else
        echo "VNC server is already running."
    fi

    # Run QEMU based on the mode
    case "$MODE" in
        ss)
            qemu-system-x86_64 -m "$MEMORY" -smp "$SMP" -hda /root/amd64_vm.qcow2 -accel tcg,thread=multi -cpu max -serial mon:stdio
            ;;
        v1)
            qemu-system-x86_64 -m "$MEMORY" -smp "$SMP" -hda /root/amd64_vm.qcow2 -accel tcg,thread=multi -cpu max -vnc :1
            ;;
        *)
            echo "Usage: qemu64tc -m <memory> -s <smp> --ss | --v1"
            ;;
    esac
}
```