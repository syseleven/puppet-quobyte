Puppet::Type.newtype(:quobyte_volume) do
  @doc = "Manages Quobyte volumes."

  newparam(:name, :namevar => true) do
    desc "The configuration to use, e.g. BASE"
    newvalues(/\S+/)
  end

  newparam(:user) do
    desc 'The user owning this volume.'
    newvalues(/\S+/)
  end

  newparam(:group) do
    desc "The volume's group."
    newvalues(/\S+/)
  end

  newparam(:mode) do
    desc 'The permission mode on this volume.'
    newvalues(/\S+/)
  end

  newparam(:config) do
    desc "The configuration to use, e.g. BASE"
    newvalues(/\S+/)
  end
end
