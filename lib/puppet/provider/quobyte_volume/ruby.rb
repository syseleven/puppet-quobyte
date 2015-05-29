Puppet::Type.type(:heat_resources).provide(:quobyte_volume) do
  
 desc "Creates resource registry environments for custom Heat resources in Heat's environment directory."

  # Checks whether the declared resource exists already.
  
  def exists?
    volumes = Hash.new
    qmgmt('volume', 'list').each_line { |l|
      if ( line.match(/^Name/) )
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
    run = Puppet::Util::Execution.new
    ret = run.execute(['/usr/bin/qmgmt'] +  args)

    while ( ret.exitstatus == 111 ) # Cluster not ready FIXME: Figure out appropriate exit status
      ret = run.execute(['/usr/bin/qmgmt'] +  args)
    end


    return ret
  end

  # Creates a new environment.d entry from resource.
  
  def create
    properties = [ resource[:name],
                   resource[:user],
                   resource[:group],
                   resource[:group] ]

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
