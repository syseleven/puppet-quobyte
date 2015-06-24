Puppet::Type.type(:quobyte_volume).provide(:quobyte_volume) do
  
 desc 'Manages Quobyte volumes.'

  # Checks whether the declared resource exists already.
  
  def exists?
    volumes = Hash.new
    qmgmt(['volume', 'list']).each_line { |l|
      if ( l.match(/^Name/) )
          next
      end
      line = l.split(/\s{2,}/)
      volumes[line.shift()] = true
    }

    if ( volumes[resource[:name]] )
      return true
    else
      return false
    end
  end


  def qmgmt(args)
    if ( resource[:api_url] )
      args.unshift('-u', resource[:api_url])
    end

    ret = Puppet::Util::Execution.execute(['/usr/bin/qmgmt'] +  args)

    while ( ret.exitstatus == 248 ) # Cluster not ready
      ret = Puppet::Util::Execution.execute(['/usr/bin/qmgmt'] +  args)
    end


    return ret
  end

  # Creates a new volume.
  
  def create
    properties = [ resource[:name],
                   resource[:user],
                   resource[:group],
                   resource[:group],
                   resource[:mode],
                  ]

    qmgmt(['volume', 'create'] + properties)
  end

  # Removes an existing environment.d entry.

  def destroy
    ret = qmgmt(['volume', 'delete', resource[:name]])
    out = Array.new
    ret.each_line { |l|
      out.push('  ' + l)
    }
    if ( ret.exitstatus != 0 )
      fail("quobyte volume delete #{resource[:name]} failed with status #{ret.exitstatus.to_s}. Output follows." + out.join("\n"))
    end
  end

  def ensure
    return resource[:ensure]
  end

  def ensure=(value)
    set(:ensure => value)
  end
end
