Puppet::Type.newtype(:quobyte_volume_config) do
  @doc = "Manages Quobyte volume configurations."

  ensurable do
    defaultto :present

    newvalue(:absent) do
      provider.destroy
    end

    newvalue(:present) do
      provider.create
    end

  end

  newparam(:name, :namevar => true) do
    desc "The configuration's name, e.g. BASE"
    newvalues(/\S+/)
  end

  newparam(:content) do
    desc "The configuration's contents."
    newvalues(/\S+/)
  end

  newparam(:api_url) do
    desc "The Quobyte API URL to use."
    newvalues(/\S+/)
    defaultto 'http://127.0.0.1:17860'
  end
end
