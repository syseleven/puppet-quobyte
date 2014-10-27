require 'puppet'

if File.exists?("/bin/lsblk")
  disks = Hash.new
  output = Puppet::Util::Execution.execute("lsblk -l -n -o kname,rota")

  String(output).each_line do |s|
    fields = s.split(/\s+/)
    disks[fields[0]] = fields[1]
  end

  disks.each_pair do |disk,rota|
    Facter.add("blockdevice_#{disk}_rotational") do
      setcode do
        rota
      end
    end
    Facter.add("blockdevice_#{disk}_scheduler") do
      setcode do
        begin
          scheduler = IO.read("/sys/block/#{disk}/queue/scheduler").strip()
          scheduler
        rescue
          'n/a'
        end
      end
    end
  end
end
