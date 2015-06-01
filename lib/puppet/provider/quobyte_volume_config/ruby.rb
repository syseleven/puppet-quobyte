Puppet::Type.type(:heat_resources).provide(:quobyte_volume_config) do
  
 desc 'Manages Quobyte volume configurations.'

  # Checks whether the declared resource exists already.
  
  def exists?
    configs = Hash.new
    qmgmt('volume', 'config' 'list').each_line { |l|
      config[l.chomp()] = true
    }

    if ( configs[resource[:name]] )
      return true
    else
      return false
    end
  end


  def qmgmt(args, stdin=nil)
    ret = Puppet::Util::Execution.execute(['/usr/bin/qmgmt'] +  args, {:stdinfile => stdin})

    if ( resource[:api_url] )
      args.unshift('-u', resource[:api_url])
    end

    while ( ret.exitstatus == 248 ) # Cluster not ready
      ret = run.execute(['/usr/bin/qmgmt'] +  args)
    end


    return ret
  end

  # Creates a new configuration based on the 'content' parameter.
  
  def create
    tmp = Puppet::FileSystem::Uniquefile.new('quobyte_volume_config')
    tmp.write(resource[:content])

    qmgmt(['volume', 'config', 'import'], tmp.open())
  end

  # Removes an existing volume configuration.

  def destroy
    ret = qmgmt(['volume', 'config', 'delete', resource[:name]])
    if ( ret.exitstatus != 0 )
      fail("quobyte volume config delete #{resource[:name]} failed with status #{ret.exitstatus.to_s}. Output follows." + out.join("\n"))
    end
  end

  def ensure
    return resource[:ensure]
  end

  def ensure=(value)
    set(:ensure => value)
  end
end
