Puppet::Type.newtype(:quobyte_volume_config) do
  @doc = "Manages Quobyte volume configurations."

  newparam(:name, :namevar => true) do
    desc "The configuration's name, e.g. BASE"
    newvalues(/\S+/)
  end

  newparam(:content) do
    desc "The configuration's contents."
    newvalues(/\S+/)
  end
end
